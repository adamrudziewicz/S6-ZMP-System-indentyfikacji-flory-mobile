import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../../core/storage/storage_service.dart';
import '../../../../core/biometry/biometry_service.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import '../../domain/use_cases/forgot_password_use_case.dart';
import '../../domain/use_cases/get_me_use_case.dart';
import '../../domain/use_cases/resend_verification_email_use_case.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/notifications/push_notification_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final StorageService _storageService;
  final BiometryService _biometryService;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final GetMeUseCase _getMeUseCase;
  final ResendVerificationEmailUseCase _resendVerificationEmailUseCase;
  final PushNotificationService _pushNotificationService;
  final AuthRepository _authRepository;

  StreamSubscription<bool>? _authStateSubscription;
  StreamSubscription<String>? _fcmTokenSubscription;

  AuthBloc({
    required StorageService storageService,
    required BiometryService biometryService,
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required GetMeUseCase getMeUseCase,
    required ResendVerificationEmailUseCase resendVerificationEmailUseCase,
    required PushNotificationService pushNotificationService,
    required AuthRepository authRepository,
  })  : _storageService = storageService,
        _biometryService = biometryService,
        _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _logoutUseCase = logoutUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _getMeUseCase = getMeUseCase,
        _resendVerificationEmailUseCase = resendVerificationEmailUseCase,
        _pushNotificationService = pushNotificationService,
        _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthForgotPasswordRequested>(_onAuthForgotPasswordRequested);
    on<AuthResendVerificationEmailRequested>(_onAuthResendVerificationEmailRequested);

    _authStateSubscription = _storageService.authStateStream.listen((hasToken) {
      if (!hasToken && state is AuthAuthenticated) {
        add(AuthLogoutRequested());
      }
    });
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    _fcmTokenSubscription?.cancel();
    return super.close();
  }

  Future<void> _initPushNotifications() async {
    await _pushNotificationService.init();
    final token = await _pushNotificationService.getToken();
    if (token != null) {
      try {
        await _authRepository.registerFcmToken(token);
      } catch (_) {}
    }

    _fcmTokenSubscription?.cancel();
    _fcmTokenSubscription = _pushNotificationService.onTokenRefresh.listen((newToken) async {
      try {
        await _authRepository.registerFcmToken(newToken);
      } catch (_) {}
    });
  }

  Future<void> _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final hasToken = await _storageService.getToken() != null;
    final rememberMe = await _storageService.getRememberMe();

    if (!hasToken) {
      emit(AuthUnauthenticated());
      return;
    }

    final isBiometryEnabled = await _biometryService.isBiometryEnabled();
    
    if (!rememberMe && !isBiometryEnabled) {
      await _storageService.deleteToken();
      emit(AuthUnauthenticated());
      return;
    }

    final canCheckBiometrics = await _biometryService.canCheckBiometrics();

    if (canCheckBiometrics && isBiometryEnabled) {
      final authenticated = await _biometryService.authenticate();
      if (authenticated) {
        try {
          final user = await _getMeUseCase();
          await _initPushNotifications();
          emit(AuthAuthenticated(user: user));
        } catch (_) {
          await _initPushNotifications();
          emit(const AuthAuthenticated());
        }
      } else {
        await _logoutUseCase();
        emit(AuthUnauthenticated());
      }
    } else {
      try {
        final user = await _getMeUseCase();
        await _initPushNotifications();
        emit(AuthAuthenticated(user: user));
      } catch (_) {
        await _initPushNotifications();
        emit(const AuthAuthenticated());
      }
    }
  }

  Future<void> _onAuthLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _loginUseCase(event.login, event.password);
      if (!user.verified) {
        await _logoutUseCase();
        emit(const AuthError('email_not_verified'));
        return;
      }
      
      final isBiometryEnabled = await _biometryService.isBiometryEnabled();
      
      await _storageService.saveRememberMe(event.rememberMe);
      
      if (event.rememberMe || isBiometryEnabled) {
        await _storageService.saveSavedUsername(event.login);
        await _storageService.saveSavedPassword(event.password);
      } else {
        await _storageService.deleteSavedCredentials();
      }
      
      await _initPushNotifications();
      emit(AuthAuthenticated(user: user));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(const AuthError('login_invalid_credentials'));
      } else if (e.response?.statusCode == 400) {
        emit(const AuthError('login_invalid_request'));
      } else {
        emit(const AuthError('login_error'));
      }
    } catch (e) {
      emit(const AuthError('login_error'));
    }
  }

  Future<void> _onAuthRegisterRequested(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _registerUseCase(event.username, event.email, event.password);
      emit(const AuthActionSuccess('register_success'));
      emit(AuthUnauthenticated());
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        emit(const AuthError('register_conflict'));
      } else if (e.response?.statusCode == 400) {
        emit(const AuthError('register_invalid_request'));
      } else {
        emit(const AuthError('register_error'));
      }
    } catch (e) {
      emit(const AuthError('register_error'));
    }
  }

  Future<void> _onAuthLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    
    _fcmTokenSubscription?.cancel();
    final fcmToken = await _pushNotificationService.getToken();
    if (fcmToken != null) {
      try {
        await _authRepository.unregisterFcmToken(fcmToken);
      } catch (_) {}
    }

    await _logoutUseCase();
    emit(AuthUnauthenticated());
  }

  Future<void> _onAuthForgotPasswordRequested(AuthForgotPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _forgotPasswordUseCase(event.email);
      emit(const AuthActionSuccess('forgot_password_success'));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(const AuthError('forgot_password_error'));
    }
  }

  Future<void> _onAuthResendVerificationEmailRequested(AuthResendVerificationEmailRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _resendVerificationEmailUseCase(event.email);
      emit(const AuthActionSuccess('resend_verification_success'));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(const AuthError('resend_verification_error'));
      emit(AuthUnauthenticated());
    }
  }
}

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

  StreamSubscription<bool>? _authStateSubscription;

  AuthBloc({
    required StorageService storageService,
    required BiometryService biometryService,
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required GetMeUseCase getMeUseCase,
  })  : _storageService = storageService,
        _biometryService = biometryService,
        _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _logoutUseCase = logoutUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _getMeUseCase = getMeUseCase,
        super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthForgotPasswordRequested>(_onAuthForgotPasswordRequested);

    _authStateSubscription = _storageService.authStateStream.listen((hasToken) {
      if (!hasToken && state is AuthAuthenticated) {
        add(AuthLogoutRequested());
      }
    });
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
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
          emit(AuthAuthenticated(user: user));
        } catch (_) {
          emit(const AuthAuthenticated());
        }
      } else {
        await _logoutUseCase();
        emit(AuthUnauthenticated());
      }
    } else {
      try {
        final user = await _getMeUseCase();
        emit(AuthAuthenticated(user: user));
      } catch (_) {
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
}

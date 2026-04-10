import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/storage_service.dart';
import '../../../../core/biometry/biometry_service.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final StorageService _storageService;
  final BiometryService _biometryService;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc({
    required StorageService storageService,
    required BiometryService biometryService,
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _storageService = storageService,
        _biometryService = biometryService,
        _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _logoutUseCase = logoutUseCase,
        super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final hasToken = await _storageService.getToken() != null;

    if (!hasToken) {
      emit(AuthUnauthenticated());
      return;
    }

    final canCheckBiometrics = await _biometryService.canCheckBiometrics();
    if (canCheckBiometrics) {
      final authenticated = await _biometryService.authenticate();
      if (authenticated) {
        emit(const AuthAuthenticated());
      } else {
        await _logoutUseCase();
        emit(AuthUnauthenticated());
      }
    } else {
      emit(const AuthAuthenticated());
    }
  }

  Future<void> _onAuthLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _loginUseCase(event.login, event.password);
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError('Nieprawidłowy login lub hasło.'));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthRegisterRequested(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _registerUseCase(event.username, event.email, event.password);
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Błąd rejestracji. Sprawdź dane.'));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _logoutUseCase();
    emit(AuthUnauthenticated());
  }
}

import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_identyfikacji_flory/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:system_identyfikacji_flory/features/auth/presentation/bloc/auth_event.dart';
import 'package:system_identyfikacji_flory/features/auth/presentation/bloc/auth_state.dart';
import 'package:system_identyfikacji_flory/features/auth/domain/entities/user.dart';
import 'package:system_identyfikacji_flory/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:system_identyfikacji_flory/features/auth/domain/use_cases/login_use_case.dart';
import 'package:system_identyfikacji_flory/features/auth/domain/use_cases/register_use_case.dart';
import 'package:system_identyfikacji_flory/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:system_identyfikacji_flory/features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:system_identyfikacji_flory/features/auth/domain/use_cases/get_me_use_case.dart';
import 'package:system_identyfikacji_flory/features/auth/domain/use_cases/resend_verification_email_use_case.dart';
import 'package:system_identyfikacji_flory/features/auth/domain/repositories/auth_repository.dart';
import 'package:system_identyfikacji_flory/core/storage/storage_service.dart';
import 'package:system_identyfikacji_flory/core/biometry/biometry_service.dart';
import 'package:system_identyfikacji_flory/core/notifications/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Mocks
class MockStorageService implements StorageService {
  final _authStateController = StreamController<bool>.broadcast();
  @override Stream<bool> get authStateStream => _authStateController.stream;
  
  bool? hasToken = false;
  bool rememberMe = false;
  
  @override Future<String?> getToken() async => hasToken! ? 'token' : null;
  @override Future<void> saveToken(String token) async { hasToken = true; _authStateController.add(true); }
  @override Future<void> deleteToken() async { hasToken = false; _authStateController.add(false); }
  @override Future<bool> getRememberMe() async => rememberMe;
  @override Future<void> saveRememberMe(bool value) async => rememberMe = value;
  
  @override Future<String?> getSavedUsername() async => null;
  @override Future<String?> getSavedPassword() async => null;
  @override Future<void> saveSavedUsername(String username) async {}
  @override Future<void> saveSavedPassword(String password) async {}
  @override Future<void> deleteSavedCredentials() async {}
  
  @override Future<String?> getRefreshToken() async => null;
  @override Future<void> saveRefreshToken(String token) async {}
}

class MockBiometryService implements BiometryService {
  @override Future<bool> canCheckBiometrics() async => false;
  @override Future<bool> isBiometryEnabled() async => false;
  @override Future<void> setBiometryEnabled(bool value) async {}
  @override Future<bool> authenticate() async => false;
}

class MockLoginUseCase implements LoginUseCase {
  @override
  final AuthRepository repository = DummyAuthRepository();
  Future<User> Function(String, String)? stub;
  @override Future<User> call(String login, String password) async => stub!(login, password);
}

class MockRegisterUseCase implements RegisterUseCase {
  @override
  final AuthRepository repository = DummyAuthRepository();
  Future<void> Function(String, String, String)? stub;
  @override Future<void> call(String username, String email, String password) async => stub!(username, email, password);
}

class MockLogoutUseCase implements LogoutUseCase {
  @override
  final AuthRepository repository = DummyAuthRepository();
  @override Future<void> call() async {}
}

class MockPushNotificationService implements PushNotificationService {
  @override Future<void> init() async {}
  @override Future<String?> getToken() async => null;
  @override Stream<String> get onTokenRefresh => const Stream.empty();
  @override Stream<RemoteMessage> get onMessage => const Stream.empty();
}

// Dummy classes for non-tested paths
class DummyAuthRepository implements AuthRepository {
  @override Future<User> login(String l, String p) { throw UnimplementedError(); }
  @override Future<void> register(String u, String e, String p) { throw UnimplementedError(); }
  @override Future<void> logout() { throw UnimplementedError(); }
  @override Future<User> getMe() { throw UnimplementedError(); }
  @override Future<void> forgotPassword(String e) { throw UnimplementedError(); }
  @override Future<void> resendVerificationEmail(String e) { throw UnimplementedError(); }
  @override Future<void> registerFcmToken(String t) { throw UnimplementedError(); }
  @override Future<void> unregisterFcmToken(String t) { throw UnimplementedError(); }
  @override Future<void> changePassword(String o, String n) { throw UnimplementedError(); }
  @override Future<void> confirmAccount(String u, String t) { throw UnimplementedError(); }
  @override Future<void> deleteMyAccount() { throw UnimplementedError(); }
  @override Future<String?> getToken() { throw UnimplementedError(); }
  @override Future<User> me() { throw UnimplementedError(); }
}
class DummyForgotPassword implements ForgotPasswordUseCase {
  @override
  final AuthRepository repository = DummyAuthRepository();
  @override Future<void> call(String e) async {}
}
class DummyGetMe implements GetMeUseCase {
  @override
  final AuthRepository repository = DummyAuthRepository();
  @override Future<User> call() async => throw UnimplementedError();
}
class DummyResend implements ResendVerificationEmailUseCase {
  @override
  final AuthRepository repository = DummyAuthRepository();
  @override Future<void> call(String e) async {}
}

void main() {
  late MockStorageService mockStorage;
  late MockBiometryService mockBiometry;
  late MockLoginUseCase mockLogin;
  late MockRegisterUseCase mockRegister;
  late MockLogoutUseCase mockLogout;
  late MockPushNotificationService mockPush;
  late AuthBloc bloc;

  setUp(() {
    mockStorage = MockStorageService();
    mockBiometry = MockBiometryService();
    mockLogin = MockLoginUseCase();
    mockRegister = MockRegisterUseCase();
    mockLogout = MockLogoutUseCase();
    mockPush = MockPushNotificationService();

    bloc = AuthBloc(
      storageService: mockStorage,
      biometryService: mockBiometry,
      loginUseCase: mockLogin,
      registerUseCase: mockRegister,
      logoutUseCase: mockLogout,
      forgotPasswordUseCase: DummyForgotPassword(),
      getMeUseCase: DummyGetMe(),
      resendVerificationEmailUseCase: DummyResend(),
      pushNotificationService: mockPush,
      authRepository: DummyAuthRepository(),
    );
  });

  tearDown(() {
    bloc.close();
  });

  final verifiedUser = User(id: '1', username: 'test', email: 'a@a.com', verified: true, active: true, admin: false);
  final unverifiedUser = User(id: '1', username: 'test', email: 'a@a.com', verified: false, active: true, admin: false);

  group('AuthBloc - Login', () {
    test('emits [AuthLoading, AuthAuthenticated] on verified user login', () {
      mockLogin.stub = (l, p) async => verifiedUser;

      final expectedStates = [
        isA<AuthLoading>(),
        isA<AuthAuthenticated>().having((s) => s.user?.username, 'username', 'test'),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const AuthLoginRequested('login', 'pass', rememberMe: true));
    });

    test('emits [AuthLoading, AuthErrorEmailNotVerified] on unverified user', () {
      mockLogin.stub = (l, p) async => unverifiedUser;

      final expectedStates = [
        isA<AuthLoading>(),
        isA<AuthErrorEmailNotVerified>(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const AuthLoginRequested('login', 'pass'));
    });

    test('emits [AuthLoading, AuthErrorInvalidCredentials] on wrong pass', () {
      mockLogin.stub = (l, p) async => throw InvalidCredentialsException();

      final expectedStates = [
        isA<AuthLoading>(),
        isA<AuthErrorInvalidCredentials>(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const AuthLoginRequested('login', 'wrong_pass'));
    });
  });

  group('AuthBloc - Register', () {
    test('emits [AuthLoading, AuthRegisterSuccess, AuthUnauthenticated] on success', () {
      mockRegister.stub = (u, e, p) async {};

      final expectedStates = [
        isA<AuthLoading>(),
        isA<AuthRegisterSuccess>(),
        isA<AuthUnauthenticated>(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const AuthRegisterRequested('user', 'email@email.com', 'pass'));
    });

    test('emits [AuthLoading, AuthErrorUserConflict] when user exists', () {
      mockRegister.stub = (u, e, p) async => throw UserConflictException();

      final expectedStates = [
        isA<AuthLoading>(),
        isA<AuthErrorUserConflict>(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const AuthRegisterRequested('user', 'email@email.com', 'pass'));
    });
  });
}

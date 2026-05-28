import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String login, String password);
  Future<void> register(String username, String email, String password);
  Future<void> logout();
  Future<void> forgotPassword(String email);
  Future<String?> getToken();
  Future<User> me();
  Future<void> deleteMyAccount();
  Future<void> resendVerificationEmail(String email);
  Future<void> registerFcmToken(String fcmToken);
  Future<void> unregisterFcmToken(String fcmToken);
}

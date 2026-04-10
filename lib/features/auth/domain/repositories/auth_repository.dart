import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String login, String password);
  Future<void> register(String username, String email, String password);
  Future<void> logout();
  Future<void> forgotPassword(String email);
  Future<String?> getToken();
}

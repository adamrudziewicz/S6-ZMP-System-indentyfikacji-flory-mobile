import '../../../../core/storage/storage_service.dart';
import '../../data/data_sources/auth_remote_data_source.dart';
import '../../data/models/login_request.dart';
import '../../data/models/register_request.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final StorageService _storageService;

  AuthRepositoryImpl(this._remoteDataSource, this._storageService);

  @override
  Future<User> login(String login, String password) async {
    final response = await _remoteDataSource.login(
      LoginRequest(login: login, password: password),
    );
    await _storageService.saveToken(response.token);
    await _storageService.saveRefreshToken(response.refreshToken);
    
    return User(
      id: response.id,
      username: response.username,
      email: response.email,
      verified: response.verified,
      active: true,
      admin: response.admin,
    );
  }

  @override
  Future<void> register(String username, String email, String password) async {
    await _remoteDataSource.register(
      RegisterRequest(username: username, email: email, password: password),
    );
  }

  @override
  Future<void> logout() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken != null) {
        await _remoteDataSource.logout(refreshToken);
      }
    } catch (_) {
    } finally {
      await _storageService.deleteToken();
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _remoteDataSource.forgotPassword(email);
  }

  @override
  Future<String?> getToken() async {
    return await _storageService.getToken();
  }

  @override
  Future<User> me() async {
    final response = await _remoteDataSource.me();
    return User(
      id: response.id,
      username: response.username,
      email: response.email,
      verified: response.verified,
      active: response.active,
      admin: response.admin,
    );
  }

  @override
  Future<void> deleteMyAccount() async {
    await _remoteDataSource.deleteMyAccount();
    await _storageService.deleteToken();
  }

  @override
  Future<void> resendVerificationEmail(String email) async {
    await _remoteDataSource.resendVerificationEmail(email);
  }

  @override
  Future<void> registerFcmToken(String fcmToken) async {
    await _remoteDataSource.registerFcmToken(fcmToken);
  }

  @override
  Future<void> unregisterFcmToken(String fcmToken) async {
    try {
      await _remoteDataSource.unregisterFcmToken(fcmToken);
    } catch (_) {
    }
  }
}

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
    
    return User(
      id: response.id,
      username: response.username,
      email: response.email,
      role: response.roles.isNotEmpty ? response.roles.first : 'USER',
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
      await _remoteDataSource.logout();
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
}

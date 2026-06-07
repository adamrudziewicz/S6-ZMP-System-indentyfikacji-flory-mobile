import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import '../../../../core/storage/storage_service.dart';
import '../../data/data_sources/auth_remote_data_source.dart';
import '../../data/models/login_request.dart';
import '../../data/models/register_request.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/exceptions/auth_exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final StorageService _storageService;

  AuthRepositoryImpl(this._remoteDataSource, this._storageService);

  @override
  Future<User> login(String login, String password) async {
    try {
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const InvalidCredentialsException();
      } else if (e.response?.statusCode == 400) {
        throw const InvalidRequestException();
      }
      throw const UnknownAuthException();
    } catch (e) {
      developer.log('Login error: $e', name: 'AuthRepository');
      throw const UnknownAuthException();
    }
  }

  @override
  Future<void> register(String username, String email, String password) async {
    try {
      await _remoteDataSource.register(
        RegisterRequest(username: username, email: email, password: password),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw const UserConflictException();
      } else if (e.response?.statusCode == 400) {
        throw const InvalidRequestException();
      }
      throw const UnknownAuthException();
    } catch (e) {
      developer.log('Register error: $e', name: 'AuthRepository');
      throw const UnknownAuthException();
    }
  }

  @override
  Future<void> logout() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken != null) {
        await _remoteDataSource.logout(refreshToken);
      }
    } catch (e) {
      developer.log('Logout API error: $e', name: 'AuthRepository');
    } finally {
      await _storageService.deleteToken();
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
    } catch (e) {
      developer.log('Forgot password error: $e', name: 'AuthRepository');
      throw const UnknownAuthException();
    }
  }

  @override
  Future<String?> getToken() async {
    return await _storageService.getToken();
  }

  @override
  Future<User> me() async {
    try {
      final response = await _remoteDataSource.me();
      return User(
        id: response.id,
        username: response.username,
        email: response.email,
        verified: response.verified,
        active: response.active,
        admin: response.admin,
      );
    } catch (e) {
      developer.log('Get me error: $e', name: 'AuthRepository');
      throw const UnknownAuthException();
    }
  }

  @override
  Future<void> deleteMyAccount() async {
    try {
      await _remoteDataSource.deleteMyAccount();
      await _storageService.deleteToken();
    } catch (e) {
      developer.log('Delete account error: $e', name: 'AuthRepository');
      throw const UnknownAuthException();
    }
  }

  @override
  Future<void> resendVerificationEmail(String email) async {
    try {
      await _remoteDataSource.resendVerificationEmail(email);
    } catch (e) {
      developer.log('Resend verification email error: $e', name: 'AuthRepository');
      throw const UnknownAuthException();
    }
  }

  @override
  Future<void> registerFcmToken(String fcmToken) async {
    try {
      await _remoteDataSource.registerFcmToken(fcmToken);
    } catch (e) {
      developer.log('Register FCM token error: $e', name: 'AuthRepository');
    }
  }

  @override
  Future<void> unregisterFcmToken(String fcmToken) async {
    try {
      await _remoteDataSource.unregisterFcmToken(fcmToken);
    } catch (e) {
      developer.log('Unregister FCM token error: $e', name: 'AuthRepository');
    }
  }
}

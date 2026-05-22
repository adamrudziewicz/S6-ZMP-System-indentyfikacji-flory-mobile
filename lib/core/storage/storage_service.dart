import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

class StorageService {
  final FlutterSecureStorage _storage;

  StorageService() : _storage = const FlutterSecureStorage();

  static const String _tokenKey = 'jwt_token';
  static const String _rememberMeKey = 'remember_me';

  final _authStateController = StreamController<bool>.broadcast();
  Stream<bool> get authStateStream => _authStateController.stream;

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    _authStateController.add(true);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    _authStateController.add(false);
  }

  Future<void> saveRememberMe(bool rememberMe) async {
    await _storage.write(key: _rememberMeKey, value: rememberMe.toString());
  }

  Future<bool> getRememberMe() async {
    final val = await _storage.read(key: _rememberMeKey);
    return val == 'true';
  }

  Future<void> saveSavedUsername(String username) async {
    await _storage.write(key: 'saved_username', value: username);
  }

  Future<String?> getSavedUsername() async {
    return await _storage.read(key: 'saved_username');
  }

  Future<void> saveSavedPassword(String password) async {
    await _storage.write(key: 'saved_password', value: password);
  }

  Future<String?> getSavedPassword() async {
    return await _storage.read(key: 'saved_password');
  }

  Future<void> deleteSavedCredentials() async {
    await _storage.delete(key: 'saved_username');
    await _storage.delete(key: 'saved_password');
  }
}

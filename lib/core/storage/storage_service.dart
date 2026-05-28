import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

class StorageService {
  final FlutterSecureStorage _storage;

  String? _cachedToken;
  String? _cachedRefreshToken;

  StorageService() : _storage = const FlutterSecureStorage();

  static const String _tokenKey = 'jwt_token';
  static const String _refreshTokenKey = 'jwt_refresh_token';
  static const String _rememberMeKey = 'remember_me';

  final _authStateController = StreamController<bool>.broadcast();
  Stream<bool> get authStateStream => _authStateController.stream;

  Future<void> saveToken(String token) async {
    _cachedToken = token;
    await _storage.write(key: _tokenKey, value: token);
    _authStateController.add(true);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    _cachedRefreshToken = refreshToken;
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getToken() async {
    if (_cachedToken != null) return _cachedToken;
    _cachedToken = await _storage.read(key: _tokenKey);
    return _cachedToken;
  }

  Future<String?> getRefreshToken() async {
    if (_cachedRefreshToken != null) return _cachedRefreshToken;
    _cachedRefreshToken = await _storage.read(key: _refreshTokenKey);
    return _cachedRefreshToken;
  }

  Future<void> deleteToken() async {
    _cachedToken = null;
    _cachedRefreshToken = null;
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshTokenKey);
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

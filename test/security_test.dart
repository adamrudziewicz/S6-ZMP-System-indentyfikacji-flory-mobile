import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:system_identyfikacji_flory/core/storage/storage_service.dart';
import 'package:system_identyfikacji_flory/core/api/api_service.dart';

class MockStorageService extends StorageService {
  String? _token;

  @override
  Future<void> saveToken(String token) async {
    _token = token;
  }

  @override
  Future<String?> getToken() async {
    return _token;
  }

  @override
  Future<void> deleteToken() async {
    _token = null;
  }
}

void main() {
  group('Security System Verification Tests', () {
    late MockStorageService mockStorageService;
    late ApiService apiService;

    setUp(() {
      mockStorageService = MockStorageService();
      apiService = ApiService(mockStorageService);
    });

    test('StorageService - Should correctly store and delete session token', () async {
      const token = 'jwt_test_token_12345';
      
      expect(await mockStorageService.getToken(), isNull);

      await mockStorageService.saveToken(token);
      expect(await mockStorageService.getToken(), equals(token));

      await mockStorageService.deleteToken();
      expect(await mockStorageService.getToken(), isNull);
    });

    test('HTTP Interceptor - Should inject Authorization Bearer header when token exists', () async {
      const token = 'jwt_test_token_54321';
      await mockStorageService.saveToken(token);

      final dio = apiService.client;
      RequestOptions? capturedOptions;
      
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedOptions = options;
            return handler.next(options);
          },
        ),
      );

      try {
        await dio.get('/test-endpoint');
      } catch (_) {}

      expect(capturedOptions, isNotNull);
      expect(capturedOptions!.headers['Authorization'], equals('Bearer $token'));
    });

    test('HTTP Interceptor - Should NOT inject Authorization header when token is empty', () async {
      final dio = apiService.client;
      RequestOptions? capturedOptions;

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedOptions = options;
            return handler.next(options);
          },
        ),
      );

      try {
        await dio.get('/test-endpoint');
      } catch (_) {}

      expect(capturedOptions, isNotNull);
      expect(capturedOptions!.headers.containsKey('Authorization'), isFalse);
    });
  });
}

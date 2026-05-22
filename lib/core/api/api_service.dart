import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import '../storage/storage_service.dart';
import 'api_constants.dart';

class ApiService {
  final Dio _dio;
  final StorageService _storageService;

  ApiService(this._storageService)
      : _dio = Dio(BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
        )) {
    _initializeInterceptors();
  }

  Dio get client => _dio;

  void _initializeInterceptors() {
    _dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: false,
      responseBody: true,
      responseHeader: false,
      error: true,
      logPrint: (object) => developer.log(object.toString(), name: 'HTTP'),
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storageService.getToken();
          if (token != null && token.isNotEmpty) {
            final cleanToken = token.replaceAll(RegExp(r'Bearer\s+', caseSensitive: false), '').trim();
            options.headers['Authorization'] = 'Bearer $cleanToken';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          final statusCode = e.response?.statusCode;
          final path = e.requestOptions.path;
          
          developer.log(
            'API ERROR: $statusCode on $path — body: ${e.response?.data}',
            name: 'ApiService',
          );

          if (statusCode == 401) {
            final isAuthEndpoint = path.contains('/users/');
            if (isAuthEndpoint) {
              await _storageService.deleteToken();
            }
          }
          return handler.next(e);
        },
      ),
    );
  }
}

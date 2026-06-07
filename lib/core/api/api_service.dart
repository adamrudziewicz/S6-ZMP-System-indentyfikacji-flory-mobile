import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import '../storage/storage_service.dart';
import 'api_constants.dart';
import 'token_refresh_interceptor.dart';

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
    _dio.interceptors.add(
      TokenRefreshInterceptor(
        dio: _dio,
        storageService: _storageService,
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: false,
        responseBody: true,
        responseHeader: false,
        error: true,
        logPrint: (object) => developer.log(object.toString(), name: 'HTTP'),
      ),
    );
  }
}

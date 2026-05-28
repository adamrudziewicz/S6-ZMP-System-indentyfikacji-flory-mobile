import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import '../storage/storage_service.dart';
import 'api_constants.dart';

class ApiService {
  final Dio _dio;
  final StorageService _storageService;

  bool _isRefreshing = false;
  Completer<bool>? _refreshCompleter;

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
            if (path.contains('/users/login') || path.contains('/users/refresh')) {
              await _storageService.deleteToken();
              return handler.next(e);
            }

            if (e.requestOptions.extra['isRetry'] == true) {
              await _storageService.deleteToken();
              return handler.next(e);
            }

            final refreshToken = await _storageService.getRefreshToken();
            if (refreshToken == null) {
              await _storageService.deleteToken();
              return handler.next(e);
            }

            if (_isRefreshing) {
              final success = await _refreshCompleter?.future ?? false;
              if (success) {
                final newToken = await _storageService.getToken();
                if (newToken != null) {
                  try {
                    await Future.delayed(const Duration(milliseconds: 50));
                    final opts = e.requestOptions;
                    opts.extra['isRetry'] = true;
                    opts.headers['Authorization'] = 'Bearer $newToken';
                    final cloneReq = await _dio.fetch(opts);
                    return handler.resolve(cloneReq);
                  } catch (retryError) {
                    return handler.next(retryError is DioException ? retryError : e);
                  }
                }
              }
              return handler.next(e);
            }

            _isRefreshing = true;
            _refreshCompleter = Completer<bool>();

            try {
              final refreshDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
              final refreshResponse = await refreshDio.post(
                '/users/refresh',
                data: {'refreshToken': refreshToken},
              );

              final newToken = refreshResponse.data['token'] as String?;
              final newRefreshToken = refreshResponse.data['refreshToken'] as String?;

              if (newToken != null && newRefreshToken != null) {
                await _storageService.saveToken(newToken);
                await _storageService.saveRefreshToken(newRefreshToken);

                _refreshCompleter?.complete(true);
                _refreshCompleter = null;
                _isRefreshing = false;

                try {
                  await Future.delayed(const Duration(milliseconds: 50));
                  final opts = e.requestOptions;
                  opts.extra['isRetry'] = true;
                  opts.headers['Authorization'] = 'Bearer $newToken';
                  final cloneReq = await _dio.fetch(opts);
                  return handler.resolve(cloneReq);
                } catch (retryError) {
                  return handler.next(retryError is DioException ? retryError : e);
                }
              } else {
                await _storageService.deleteToken();
                _refreshCompleter?.complete(false);
                _refreshCompleter = null;
                _isRefreshing = false;
              }
            } catch (_) {
              await _storageService.deleteToken();
              if (_refreshCompleter?.isCompleted == false) {
                _refreshCompleter?.complete(false);
              }
              _refreshCompleter = null;
              _isRefreshing = false;
            }
          }
          return handler.next(e);
        },
      ),
    );

    _dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: false,
      responseBody: true,
      responseHeader: false,
      error: true,
      logPrint: (object) => developer.log(object.toString(), name: 'HTTP'),
    ));
  }
}

import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import '../storage/storage_service.dart';
import 'api_constants.dart';

class TokenRefreshInterceptor extends Interceptor {
  final Dio _dio;
  final StorageService _storageService;

  bool _isRefreshing = false;
  Completer<bool>? _refreshCompleter;

  TokenRefreshInterceptor({
    required Dio dio,
    required StorageService storageService,
  })  : _dio = dio,
        _storageService = storageService;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storageService.getToken();
    if (token != null && token.isNotEmpty) {
      final cleanToken = token.replaceAll(RegExp(r'Bearer\s+', caseSensitive: false), '').trim();
      options.headers['Authorization'] = 'Bearer $cleanToken';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;

    developer.log(
      'API ERROR: $statusCode on $path — body: ${err.response?.data}',
      name: 'TokenRefreshInterceptor',
    );

    if (statusCode == 401) {
      if (_isAuthPath(path)) {
        await _storageService.deleteToken();
        return handler.next(err);
      }

      if (_isRetryAttempt(err.requestOptions)) {
        await _storageService.deleteToken();
        return handler.next(err);
      }

      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken == null) {
        await _storageService.deleteToken();
        return handler.next(err);
      }

      if (_isRefreshing) {
        await _waitForRefreshAndRetry(err, handler);
        return;
      }

      await _performTokenRefresh(refreshToken, err, handler);
      return;
    }

    return handler.next(err);
  }

  bool _isAuthPath(String path) {
    return path.contains(ApiConstants.loginPath) || path.contains(ApiConstants.refreshPath);
  }

  bool _isRetryAttempt(RequestOptions options) {
    return options.extra['isRetry'] == true;
  }

  Future<void> _waitForRefreshAndRetry(DioException err, ErrorInterceptorHandler handler) async {
    final success = await _refreshCompleter?.future ?? false;
    if (success) {
      final newToken = await _storageService.getToken();
      if (newToken != null) {
        await _retryRequest(newToken, err, handler);
        return;
      }
    }
    handler.next(err);
  }

  Future<void> _performTokenRefresh(
    String refreshToken,
    DioException originalError,
    ErrorInterceptorHandler handler,
  ) async {
    _isRefreshing = true;
    _refreshCompleter = Completer<bool>();

    try {
      final refreshDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
      final refreshResponse = await refreshDio.post(
        ApiConstants.refreshPath,
        data: {'refreshToken': refreshToken},
      );

      final newToken = refreshResponse.data['token'] as String?;
      final newRefreshToken = refreshResponse.data['refreshToken'] as String?;

      if (newToken != null && newRefreshToken != null) {
        await _storageService.saveToken(newToken);
        await _storageService.saveRefreshToken(newRefreshToken);

        _completeRefresh(true);
        await _retryRequest(newToken, originalError, handler);
      } else {
        await _failRefresh();
        handler.next(originalError);
      }
    } catch (e) {
      developer.log('Token refresh failed: $e', name: 'TokenRefreshInterceptor');
      await _failRefresh();
      handler.next(originalError);
    }
  }

  Future<void> _retryRequest(String newToken, DioException originalError, ErrorInterceptorHandler handler) async {
    try {
      await Future.delayed(const Duration(milliseconds: 50));
      final opts = originalError.requestOptions;
      opts.extra['isRetry'] = true;
      opts.headers['Authorization'] = 'Bearer $newToken';
      final cloneReq = await _dio.fetch(opts);
      handler.resolve(cloneReq);
    } catch (retryError) {
      handler.next(retryError is DioException ? retryError : originalError);
    }
  }

  void _completeRefresh(bool success) {
    if (_refreshCompleter?.isCompleted == false) {
      _refreshCompleter?.complete(success);
    }
    _refreshCompleter = null;
    _isRefreshing = false;
  }

  Future<void> _failRefresh() async {
    await _storageService.deleteToken();
    _completeRefresh(false);
  }
}

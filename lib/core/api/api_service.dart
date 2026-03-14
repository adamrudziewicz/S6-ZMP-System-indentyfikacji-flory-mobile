import 'package:dio/dio.dart';
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
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storageService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Tutaj możemy obsłużyć kody błędów np. 401 Unauthorized do wylogowania lub odświeżenia
          if (e.response?.statusCode == 401) {
            // TODO: Logika wylogowania / odświeżenia tokena z AuthRepository
          }
          return handler.next(e);
        },
      ),
    );
  }
}

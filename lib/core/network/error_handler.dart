import 'package:dio/dio.dart';
import 'app_exception.dart';

class ErrorHandler {
  static AppException mapError(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final responseData = error.response?.data;
      String? serverMsg;
      
      if (responseData is String && responseData.isNotEmpty) {
        serverMsg = responseData;
      } else if (responseData is Map<String, dynamic> && responseData['message'] is String) {
        serverMsg = responseData['message'] as String;
      }

      switch (statusCode) {
        case 401:
          return SessionExpiredException(serverMsg);
        case 403:
          return ForbiddenException(serverMsg);
        case 404:
          return NotFoundException(serverMsg);
        case 409:
          return ConflictException(serverMsg);
        default:
          return NetworkException(serverMsg);
      }
    }
    return UnknownException();
  }
}

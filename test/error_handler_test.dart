import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:system_identyfikacji_flory/core/network/error_handler.dart';
import 'package:system_identyfikacji_flory/core/network/app_exception.dart';

void main() {
  group('ErrorHandler Tests', () {
    test('Should map 401 to SessionExpiredException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
        ),
      );
      final result = ErrorHandler.mapError(dioException);
      expect(result, isA<SessionExpiredException>());
    });

    test('Should map 403 to ForbiddenException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 403,
        ),
      );
      final result = ErrorHandler.mapError(dioException);
      expect(result, isA<ForbiddenException>());
    });

    test('Should map 404 to NotFoundException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
        ),
      );
      final result = ErrorHandler.mapError(dioException);
      expect(result, isA<NotFoundException>());
    });

    test('Should map 409 to ConflictException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 409,
        ),
      );
      final result = ErrorHandler.mapError(dioException);
      expect(result, isA<ConflictException>());
    });

    test('Should map 500 to NetworkException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
      );
      final result = ErrorHandler.mapError(dioException);
      expect(result, isA<NetworkException>());
    });

    test('Should map string response data to serverMessage', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 400,
          data: 'Bad Request Payload',
        ),
      );
      final result = ErrorHandler.mapError(dioException);
      expect(result, isA<NetworkException>());
      expect(result.serverMessage, 'Bad Request Payload');
    });

    test('Should map json response data to serverMessage', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
          data: {'message': 'Plant not found'},
        ),
      );
      final result = ErrorHandler.mapError(dioException);
      expect(result, isA<NotFoundException>());
      expect(result.serverMessage, 'Plant not found');
    });

    test('Should map unknown exception to UnknownException', () {
      final result = ErrorHandler.mapError(FormatException('Invalid format'));
      expect(result, isA<UnknownException>());
    });
    
    test('Should map DioException without response to NetworkException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
      );
      final result = ErrorHandler.mapError(dioException);
      expect(result, isA<NetworkException>());
      expect(result.serverMessage, isNull);
    });
  });
}

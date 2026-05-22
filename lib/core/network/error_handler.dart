import 'package:dio/dio.dart';

class ErrorHandler {
  static String mapError(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final responseData = error.response?.data;

      switch (statusCode) {
        case 401:
          return 'Sesja wygasła. Wylogowywanie...';
        case 403:
          if (responseData is String && responseData.isNotEmpty) {
            return responseData;
          }
          return 'Brak dostępu do tego zasobu.';
        case 404:
          return 'Nie znaleziono zasobu.';
        case 409:
          if (responseData is String && responseData.isNotEmpty) {
            return responseData;
          }
          return 'Konflikt danych.';
        default:
          return 'Błąd połączenia z serwerem.';
      }
    }
    return 'Wystąpił nieoczekiwany błąd.';
  }
}

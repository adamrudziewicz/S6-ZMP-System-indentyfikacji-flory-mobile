import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl {
    if (dotenv.isInitialized) {
      final url = dotenv.env['API_BASE_URL'];
      if (url != null && url.isNotEmpty) {
        return url;
      }
    }
    return 'http://10.0.2.2:8080';
  }
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 10000;

  static const String loginPath = '/users/login';
  static const String refreshPath = '/users/refresh';
}
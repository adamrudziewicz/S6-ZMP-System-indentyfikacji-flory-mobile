import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl => dotenv.env['API_BASE_URL'] ?? 'https://ezielnik-production.up.railway.app';
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 10000;
}
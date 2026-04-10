import 'package:dio/dio.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      '/users/login',
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await _dio.post(
      '/users/register',
      data: request.toJson(),
    );
    return RegisterResponse.fromJson(response.data);
  }

  Future<void> logout() async {
    await _dio.post('/users/logout');
  }

  Future<void> forgotPassword(String email) async {
    await _dio.post(
      '/users/password/forgot',
      data: {'email': email},
    );
  }
}

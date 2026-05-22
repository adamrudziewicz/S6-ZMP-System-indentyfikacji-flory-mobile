import 'package:dio/dio.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';
import '../models/user_response.dart';

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

  Future<void> forgotPassword(String email) async {
    await _dio.post(
      '/users/forgot-password',
      data: {'email': email},
    );
  }

  Future<UserResponse> me() async {
    final response = await _dio.get('/users/me');
    return UserResponse.fromJson(response.data);
  }

  Future<void> deleteMyAccount() async {
    await _dio.delete('/users/me');
  }
}

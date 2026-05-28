// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    _LoginResponse(
      message: json['message'] as String?,
      warning: json['warning'] as String?,
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      verified: json['verified'] as bool? ?? false,
      admin: json['admin'] as bool? ?? false,
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(_LoginResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'warning': instance.warning,
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'verified': instance.verified,
      'admin': instance.admin,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };

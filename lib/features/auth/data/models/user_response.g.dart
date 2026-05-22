// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserResponse _$UserResponseFromJson(Map<String, dynamic> json) =>
    _UserResponse(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      verified: json['verified'] as bool? ?? false,
      active: json['active'] as bool? ?? false,
      admin: json['admin'] as bool? ?? false,
      warning: json['warning'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(_UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'verified': instance.verified,
      'active': instance.active,
      'admin': instance.admin,
      'warning': instance.warning,
    };

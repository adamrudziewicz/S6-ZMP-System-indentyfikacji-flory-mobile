// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'herbarium_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HerbariumResponse _$HerbariumResponseFromJson(Map<String, dynamic> json) =>
    _HerbariumResponse(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      plantCount: (json['plantCount'] as num?)?.toInt() ?? 0,
      isPublic: json['public'] as bool? ?? false,
    );

Map<String, dynamic> _$HerbariumResponseToJson(_HerbariumResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'plantCount': instance.plantCount,
      'public': instance.isPublic,
    };

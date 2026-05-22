// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_photo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlantPhotoResponse _$PlantPhotoResponseFromJson(Map<String, dynamic> json) =>
    _PlantPhotoResponse(
      id: json['id'] as String,
      plantId: json['plantId'] as String,
      url: json['url'] as String,
      description: json['description'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PlantPhotoResponseToJson(_PlantPhotoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plantId': instance.plantId,
      'url': instance.url,
      'description': instance.description,
      'confidence': instance.confidence,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

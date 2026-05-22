// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlantResponse _$PlantResponseFromJson(Map<String, dynamic> json) =>
    _PlantResponse(
      id: json['id'] as String,
      herbariumId: json['herbariumId'] as String,
      name: json['name'] as String?,
      detectedSpecies: json['detectedSpecies'] as String?,
      speciesId: json['speciesId'] as String?,
      family: json['family'] as String?,
      genus: json['genus'] as String?,
      commonNames: json['commonNames'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map(
                (e) => PlantPhotoResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PlantResponseToJson(_PlantResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'herbariumId': instance.herbariumId,
      'name': instance.name,
      'detectedSpecies': instance.detectedSpecies,
      'speciesId': instance.speciesId,
      'family': instance.family,
      'genus': instance.genus,
      'commonNames': instance.commonNames,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'photos': instance.photos,
    };

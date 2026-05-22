// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_identification_choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlantIdentificationChoice _$PlantIdentificationChoiceFromJson(
  Map<String, dynamic> json,
) => _PlantIdentificationChoice(
  resolved: json['resolved'] as bool,
  plant: json['plant'] == null
      ? null
      : PlantResponse.fromJson(json['plant'] as Map<String, dynamic>),
  pendingPhotoId: json['pendingPhotoId'] as String?,
  status: json['status'] as String?,
  identification: json['identification'] == null
      ? null
      : IdentificationInfo.fromJson(
          json['identification'] as Map<String, dynamic>,
        ),
  recommendedPlants:
      (json['recommendedPlants'] as List<dynamic>?)
          ?.map((e) => PlantResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$PlantIdentificationChoiceToJson(
  _PlantIdentificationChoice instance,
) => <String, dynamic>{
  'resolved': instance.resolved,
  'plant': instance.plant,
  'pendingPhotoId': instance.pendingPhotoId,
  'status': instance.status,
  'identification': instance.identification,
  'recommendedPlants': instance.recommendedPlants,
};

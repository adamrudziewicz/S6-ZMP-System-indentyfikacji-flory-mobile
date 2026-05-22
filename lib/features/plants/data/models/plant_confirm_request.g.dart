// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_confirm_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlantConfirmRequest _$PlantConfirmRequestFromJson(Map<String, dynamic> json) =>
    _PlantConfirmRequest(
      pendingPhotoId: json['pendingPhotoId'] as String,
      decisionType: json['decisionType'] as String,
      existingPlantId: json['existingPlantId'] as String?,
    );

Map<String, dynamic> _$PlantConfirmRequestToJson(
  _PlantConfirmRequest instance,
) => <String, dynamic>{
  'pendingPhotoId': instance.pendingPhotoId,
  'decisionType': instance.decisionType,
  'existingPlantId': instance.existingPlantId,
};

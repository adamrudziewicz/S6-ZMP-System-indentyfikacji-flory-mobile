// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identification_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IdentificationInfo _$IdentificationInfoFromJson(Map<String, dynamic> json) =>
    _IdentificationInfo(
      detectedSpecies: json['detectedSpecies'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      speciesId: json['speciesId'] as String?,
      family: json['family'] as String?,
      genus: json['genus'] as String?,
      commonNames: json['commonNames'] as String?,
    );

Map<String, dynamic> _$IdentificationInfoToJson(_IdentificationInfo instance) =>
    <String, dynamic>{
      'detectedSpecies': instance.detectedSpecies,
      'confidence': instance.confidence,
      'speciesId': instance.speciesId,
      'family': instance.family,
      'genus': instance.genus,
      'commonNames': instance.commonNames,
    };

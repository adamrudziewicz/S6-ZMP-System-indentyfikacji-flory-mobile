// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'herbarium_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HerbariumRequest _$HerbariumRequestFromJson(Map<String, dynamic> json) =>
    _HerbariumRequest(
      name: json['name'] as String,
      description: json['description'] as String?,
      isPublic: json['public'] as bool? ?? false,
    );

Map<String, dynamic> _$HerbariumRequestToJson(_HerbariumRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'public': instance.isPublic,
    };

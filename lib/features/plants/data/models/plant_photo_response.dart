import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant_photo_response.freezed.dart';
part 'plant_photo_response.g.dart';

@freezed
abstract class PlantPhotoResponse with _$PlantPhotoResponse {
  const factory PlantPhotoResponse({
    required String id,
    required String plantId,
    required String url,
    String? description,
    double? confidence,
    DateTime? createdAt,
  }) = _PlantPhotoResponse;

  factory PlantPhotoResponse.fromJson(Map<String, dynamic> json) => _$PlantPhotoResponseFromJson(json);
}

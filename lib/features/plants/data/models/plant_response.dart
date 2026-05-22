import 'package:freezed_annotation/freezed_annotation.dart';
import 'plant_photo_response.dart';

part 'plant_response.freezed.dart';
part 'plant_response.g.dart';

@freezed
abstract class PlantResponse with _$PlantResponse {
  const factory PlantResponse({
    required String id,
    required String herbariumId,
    String? name,
    String? detectedSpecies,
    String? speciesId,
    String? family,
    String? genus,
    String? commonNames,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default([]) List<PlantPhotoResponse> photos,
  }) = _PlantResponse;

  factory PlantResponse.fromJson(Map<String, dynamic> json) => _$PlantResponseFromJson(json);
}

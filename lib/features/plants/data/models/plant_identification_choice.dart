import 'package:freezed_annotation/freezed_annotation.dart';
import 'plant_response.dart';
import 'identification_info.dart';

part 'plant_identification_choice.freezed.dart';
part 'plant_identification_choice.g.dart';

@freezed
abstract class PlantIdentificationChoice with _$PlantIdentificationChoice {
  const factory PlantIdentificationChoice({
    required bool resolved,
    PlantResponse? plant,
    String? pendingPhotoId,
    String? status,
    IdentificationInfo? identification,
    @Default([]) List<PlantResponse> recommendedPlants,
  }) = _PlantIdentificationChoice;

  factory PlantIdentificationChoice.fromJson(Map<String, dynamic> json) => _$PlantIdentificationChoiceFromJson(json);
}

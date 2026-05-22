import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant_confirm_request.freezed.dart';
part 'plant_confirm_request.g.dart';

@freezed
abstract class PlantConfirmRequest with _$PlantConfirmRequest {
  const factory PlantConfirmRequest({
    required String pendingPhotoId,
    required String decisionType,
    String? existingPlantId,
  }) = _PlantConfirmRequest;

  factory PlantConfirmRequest.fromJson(Map<String, dynamic> json) => _$PlantConfirmRequestFromJson(json);
}

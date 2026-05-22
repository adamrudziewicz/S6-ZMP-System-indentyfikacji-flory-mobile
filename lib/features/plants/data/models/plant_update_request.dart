import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant_update_request.freezed.dart';
part 'plant_update_request.g.dart';

@freezed
abstract class PlantUpdateRequest with _$PlantUpdateRequest {
  const factory PlantUpdateRequest({
    required String name,
  }) = _PlantUpdateRequest;

  factory PlantUpdateRequest.fromJson(Map<String, dynamic> json) => _$PlantUpdateRequestFromJson(json);
}

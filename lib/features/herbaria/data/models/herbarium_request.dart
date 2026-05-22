import 'package:freezed_annotation/freezed_annotation.dart';

part 'herbarium_request.freezed.dart';
part 'herbarium_request.g.dart';

@freezed
abstract class HerbariumRequest with _$HerbariumRequest {
  const factory HerbariumRequest({
    required String name,
    String? description,
    @JsonKey(name: 'public') @Default(false) bool isPublic,
  }) = _HerbariumRequest;

  factory HerbariumRequest.fromJson(Map<String, dynamic> json) => _$HerbariumRequestFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'herbarium_response.freezed.dart';
part 'herbarium_response.g.dart';

@freezed
abstract class HerbariumResponse with _$HerbariumResponse {
  const factory HerbariumResponse({
    required String id,
    required String userId,
    required String name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(0) int plantCount,
    @JsonKey(name: 'public') @Default(false) bool isPublic,
  }) = _HerbariumResponse;

  factory HerbariumResponse.fromJson(Map<String, dynamic> json) => _$HerbariumResponseFromJson(json);
}

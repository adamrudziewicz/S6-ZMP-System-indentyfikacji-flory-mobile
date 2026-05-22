import 'package:freezed_annotation/freezed_annotation.dart';

part 'identification_info.freezed.dart';
part 'identification_info.g.dart';

@freezed
abstract class IdentificationInfo with _$IdentificationInfo {
  const factory IdentificationInfo({
    String? detectedSpecies,
    double? confidence,
    String? speciesId,
    String? family,
    String? genus,
    String? commonNames,
  }) = _IdentificationInfo;

  factory IdentificationInfo.fromJson(Map<String, dynamic> json) => _$IdentificationInfoFromJson(json);
}

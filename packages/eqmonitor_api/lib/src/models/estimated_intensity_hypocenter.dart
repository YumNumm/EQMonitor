// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'estimated_intensity_hypocenter.freezed.dart';
part 'estimated_intensity_hypocenter.g.dart';

@Freezed()
abstract class EstimatedIntensityHypocenter with _$EstimatedIntensityHypocenter {
  const factory EstimatedIntensityHypocenter({
    required num regionCode,
    required String originTime,
    @JsonKey(includeIfNull: false)
    String? regionName,
    @JsonKey(includeIfNull: false)
    num? magnitude,
    @JsonKey(includeIfNull: false)
    num? depthKm,
  }) = _EstimatedIntensityHypocenter;
  
  factory EstimatedIntensityHypocenter.fromJson(Map<String, Object?> json) => _$EstimatedIntensityHypocenterFromJson(json);
}

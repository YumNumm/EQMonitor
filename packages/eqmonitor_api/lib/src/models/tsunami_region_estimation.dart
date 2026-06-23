// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'first_height.dart';
import 'max_height.dart';

part 'tsunami_region_estimation.freezed.dart';
part 'tsunami_region_estimation.g.dart';

@Freezed()
abstract class TsunamiRegionEstimation with _$TsunamiRegionEstimation {
  const factory TsunamiRegionEstimation({
    @JsonKey(name: 'first_height') required FirstHeight firstHeight,

    /// 津波の予想高さ(推定値)
    @JsonKey(name: 'max_height') required MaxHeight maxHeight,
  }) = _TsunamiRegionEstimation;

  factory TsunamiRegionEstimation.fromJson(Map<String, Object?> json) =>
      _$TsunamiRegionEstimationFromJson(json);
}

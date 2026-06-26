// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_region_estimation_first_height.dart';
import 'tsunami_region_estimation_max_height.dart';

part 'tsunami_region_estimation.freezed.dart';
part 'tsunami_region_estimation.g.dart';

@Freezed()
abstract class TsunamiRegionEstimation with _$TsunamiRegionEstimation {
  const factory TsunamiRegionEstimation({
    @JsonKey(name: 'first_height')
    required TsunamiRegionEstimationFirstHeight firstHeight,
    @JsonKey(name: 'max_height')
    required TsunamiRegionEstimationMaxHeight maxHeight,
  }) = _TsunamiRegionEstimation;
  
  factory TsunamiRegionEstimation.fromJson(Map<String, Object?> json) => _$TsunamiRegionEstimationFromJson(json);
}

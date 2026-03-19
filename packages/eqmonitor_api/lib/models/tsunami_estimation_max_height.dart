// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'qualitative_height.dart';

part 'tsunami_estimation_max_height.freezed.dart';
part 'tsunami_estimation_max_height.g.dart';

@Freezed()
abstract class TsunamiEstimationMaxHeight with _$TsunamiEstimationMaxHeight {
  const factory TsunamiEstimationMaxHeight({
    @JsonKey(name: 'date_time') required DateTime dateTime,
    required num value,
    required bool over,
    required QualitativeHeight qualitative,
    @JsonKey(name: 'is_observing') required bool isObserving,
  }) = _TsunamiEstimationMaxHeight;

  factory TsunamiEstimationMaxHeight.fromJson(Map<String, Object?> json) =>
      _$TsunamiEstimationMaxHeightFromJson(json);
}

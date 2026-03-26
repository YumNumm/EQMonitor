// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_estimation_first_height.dart';
import 'tsunami_estimation_max_height.dart';

part 'tsunami_estimation.freezed.dart';
part 'tsunami_estimation.g.dart';

@Freezed()
abstract class TsunamiEstimation with _$TsunamiEstimation {
  const factory TsunamiEstimation({
    required String code,
    required String name,
    @JsonKey(name: 'first_height')
    required TsunamiEstimationFirstHeight firstHeight,
    @JsonKey(name: 'max_height') required TsunamiEstimationMaxHeight maxHeight,
  }) = _TsunamiEstimation;

  factory TsunamiEstimation.fromJson(Map<String, Object?> json) =>
      _$TsunamiEstimationFromJson(json);
}

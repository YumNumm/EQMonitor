// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_accuracy.freezed.dart';
part 'eew_accuracy.g.dart';

@Freezed()
abstract class EewAccuracy with _$EewAccuracy {
  const factory EewAccuracy({
    /// 震央位置の精度値
    required num epicenter,

    /// 震源位置の精度値
    required num hypocenter,

    /// 深さの精度値
    required num depth,

    /// マグニチュードの精度値
    @JsonKey(name: 'magnitude_calculation') required num magnitudeCalculation,

    /// マグニチュード計算使用観測点数
    @JsonKey(name: 'number_of_magnitude_calculation')
    required num numberOfMagnitudeCalculation,
  }) = _EewAccuracy;

  factory EewAccuracy.fromJson(Map<String, Object?> json) =>
      _$EewAccuracyFromJson(json);
}

import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kmoni_observation_point.freezed.dart';

@freezed
abstract class AnalyzedKmoniObservationPoint
    with _$AnalyzedKmoniObservationPoint {
  const factory AnalyzedKmoniObservationPoint({
    required KyoshinObservationPoint point,
    // ここから
    double? intensityValue,
@ColorJsonConverter()
    Color? intensityColor,
    double? pga,
@ColorJsonConverter() Color? pgaColor,
  }) = _AnalyzedKmoniObservationPoint;
}

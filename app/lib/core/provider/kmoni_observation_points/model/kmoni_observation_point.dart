import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kmoni_observation_point.freezed.dart';

@freezed
abstract class AnalyzedKmoniObservationPoint
    with _$AnalyzedKmoniObservationPoint {
  const factory({
    required KyoshinObservationPoint point,
    double? intensityValue,
    @ColorJsonConverter() Color? intensityColor,
    double? pga,
    @ColorJsonConverter() Color? pgaColor,
  }) = _AnalyzedKmoniObservationPoint;
}

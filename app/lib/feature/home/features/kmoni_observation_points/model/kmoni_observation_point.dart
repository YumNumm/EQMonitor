import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_observation_point_types/kyoshin_observation_point.pb.dart';

part 'kmoni_observation_point.freezed.dart';

@freezed
class AnalyzedKmoniObservationPoint with _$AnalyzedKmoniObservationPoint {
  const factory AnalyzedKmoniObservationPoint({
    required KyoshinObservationPoint point,
    // ここから
    double? intensityValue,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    Color? intensityColor,
    double? pga,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson) Color? pgaColor,
  }) = _AnalyzedKmoniObservationPoint;
}

String? colorToJson(Color? color) {
  return color?.value.toRadixString(16);
}

Color? colorFromJson(String? color) {
  if (color == null) {
    return null;
  }
  return Color(int.parse(color, radix: 16));
}

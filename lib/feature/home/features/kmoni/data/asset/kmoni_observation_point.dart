import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kmoni_observation_point.freezed.dart';
part 'kmoni_observation_point.g.dart';

@freezed
class KmoniObservationPoint with _$KmoniObservationPoint {
  const factory KmoniObservationPoint({
    required String code,
    required String prefecture,
    required String name,
    required double lat,
    required double lon,
    required int x,
    required int y,
    required double arv,
  }) = _KmoniObservationPoint;
  const KmoniObservationPoint._();

  factory KmoniObservationPoint.fromList(List<String> list) {
    return KmoniObservationPoint(
      code: list[0],
      prefecture: list[1],
      name: list[2],
      lat: double.parse(list[3]),
      lon: double.parse(list[4]),
      x: int.parse(list[5]),
      y: int.parse(list[6]),
      arv: double.parse(list[7]),
    );
  }
}

@freezed
class AnalyzedKmoniObservationPoint with _$AnalyzedKmoniObservationPoint {
  const factory AnalyzedKmoniObservationPoint({
    required String code,
    required String prefecture,
    required String name,
    required double lat,
    required double lon,
    required int x,
    required int y,
    required double arv,
    // ここから
    double? intensityValue,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
        Color? intensityColor,
    double? pga,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
        Color? pgaColor,
  }) = _AnalyzedKmoniObservationPoint;

  factory AnalyzedKmoniObservationPoint.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedKmoniObservationPointFromJson(json);
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

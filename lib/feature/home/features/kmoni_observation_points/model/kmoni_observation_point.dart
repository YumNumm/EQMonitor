import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'kmoni_observation_point.freezed.dart';

@freezed
class KmoniObservationPoint with _$KmoniObservationPoint {
  const factory KmoniObservationPoint({
    required String code,
    required String prefecture,
    required String name,
    required LatLng latLng,
    required GlobalPoint globalPoint,
    required int x,
    required int y,
    required double arv,
  }) = _KmoniObservationPoint;

  factory KmoniObservationPoint.fromList(
    List<String> list, {
    required WebMercatorProjection projection,
  }) {
    final latLng = LatLng(double.parse(list[3]), double.parse(list[4]));
    final globalPoint = projection.project(latLng);
    return KmoniObservationPoint(
      code: list[0],
      prefecture: list[1],
      name: list[2],
      latLng: latLng,
      globalPoint: globalPoint,
      x: int.parse(list[5]),
      y: int.parse(list[6]),
      arv: double.parse(list[7]),
    );
  }
}

@freezed
class AnalyzedKmoniObservationPoint with _$AnalyzedKmoniObservationPoint {
  const factory AnalyzedKmoniObservationPoint({
    required KmoniObservationPoint point,
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

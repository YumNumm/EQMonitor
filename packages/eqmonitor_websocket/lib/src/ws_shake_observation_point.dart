import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_shake_observation_point.freezed.dart';
part 'ws_shake_observation_point.g.dart';

@freezed
abstract class WsShakeObservationPoint with _$WsShakeObservationPoint {
  const factory WsShakeObservationPoint({
    required String code,
    required String name,
    required String region,
    required String type,
    required WsShakeObservationLocation location,
    required double intensityDiff,
    double? intensity,
  }) = _WsShakeObservationPoint;

  factory WsShakeObservationPoint.fromJson(Map<String, dynamic> json) =>
      _$WsShakeObservationPointFromJson(json);
}

@freezed
abstract class WsShakeObservationLocation with _$WsShakeObservationLocation {
  const factory WsShakeObservationLocation({
    required double latitude,
    required double longitude,
  }) = _WsShakeObservationLocation;

  factory WsShakeObservationLocation.fromJson(Map<String, dynamic> json) =>
      _$WsShakeObservationLocationFromJson(json);
}

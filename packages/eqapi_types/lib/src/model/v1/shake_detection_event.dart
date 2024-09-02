import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_event.freezed.dart';
part 'shake_detection_event.g.dart';

/// YumNumm/eqproxy-io/server/telegram-proxy-server/src/service/shake-detect.ts
/// `KyoshinEventWebSocketSchema.entries`に準拠
@freezed
class ShakeDetectionEvent with _$ShakeDetectionEvent {
  const factory ShakeDetectionEvent({
    required int id,
    required String eventId,
    required int serialNo,
    required DateTime createdAt,
    required DateTime insertedAt,

    /// `Unknown`もしくは`Error`の場合、Nullにフォールバックされます
    @JsonKey(unknownEnumValue: null, defaultValue: null)
    required JmaIntensity? maxIntensity,
    required List<ShakeDetectionRegion> regions,
    required ShakeDetectionLatLng topLeft,
    required ShakeDetectionLatLng bottomRight,
    required int pointCount,
  }) = _ShakeDetectionEvent;

  factory ShakeDetectionEvent.fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionEventFromJson(json);
}

@freezed
class ShakeDetectionRegion with _$ShakeDetectionRegion {
  const factory ShakeDetectionRegion({
    required String name,
    @JsonKey(name: 'maxIntensity', unknownEnumValue: null, defaultValue: null)
    required JmaIntensity? maxIntensity,
    required List<ShakeDetectionPoint> points,
  }) = _ShakeDetectionRegion;

  factory ShakeDetectionRegion.fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionRegionFromJson(json);
}

@freezed
class ShakeDetectionPoint with _$ShakeDetectionPoint {
  const factory ShakeDetectionPoint({
    @JsonKey(unknownEnumValue: null, defaultValue: null)
    required JmaIntensity? intensity,
    required String code,
  }) = _ShakeDetectionPoint;

  factory ShakeDetectionPoint.fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionPointFromJson(json);
}

@freezed
class ShakeDetectionLatLng with _$ShakeDetectionLatLng {
  const factory ShakeDetectionLatLng({
    required double latitude,
    required double longitude,
  }) = _ShakeDetectionLatLng;

  factory ShakeDetectionLatLng.fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionLatLngFromJson(json);
}

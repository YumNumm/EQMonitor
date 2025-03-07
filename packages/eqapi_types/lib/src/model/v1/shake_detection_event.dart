import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_event.freezed.dart';
part 'shake_detection_event.g.dart';

/// YumNumm/eqproxy-io/server/telegram-proxy-server/src/service/shake-detect.ts
/// `KyoshinEventWebSocketSchema`に準拠
@freezed
class ShakeDetectionWebSocketTelegram
    with _$ShakeDetectionWebSocketTelegram
    implements V1Database {
  const factory ShakeDetectionWebSocketTelegram({
    required List<ShakeDetectionEvent> events,
  }) = _ShakeDetectionWebSocketTelegram;

  factory ShakeDetectionWebSocketTelegram.fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionWebSocketTelegramFromJson(json);
}

@freezed
class ShakeDetectionEvent with _$ShakeDetectionEvent implements V1Database {
  const factory ShakeDetectionEvent({
    @JsonKey(defaultValue: -1) required int? id,
    required String eventId,
    @JsonKey(defaultValue: -1) required int serialNo,
    required DateTime createdAt,
    required DateTime insertedAt,

    /// `Unknown`もしくは`Error`の場合、Nullにフォールバックされます
    @JsonKey(
      unknownEnumValue: JmaForecastIntensity.unknown,
      defaultValue: JmaForecastIntensity.unknown,
    )
    required JmaForecastIntensity maxIntensity,
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
    @JsonKey(
      name: 'maxIntensity',
      unknownEnumValue: JmaForecastIntensity.unknown,
      defaultValue: JmaForecastIntensity.unknown,
    )
    required JmaForecastIntensity maxIntensity,
    required List<ShakeDetectionPoint> points,
  }) = _ShakeDetectionRegion;

  factory ShakeDetectionRegion.fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionRegionFromJson(json);
}

@freezed
class ShakeDetectionPoint with _$ShakeDetectionPoint {
  const factory ShakeDetectionPoint({
    @JsonKey(
      unknownEnumValue: JmaForecastIntensity.unknown,
      defaultValue: JmaForecastIntensity.unknown,
    )
    required JmaForecastIntensity intensity,
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

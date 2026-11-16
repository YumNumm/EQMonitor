import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_event.freezed.dart';

@Freezed()
abstract class ShakeDetectionEvent with _$ShakeDetectionEvent {
  const factory({
    required String eventId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    required ShakeDetectionLevel level,
    required int pointCount,
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    String? correlatedEewEventId,
    @Default([]) List<ShakeDetectionPoint> points,
  }) = _ShakeDetectionEvent;
}

@Freezed()
abstract class ShakeDetectionPoint with _$ShakeDetectionPoint {
  const factory({
    required String code,
    required String name,
    required double latitude,
    required double longitude,
    required double? intensity,
    required double intensityDiff,
    required String? prefectureCode,
    required String? regionCode,
  }) = _ShakeDetectionPoint;
}

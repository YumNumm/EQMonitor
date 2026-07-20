import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_event.freezed.dart';

@Freezed()
abstract class ShakeDetectionEvent with _$ShakeDetectionEvent {
  const factory ShakeDetectionEvent({
    required String eventId,
    required int serialNo,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    required ShakeDetectionLevel level,
    required int pointCount,
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    required List<String> changeReasons,
    String? correlatedEewEventId,
  }) = _ShakeDetectionEvent;
}

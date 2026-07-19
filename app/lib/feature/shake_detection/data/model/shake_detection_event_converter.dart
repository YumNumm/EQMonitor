import 'package:eqmonitor/core/realtime/model/realtime_shake_data.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level_parser.dart';

extension RealtimeShakeDataConverter on RealtimeShakeData {
  ShakeDetectionEvent toShakeDetectionEvent() => ShakeDetectionEvent(
    eventId: eventId,
    createdAt: createdAt,
    level: level.toShakeDetectionLevel(),
    isReplay: isReplay,
    pointCount: pointCount,
    minLat: minLat,
    maxLat: maxLat,
    minLng: minLng,
    maxLng: maxLng,
    changeReasons: changeReasons,
  );
}

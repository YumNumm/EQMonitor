import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level_parser.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

extension ShakeDetectionStateConverter on api.ShakeDetectionState {
  ShakeDetectionEvent toShakeDetectionEvent() => ShakeDetectionEvent(
    eventId: eventId,
    serialNo: serialNo,
    createdAt: createdAt,
    updatedAt: updatedAt,
    expiresAt: expiresAt,
    level: level.toJson().toShakeDetectionLevel(),
    pointCount: pointCount,
    minLat: region.bottomRight.latitude.toDouble(),
    maxLat: region.topLeft.latitude.toDouble(),
    minLng: region.topLeft.longitude.toDouble(),
    maxLng: region.bottomRight.longitude.toDouble(),
    changeReasons: changeReasons
        .map((reason) => reason.toJson())
        .toList(growable: false),
    correlatedEewEventId: correlatedEew?.eventId,
    mergedEvents: mergedEvents,
    points: points,
    correlatedEew: correlatedEew,
  );
}

extension ShakeDetectionSnapshotConverter on api.ShakeDetectionSnapshot {
  ShakeDetectionSnapshot toShakeDetectionSnapshot() => ShakeDetectionSnapshot(
    revision: revision,
    responseAt: responseAt,
    events: events
        .map((event) => event.toShakeDetectionEvent())
        .toList(growable: false),
  );
}

extension RealtimeShakeDetectionSnapshotConverter
    on api.RealtimeShakeDetectionSnapshotPayload {
  ShakeDetectionSnapshot toShakeDetectionSnapshot() => ShakeDetectionSnapshot(
    revision: revision,
    responseAt: responseAt,
    sourceRecord: this,
    events: events
        .map((event) => event.toShakeDetectionEvent())
        .toList(growable: false),
  );
}

import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_snapshot.freezed.dart';

@Freezed()
abstract class ShakeDetectionSnapshot with _$ShakeDetectionSnapshot {
  const factory ShakeDetectionSnapshot({
    required int revision,
    required DateTime responseAt,
    required List<ShakeDetectionEvent> events,
    RealtimeShakeDetectionSnapshotPayload? sourceRecord,
  }) = _ShakeDetectionSnapshot;
}

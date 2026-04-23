import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_event.freezed.dart';

@Freezed()
abstract class ShakeDetectionEvent with _$ShakeDetectionEvent {
  const factory ShakeDetectionEvent({
    required String eventId,
    required DateTime createdAt,
    required ShakeDetectionLevel level,
    required bool isReplay,
    required int pointCount,
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    /// 結合済み EEW の eventId。null なら未結合（表示対象）
    String? mergedEewEventId,
  }) = _ShakeDetectionEvent;
}

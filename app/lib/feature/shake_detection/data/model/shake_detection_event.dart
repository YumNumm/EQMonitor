import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_event.freezed.dart';

@Freezed()
abstract class ShakeDetectionEvent with _$ShakeDetectionEvent {
  const factory ShakeDetectionEvent({
    required String eventId,

    /// Legacy realtime producer の移行完了まで nullable。REST repository は必ず設定する。
    int? serialNo,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? expiresAt,
    required ShakeDetectionLevel level,

    /// Task 6 で canonical snapshot consumer へ移行後に削除する。
    bool? isReplay,
    required int pointCount,
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    required List<String> changeReasons,

    /// Task 6 で canonical correlation/expiry consumer へ移行後に削除する。
    String? mergedEewEventId,
    String? correlatedEewEventId,
  }) = _ShakeDetectionEvent;
}

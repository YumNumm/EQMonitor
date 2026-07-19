import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_shake_snapshot.freezed.dart';
part 'realtime_shake_snapshot.g.dart';

@freezed
abstract class RealtimeShakeEventData with _$RealtimeShakeEventData {
  const factory RealtimeShakeEventData({
    required String eventId,
    required int serialNo,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    required String level,
    required int pointCount,
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    required List<String> changeReasons,
    String? correlatedEewEventId,
  }) = _RealtimeShakeEventData;

  factory RealtimeShakeEventData.fromJson(Map<String, dynamic> json) =>
      _$RealtimeShakeEventDataFromJson(json);
}

@freezed
abstract class RealtimeShakeSnapshot with _$RealtimeShakeSnapshot {
  const factory RealtimeShakeSnapshot({
    required int revision,
    required DateTime responseAt,
    required List<RealtimeShakeEventData> events,
  }) = _RealtimeShakeSnapshot;

  factory RealtimeShakeSnapshot.fromJson(Map<String, dynamic> json) =>
      _$RealtimeShakeSnapshotFromJson(json);
}

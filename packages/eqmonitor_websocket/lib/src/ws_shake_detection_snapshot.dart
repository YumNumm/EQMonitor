import 'package:eqmonitor_websocket/src/ws_shake_observation_point.dart';
import 'package:eqmonitor_websocket/src/ws_shake_payload.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_shake_detection_snapshot.freezed.dart';
part 'ws_shake_detection_snapshot.g.dart';

@freezed
abstract class WsShakeMergedEvent with _$WsShakeMergedEvent {
  const factory WsShakeMergedEvent({
    required String eventId,
    required DateTime mergedAt,
  }) = _WsShakeMergedEvent;

  factory WsShakeMergedEvent.fromJson(Map<String, dynamic> json) =>
      _$WsShakeMergedEventFromJson(json);
}

@freezed
abstract class WsShakeCorrelatedEew with _$WsShakeCorrelatedEew {
  const factory WsShakeCorrelatedEew({
    required String eventId,
    required double score,
  }) = _WsShakeCorrelatedEew;

  factory WsShakeCorrelatedEew.fromJson(Map<String, dynamic> json) =>
      _$WsShakeCorrelatedEewFromJson(json);
}

@freezed
abstract class WsShakeDetectionEvent with _$WsShakeDetectionEvent {
  const factory WsShakeDetectionEvent({
    required String type,
    required String eventId,
    required int serialNo,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    required String level,
    required List<String> changeReasons,
    required List<WsShakeMergedEvent> mergedEvents,
    required int pointCount,
    required WsShakeRegionPayload region,
    required List<WsShakeObservationPoint> points,
    WsShakeCorrelatedEew? correlatedEew,
  }) = _WsShakeDetectionEvent;

  factory WsShakeDetectionEvent.fromJson(Map<String, dynamic> json) =>
      _$WsShakeDetectionEventFromJson(json);
}

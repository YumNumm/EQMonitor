import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:eqmonitor_websocket/src/ws_estimated_intensity_payload.dart';
import 'package:eqmonitor_websocket/src/ws_shake_payload.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_event_envelope.freezed.dart';
part 'realtime_event_envelope.g.dart';

/// WebSocket `{type: "realtime", data: ...}` のペイロード。
/// `type` フィールドで分岐する discriminated union。
@Freezed(unionKey: 'type')
sealed class RealtimeEventEnvelope with _$RealtimeEventEnvelope {
  /// EEW（緊急地震速報）
  @FreezedUnionValue('EEW')
  const factory RealtimeEventEnvelope.eew({
    required EewItemWithRelations item,
  }) = WsEewRealtimeEvent;

  /// 地震情報ブロードキャスト
  @FreezedUnionValue('EARTHQUAKE')
  const factory RealtimeEventEnvelope.earthquakeBroadcast({
    required EarthquakePartial item,
  }) = WsEarthquakeBroadcastEvent;

  /// 地震情報 upsert / delete
  @FreezedUnionValue('earthquake')
  const factory RealtimeEventEnvelope.earthquake({
    required String operation,
    @JsonKey(name: 'event_id') required String eventId,
    EarthquakePartial? record,
  }) = WsEarthquakeRealtimeEvent;

  /// 津波情報 upsert / delete
  @FreezedUnionValue('tsunami')
  const factory RealtimeEventEnvelope.tsunami({
    required String operation,
    @JsonKey(name: 'event_id') required String eventId,
    Map<String, dynamic>? record,
  }) = WsTsunamiRealtimeEvent;

  /// 揺れ検知
  @FreezedUnionValue('shake_detected')
  const factory RealtimeEventEnvelope.shakeDetected({
    required String eventId,
    required DateTime createdAt,
    required String level,
    @Default([]) List<String> changeReasons,
    required bool isReplay,
    required int pointCount,
    required WsShakeRegionPayload region,
  }) = WsShakeDetectedRealtimeEvent;

  /// 推計震度
  @FreezedUnionValue('ESTIMATED_INTENSITY')
  const factory RealtimeEventEnvelope.estimatedIntensity({
    required WsEstimatedIntensityPayload estimatedIntensity,
  }) = WsEstimatedIntensityRealtimeEvent;

  factory RealtimeEventEnvelope.fromJson(Map<String, dynamic> json) =>
      _$RealtimeEventEnvelopeFromJson(json);
}

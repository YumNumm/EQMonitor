import 'package:eqmonitor_api/eqmonitor_api.dart';
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
    @JsonKey(name: 'event_id') required String eventId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required String level,
    @JsonKey(name: 'is_replay') required bool isReplay,
    @JsonKey(name: 'point_count') required int pointCount,
    @JsonKey(name: 'min_lat') required double minLat,
    @JsonKey(name: 'max_lat') required double maxLat,
    @JsonKey(name: 'min_lng') required double minLng,
    @JsonKey(name: 'max_lng') required double maxLng,
  }) = WsShakeDetectedRealtimeEvent;

  /// 推計震度
  @FreezedUnionValue('ESTIMATED_INTENSITY')
  const factory RealtimeEventEnvelope.estimatedIntensity() =
      WsEstimatedIntensityRealtimeEvent;

  factory RealtimeEventEnvelope.fromJson(Map<String, dynamic> json) =>
      _$RealtimeEventEnvelopeFromJson(json);
}

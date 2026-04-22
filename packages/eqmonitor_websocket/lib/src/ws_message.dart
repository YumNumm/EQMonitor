import 'package:eqmonitor_websocket/src/realtime_event_envelope.dart';
import 'package:eqmonitor_websocket/src/ws_snapshot_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_message.freezed.dart';
part 'ws_message.g.dart';

/// WebSocket から受信するトップレベルメッセージ。
/// `type` フィールドで分岐する discriminated union。
/// `ping` はプロバイダー側で処理されるためここには含まれない。
@Freezed(unionKey: 'type')
sealed class WsMessage with _$WsMessage {
  @FreezedUnionValue('snapshot')
  const factory WsMessage.snapshot({
    required WsSnapshotData data,
  }) = WsSnapshotMessage;

  @FreezedUnionValue('realtime')
  const factory WsMessage.realtime({
    required RealtimeEventEnvelope data,
  }) = WsRealtimeMessage;

  factory WsMessage.fromJson(Map<String, dynamic> json) =>
      _$WsMessageFromJson(json);
}

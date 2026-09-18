import 'package:eqmonitor_websocket/src/realtime_event_envelope.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_message.freezed.dart';
part 'ws_message.g.dart';

/// WebSocket から受信するトップレベルメッセージ。
/// `type` フィールドで分岐する discriminated union。
@Freezed(unionKey: 'type', toJson: false)
sealed class WsMessage with _$WsMessage {
  @FreezedUnionValue('realtime')
  const factory realtime({required RealtimeEventEnvelope data}) =
      WsRealtimeMessage;

  /// サーバー起因の生存確認 ping。`{"type":"pong"}` を返す必要がある。
  @FreezedUnionValue('ping')
  const factory ping() = WsPingMessage;

  /// クライアント起因 ping への応答。[pingId] は送信した値の echo。
  ///
  /// pingId を持たない古いサーバー実装にも耐えられるよう nullable にしている。
  @FreezedUnionValue('pong')
  const factory pong({String? pingId}) = WsPongMessage;

  @FreezedUnionValue('ready')
  const factory ready() = WsReadyMessage;

  factory fromJson(Map<String, dynamic> json) =>
      _$WsMessageFromJson(json);
}

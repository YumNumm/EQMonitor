import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_client_ping_message.freezed.dart';
part 'ws_client_ping_message.g.dart';

/// RTT 計測のためにクライアントから送信する ping。
///
/// サーバーは [pingId] をそのまま echo した `{"type":"pong","pingId":...}` を
/// 返す。クライアントは送信時刻との差分を RTT とする。
///
/// サーバー起因 ping (`{"type":"ping"}`, pingId なし) とは別系統で、
/// 接続の生存判定には使われない。
@freezed
abstract class WsClientPingMessage with _$WsClientPingMessage {
  const factory({
    required String pingId,
    @Default('ping') String type,
  }) = _WsClientPingMessage;

  factory fromJson(Map<String, dynamic> json) =>
      _$WsClientPingMessageFromJson(json);
}

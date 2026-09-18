import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_client_pong_message.freezed.dart';
part 'ws_client_pong_message.g.dart';

/// サーバー起因 ping (`{"type":"ping"}`) への応答として送信する pong。
///
/// サーバーはこれを 15 秒以内に受け取れないと接続を切断する。
/// クライアント起因 ping への応答である受信側の pong は [WsPongMessage]。
@freezed
abstract class WsClientPongMessage with _$WsClientPongMessage {
  const factory({
    @Default('pong') String type,
  }) = _WsClientPongMessage;

  factory fromJson(Map<String, dynamic> json) =>
      _$WsClientPongMessageFromJson(json);
}

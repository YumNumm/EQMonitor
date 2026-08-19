import 'dart:convert';

import 'package:eqmonitor_websocket/src/ws_client_pong_message.dart';

/// サーバー起因 ping (`{"type":"ping"}`) に pong を返す。
///
/// クライアント起因 ping の RTT 計測は [WsRttTracker] 側の責務。
class WsHeartbeatResponder {
  const new();

  String? buildResponse(String text) {
    try {
      final json = jsonDecode(text);
      if (json is! Map<String, dynamic>) {
        return null;
      }
      if (json['type'] != 'ping') {
        return null;
      }
      return jsonEncode(const WsClientPongMessage().toJson());
    } on FormatException {
      return null;
    }
  }
}

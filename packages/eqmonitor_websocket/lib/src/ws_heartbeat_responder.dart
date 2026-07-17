import 'dart:convert';

import 'package:eqmonitor_websocket/src/ws_pong_message.dart';

class WsHeartbeatResponder {
  const WsHeartbeatResponder();

  String? buildResponse(String text) {
    try {
      final json = jsonDecode(text);
      if (json is! Map<String, dynamic>) {
        return null;
      }
      if (json['type'] != 'ping') {
        return null;
      }
      return jsonEncode(const WsPongMessage().toJson());
    } on FormatException {
      return null;
    }
  }
}

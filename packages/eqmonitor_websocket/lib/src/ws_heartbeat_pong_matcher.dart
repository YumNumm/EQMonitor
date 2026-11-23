import 'dart:convert';

class const WsHeartbeatPongMatcher({required final String pingId}) {
  bool matches(String text) {
    try {
      final json = jsonDecode(text);
      return json is Map<String, dynamic> &&
          json['type'] == 'pong' &&
          json['pingId'] == pingId;
    } on FormatException {
      return false;
    }
  }
}

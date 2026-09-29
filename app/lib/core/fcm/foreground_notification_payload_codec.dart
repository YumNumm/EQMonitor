import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

class const ForegroundNotificationPayloadCodec() {
  String encode(RemoteMessage message) => jsonEncode({
    'type': 'eqmonitor.foregroundNotification',
    'data': message.data,
  });

  RemoteMessage? decode(String? payload) {
    if (payload == null) {
      return null;
    }
    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map<String, dynamic> &&
          decoded['type'] == 'eqmonitor.foregroundNotification') {
        final data = decoded['data'];
        if (data is Map<String, dynamic>) {
          return RemoteMessage(data: data);
        }
      }
    } on FormatException {
      return null;
    }
    return null;
  }
}

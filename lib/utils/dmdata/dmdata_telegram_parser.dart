// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';
import 'dart:io';

import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import 'package:dmdata_telegram_json/schema/dmdata/websocket_v2/websocket_v2_data.dart';

class DmDataTelegramParser {
  static Future<void> parse(WebSocketV2Data wsdata) async {
    switch (wsdata.head.type) {
      // EEW(予報)
      case 'VXSE44':
        final unZippedPayload = utf8.decode(
          gzip.decode(
            base64.decode(
              base64.normalize(wsdata.body),
            ),
          ),
        );
        final j = jsonDecode(unZippedPayload) as Map<String, dynamic>;
        final commonHead = TelegramJsonMain.fromJson(j);
        final eew = EewInformation.fromJson(commonHead.body);
        break;
      default:
        break;
    }
  }
}

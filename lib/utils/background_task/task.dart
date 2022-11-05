// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import 'package:dmdata_telegram_json/schema/dmdata/websocket_v2/websocket_v2_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/io.dart';

import '../../env/env.dart';
import '../../ui/theme/jma_intensity.dart';

// The callback function should always be a top-level function.
@pragma('vm:entry-point')
void startForegroundTask() {
  Logger().d('startForegroundTask');
  FlutterForegroundTask.setTaskHandler(FirstTaskHandler());
}

class FirstTaskHandler extends TaskHandler {
  IOWebSocketChannel? ws;

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    ws = IOWebSocketChannel.connect(Env.eqmonitorWebSocketUrl);
    ws!.stream.listen((event) {
      final json = jsonDecode(event.toString());
      if (json['type'] == 'pong' && json['measure'] != null) {
        final ping = double.tryParse(json['measure']['duration'].toString());
        FlutterForegroundTask.updateService(
          notificationText: '接続済み '
              'Ping: ${ping?.toStringAsFixed(2)}ms '
              '${DateTime.now()}',
        );
        return;
      }
      if (json['type'] == 'data') {
        // 電文解析
        final wsdata = WebSocketV2Data.fromJson(json);
        switch (wsdata.head.type) {
          case 'VXSE44':
            // 緊急地震速報(予報)
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
            // 通常報以外は無視
            if (commonHead.status != TelegramStatus.normal) {
              return;
            }

            final iconUrl =
                'asset://assets/intensity/${eew.intensity?.forecastMaxInt.from.name ?? 'unknown'}.PNG';

            final msg = StringBuffer();
            final isTesting = commonHead.status != TelegramStatus.normal;

            msg.writeAll(
              <String>[
                if (eew.earthquake?.hypocenter.name != null)
                  '${eew.earthquake?.hypocenter.name}で',
                '予想最大震度${((eew.intensity?.forecastMaxInt.to == JmaIntensity.over) ? ('${eew.intensity!.forecastMaxInt.from.name}程度以上') : eew.intensity?.forecastMaxInt.to.name ?? "不明").replaceAll("-", "弱").replaceAll("+", "強")}の地震',
                '\n',
                if (eew.isLastInfo)
                  '(最終 第${commonHead.serialNo}報)'
                else
                  '(継続 第${commonHead.serialNo}報)',
                if (eew.earthquake?.condition == '仮定震源要素') ' 仮定震源要素による推定',
                '\n',
              ],
            );
            if (!((eew.earthquake?.condition ?? '仮定震源要素') == '仮定震源要素')) {
              msg.writeAll(
                <String>[
                  '深さ ',
                  if (eew.earthquake!.hypocenter.depth.condition != null)
                    eew.earthquake!.hypocenter.depth.condition!.toString()
                  else if (eew.earthquake?.hypocenter.depth.value != null)
                    '約${eew.earthquake?.hypocenter.depth.value}km'
                  else
                    '不明',
                  ' ',
                  if (eew.earthquake?.magnitude.condition != null)
                    eew.earthquake!.magnitude.condition!
                  else if (eew.earthquake?.magnitude.value != null)
                    'M${eew.earthquake!.magnitude.value}'
                  else
                    'M不明',
                  ' ',
                ],
              );
            }
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: int.parse(commonHead.eventId.toString()) % 1000,
                channelKey: 'VXSE54',
                color: Colors.red,
                criticalAlert: true,
                wakeUpScreen: true,
                title: '${isTesting ? '[テスト]' : ''}'
                    '緊急地震速報 ('
                    '${(eew.comments?.warning?.codes ?? []).contains(201) ? '警報' : '予報'}'
                    '${eew.earthquake!.condition == '仮定震源要素' ? ' - PULM法)' : ')'}',
                body: '$msg\n${DateTime.now()}',
                notificationLayout: NotificationLayout.Messaging,
              ),
            );
            return;
          case 'VXSE42':
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 10,
                channelKey: 'VXSE54',
                color: const Color.fromARGB(255, 0, 42, 255),
                criticalAlert: true,
                wakeUpScreen: true,
                title: '緊急地震速報テストを受信しました',
                body: '${wsdata.body}\n${DateTime.now()}',
                notificationLayout: NotificationLayout.Messaging,
              ),
            );
            return;

          default:
        }
      }
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: 'VXSE54',
          title: 'WebSocket',
          body: '$event',
        ),
      );
      if (kDebugMode) {
        print('${event.runtimeType} $event');
      }
    });

    await FlutterForegroundTask.updateService(
      notificationText: '接続済み: Ping: 計測待ち',
    );
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {}

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {}
}

// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eqmonitor/model/setting/notification_settings_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final stopwatch = Stopwatch()..start();
  await Firebase.initializeApp();
  // prefsのセットアップ
  if (Platform.isAndroid) SharedPreferencesAndroid.registerWith();
  if (Platform.isIOS) SharedPreferencesIOS.registerWith();
  final prefs = await SharedPreferences.getInstance();
  final flutterTts = FlutterTts();
  await flutterTts.setLanguage('ja-JP');
  final crashlytics = FirebaseCrashlytics.instance;
  await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
  FlutterError.onError = (details) async {
    FlutterError.dumpErrorToConsole(details);
    await FirebaseCrashlytics.instance.recordFlutterError(details);
  };

  final notificationSettings = NotificationSettingsModel.load(prefs);

  // try {
  //   if (message.data['url'] != null && message.data['type'] != null) {
  //     final dio = Dio();
  //     final res = await dio.get(message.data['url']);
  //     // base64 -> gzip
  //     final payload = res.data as Map<String, dynamic>;
  //     // 電文タイプごとの処理
  //     final telegramType = DmDssTelegramDataType.values
  //         .firstWhere((e) => e.toString() == message.data['type']);
  //     switch (telegramType) {
  //       case DmDssTelegramDataType.VXSE42:
  //       case DmDssTelegramDataType.VXSE44:
  //         final commonHead = CommonHead.fromJson(payload);
  //         final eew = EEWInformation.fromJson(commonHead.body);
  //         final msg = StringBuffer();
  //         final tts = StringBuffer();
//
  //         msg.writeAll(
  //           <String>[
  //             if (eew.earthQuake?.hypoCenter.name != null)
  //               '${eew.earthQuake?.hypoCenter.name}で',
  //             '予想最大震度${((eew.intensity?.maxint.to == JmaIntensity.over) ? ('${eew.intensity!.maxint.from.name}程度以上') : eew.intensity?.maxint.to.name ?? "不明").replaceAll("-", "弱").replaceAll("+", "強")}の地震',
  //             '\n',
  //             if (eew.isLastInfo)
  //               '(最終 第${commonHead.serialNo}報)'
  //             else
  //               '(継続 第${commonHead.serialNo}報)',
  //             if (eew.earthQuake?.isAssuming ?? false) ' 仮定震源要素による推定',
  //             '\n',
  //           ],
  //         );
  //         tts.writeAll(<String>[
  //           '緊急地震速報 予報、',
  //           if (eew.isLastInfo)
  //             '最終、第${commonHead.serialNo}報、'
  //           else
  //             '第${commonHead.serialNo}報、',
  //           if (eew.earthQuake?.isAssuming ?? true) 'PLUM法、',
  //           '予想最大震度、',
  //           if (eew.intensity?.maxint.to == JmaIntensity.over)
  //             '${eew.intensity!.maxint.from.name}程度以上'
  //           else if (eew.intensity?.maxint.to != null)
  //             eew.intensity!.maxint.to.name
  //           else
  //             '不明',
  //         ]);
//
  //         if (!(eew.earthQuake?.isAssuming ?? true)) {
  //           msg.writeAll(
  //             <String>[
  //               '深さ ',
  //               if (eew.earthQuake!.hypoCenter.depth.condition != null)
  //                 eew.earthQuake!.hypoCenter.depth.condition!.description
  //                     .toString()
  //               else if (eew.earthQuake?.hypoCenter.depth.value != null)
  //                 '約${eew.earthQuake?.hypoCenter.depth.value}km'
  //               else
  //                 '不明',
  //               ' ',
  //               if (eew.earthQuake?.magnitude.condition != null)
  //                 eew.earthQuake!.magnitude.condition!.description.toString()
  //               else if (eew.earthQuake?.magnitude.value != null)
  //                 'M${eew.earthQuake!.magnitude.value}'
  //               else
  //                 'M不明',
  //               ' ',
  //             ],
  //           );
  //           tts.writeAll(
  //             <String>[
  //               '深さ ',
  //               if (eew.earthQuake!.hypoCenter.depth.condition != null)
  //                 eew.earthQuake!.hypoCenter.depth.condition!.description
  //                     .toString()
  //               else if (eew.earthQuake?.hypoCenter.depth.value != null)
  //                 '約${eew.earthQuake?.hypoCenter.depth.value}km'
  //               else
  //                 '不明',
  //               ' ',
  //               if (eew.earthQuake?.magnitude.condition != null)
  //                 eew.earthQuake!.magnitude.condition!.description.toString()
  //               else if (eew.earthQuake?.magnitude.value != null)
  //                 'マグニチュード${eew.earthQuake!.magnitude.value.toString().replaceAll('.', '点')}'
  //               else
  //                 'マグニチュード不明',
  //               ' ',
  //             ],
  //           );
  //         }
  //         await AwesomeNotifications().createNotification(
  //           content: NotificationContent(
  //             color: Colors.pi ,
  //             id: (int.tryParse(commonHead.eventId.toString()) ??
  //                     DmDssTelegramDataType.VXSE44.index) %
  //                 1024,
  //             channelKey: 'eew_alert',
  //             title: ('緊急地震速報 (予報') +
  //                 ((eew.earthQuake!.isAssuming) ? ' - PULM法)' : ')'),
  //             body: msg.toString(),
  //           ),
  //         );
  //         print('${stopwatch.elapsed.inMicroseconds / 1000}ms');
  //         return;
  //       default:
  //     }
  //   }
  // } catch (e) {
  await AwesomeNotifications().createNotificationFromJsonData(message.data);

  if (message.data['tts'] != null && notificationSettings.useTts) {
    await flutterTts.speak(message.data['tts'].toString());
  }
  // }

  print('通知処理が終了: ${stopwatch.elapsed.inMicroseconds / 1000}ms');
}

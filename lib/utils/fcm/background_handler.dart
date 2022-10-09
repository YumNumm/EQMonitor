// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eqmonitor/model/setting/notification_settings_model.dart';
import 'package:eqmonitor/schema/remote/dmdata/websocketv2/type.dart';
import 'package:eqmonitor/schema/remote/eqmonitor/eew_payload.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final stopwatch = Stopwatch()..start();
  // prefsのセットアップ
  if (Platform.isAndroid) SharedPreferencesAndroid.registerWith();
  if (Platform.isIOS) SharedPreferencesIOS.registerWith();
  final prefs = await SharedPreferences.getInstance();
  final notificationSettings = NotificationSettingsModel.load(prefs);
  // EEWかどうか
  if (message.data['type'].toString() == DmDssTelegramDataType.VXSE44.name) {
    final payload =
        EewPayload.fromJson(message.data['payload'] as Map<String, dynamic>);
    // 最大震度の確認
    if (payload.intensity != null) {
      if (!(payload.intensity!.maxint.from.intValue >=
          notificationSettings.intensityThreshold.intValue)) {
        return;
      }
      if (!((payload.magnitude ?? 0.0) >=
          notificationSettings.magnitudeThreshold)) {
        return;
      }
    }
    if (payload.accuracy != null) {
      if (payload.accuracy!.epicCenterAccuracy.epicCenterAccuracy.code == 1 &&
          payload.accuracy!.epicCenterAccuracy.hypoCenterAccuracy == 1 &&
          !message.data['content']['title'].toString().contains('警報')) {
        return;
      }
    }
  }

  await AwesomeNotifications().createNotificationFromJsonData(message.data);

  if (message.data['tts'] != null && notificationSettings.useTts) {
    final flutterTts = FlutterTts();
    await flutterTts.setLanguage('ja-JP');
    await flutterTts.speak(message.data['tts'].toString());
  }
}

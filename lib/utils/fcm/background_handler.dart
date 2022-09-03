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
  // prefsのセットアップ
  if (Platform.isAndroid) SharedPreferencesAndroid.registerWith();
  if (Platform.isIOS) SharedPreferencesIOS.registerWith();
  final prefs = await SharedPreferences.getInstance();
  print('prefs: ${stopwatch.elapsed.inMicroseconds/1000}ms');

  final notificationSettings = NotificationSettingsModel.load(prefs);
  print('load: ${stopwatch.elapsed.inMicroseconds / 1000}ms');

  await AwesomeNotifications().createNotificationFromJsonData(message.data);

  if (message.data['tts'] != null && notificationSettings.useTts) {
    final flutterTts = FlutterTts();
    await flutterTts.setLanguage('ja-JP');
    await flutterTts.speak(message.data['tts'].toString());
  }
  // }

  print('通知処理が終了: ${stopwatch.elapsed.inMicroseconds / 1000}ms');
}

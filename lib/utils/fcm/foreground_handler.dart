// ignore_for_file: constant_identifier_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eqmonitor/model/setting/notification_settings_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> firebaseMessagingForegroundHandler(RemoteMessage message) async {
  await AwesomeNotifications().createNotificationFromJsonData(message.data);
  final prefs = await SharedPreferences.getInstance();

  if (message.data['tts'] != null &&
      NotificationSettingsModel.load(prefs).useTts) {
    final flutterTts = FlutterTts();
    await flutterTts.setLanguage('ja-JP');
    await flutterTts.speak(message.data['tts'].toString());
  }
}

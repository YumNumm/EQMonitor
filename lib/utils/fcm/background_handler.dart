// ignore_for_file: constant_identifier_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final deviceInfo = await DeviceInfoPlugin().androidInfo;
  final crashlytics = FirebaseCrashlytics.instance;
  await crashlytics.setUserIdentifier(deviceInfo.androidId.toString());
  await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
  FlutterError.onError = (details) async {
    FlutterError.dumpErrorToConsole(details);
    await FirebaseCrashlytics.instance.recordFlutterError(details);
  };

  await AwesomeNotifications().createNotificationFromJsonData(message.data);
  final flutterTts = FlutterTts();
  await flutterTts.setLanguage('ja-JP');
  if (message.data['tts'] != null) {
    await flutterTts.speak(message.data['tts'].toString());
  }
}

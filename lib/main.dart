import 'dart:developer';

import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcmToken = await getFirebaseMessagingToken();
  log('Firebase token: $fcmToken');
  await Permission.notification.request();
  await FirebaseMessaging.instance.subscribeToTopic('config-developer');
  await FirebaseMessaging.instance.subscribeToTopic('eew-all');
  return runApp(const App());
}

// Request FCM token to Firebase
Future<String> getFirebaseMessagingToken() async {
  var firebaseAppToken = '';
  if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
    try {
      firebaseAppToken =
          await AwesomeNotificationsFcm().requestFirebaseAppToken();
    } on Exception catch (exception) {
      log('$exception');
    }
  } else {
    log('Firebase is not available on this project');
  }
  return firebaseAppToken;
}

import 'dart:async';
import 'dart:developer';

import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/common/provider/shared_preferences.dart';
import 'package:eqmonitor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final fcmToken = await getFirebaseMessagingToken();
  log('Firebase token: $fcmToken');
  if (kDebugMode) {
    unawaited(FirebaseMessaging.instance.subscribeToTopic('config-developer'));
  }
  unawaited(FirebaseMessaging.instance.subscribeToTopic('eew-all'));
  unawaited(FirebaseMessaging.instance.subscribeToTopic('earthquake-all'));
  unawaited(FirebaseMessaging.instance.subscribeToTopic('everyone'));

  return runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const App(),
    ),
  );
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

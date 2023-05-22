import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/common/provider/shared_preferences.dart';
import 'package:eqmonitor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final prefs = await SharedPreferences.getInstance();
  String? fcmToken;
  if (Platform.isAndroid || Platform.isIOS) {
    fcmToken = await getFirebaseMessagingToken();
    unawaited(() async {
      await Permission.notification.request();
      log('Firebase token: $fcmToken');
      if (kDebugMode) {
        unawaited(
          FirebaseMessaging.instance.subscribeToTopic('config-developer'),
        );
        log('config-developer OK ');
      }
      await FirebaseMessaging.instance.subscribeToTopic('everyone');
      log('everyone OK');
      await FirebaseMessaging.instance.subscribeToTopic('eew');
      log('eew OK');
      await FirebaseMessaging.instance.subscribeToTopic('earthquake');
      log('earthquake OK');
    }());
  }
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

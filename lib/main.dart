import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/fcm/notification_controller.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final talker = TalkerFlutter.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationController.initializeLocalNotifications(debug: kDebugMode);
  await NotificationController.initializeRemoteNotifications(debug: kDebugMode);
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (error) {
    talker.handle(error.exception, error.stack, 'Uncaught fatal exception');
  };
  // Pass all uncaught asynchronous errors that aren't handled
  // by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'Uncaught async exception');
    return true;
  };

  final prefs = await SharedPreferences.getInstance();
  if (Platform.isAndroid || Platform.isIOS) {
    unawaited(() async {
      if (kDebugMode) {
        unawaited(
          FirebaseMessaging.instance.subscribeToTopic('config-developer'),
        );
        talker.log('config-developer OK ');
      }
      await FirebaseMessaging.instance.subscribeToTopic('everyone');
      talker.log('everyone OK');
      await FirebaseMessaging.instance.subscribeToTopic('eew');
      talker.log('eew OK');
      await FirebaseMessaging.instance.subscribeToTopic('earthquake');
      talker.log('earthquake OK');
    }());
  }

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        talkerProvider.overrideWithValue(talker),
      ],
      child: const App(),
    ),
  );
}

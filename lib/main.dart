import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/fcm/notification_controller.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/provider/kmoni_observation_points_provider.dart';
import 'package:eqmonitor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  final results = await (
    SharedPreferences.getInstance(),
    loadKmoniObservationPoints(),
  ).wait;
  if (Platform.isAndroid || Platform.isIOS) {
    final fcm = FirebaseMessaging.instance;
    unawaited(
      (
        fcm.subscribeToTopic('everyone'),
        fcm.subscribeToTopic('eew'),
        fcm.subscribeToTopic('earthquake'),
      ).wait,
    );
  }

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(results.$1),
        kmoniObservationPointsProvider.overrideWithValue(results.$2),
        talkerProvider.overrideWithValue(talker),
      ],
      child: const App(),
    ),
  );
}

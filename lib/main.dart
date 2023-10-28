import 'dart:async';
import 'dart:developer';
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
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    NotificationController.initializeLocalNotifications(debug: kDebugMode),
    NotificationController.initializeRemoteNotifications(debug: kDebugMode),
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
      observers: [
        if (kDebugMode)
          Observer(
            talker,
          ),
      ],
      child: const App(),
    ),
  );
}

class Observer extends ProviderObserver {
  Observer(this.talker);

  final Talker talker;

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) =>
      log('didAddProvider: ${provider.name} ($value)}');

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) =>
      log('didDisposeProvider: ${provider.name}');

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {}

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) =>
      talker.handle(error, stackTrace, 'providerDidFail: ${provider.name}');
}

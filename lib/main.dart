import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/fcm/channels.dart';
import 'package:eqmonitor/core/provider/custom_provider_observer.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/provider/kmoni_observation_points_provider.dart';
import 'package:eqmonitor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = TalkerFlutter.init();
  FlutterError.onError = (error) {
    talker.handle(error.exception, error.stack, 'Uncaught fatal exception');
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordFlutterError(error);
    }
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'Uncaught async exception');
    if (kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  final deviceInfo = DeviceInfoPlugin();

  final prefs = await SharedPreferences.getInstance();
  final kmoni = await loadKmoniObservationPoints();
  await kIsWeb
      ? Future<Null>.value()
      : Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
  final packageInfo = await PackageInfo.fromPlatform();
  // ignore: prefer_void_to_null
  final androidInfo = await (!kIsWeb && Platform.isAndroid
      ? deviceInfo.androidInfo
      : Future<Null>.value());
  // ignore: prefer_void_to_null
  final iosInfo = await (!kIsWeb && Platform.isIOS
      ? deviceInfo.iosInfo
      : Future<Null>.value());
  await FlutterLocalNotificationsPlugin().initialize(
    const InitializationSettings(
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestSoundPermission: false,
        requestBadgePermission: false,
      ),
      android: AndroidInitializationSettings('mipmap/ic_launcher'),
    ),
  );
  await _registerNotificationChannelIfNeeded();

  if (!kIsWeb) {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);
  }
  print('kDebugMode: $kDebugMode');
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        kmoniObservationPointsProvider.overrideWithValue(kmoni),
        talkerProvider.overrideWithValue(talker),
        packageInfoProvider.overrideWithValue(packageInfo),
        if (androidInfo != null)
          androidDeviceInfoProvider.overrideWithValue(androidInfo),
        if (iosInfo != null) iosDeviceInfoProvider.overrideWithValue(iosInfo),
      ],
      observers: [
        if (kDebugMode)
          CustomProviderObserver(
            talker,
          ),
      ],
      child: const App(),
    ),
  );
}

Future<void> _registerNotificationChannelIfNeeded() async {
  final androidNotificationPlugin = FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  if (androidNotificationPlugin == null) {
    return;
  }
  for (final group in notificationChannelGroups) {
    await androidNotificationPlugin.createNotificationChannelGroup(group);
  }
  for (final channel in notificationChannels) {
    await androidNotificationPlugin.createNotificationChannel(channel);
  }
}

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  log('onBackgroundMessage: $message');
}

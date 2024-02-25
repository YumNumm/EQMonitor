import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/fcm/channels.dart';
import 'package:eqmonitor/core/provider/application_documents_directory.dart';
import 'package:eqmonitor/core/provider/custom_provider_observer.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
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
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

late final ProviderContainer container;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final talker = TalkerFlutter.init(
    logger: TalkerLogger(),
  )..configure(
      observer: CrashlyticsTalkerObserver(),
    );

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

  final results = await (
    SharedPreferences.getInstance(),
    loadKmoniObservationPoints(),
    PackageInfo.fromPlatform(),
    // ignore: prefer_void_to_null
    (!kIsWeb && Platform.isAndroid
        ? deviceInfo.androidInfo
        : Future<Null>.value()),
    // ignore: prefer_void_to_null
    (!kIsWeb && Platform.isIOS ? deviceInfo.iosInfo : Future<Null>.value()),
    FlutterLocalNotificationsPlugin().initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          requestBadgePermission: false,
        ),
        android: AndroidInitializationSettings('mipmap/ic_launcher'),
      ),
    ),
    _registerNotificationChannelIfNeeded(),
    getApplicationDocumentsDirectory(),
    loadJmaCodeTable(),
  ).wait;

  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  unawaited(
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode),
  );
  container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(results.$1),
      kmoniObservationPointsProvider.overrideWithValue(results.$2),
      talkerProvider.overrideWithValue(talker),
      packageInfoProvider.overrideWithValue(results.$3),
      if (results.$4 != null)
        androidDeviceInfoProvider.overrideWithValue(results.$4!),
      if (results.$5 != null)
        iosDeviceInfoProvider.overrideWithValue(results.$5!),
      applicationDocumentsDirectoryProvider.overrideWithValue(results.$8),
      jmaCodeTableProvider.overrideWithValue(results.$9),
    ],
    observers: [
      if (kDebugMode)
        CustomProviderObserver(
          talker,
        ),
    ],
  );
  runApp(
    ProviderScope(
      parent: container,
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

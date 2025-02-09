// ignore_for_file: unreachable_from_main, prefer_void_to_null

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/fcm/channels.dart';
import 'package:eqmonitor/core/provider/application_documents_directory.dart';
import 'package:eqmonitor/core/provider/config/permission/permission_notifier.dart';
import 'package:eqmonitor/core/provider/custom_provider_observer.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/core/util/license/init_licenses.dart';
import 'package:eqmonitor/feature/donation/data/donation_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/kyoshin_color_map_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_color_map.dart';
import 'package:eqmonitor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
    ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  talker = TalkerFlutter.init(
    settings: TalkerSettings(
      // ignore: avoid_redundant_argument_values
      useConsoleLogs: kDebugMode,
    ),
  );
  if (!kIsWeb) {
    talker.configure(
      observer: CrashlyticsTalkerObserver(),
    );
  }

  FlutterError.onError = (error) {
    final exception = error.exception;
    if (exception is ParallelWaitError) {
      talker
        ..handle(exception, error.stack, 'Uncaught fatal exception')
        ..log(exception.errors.toString());
      final stackTrace = error.stack;
      if (stackTrace != null) {
        talker.log(stackTrace.toString());
      }
    }
    talker.handle(error.exception, error.stack, 'Uncaught fatal exception');
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'Uncaught async exception');
    final exception = error;
    log(
      'Uncaught async exception: ${exception.runtimeType} $exception',
      name: 'main',
    );
    if (exception is ParallelWaitError) {
      talker
        ..log(exception.errors.toString())
        ..log(exception.stackTrace.toString());
    }
    return true;
  };

  final deviceInfo = DeviceInfoPlugin();

  final results = await (
    (
      SharedPreferences.getInstance(),
      PackageInfo.fromPlatform(),
      (!kIsWeb && Platform.isAndroid
          ? deviceInfo.androidInfo
          : Future<Null>.value()),
      (!kIsWeb && Platform.isIOS ? deviceInfo.iosInfo : Future<Null>.value()),
      kIsWeb ? Future<Null>.value() : _registerNotificationChannelIfNeeded(),
      kIsWeb ? Future<Null>.value() : getApplicationDocumentsDirectory(),
      loadJmaCodeTable(),
      kIsWeb
          ? Future<Null>.value()
          : FlutterLocalNotificationsPlugin().initialize(
              const InitializationSettings(
                iOS: DarwinInitializationSettings(
                  requestAlertPermission: false,
                  requestSoundPermission: false,
                  requestBadgePermission: false,
                ),
                android: AndroidInitializationSettings('mipmap/ic_launcher'),
                macOS: DarwinInitializationSettings(
                  requestAlertPermission: false,
                  requestSoundPermission: false,
                  requestBadgePermission: false,
                ),
              ),
            ),
    ).wait,
    (
      initInAppPurchase(),
      initLicenses(),
      kIsWeb ? Future<Null>.value() : getKyoshinColorMap(),
      !kIsWeb && Platform.isIOS
          ? SharedPreferenceAppGroup.setAppGroup('group.net.yumnumm.eqmonitor')
          : Future<void>.value(),
    ).wait,
  ).wait;

  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  if (!kIsWeb) {
    unawaited(
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode),
    );
  }

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(results.$1.$1),
      packageInfoProvider.overrideWithValue(results.$1.$2),
      if (results.$1.$3 != null)
        androidDeviceInfoProvider.overrideWithValue(results.$1.$3!),
      if (results.$1.$4 != null)
        iosDeviceInfoProvider.overrideWithValue(results.$1.$4!),
      applicationDocumentsDirectoryProvider.overrideWithValue(results.$1.$6!),
      jmaCodeTableProvider.overrideWithValue(results.$1.$7),
      if (results.$2.$3 != null)
        kyoshinColorMapProvider.overrideWithValue(results.$2.$3!),
    ],
    observers: [
      if (kDebugMode)
        CustomProviderObserver(
          talker,
        ),
    ],
  );

  await (
    container
        .read(kyoshinMonitorInternalObservationPointsConvertedProvider.future),
    container.read(travelTimeInternalProvider.future),
    container.read(permissionNotifierProvider.notifier).initialize(),
  ).wait;

  runApp(
    UncontrolledProviderScope(
      container: container,
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

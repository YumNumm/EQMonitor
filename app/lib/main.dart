// ignore_for_file: prefer_void_to_null

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:core/core.dart' as core;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/fcm/channels.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';
import 'package:eqmonitor/core/provider/application_documents_directory.dart';
import 'package:eqmonitor/core/provider/custom_provider_observer.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/core/util/license/init_licenses.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/kyoshin_color_map_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_color_map.dart';
import 'package:eqmonitor/feature/live_activity/data/repository/live_activity_token_sync_service.dart';
import 'package:eqmonitor/feature/location/data/background_location_service.dart';
import 'package:eqmonitor/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:shared_preferences/shared_preferences.dart'
    hide SharedPreferencesAsync;
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  try {
    await _main();
  } on Object catch (error, stackTrace) {
    WidgetsFlutterBinding.ensureInitialized();
    unawaited(_recordStartupError(error, stackTrace));
    runApp(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Center(child: ErrorCard(error: error)),
          ),
        ),
      ),
    );
  }
}

Future<void> _recordStartupError(Object error, StackTrace stackTrace) async {
  if (kIsWeb || Firebase.apps.isEmpty) {
    return;
  }
  try {
    await FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      fatal: true,
    );
  } on Object {
    // 起動失敗時のフォールバック表示を優先する。
  }
}

Future<void> _main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    await BackgroundLocationTracker.initialize();
  }

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

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  talker = TalkerFlutter.init(
    settings: TalkerSettings(
      // ignore: avoid_redundant_argument_values
      useConsoleLogs: kDebugMode,
    ),
    logger: TalkerLogger(formatter: const ColoredLoggerFormatter()),
  );
  if (!kIsWeb) {
    talker.configure(observer: CrashlyticsTalkerObserver());
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

  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    unawaited(MobileAds.instance.initialize());
    await _configureRevenueCat();
  }

  await FirebaseAppCheck.instance.activate(
    providerAndroid: kDebugMode
        ? const AndroidDebugProvider()
        : const AndroidPlayIntegrityProvider(),
    providerApple: const AppleAppAttestProvider(),
  );

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
      kIsWeb
          ? Future<Null>.value()
          : FlutterLocalNotificationsPlugin().initialize(
              settings: const InitializationSettings(
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
      kIsWeb ? Future<Null>.value() : getKyoshinColorMap(),
      core.initializeTimeZones(),
    ).wait,
  ).wait;
  initLicenses();

  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  if (!kIsWeb) {
    unawaited(
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode),
    );
  }

  final container = ProviderContainer(
    overrides: [
      data_prefs.sharedPreferencesProvider.overrideWithValue(
        AsyncValue.data(results.$1.$1),
      ),
      sharedPreferencesProvider.overrideWithValue(
        SharedPreferencesAsync(results.$1.$1),
      ),
      packageInfoProvider.overrideWithValue(results.$1.$2),
      if (results.$1.$3 case final androidInfo?)
        androidDeviceInfoProvider.overrideWithValue(androidInfo),
      if (results.$1.$4 case final iosInfo?)
        iosDeviceInfoProvider.overrideWithValue(iosInfo),
      if (results.$1.$6 case final appDir?)
        applicationDocumentsDirectoryProvider.overrideWithValue(appDir),
      if (results.$2.$1 case final colorMap?)
        kyoshinColorMapProvider.overrideWithValue(colorMap),
    ],
    observers: [if (kDebugMode) CustomProviderObserver(talker)],
    retry: (_, _) => null,
  );

  container.read(eqMonitorWsStatusProvider);
  container.read(realtimeEventsProvider);
  // killed状態で永続化された位置情報の反映と、live位置更新の購読を開始する。
  // backgroundLocationServiceProvider は keepAlive: true で常駐させる。
  container.listen(backgroundLocationServiceProvider, (_, _) {});

  runApp(UncontrolledProviderScope(container: container, child: const App()));

  if (!kIsWeb && Platform.isIOS) {
    unawaited(container.read(appGroupSettingsWriterProvider.future));
    unawaited(container.read(liveActivityTokenSyncWiringProvider.future));
  }
}

Future<void> _registerNotificationChannelIfNeeded() async {
  final androidNotificationPlugin = FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();
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

/// RevenueCat の SDK を初期化する。
///
/// appUserID は本 PR では未バインド（anonymous）のままにし、
/// 後続 PR で deviceId へバインドする。
Future<void> _configureRevenueCat() async {
  final apiKey = BuildConfig.fromEnvironment().revenueCatApiKey;
  if (apiKey == null || apiKey.isEmpty) {
    log('RevenueCat API key is not configured; skipping configure.');
    return;
  }
  try {
    await rc.Purchases.setLogLevel(rc.LogLevel.info);
    await rc.Purchases.configure(rc.PurchasesConfiguration(apiKey));
  } on Object catch (error, stackTrace) {
    talker.handle(error, stackTrace, 'Failed to configure RevenueCat');
  }
}

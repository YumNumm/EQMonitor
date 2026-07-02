// ignore_for_file: prefer_void_to_null

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:core/core.dart' as core;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/error/fatal_error_screen.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/fcm/channels.dart';
import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';
import 'package:eqmonitor/core/provider/application_documents_directory.dart';
import 'package:eqmonitor/core/provider/custom_provider_observer.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging_interaction.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/core/util/license/init_licenses.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_sync_wiring.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/kyoshin_color_map_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_color_map.dart';
import 'package:eqmonitor/feature/live_activity/data/repository/live_activity_token_sync_service.dart';
import 'package:eqmonitor/feature/location/data/background_location_service.dart';
import 'package:eqmonitor/feature/playback_mode/data/notifier/auto_return_watcher.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/app_launch_watcher_provider.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_database_provider.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_uploader_provider.dart';
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
import 'package:shared_preferences/shared_preferences.dart'
    hide SharedPreferencesAsync;
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await _main();
  } on Object catch (error, stackTrace) {
    unawaited(() async {
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
        talker.error(error, stackTrace);
      }
    }());
    runApp(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: ErrorCard(
                error: error,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _main() async {
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

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  talker = TalkerFlutter.init(
    settings: TalkerSettings(
      // ignore: avoid_redundant_argument_values
      useConsoleLogs: kDebugMode,
    ),
    logger: TalkerLogger(
      formatter: const ColoredLoggerFormatter(),
    ),
  );
  if (!kIsWeb && !kDebugMode) {
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
    talker.handle(
      error.exception,
      error.stack,
      'Uncaught fatal exception',
    );
  };
  if (!kDebugMode) {
    ErrorWidget.builder = buildFatalErrorWidget;
  }
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    talker.handle(
      exception,
      stackTrace,
      'Uncaught async exception',
    );
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
    await MobileAds.instance.initialize();
  }

  await FirebaseAppCheck.instance.activate(
    providerAndroid: kDebugMode
        ? const AndroidDebugProvider()
        : const AndroidPlayIntegrityProvider(),
    providerApple: kDebugMode
        ? const AppleDebugProvider()
        : const AppleAppAttestProvider(),
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
      kIsWeb
          ? Future<Null>.value()
          : FirebaseMessaging.instance
                .setForegroundNotificationPresentationOptions(
                  alert: true,
                  sound: true,
                  badge: true,
                ),
    ).wait,
    (
      kIsWeb ? Future<Null>.value() : getKyoshinColorMap(),
      core.initializeTimeZones(),
    ).wait,
  ).wait;
  initLicenses();

  final telemetryDbPath = kIsWeb ? null : await resolveTelemetryDbPath();

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
      if (telemetryDbPath case final dbPath?)
        telemetryDbPathProvider.overrideWithValue(dbPath),
    ],
    observers: [
      if (kDebugMode) CustomProviderObserver(talker),
    ],
    retry: (_, _) => null,
  );

  container.read(eqMonitorWsStatusProvider);
  container.read(realtimeEventsProvider);
  container.read(autoReturnWatcherProvider);
  container.listen(backgroundLocationServiceProvider, (_, _) {});
  container.listen(firebaseMessagingInteractionProvider, (_, _) {});
  unawaited(container.read(pushTokenSyncWiringProvider.future));
  if (!kIsWeb) {
    unawaited(() async {
      try {
        final uploader = container.read(telemetryUploaderProvider);
        await uploader.flush();
      } on Exception catch (exception, stackTrace) {
        talker.error(exception, stackTrace);
      }
    }());
    container.read(appLaunchWatcherProvider);
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );

  if (!kIsWeb && Platform.isIOS) {
    unawaited(
      container.read(appGroupSettingsWriterProvider.future),
    );
    unawaited(
      container.read(liveActivityTokenSyncWiringProvider.future),
    );
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

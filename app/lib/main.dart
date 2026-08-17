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
import 'package:eqmonitor/core/fcm/android_notification_channel_initializer.dart';
import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';
import 'package:eqmonitor/core/provider/app_links_interaction.dart';
import 'package:eqmonitor/core/provider/application_documents_directory.dart';
import 'package:eqmonitor/core/provider/custom_provider_observer.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging_interaction.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/core/startup/startup_profiler.dart';
import 'package:eqmonitor/core/startup/startup_profiler_provider.dart';
import 'package:eqmonitor/core/util/guarded_unawaited.dart';
import 'package:eqmonitor/core/util/license/init_licenses.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_sync_wiring.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/kyoshin_color_map_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_color_map.dart';
import 'package:eqmonitor/feature/location/data/background_location_service.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:eqmonitor/feature/playback_mode/data/notifier/auto_return_watcher.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/app_launch_watcher_provider.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_database_provider.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_recorder_provider.dart';
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
import 'package:telemetry_store/telemetry_store.dart';

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
                // ブートストラップ失敗時のフォールバックでは Provider が未 override のため
                // 詳細/問い合わせを押すと未実装 Provider で二次クラッシュする。抑制する。
                showDetails: false,
                showContact: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _main() async {
  final profiler = StartupProfiler();

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
  profiler.mark('firebase_init');

  talker = TalkerFlutter.init(
    settings: TalkerSettings(
      // ignore: avoid_redundant_argument_values
      useConsoleLogs: kDebugMode,
    ),
    logger: TalkerLogger(formatter: const ColoredLoggerFormatter()),
  );
  if (!kIsWeb && !kDebugMode) {
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
  if (!kDebugMode) {
    ErrorWidget.builder = buildFatalErrorWidget;
  }
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    talker.handle(exception, stackTrace, 'Uncaught async exception');
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
      kIsWeb ? Future<Null>.value() : getApplicationDocumentsDirectory(),
    ).wait,
    (
      kIsWeb ? Future<Null>.value() : getKyoshinColorMap(),
      core.initializeTimeZones(),
    ).wait,
  ).wait;
  profiler.mark('parallel_init');
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
      if (results.$1.$5 case final appDir?)
        applicationDocumentsDirectoryProvider.overrideWithValue(appDir),
      if (results.$2.$1 case final colorMap?)
        kyoshinColorMapProvider.overrideWithValue(colorMap),
      if (telemetryDbPath case final dbPath?)
        telemetryDbPathProvider.overrideWithValue(dbPath),
      startupProfilerProvider.overrideWithValue(profiler),
    ],
    observers: [if (kDebugMode) CustomProviderObserver(talker)],
    retry: (_, _) => null,
  );

  container.read(eqMonitorWsStatusProvider);
  container.read(realtimeEventsProvider);
  container.listen(autoReturnWatcherProvider, (_, _) {});
  container.listen(backgroundLocationServiceProvider, (_, _) {});
  container.listen(firebaseMessagingInteractionProvider, (_, _) {});
  container.listen(appLinksInteractionProvider, (_, _) {});
  container.listen(pushTokenSyncStartupProvider, (_, _) {});
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

  profiler.mark('before_run_app');
  runApp(UncontrolledProviderScope(container: container, child: const App()));

  // 広告SDK・通知プラグインは override 値を生まないため runApp 後に遅延初期化する。
  // 例外が発生しても起動フローを止めず talker に記録する。
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    guardedUnawaited(
      () => MobileAds.instance.initialize(),
      onError: (error, stack) => talker.error(error, stack),
    );
  }
  if (!kIsWeb) {
    guardedUnawaited(() async {
      await AndroidNotificationChannelInitializer.forCurrentPlatform()
          .initialize();
      await FlutterLocalNotificationsPlugin().initialize(
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
      );
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            sound: true,
            badge: true,
          );
    }, onError: (error, stack) => talker.error(error, stack));
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    profiler.mark('home_first_frame');
    if (!kIsWeb) {
      // バックグラウンドで完了する travel_time_load / parameter_load が
      // timingsMicros に記録されてからテレメトリを送信する。
      // 各ロードの失敗は計測の欠落として許容し、record() の失敗は talker に委ねる。
      Future<void> awaitQuietly(Future<Object?> f) async {
        try {
          await f;
        } catch (_) {}
      }

      guardedUnawaited(() async {
        await awaitQuietly(container.read(travelTimeInternalProvider.future));
        await awaitQuietly(container.read(parameterSetProvider.future));
        final recorder = container.read(telemetryRecorderProvider);
        await recorder.record(
          TelemetryEvent.startupTiming(phasesMicros: profiler.timingsMicros),
        );
      }, onError: (error, stack) => talker.error(error, stack));
    }
  });

  if (!kIsWeb && Platform.isIOS) {
    container.listen(appGroupSettingsWriterProvider, (_, _) {});
  }
}

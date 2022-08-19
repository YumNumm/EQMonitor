// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:eqmonitor/const/obspoint.dart';
import 'package:eqmonitor/const/prefecture/area_forecast_local_eew.model.dart';
import 'package:eqmonitor/model/travel_time_table/travel_time_table.dart';
import 'package:eqmonitor/page/main_page.dart';
import 'package:eqmonitor/private/keys.dart';
import 'package:eqmonitor/provider/init/kyoshin_kansokuten.dart';
import 'package:eqmonitor/provider/init/map_area_forecast_local_e.dart';
import 'package:eqmonitor/provider/init/parameter-earthquake.dart';
import 'package:eqmonitor/provider/init/secure_storage.dart';
import 'package:eqmonitor/provider/init/shared_preferences.dart';
import 'package:eqmonitor/provider/init/travel_time.dart';
import 'package:eqmonitor/provider/setting/crash_log_share.dart';
import 'package:eqmonitor/provider/theme_providers.dart';
import 'package:eqmonitor/res/theme.dart';
import 'package:eqmonitor/schema/dmdata/parameter-earthquake/parameter-earthquake.dart';
import 'package:eqmonitor/utils/fcm/firebase_notification_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      final stopwatch = Stopwatch()..start();
      FlutterNativeSplash.preserve(
        widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
      );

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // transparent status bar
        ),
      );
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      Intl.defaultLocale = 'ja_JP';
      final crashlytics = FirebaseCrashlytics.instance;
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      late List<KyoshinKansokuten> kansokuten;
      late List<MapPolygon> mapAreaForecastLocalE;
      late ParameterEarthquake parameterEarthquake;
      late List<TravelTimeTable> travelTimeTable;
      late SharedPreferences prefs;
      late Directory dir;
      late Isar isar;

      final futures = <Future<dynamic>>[
        loadKyoshinKansokuten().then((e) => kansokuten = e),
        loadMapAreaForecastLocalE().then((e) => mapAreaForecastLocalE = e),
        loadParameterEarthquake().then((e) => parameterEarthquake = e),
        loadTravelTimeTable().then((e) => travelTimeTable = e),
        SharedPreferences.getInstance().then((e) => prefs = e),
        getApplicationSupportDirectory().then((e) => dir = e),
        Supabase.initialize(
          url: supabaseS1Url,
          anonKey: supabaseS1AnonKey,
          debug: false,
        ),
        initFirebaseCloudMessaging(),
        crashlytics.sendUnsentReports(),
        crashlytics.setUserIdentifier(deviceInfo.fingerprint.toString()),
      ];
      await Future.wait(futures);
      final isCrashLogShareAllowed =
          await CrashLogShareProvider(prefs).loadSettingsFromSharedPrefrences();
      await crashlytics.setCrashlyticsCollectionEnabled(
        isCrashLogShareAllowed && kReleaseMode,
      );

      //isar = await Isar.open([], directory: dir.path);
      FlutterNativeSplash.remove();
      Logger()
          .d('全ての初期化が完了: ${(stopwatch..stop()).elapsedMicroseconds / 1000}ms');

      // final prefs = await SharedPreferences.getInstance();
      FlutterError.onError = onFlutterError;
      runApp(
        ProviderScope(
          overrides: [
            TravelTimeProvider.overrideWithValue(travelTimeTable),
            kyoshinKansokutenProvider.overrideWithValue(kansokuten),
            mapAreaForecastLocalEProvider
                .overrideWithValue(mapAreaForecastLocalE),
            parameterEarthquakeProvider.overrideWithValue(parameterEarthquake),
            sharedPreferencesProvder.overrideWithValue(prefs),
            secureStorageProvider.overrideWithValue(
              const FlutterSecureStorage(
                aOptions: AndroidOptions(
                  encryptedSharedPreferences: true,
                  resetOnError: true,
                ),
              ),
            ),
            //isarProvider.overrideWithValue(isar),
          ],
          observers: const [
            // if (kDebugMode) ProvidersLogger(),
          ],
          child: const MyApp(),
        ),
      );

      FlutterNativeSplash.remove();
    },
    (error, stack) async {
      print('Error: $error');
      print('Stack: $stack');
      await FirebaseCrashlytics.instance.recordError(error, stack);
    },
  );
  // スプラッシュ画面を表示
}

Future<void> onFlutterError(FlutterErrorDetails details) async {
  print('Error: ${details.exception}');
  print('Stack: ${details.stack}');
  await FirebaseCrashlytics.instance.recordFlutterError(details);
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(themeProvider.select((value) => value.themeMode));
    return MaterialApp(
      title: 'EQMonitor',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: themeMode,
      locale: DevicePreview.locale(context),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      home: const Banner(
        message: 'DEVELOP',
        location: BannerLocation.bottomStart,
        child: MainPage(),
      ),
    );
  }
}

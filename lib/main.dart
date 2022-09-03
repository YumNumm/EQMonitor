// ignore_for_file: avoid_Logger().wtf

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:eqmonitor/const/obspoint.dart';
import 'package:eqmonitor/const/prefecture/area_forecast_local_eew.model.dart';
import 'package:eqmonitor/model/travel_time_table/travel_time_table.dart';
import 'package:eqmonitor/page/introduction.dart';
import 'package:eqmonitor/private/keys.dart';
import 'package:eqmonitor/provider/init/application_support_dir.dart';
import 'package:eqmonitor/provider/init/device_info.dart';
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
import 'page/main_page.dart';

Future<void> main() async {
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
  late List<TravelTimeTable> travelTimeTable;
  late SharedPreferences prefs;
  late Directory dir;
  late Isar isar;
  late AndroidDeviceInfo androidDeviceInfo;
  late IosDeviceInfo iosDeviceInfo;
  ParameterEarthquake? parameterEarthquake;

  final futures = <Future<dynamic>>[
    loadKyoshinKansokuten().then((e) => kansokuten = e),
    loadMapAreaForecastLocalE().then((e) => mapAreaForecastLocalE = e),
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
    if (Platform.isAndroid)
      DeviceInfoPlugin().androidInfo.then((e) => androidDeviceInfo = e),
    if (Platform.isIOS)
      DeviceInfoPlugin().iosInfo.then((e) => iosDeviceInfo = e),
  ];
  await Future.wait(futures);
  final isCrashLogShareAllowed =
      await CrashLogShareProvider(prefs).loadSettingsFromSharedPrefrences();
  await crashlytics.setUserIdentifier(
    deviceInfo.fingerprint ?? deviceInfo.board ?? 'Unknown',
  );
  await crashlytics.setCrashlyticsCollectionEnabled(
    isCrashLogShareAllowed && kReleaseMode,
  );

  if (File('${dir.path}/parameter-earthquake-with-arv.json').existsSync()) {
    final paramData = json.decode(
      await File('${dir.path}/parameter-earthquake-with-arv.json')
          .readAsString(),
    );
    parameterEarthquake = ParameterEarthquake.fromJson(paramData);
  }

  //isar = await Isar.open([], directory: dir.path);
  FlutterNativeSplash.remove();
  Logger().d('全ての初期化が完了: ${(stopwatch..stop()).elapsedMicroseconds / 1000}ms');
  FlutterError.onError = onFlutterError;

 // PlatformDispatcher.instance.onError = (error, stackTrace) {
 //   Logger().e(error, stackTrace);
 //   crashlytics.recordError(error, stackTrace);
 //   return true;
 // };
  runApp(
    ProviderScope(
      overrides: [
        TravelTimeProvider.overrideWithValue(travelTimeTable),
        kyoshinKansokutenProvider.overrideWithValue(kansokuten),
        mapAreaForecastLocalEProvider.overrideWithValue(mapAreaForecastLocalE),
        if (parameterEarthquake != null)
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
        applicationSupportDirectoryProvider.overrideWithValue(dir),
        if (Platform.isAndroid)
          androidDeviceInfoProvider.overrideWithValue(androidDeviceInfo),
        if (Platform.isIOS)
          iOSDeviceInfoProvider.overrideWithValue(iosDeviceInfo),
        // if (kDebugMode)
        //   changeLogProvider.overrideWithProvider(changeLogMockProvider),
      ],
      observers: const [
        //if (kDebugMode) ProvidersLogger(),
      ],
      child: const MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

Future<void> onFlutterError(FlutterErrorDetails details) async {
  Logger().wtf('Error: ${details.exception}');
  Logger().wtf('Stack: ${details.stack}');
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
      builder: (context, widget) {
        Widget error = const Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator) {
          error = Scaffold(body: Center(child: error));
        }
        ErrorWidget.builder = (errorDetails) => error;
        if (widget != null) {
          return widget;
        }
        throw Exception('widget is null');
      },
      home: (ref.read(sharedPreferencesProvder).getBool('isInitializated') ??
              false)
          ? const MainPage()
          : const IntroductionPage(),
    );
  }
}

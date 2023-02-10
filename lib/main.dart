// ignore_for_file: avoid_talker.wdebugtf

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/env/env.dart';
import 'package:eqmonitor/flavors.dart';
import 'package:eqmonitor/helper/firebase/firebase_options.dart';
import 'package:eqmonitor/model/travel_time_table/travel_time_table.dart';
import 'package:eqmonitor/provider/init/application_support_dir.dart';
import 'package:eqmonitor/provider/init/device_info.dart';
import 'package:eqmonitor/provider/init/kyoshin_kansokuten.dart';
import 'package:eqmonitor/provider/init/map_area_forecast_local_e.dart';
import 'package:eqmonitor/provider/init/map_area_forecast_local_eew.dart';
import 'package:eqmonitor/provider/init/map_area_information_city_quake.dart';
import 'package:eqmonitor/provider/init/map_area_tsunami_forecast.dart';
import 'package:eqmonitor/provider/init/parameter_earthquake.dart';
import 'package:eqmonitor/provider/init/secure_storage.dart';
import 'package:eqmonitor/provider/init/shared_preferences.dart';
import 'package:eqmonitor/provider/init/talker.dart';
import 'package:eqmonitor/provider/init/travel_time.dart';
import 'package:eqmonitor/provider/setting/crash_log_share.dart';
import 'package:eqmonitor/schema/local/kyoshin_kansokuten.dart';
import 'package:eqmonitor/schema/local/prefecture/map_polygon.dart';
import 'package:eqmonitor/schema/remote/dmdata/parameter-earthquake/parameter-earthquake.dart';
import 'package:eqmonitor/ui/app.dart';
import 'package:eqmonitor/ui/route.dart';
import 'package:eqmonitor/utils/fcm/firebase_notification_controller.dart';
import 'package:eqmonitor/utils/talker_log/log_types.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

late Talker talker;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.DEV;
  await Firebase.initializeApp(
    options: FirebaseOptionsWrapper.currentPlatform,
  );
  final stopwatch = Stopwatch()..start();
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ),
  );
  talker = Talker();
  final prefs = await SharedPreferences.getInstance();
  if (Platform.isAndroid || Platform.isIOS) {
    final crashlytics = FirebaseCrashlytics.instance;

    // クラッシュレポートの初期化
    final isCrashLogShareAllowed =
        await CrashLogShareProvider(prefs).loadSettingsFromSharedPrefrences();
    await crashlytics.setCrashlyticsCollectionEnabled(
      isCrashLogShareAllowed && kReleaseMode,
    );
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      talker.handle(error, stackTrace, 'Uncaught App Exception');
      if (kReleaseMode) {
        crashlytics.recordError(error, stackTrace);
      }
      return true;
    };
  }
  Intl.defaultLocale = 'ja_JP';
  // final appInfo = await PackageInfo.fromPlatform();

  // ファイル等の読み込み
  late List<KyoshinKansokuten> kansokuten;
  late List<MapPolygon> mapAreaForecastLocalE;
  late List<MapPolygon> mapAreaForecastLocalEew;
  late List<MapAreaTsunami> mapAreaTsunamiForecast;
  late List<MapAreaInformationCityQuakePolygon> mapAreaInformationCityQuake;
  late List<TravelTimeTable> travelTimeTable;
  late Directory dir;
  // late Isar isar;
  late AndroidDeviceInfo androidDeviceInfo;
  late IosDeviceInfo iosDeviceInfo;
  ParameterEarthquake? parameterEarthquake;
  var isNeedDownloadParam = true;

  final futures = <Future<dynamic>>[
    loadKyoshinKansokuten(talker).then((e) => kansokuten = e),
    loadMapAreaTsunamiForecast(talker).then((e) => mapAreaTsunamiForecast = e),
    loadMapAreaForecastLocalE(talker).then((e) => mapAreaForecastLocalE = e),
    loadMapAreaForecastLocalEew(talker)
        .then((e) => mapAreaForecastLocalEew = e),
    loadMapAreaInformationCityQuake(talker)
        .then((e) => mapAreaInformationCityQuake = e),
    loadTravelTimeTable(talker).then((e) => travelTimeTable = e),
    getApplicationSupportDirectory().then((e) => dir = e),
    Supabase.initialize(
      url: Env.supabaseS1Url,
      anonKey: Env.supabaseS1AnonKey,
      debug: kDebugMode,
    ),
    if (Platform.isAndroid || Platform.isIOS) ...[
      initFirebaseCloudMessaging(talker),
      if (Platform.isAndroid)
        DeviceInfoPlugin().androidInfo.then((e) => androidDeviceInfo = e),
      if (Platform.isIOS)
        DeviceInfoPlugin().iosInfo.then((e) => iosDeviceInfo = e),
    ],
  ];
  await Future.wait(futures);

  if (File('${dir.path}/parameter-earthquake-with-arv.json').existsSync()) {
    isNeedDownloadParam = false;
    final paramData = json.decode(
      await File('${dir.path}/parameter-earthquake-with-arv.json')
          .readAsString(),
    ) as Map<String, dynamic>;
    parameterEarthquake = ParameterEarthquake.fromJson(paramData);
  }

  //isar = await Isar.open([], directory: dir.path);
  FlutterNativeSplash.remove();
  talker.logTyped(
    InitializationEventLog(
      '全ての初期化が完了: ${(stopwatch..stop()).elapsedMicroseconds / 1000}ms',
    ),
  );
  FlutterError.onError = onFlutterError;
  DartPluginRegistrant.ensureInitialized();

  runApp(
    ProviderScope(
      overrides: [
        travelTimeProvider.overrideWithValue(travelTimeTable),
        kyoshinKansokutenProvider.overrideWithValue(kansokuten),
        mapAreaForecastLocalEProvider.overrideWithValue(mapAreaForecastLocalE),
        mapAreaForecastLocalEewProvider
            .overrideWithValue(mapAreaForecastLocalEew),
        mapAreaTsunamiForecastProvider
            .overrideWithValue(mapAreaTsunamiForecast),
        mapAreaInformationCityQuakeProvider
            .overrideWithValue(mapAreaInformationCityQuake),
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
        talkerProvider.overrideWithValue(talker),
        initialRouteProvider
            .overrideWithValue(isNeedDownloadParam ? '/introduction' : '/'),
      ],
      observers: const [
        //if (kDebugMode) ProvidersLogger(),
      ],
      child: const App(),
    ),
  );
  FlutterNativeSplash.remove();
}

Future<void> onFlutterError(FlutterErrorDetails details) async {
  talker.handle(details.exception, details.stack, 'Uncaught Flutter Exception');
  if (kReleaseMode) {
    await FirebaseCrashlytics.instance.recordFlutterError(details);
  }
}

// ignore_for_file: avoid_Logger().wtf

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/env/env.dart';
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
import 'package:eqmonitor/provider/init/travel_time.dart';
import 'package:eqmonitor/provider/setting/crash_log_share.dart';
import 'package:eqmonitor/schema/local/kyoshin_kansokuten.dart';
import 'package:eqmonitor/schema/local/prefecture/map_polygon.dart';
import 'package:eqmonitor/schema/remote/dmdata/parameter-earthquake/parameter-earthquake.dart';
import 'package:eqmonitor/ui/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  Intl.defaultLocale = 'ja_JP';
  try {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
  } catch (_, __) {}
  final prefs = await SharedPreferences.getInstance();
  // final appInfo = await PackageInfo.fromPlatform();
  // クラッシュレポートの初期化
  final isCrashLogShareAllowed =
      await CrashLogShareProvider(prefs).loadSettingsFromSharedPrefrences();

  // ログ出力の初期化

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

  final futures = <Future<dynamic>>[
    loadKyoshinKansokuten().then((e) => kansokuten = e),
    loadMapAreaTsunamiForecast().then((e) => mapAreaTsunamiForecast = e),
    loadMapAreaForecastLocalE().then((e) => mapAreaForecastLocalE = e),
    loadMapAreaForecastLocalEew().then((e) => mapAreaForecastLocalEew = e),
    loadMapAreaInformationCityQuake()
        .then((e) => mapAreaInformationCityQuake = e),
    loadTravelTimeTable().then((e) => travelTimeTable = e),
    getApplicationSupportDirectory().then((e) => dir = e),
    Supabase.initialize(
      url: Env.supabaseS1Url,
      anonKey: Env.supabaseS1AnonKey,
      debug: false,
    ),
    if (Platform.isAndroid)
      DeviceInfoPlugin().androidInfo.then((e) => androidDeviceInfo = e),
    if (Platform.isIOS)
      DeviceInfoPlugin().iosInfo.then((e) => iosDeviceInfo = e),
  ];
  await Future.wait(futures);

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
  DartPluginRegistrant.ensureInitialized();

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    Logger().e(error, stackTrace);
    if (kReleaseMode) {}
    return true;
  };
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
  Logger().wtf('Error: ${details.exception}');
  Logger().wtf('Stack: ${details.stack}');
}

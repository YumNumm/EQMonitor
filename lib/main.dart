// ignore_for_file: cascade_invocations, file_names

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:eqmonitor/db/notificationSettings/notificationSettings.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/kyoshinMonitorlibTime.dart';
import 'package:eqmonitor/utils/background/background_task.dart';
import 'package:eqmonitor/utils/map/customZoomPanBehavior.dart';
import 'package:eqmonitor/utils/settings/notificationSettings.dart';
import 'package:eqmonitor/utils/settings/volumeController.dart';
import 'package:eqmonitor/utils/updater/appUpdate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import './const/const.dart';
import 'pages/mainPage.dart';
import 'pages/settingscreen.dart';
import 'pages/splashscreen.dart';
import 'utils/auth.dart';
import 'utils/earthquake.dart';
import 'utils/map.dart';
import 'utils/messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ),
  );
  //? Setup DB
  await Hive.initFlutter();
  Hive.registerAdapter(NotificationSettingsStateAdapter());
  Get.put<Box<NotificationSettingsState?>>(
    await Hive.openBox<NotificationSettingsState?>('NotificationSettings'),
  );
  //? End DB
  final prefs =
      Get.put<SharedPreferences>(await SharedPreferences.getInstance());
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(!kDebugMode);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  Get.put<Logger>(
    Logger(
      level: Level.debug,
      printer: PrettyPrinter(
        printTime: true,
      ),
    ),
  );
  Get.put<FlutterSecureStorage>(const FlutterSecureStorage());
  Get.put<PackageInfo>(await PackageInfo.fromPlatform());
  final deviceInfo =
      Get.put<AndroidDeviceInfo>(await DeviceInfoPlugin().androidInfo);
  Get.put<UserNotificationSettings>(await UserNotificationSettings().onInit());
  Get.put<FirebaseApp>(await Firebase.initializeApp());
  Get.put<FirebaseAuth>(FirebaseAuth.instance);
  Get.put<FirebaseMessaging>(FirebaseMessaging.instance);
  Get.put<FirebasePerformance>(FirebasePerformance.instance);
  Get.put<MapData>(MapData());
  Get.put<Messaging>(Messaging());
  Get.put<AuthStateUtils>(AuthStateUtils());
  Get.put<KyoshinMonitorlibTime>(KyoshinMonitorlibTime());
  Get.put<CustomZoomPanBehavior>(CustomZoomPanBehavior());
  Get.put<EarthQuake>(EarthQuake());
  Get.put<VolumeController>(VolumeController());
  Get.put<AppUpdate>(AppUpdate());
  Get.put<FlutterSecureStorage>(const FlutterSecureStorage());
  await Workmanager().initialize(callbackDispatcher,
      isInDebugMode: deviceInfo.androidId == '50249192fa1a1539');
  await Workmanager().registerPeriodicTask(
    'widgetUpdate',
    'widgetUpdate',
    frequency: const Duration(minutes: 15),
  );
  runApp(
    DevicePreview(
      enabled: prefs.getBool('showDevicePreview') ?? false,
      builder: (context) => const EQApp(),
    ),
  );
}

class EQApp extends StatelessWidget {
  const EQApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EQMonitor',
      theme: lightTheme().copyWith(),
      darkTheme: darkTheme(),
      locale: DevicePreview.locale(context),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        locale,
      ],
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      initialRoute: '/splash',
      getPages: [
        GetPage<dynamic>(
          name: '/',
          page: IntroPage.new,
          transition: Transition.fadeIn,
        ),
        GetPage<dynamic>(
          name: '/splash',
          page: SplashScreen.new,
          transition: Transition.downToUp,
        ),
        GetPage<dynamic>(
          name: '/setting',
          page: SettingScreen.new,
          popGesture: true,
        ),
      ],
    );
  }
}

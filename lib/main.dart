// ignore_for_file: cascade_invocations, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Get.put<SharedPreferences>(await SharedPreferences.getInstance());
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  Get.put<Logger>(
    Logger(
      level: Level.debug,
      printer: PrettyPrinter(
        printTime: true,
      ),
    ),
  );
  Get.put<PackageInfo>(await PackageInfo.fromPlatform());
  Get.put<FirebaseApp>(await Firebase.initializeApp());
  Get.put<FirebaseAuth>(FirebaseAuth.instance);
  Get.put<FirebaseMessaging>(FirebaseMessaging.instance);
  Get.put<FirebasePerformance>(FirebasePerformance.instance);
  Get.put<MapData>(MapData());
  Get.put<Messaging>(Messaging());
  Get.put<AuthStateUtils>(AuthStateUtils());
  Get.put<EarthQuake>(EarthQuake());
  Get.put<FlutterSecureStorage>(const FlutterSecureStorage());
  runApp(const EQApp());
}

class EQApp extends StatelessWidget {
  const EQApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EQMonitor',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      locale: locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        locale,
      ],
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

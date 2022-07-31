import 'dart:async';
import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:eqmonitor/page/main_page.dart';
import 'package:eqmonitor/private/keys.dart';
import 'package:eqmonitor/res/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
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
      // Supabaseを初期化
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
        debug: kDebugMode,
      );

      Intl.defaultLocale = 'ja_JP';
      // final prefs = await SharedPreferences.getInstance();
      final crashlytics = FirebaseCrashlytics.instance;
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      await crashlytics.sendUnsentReports();
      await crashlytics.setUserIdentifier(deviceInfo.androidId.toString());
      await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      if (kDebugMode) {
        runApp(
          DevicePreview(
            builder: (context) => const EqMonitorApp(),
          ),
        );
      } else {
        runApp(const EqMonitorApp());
      }
      FlutterNativeSplash.remove();
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
  // スプラッシュ画面を表示
}

class EqMonitorApp extends StatelessWidget {
  const EqMonitorApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
          ColorScheme lightColorScheme;
          ColorScheme darkColorScheme;
          if (lightDynamic != null && darkDynamic != null) {
            log('Loaded DynamicColor ${lightDynamic.background}', name: 'main');
            lightColorScheme = lightDynamic.harmonized();
            darkColorScheme = darkDynamic.harmonized();
          } else {
            lightColorScheme = ColorScheme.fromSeed(
              seedColor: Colors.blueAccent,
            );
            darkColorScheme = ColorScheme.fromSeed(
              seedColor: Colors.blueAccent,
              brightness: Brightness.dark,
            );
          }
          return MaterialApp(
            title: 'EQMonitor',
            theme: lightTheme().copyWith(
              colorScheme: lightColorScheme,
            ),
            darkTheme: darkTheme().copyWith(
              colorScheme: darkColorScheme,
            ),
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
            home: const MainPage(),
          );
        },
      ),
    );
  }
}

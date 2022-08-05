// ignore_for_file: avoid_print

import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:eqmonitor/page/main_page.dart';
import 'package:eqmonitor/private/keys.dart';
import 'package:eqmonitor/state/theme_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
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
        url: supabaseS1Url,
        anonKey: supabaseS1AnonKey,
        debug: false,
      );

      Intl.defaultLocale = 'ja_JP';
      // final prefs = await SharedPreferences.getInstance();
      final crashlytics = FirebaseCrashlytics.instance;
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      await crashlytics.sendUnsentReports();
      await crashlytics.setUserIdentifier(deviceInfo.androidId.toString());
      await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
      FlutterError.onError = onFlutterError;
      if (kDebugMode) {
        runApp(
          ProviderScope(
            child: DevicePreview(
              builder: (context) => const EqMonitorApp(),
            ),
          ),
        );
      } else {
        runApp(
          const ProviderScope(child: EqMonitorApp()),
        );
      }
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

class EqMonitorApp extends ConsumerWidget {
  const EqMonitorApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(themeController.select((value) => value.themeMode));
    return MaterialApp(
      title: 'EQMonitor',
      theme: FlexThemeData.light(),
      darkTheme: FlexThemeData.dark(),
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
      home: const MainPage(),
    );
  }
}

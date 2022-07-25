import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_preview/device_preview.dart';
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
  // スプラッシュ画面を表示
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


  runApp(
    DevicePreview(
      builder: (context) => ProviderScope(

        child: MaterialApp(
          title: 'EQMonitor',
          theme: lightTheme(),
          darkTheme: darkTheme(),
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
        ),
      ),
    ),
  );
  FlutterNativeSplash.remove();
}

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/provider/custom_provider_observer.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/provider/kmoni_observation_points_provider.dart';
import 'package:eqmonitor/widgetbook.directories.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = TalkerFlutter.init(
    logger: TalkerLogger(),
  );

  FlutterError.onError = (error) {
    final exception = error.exception;
    if (exception is ParallelWaitError) {
      talker
        ..handle(exception, error.stack, 'Uncaught fatal exception')
        ..log(exception.errors.toString());
    }
    talker.handle(error.exception, error.stack, 'Uncaught fatal exception');
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'Uncaught async exception');
    final exception = error;
    if (exception is ParallelWaitError) {
      talker
        ..log(exception.errors.toString())
        ..log(exception.stackTrace.toString());
    }
    return true;
  };

  final deviceInfo = DeviceInfoPlugin();

  final results = await (
    SharedPreferences.getInstance(),
    loadKmoniObservationPoints(),
    PackageInfo.fromPlatform(),
    // ignore: prefer_void_to_null
    (!kIsWeb && Platform.isAndroid
        ? deviceInfo.androidInfo
        : Future<Null>.value()),
    // ignore: prefer_void_to_null
    (!kIsWeb && Platform.isIOS ? deviceInfo.iosInfo : Future<Null>.value()),
    loadJmaCodeTable(),
  ).wait;

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(results.$1),
      kmoniObservationPointsProvider.overrideWithValue(results.$2),
      talkerProvider.overrideWithValue(talker),
      packageInfoProvider.overrideWithValue(results.$3),
      if (results.$4 != null)
        androidDeviceInfoProvider.overrideWithValue(results.$4!),
      if (results.$5 != null)
        iosDeviceInfoProvider.overrideWithValue(results.$5!),
      jmaCodeTableProvider.overrideWithValue(results.$6),
    ],
    observers: [
      if (kDebugMode)
        CustomProviderObserver(
          talker,
        ),
    ],
  );
  return runApp(
    ProviderScope(
      parent: container,
      child: const WidgetbookApp(),
    ),
  );
}

@widgetbook.App()
class WidgetbookApp extends ConsumerWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final child = Widgetbook.material(
      directories: directories,
      addons: [
        AccessibilityAddon(),
        InspectorAddon(enabled: true),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: ThemeData.light(),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData.dark(),
            ),
          ],
          initialTheme: WidgetbookTheme(
            name: 'Dark',
            data: ThemeData.dark(),
          ),
        ),
        ZoomAddon(),
      ],
      integrations: [
        WidgetbookCloudIntegration(),
      ],
    );
    final packageInfo = ref.watch(packageInfoProvider);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        message: 'v${packageInfo.version}-${packageInfo.buildNumber}',
        location: BannerLocation.bottomStart,
        color: Colors.red.shade900,
        child: child,
      ),
    );
  }
}

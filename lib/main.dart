import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/provider/kmoni_observation_points_provider.dart';
import 'package:eqmonitor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = TalkerFlutter.init();
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (error) {
    talker.handle(error.exception, error.stack, 'Uncaught fatal exception');
    FirebaseCrashlytics.instance.recordFlutterError(error);
  };
  // Pass all uncaught asynchronous errors that aren't handled
  // by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'Uncaught async exception');
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };
  final deviceInfo = DeviceInfoPlugin();
  final results = await (
    SharedPreferences.getInstance(),
    loadKmoniObservationPoints(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    PackageInfo.fromPlatform(),
    // ignore: prefer_void_to_null
    (Platform.isAndroid ? deviceInfo.androidInfo : Future<Null>.value()),
    // ignore: prefer_void_to_null
    (Platform.isIOS ? deviceInfo.iosInfo : Future<Null>.value()),
    FlutterLocalNotificationsPlugin().initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          requestBadgePermission: false,
        ),
        android: AndroidInitializationSettings('mipmap/ic_launcher'),
      ),
    ),
  ).wait;
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(results.$1),
        kmoniObservationPointsProvider.overrideWithValue(results.$2),
        talkerProvider.overrideWithValue(talker),
        packageInfoProvider.overrideWithValue(results.$4),
        if (results.$5 != null)
          androidDeviceInfoProvider.overrideWithValue(results.$5!),
        if (results.$6 != null)
          iosDeviceInfoProvider.overrideWithValue(results.$6!),
      ],
      observers: [
        if (kDebugMode)
          Observer(
            talker,
          ),
      ],
      child: const App(),
    ),
  );
}

class Observer extends ProviderObserver {
  Observer(this.talker);

  final Talker talker;

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) =>
      switch (provider.name) {
        _ when value.toString().length > 1000 => log(
            '${provider.name} (${provider.runtimeType}) '
            '${value?.toString().length} ',
            name: 'didAddProvider',
          ),
        _ => log(
            '${provider.name} ($provider)',
            name: 'didAddProvider',
          ),
      };

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) =>
      log('didDisposeProvider: ${provider.name}');

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) =>
      switch (provider.name) {
        'mapViewModelProvider' || 'kmoniViewModelProvider' => null,
        _
            when newValue.toString().length + previousValue.toString().length >
                300 =>
          log(
            '${provider.name} (${previousValue.runtimeType} '
            '-> ${newValue.runtimeType})',
            name: 'didUpdateProvider',
          ),
        _ => log(
            '${provider.name} ($previousValue -> $newValue)',
            name: 'didUpdateProvider',
          ),
      };

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    talker.handle(error, stackTrace, 'providerDidFail: ${provider.name}');
    log(
      '${provider.name} $error',
      name: 'providerDidFail',
      error: error,
    );
  }
}

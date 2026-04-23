import 'dart:io';

import 'package:eqmonitor/core/provider/app_group_preferences.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_group_settings_writer.g.dart';

/// アプリ起動時に apiServerUrl と debugMode を App Groups UserDefaults に書き込む。
/// Widget Extension がこの値を読んで正しいエンドポイントへ接続する。
@Riverpod(keepAlive: true)
Future<void> appGroupSettingsWriter(Ref ref) async {
  if (!Platform.isIOS) return;

  final prefs = await ref.watch(appGroupPreferencesProvider.future);
  final env = ref.watch(environmentProvider);

  await Future.wait([
    prefs.setString('apiServerUrl', env.restApiUrl),
    prefs.setBool('debugMode', kDebugMode),
  ]);
}

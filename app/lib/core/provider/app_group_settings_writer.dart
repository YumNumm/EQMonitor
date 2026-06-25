import 'dart:io';

import 'package:eqmonitor/core/provider/app_group_preferences.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_group_settings_writer.g.dart';

/// apiServerUrl を App Groups UserDefaults に書き込む。
/// telegramUrlProvider を watch するため、デバッグ画面での URL 変更も Widget に即時反映される。
/// debugMode はデバッグ設定画面から直接制御するため、ここでは書き込まない。
@Riverpod(keepAlive: true)
Future<void> appGroupSettingsWriter(Ref ref) async {
  if (!Platform.isIOS) {
    return;
  }

  final prefs = await ref.watch(appGroupPreferencesProvider.future);
  final telegramUrl = await ref.watch(telegramUrlProvider.future);

  await prefs.setString('apiServerUrl', telegramUrl.restApiUrl);
}

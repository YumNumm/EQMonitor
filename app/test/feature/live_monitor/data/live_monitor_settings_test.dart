import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_settings.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  talker_lib.talker = Talker();

  test('未設定なら承認済み既定値を返す', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      await container.read(liveMonitorSettingsProvider.future),
      const LiveMonitorSettings(),
    );
  });

  test('縦横比率と表示方式を一つの設定として復元する', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      SharedPreferencesKey.liveMonitorSettings.key: jsonEncode(<String, Object>{
        'display_mode': 'split',
        'earthquake_display_seconds': 24,
        'keep_screen_awake': false,
        'portrait_realtime_ratio': 0.35,
        'landscape_realtime_ratio': 0.7,
      }),
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final value = await container.read(liveMonitorSettingsProvider.future);
    expect(value.displayMode, LiveMonitorDisplayMode.split);
    expect(value.earthquakeDisplaySeconds, 24);
    expect(value.portraitRealtimeRatio, 0.35);
    expect(value.landscapeRealtimeRatio, 0.7);
  });

  test('破損した永続値は承認済みの範囲と既定値に正規化する', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      SharedPreferencesKey.liveMonitorSettings.key: jsonEncode(<String, Object>{
        'earthquake_display_seconds': 301,
        'portrait_realtime_ratio': 0.1,
        'landscape_realtime_ratio': 0.9,
      }),
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final value = await container.read(liveMonitorSettingsProvider.future);
    expect(value.earthquakeDisplaySeconds, 10);
    expect(value.portraitRealtimeRatio, 0.2);
    expect(value.landscapeRealtimeRatio, 0.8);
  });

  test('保存した設定をJSONとして永続化する', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final settings = const LiveMonitorSettings(
      displayMode: LiveMonitorDisplayMode.split,
      earthquakeDisplaySeconds: 24,
      keepScreenAwake: false,
      portraitRealtimeRatio: 0.35,
      landscapeRealtimeRatio: 0.7,
    );

    await container.read(liveMonitorSettingsProvider.notifier).save(settings);

    final preferences = await SharedPreferences.getInstance();
    expect(
      jsonDecode(
        preferences.getString(SharedPreferencesKey.liveMonitorSettings.key) ??
            '',
      ),
      <String, Object>{
        'display_mode': 'split',
        'earthquake_display_seconds': 24,
        'keep_screen_awake': false,
        'portrait_realtime_ratio': 0.35,
        'landscape_realtime_ratio': 0.7,
      },
    );
  });
}

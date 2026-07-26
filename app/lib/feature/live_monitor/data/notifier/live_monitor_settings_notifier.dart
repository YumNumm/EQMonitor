import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_settings.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_settings_notifier.g.dart';

LiveMonitorSettings normalizeLiveMonitorSettings(LiveMonitorSettings settings) {
  final earthquakeDisplaySeconds =
      settings.earthquakeDisplaySeconds >= 3 &&
          settings.earthquakeDisplaySeconds <= 300
      ? settings.earthquakeDisplaySeconds
      : const LiveMonitorSettings().earthquakeDisplaySeconds;
  return settings.copyWith(
    earthquakeDisplaySeconds: earthquakeDisplaySeconds,
    portraitRealtimeRatio: settings.portraitRealtimeRatio.clamp(0.2, 0.8),
    landscapeRealtimeRatio: settings.landscapeRealtimeRatio.clamp(0.2, 0.8),
  );
}

@riverpod
class LiveMonitorSettingsNotifier extends _$LiveMonitorSettingsNotifier {
  static final saveMutation = Mutation<void>();

  @override
  Future<LiveMonitorSettings> build() async {
    try {
      final dataSource = await ref.read(
        sharedPreferencesDataSourceProvider.future,
      );
      final raw = await dataSource.getString(
        key: SharedPreferencesKey.liveMonitorSettings,
      );
      if (raw == null) {
        return const LiveMonitorSettings();
      }
      final Object? decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        talker.warning('[LiveMonitor] settings JSON is not an object');
        return const LiveMonitorSettings();
      }
      return normalizeLiveMonitorSettings(
        LiveMonitorSettings.fromJson(decoded),
      );
    } catch (error, stackTrace) {
      talker.error('[LiveMonitor] failed to load settings', error, stackTrace);
      return const LiveMonitorSettings();
    }
  }

  Future<void> save(LiveMonitorSettings settings) async {
    if (settings.earthquakeDisplaySeconds < 3 ||
        settings.earthquakeDisplaySeconds > 300) {
      throw ArgumentError.value(
        settings.earthquakeDisplaySeconds,
        'settings.earthquakeDisplaySeconds',
        '3〜300の整数である必要があります。',
      );
    }
    final normalized = normalizeLiveMonitorSettings(settings);
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setString(
      key: SharedPreferencesKey.liveMonitorSettings,
      value: jsonEncode(normalized.toJson()),
    );
    state = AsyncData(normalized);
  }
}

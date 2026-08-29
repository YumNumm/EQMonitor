import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_settings.g.dart';

@Riverpod(keepAlive: true)
class KyoshinMonitorSettings extends _$KyoshinMonitorSettings {
  @override
  Future<KyoshinMonitorSettingsModel> build() async => _load();

  Future<KyoshinMonitorSettingsModel> _load() async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    final json = await sharedPreferences.getString(
      key: SharedPreferencesKey.kmoniSettings,
    );
    if (json == null) {
      return const KyoshinMonitorSettingsModel();
    }
    try {
      return KyoshinMonitorSettingsModel.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return const KyoshinMonitorSettingsModel();
    }
  }

  Future<void> save(KyoshinMonitorSettingsModel model) async {
    state = AsyncValue.data(model);
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await sharedPreferences.setString(
      key: SharedPreferencesKey.kmoniSettings,
      value: jsonEncode(model.toJson()),
    );
  }
}

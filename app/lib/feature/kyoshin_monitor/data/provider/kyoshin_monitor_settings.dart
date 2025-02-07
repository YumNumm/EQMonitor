import 'dart:convert';

import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_settings.g.dart';

@Riverpod(keepAlive: true)
class KyoshinMonitorSettings extends _$KyoshinMonitorSettings {
  @override
  KyoshinMonitorSettingsModel build() {
    final result = _load();
    if (result != null) {
      return result;
    }

    return const KyoshinMonitorSettingsModel();
  }

  static const _prefsKey = '_kmoni_settings';

  KyoshinMonitorSettingsModel? _load() {
    final json = ref.read(sharedPreferencesProvider).getString(_prefsKey);
    if (json == null) {
      return null;
    }
    try {
      return KyoshinMonitorSettingsModel.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return null;
    }
  }

  Future<void> save(KyoshinMonitorSettingsModel model) async {
    state = model;
    await ref.read(sharedPreferencesProvider).setString(
          _prefsKey,
          jsonEncode(state.toJson()),
        );
  }
}

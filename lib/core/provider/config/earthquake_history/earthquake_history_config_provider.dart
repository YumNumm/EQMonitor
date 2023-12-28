import 'dart:convert';

import 'package:eqmonitor/core/provider/config/earthquake_history/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_config_provider.g.dart';

@riverpod
class EarthquakeHistoryConfig extends _$EarthquakeHistoryConfig {
  @override
  EarthquakeHistoryConfigModel build() {
    final result = _load();
    if (result != null) {
      return result;
    }
    return const EarthquakeHistoryConfigModel(
      list: EarthquakeHistoryListConfig(),
      detail: EarthquakeHistoryDetailConfig(),
    );
  }

  static const _key = 'earthquake_history_config';

  Future<void> _save() async => ref.read(sharedPreferencesProvider).setString(
        _key,
        jsonEncode(state),
      );

  EarthquakeHistoryConfigModel? _load() {
    final jsonString = ref.read(sharedPreferencesProvider).getString(_key);
    if (jsonString == null) {
      return null;
    }
    try {
      return EarthquakeHistoryConfigModel.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return null;
    }
  }

  void updateListConfig(EarthquakeHistoryListConfig config) {
    state = state.copyWith(list: config);
    _save();
  }

  void updateDetailConfig(EarthquakeHistoryDetailConfig config) {
    state = state.copyWith(detail: config);
    _save();
  }
}

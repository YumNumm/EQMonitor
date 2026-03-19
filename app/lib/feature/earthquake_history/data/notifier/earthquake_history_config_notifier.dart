import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_config_notifier.g.dart';

const _defaultEarthquakeHistoryConfig = EarthquakeHistoryConfig(
  list: EarthquakeHistoryListConfig(),
  detail: EarthquakeHistoryDetailConfig(),
);

@riverpod
class EarthquakeHistoryConfigNotifier
    extends _$EarthquakeHistoryConfigNotifier {
  @override
  Future<EarthquakeHistoryConfig> build() async => _load();

  Future<EarthquakeHistoryConfig> _load() async {
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    final jsonString = await ds.getString(
      key: SharedPreferencesKey.earthquakeHistoryConfig,
    );
    if (jsonString == null) {
      return _defaultEarthquakeHistoryConfig;
    }
    try {
      return EarthquakeHistoryConfig.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return _defaultEarthquakeHistoryConfig;
    }
  }

  Future<void> _save(EarthquakeHistoryConfig value) async {
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    await ds.setString(
      key: SharedPreferencesKey.earthquakeHistoryConfig,
      value: jsonEncode(value.toJson()),
    );
  }

  Future<void> updateListConfig(EarthquakeHistoryListConfig config) async {
    final current = state.value ?? _defaultEarthquakeHistoryConfig;
    state = AsyncValue.data(current.copyWith(list: config));
    await _save(state.value!);
  }

  Future<void> updateDetailConfig(EarthquakeHistoryDetailConfig config) async {
    final current = state.value ?? _defaultEarthquakeHistoryConfig;
    state = AsyncValue.data(current.copyWith(detail: config));
    await _save(state.value!);
  }

  Future<void> updateIntensityIcon({required bool value}) async {
    final current = state.value ?? _defaultEarthquakeHistoryConfig;
    state = AsyncValue.data(current.copyWith(
      detail: current.detail.copyWith(showIntensityIcon: value),
    ));
    await _save(state.value!);
  }
}

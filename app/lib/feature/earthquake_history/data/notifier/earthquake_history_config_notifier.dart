import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_config_notifier.g.dart';

const _defaultEarthquakeHistoryConfig = EarthquakeHistoryConfig(
  list: EarthquakeHistoryListConfig(),
  detail: EarthquakeHistoryDetailConfig(),
);

@Riverpod(keepAlive: true)
class EarthquakeHistoryConfigNotifier
    extends _$EarthquakeHistoryConfigNotifier {
  @override
  Future<EarthquakeHistoryConfig> build() async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    final jsonString = await sharedPreferences.getString(
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
    } catch (exception, stackTrace) {
      talker.error(
        'load earthquake history config failed: $exception',
        exception,
        stackTrace,
      );
      return _defaultEarthquakeHistoryConfig;
    }
  }

  Future<void> save(EarthquakeHistoryConfig value) async {
    state = AsyncValue.data(value);
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await sharedPreferences.setString(
      key: SharedPreferencesKey.earthquakeHistoryConfig,
      value: jsonEncode(value.toJson()),
    );
  }
}

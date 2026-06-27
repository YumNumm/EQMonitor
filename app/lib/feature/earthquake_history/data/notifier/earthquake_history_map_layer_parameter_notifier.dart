import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_map_layer_parameter_notifier.g.dart';

const _defaultEarthquakeHistoryMapLayerParameter =
    EarthquakeHistoryMapLayerParameter();

@Riverpod(keepAlive: true)
class EarthquakeHistoryMapLayerParameterNotifier
    extends _$EarthquakeHistoryMapLayerParameterNotifier {
  @override
  Future<EarthquakeHistoryMapLayerParameter> build() async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    final jsonString = await sharedPreferences.getString(
      key: .earthquakeHistoryMapLayerParameter,
    );
    if (jsonString == null) {
      return _defaultEarthquakeHistoryMapLayerParameter;
    }
    try {
      return EarthquakeHistoryMapLayerParameter.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (exception, stackTrace) {
      talker.error(
        'load earthquake history map layer parameter failed: $exception',
        exception,
        stackTrace,
      );
      return _defaultEarthquakeHistoryMapLayerParameter;
    }
  }

  Future<void> save(EarthquakeHistoryMapLayerParameter value) async {
    state = AsyncValue.data(value);
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await sharedPreferences.setString(
      key: SharedPreferencesKey.earthquakeHistoryMapLayerParameter,
      value: jsonEncode(value.toJson()),
    );
  }

  Future<void> reset() async {
    await save(_defaultEarthquakeHistoryMapLayerParameter);
  }
}

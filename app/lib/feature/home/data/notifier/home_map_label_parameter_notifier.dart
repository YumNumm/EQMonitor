import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_label_parameter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_map_label_parameter_notifier.g.dart';

const _default = HomeMapLabelParameter();

@Riverpod(keepAlive: true)
class HomeMapLabelParameterNotifier
    extends _$HomeMapLabelParameterNotifier {
  @override
  Future<HomeMapLabelParameter> build() async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    final jsonString = await sharedPreferences.getString(
      key: SharedPreferencesKey.homeMapLabelParameter,
    );
    if (jsonString == null) {
      return _default;
    }
    try {
      return HomeMapLabelParameter.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (exception, stackTrace) {
      talker.error(
        'load home map label parameter failed: $exception',
        exception,
        stackTrace,
      );
      return _default;
    }
  }

  Future<void> save(HomeMapLabelParameter value) async {
    state = AsyncValue.data(value);
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await sharedPreferences.setString(
      key: SharedPreferencesKey.homeMapLabelParameter,
      value: jsonEncode(value.toJson()),
    );
  }

  Future<void> reset() async {
    await save(_default);
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_configuration_notifier.g.dart';

@riverpod
class HomeConfigurationNotifier extends _$HomeConfigurationNotifier {
  @override
  Future<HomeConfigurationModel> build() async => load();

  Future<HomeConfigurationModel> load() async {
    try {
      final sharedPreferences = await ref.read(
        sharedPreferencesDataSourceProvider.future,
      );
      final jsonString = await sharedPreferences.getString(
        key: SharedPreferencesKey.homeConfiguration,
      );
      if (jsonString == null) {
        return const HomeConfigurationModel();
      }
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return HomeConfigurationModel.fromJson(json);
    } on Exception catch (e) {
      log('load home configuration failed: $e');
      return const HomeConfigurationModel();
    }
  }

  Future<void> save(HomeConfigurationModel configuration) async {
    state = AsyncValue.data(configuration);
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await sharedPreferences.setString(
      key: SharedPreferencesKey.homeConfiguration,
      value: jsonEncode(configuration.toJson()),
    );
  }

  Future<void> setEarthquakeHistoryScope(
    HomeEarthquakeHistoryScope scope,
  ) async {
    final current = await future;
    await save(
      current.copyWith(
        common: current.common.copyWith(earthquakeHistoryScope: scope),
      ),
    );
  }

  Future<void> updateEew(HomeEewSettings eew) async {
    final current = await future;
    await save(current.copyWith(eew: eew));
  }

  Future<void> updateKyoshinMonitor(
    HomeKyoshinMonitorSettings kyoshinMonitor,
  ) async {
    final current = await future;
    await save(current.copyWith(kyoshinMonitor: kyoshinMonitor));
  }

  Future<void> updateMap(HomeMapSettings map) async {
    final current = await future;
    await save(current.copyWith(map: map));
  }

  Future<void> updateCommon(HomeCommonSettings common) async {
    final current = await future;
    await save(current.copyWith(common: common));
  }

  Future<void> updateShakeDetection(
    HomeShakeDetectionSettings shakeDetection,
  ) async {
    final current = await future;
    await save(current.copyWith(shakeDetection: shakeDetection));
  }
}

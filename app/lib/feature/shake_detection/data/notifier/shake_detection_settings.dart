import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_settings_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_settings.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetectionSettings extends _$ShakeDetectionSettings {
  @override
  Future<ShakeDetectionSettingsModel> build() async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    final json = await sharedPreferences.getString(
      key: SharedPreferencesKey.shakeDetectionSettings,
    );
    if (json == null) {
      return const ShakeDetectionSettingsModel();
    }
    try {
      return ShakeDetectionSettingsModel.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
      // 保存値が壊れている場合は初期値で起動する。
    } on Object {
      return const ShakeDetectionSettingsModel();
    }
  }

  Future<void> save(ShakeDetectionSettingsModel model) async {
    state = AsyncData(model);
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await sharedPreferences.setString(
      key: SharedPreferencesKey.shakeDetectionSettings,
      value: jsonEncode(model.toJson()),
    );
  }
}

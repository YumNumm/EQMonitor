import 'dart:convert';

import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/home/features/eew_settings/model/eew_setitngs_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class EewSettingsNotifier extends _$EewSettingsNotifier {
  @override
  EewSetitngs build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final json = prefs.getString(_prefsKey);
    if (json == null) {
      return const EewSetitngs();
    }
    return EewSetitngs.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  Future<void> setShowCalculatedRegionIntensity({required bool value}) async {
    state = state.copyWith(showCalculatedRegionIntensity: value);
    await _save();
  }

  Future<void> setShowCalculatedCityIntensity({required bool value}) async {
    state = state.copyWith(showCalculatedCityIntensity: value);
    await _save();
  }

  Future<void> _save() async => ref
      .read(sharedPreferencesProvider)
      .setString(_prefsKey, jsonEncode(state.toJson()));

  static const _prefsKey = 'eew_settings';
}

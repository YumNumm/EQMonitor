import 'dart:convert';

import 'package:eqmonitor/core/provider/config/crashlytics/model/crashlytics_setting_model.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'crashlytics_setting_provider.g.dart';

@riverpod
class CrashlyticsSetting extends _$CrashlyticsSetting {
  @override
  CrashlyticsSettingModel build() {
    ref.listenSelf((_, next) => _save());
    return const CrashlyticsSettingModel();
  }

  static const String _key = 'crashlytics_setting';

  Future<void> _save() async => ref
      .read(sharedPreferencesProvider)
      .setString(_key, jsonEncode(state.toJson()));

  void setEnabled({required bool isEnabled}) {
    state = state.copyWith(isEnabled: isEnabled);
  }

  static CrashlyticsSettingModel? read(SharedPreferences prefs) {
    final json = prefs.getString(_key);
    if (json == null) {
      return null;
    }
    return CrashlyticsSettingModel.fromJson(
      jsonDecode(json) as Map<String, dynamic>,
    );
  }
}

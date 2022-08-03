import 'package:eqmonitor/model/setting/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends StateNotifier<ThemeModel> {
  ThemeController()
      : super(
          const ThemeModel(
            themeMode: ThemeMode.system,
          ),
        ) {
    loadSettingsFromSharedPrefrences();
  }

  /// SharedPreferencesから直近の設定を取得する
  Future<void> loadSettingsFromSharedPrefrences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getString('themeMode');
    final themeModeEnum = ThemeMode.values.firstWhere(
      (element) => element.name == themeMode,
      orElse: () => ThemeMode.system,
    );
    state = state.copyWith(
      themeMode: themeModeEnum,
    );
  }

  /// SharedPreferencesに設定を保存する
  Future<void> saveSettingsToSharedPrefrences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('themeMode', state.themeMode.name);
  }

  void setTheme(ThemeMode themeMode) {
    state = state.copyWith(
      themeMode: themeMode,
    );
    saveSettingsToSharedPrefrences();
  }
}

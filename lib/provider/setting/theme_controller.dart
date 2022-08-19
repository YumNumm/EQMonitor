import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/setting/theme_model.dart';

/// テーマモードを管理するProvider
class ThemeProvider extends StateNotifier<ThemeModel> {
  ThemeProvider()
      : super(
          const ThemeModel(
            themeMode: ThemeMode.system,
          ),
        ) {
    loadSettingsFromSharedPrefrences();
  }

  /// ## SharedPreferencesから設定を取得
  /// デフォルトはThemeMode.system
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

  /// ## SharedPreferencesに設定を保存する
  Future<void> _saveSettingsToSharedPrefrences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('themeMode', state.themeMode.name);
  }

  /// ## テーマを変更
  /// [themeMode] テーマモード
  /// 変更後、SharedPreferencesに設定を保存します
  void setTheme(ThemeMode themeMode) {
    state = state.copyWith(
      themeMode: themeMode,
    );
    _saveSettingsToSharedPrefrences();
  }

  /// ## ダークモードかどうか
  /// システム設定のテーマも考慮します
  bool get isDarkMode => (state.themeMode == ThemeMode.system)
      ? (SchedulerBinding.instance.window.platformBrightness == Brightness.dark)
      : state.themeMode == ThemeMode.dark;
}



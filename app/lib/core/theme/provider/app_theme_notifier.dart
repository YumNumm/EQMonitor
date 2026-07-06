import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/core/theme/migration/theme_migration.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:eqmonitor/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_notifier.g.dart';

@Riverpod(keepAlive: true)
class AppThemeNotifier extends _$AppThemeNotifier {
  static const _lightKey = 'app_theme_light';
  static const _darkKey = 'app_theme_dark';
  static const _legacyIntensityColorKey = 'intensity_color';
  static const _legacyEstimatedIntensityColorKey = 'estimated_intensity_color';

  @override
  ({AppTheme lightTheme, AppTheme darkTheme}) build() {
    // 既に新形式のテーマが保存されている場合はマイグレーション不要
    final savedLight = _load(_lightKey);
    final savedDark = _load(_darkKey);
    if (savedLight == null && savedDark == null) {
      final migrated = migrateFromLegacyIntensityColors(
        ref.read(sharedPreferencesProvider),
      );
      if (migrated != null) {
        // 新形式の保存が完了してから旧キーを削除する。
        // 途中でプロセスが終了しても旧キーが残るため、
        // 次回起動時にマイグレーションを再試行できる（冪等）。
        unawaited(
          Future.wait([
            _save(_lightKey, migrated),
            _save(_darkKey, migrated),
          ]).then((_) => _removeLegacyKeys()),
        );
        return (lightTheme: migrated, darkTheme: migrated);
      }
    }

    return (
      lightTheme: savedLight ?? AppTheme.eqmonitorDefault(),
      darkTheme: savedDark ?? AppTheme.eqmonitorDefault(),
    );
  }

  Future<void> _removeLegacyKeys() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove(_legacyIntensityColorKey);
    await prefs.remove(_legacyEstimatedIntensityColorKey);
  }

  Future<void> setLightTheme(AppTheme theme) async {
    state = (lightTheme: theme, darkTheme: state.darkTheme);
    await _save(_lightKey, theme);
  }

  Future<void> setDarkTheme(AppTheme theme) async {
    state = (lightTheme: state.lightTheme, darkTheme: theme);
    await _save(_darkKey, theme);
  }

  Future<void> setThemeForMode(ThemeBrightnessMode mode, AppTheme theme) {
    return switch (mode) {
      ThemeBrightnessMode.light => setLightTheme(theme),
      ThemeBrightnessMode.dark => setDarkTheme(theme),
    };
  }

  Result<AppTheme, AppThemeImportException> importFromJson(String rawJson) {
    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic>) {
        return const Failure(AppThemeImportException('JSONの形式が不正です'));
      }
      final theme = AppTheme.fromJson(decoded);
      if (theme.version != 1) {
        return const Failure(AppThemeImportException('未対応のテーマバージョンです'));
      }
      for (final mode in theme.modes) {
        final colorSet = switch (mode) {
          ThemeBrightnessMode.light => theme.light,
          ThemeBrightnessMode.dark => theme.dark,
        };
        if (colorSet == null) {
          return Failure(AppThemeImportException('${mode.name}モードの色定義がありません'));
        }
      }
      return Success(theme);
    } on FormatException catch (_) {
      return const Failure(AppThemeImportException('JSONの解析に失敗しました'));
    } on Object catch (_) {
      return const Failure(AppThemeImportException('テーマJSONの内容が不正です'));
    }
  }

  String exportToJson(AppTheme theme) =>
      const JsonEncoder.withIndent('  ').convert(theme.toJson());

  AppTheme? _load(String key) {
    final value = ref.read(sharedPreferencesProvider).getString(key);
    if (value == null) {
      return null;
    }
    try {
      return AppTheme.fromJson(jsonDecode(value) as Map<String, dynamic>);
    } on Object catch (_) {
      return null;
    }
  }

  Future<void> _save(String key, AppTheme theme) async {
    await ref
        .read(sharedPreferencesProvider)
        .setString(key, jsonEncode(theme.toJson()));
  }
}

@riverpod
ThemeColorSet activeColorSet(Ref ref) {
  final brightness = ref.watch(brightnessProvider);
  final themes = ref.watch(appThemeProvider);
  final theme = switch (brightness) {
    Brightness.light => themes.lightTheme,
    Brightness.dark => themes.darkTheme,
  };
  return theme.colorSetFor(brightness);
}

@riverpod
ThemeColorSet colorSetForBrightness(Ref ref, Brightness brightness) {
  final themes = ref.watch(appThemeProvider);
  final theme = switch (brightness) {
    Brightness.light => themes.lightTheme,
    Brightness.dark => themes.darkTheme,
  };
  return theme.colorSetFor(brightness);
}

final class AppThemeImportException implements Exception {
  const AppThemeImportException(this.message);
  final String message;
}

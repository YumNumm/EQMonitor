import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_field_def.dart';
import 'package:eqmonitor/core/theme/model/theme_color_field_def.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_editor_controller.g.dart';

@riverpod
class ThemeEditorController extends _$ThemeEditorController {
  @override
  ThemeColorSet build(ThemeBrightnessMode mode) {
    final themes = ref.watch(appThemeProvider).requireValue;
    final theme = switch (mode) {
      ThemeBrightnessMode.light => themes.lightTheme,
      ThemeBrightnessMode.dark => themes.darkTheme,
    };
    return theme.colorSetFor(_brightnessFor(mode));
  }

  Future<void> updateField(ThemeColorFieldDef def, Color color) async {
    final updated = def.setter(state, color);
    state = updated;
    await _save(updated);
  }

  Future<void> updateIntensityEntry(
    IntensityFieldDef def,
    IntensityColorEntry entry,
  ) async {
    final updated = def.entrySetter(state, entry);
    state = updated;
    await _save(updated);
  }

  Future<void> _save(ThemeColorSet colorSet) async {
    final theme = AppTheme(
      name: 'カスタム',
      version: 1,
      author: 'EQMonitor',
      modes: [mode],
      light: mode == ThemeBrightnessMode.light ? colorSet : null,
      dark: mode == ThemeBrightnessMode.dark ? colorSet : null,
    );
    await ref.read(appThemeProvider.notifier).setThemeForMode(mode, theme);
  }

  Brightness _brightnessFor(ThemeBrightnessMode mode) => switch (mode) {
    ThemeBrightnessMode.light => Brightness.light,
    ThemeBrightnessMode.dark => Brightness.dark,
  };
}

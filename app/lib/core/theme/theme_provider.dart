import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    final result = _load();
    if (result != null) {
      return result;
    }
    return ThemeMode.system;
  }

  void update(ThemeMode mode) {
    state = mode;
    ref.read(sharedPreferencesProvider).setString(_prefsKey, mode.name);
  }

  ThemeMode? _load() {
    final prefs = ref.read(sharedPreferencesProvider);
    final value = prefs.getString(_prefsKey);
    if (value == null) {
      return null;
    }
    return ThemeMode.values.firstWhereOrNull((e) => e.name == value);
  }

  static const _prefsKey = 'theme_mode';
}

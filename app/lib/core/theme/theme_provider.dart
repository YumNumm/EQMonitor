import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  Future<ThemeMode> build() async => _load();

  Future<ThemeMode> _load() async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    final value = await sharedPreferences.getString(
      key: SharedPreferencesKey.themeMode,
    );
    if (value == null) {
      return ThemeMode.system;
    }
    return ThemeMode.values.firstWhereOrNull((e) => e.name == value) ??
        ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = AsyncValue.data(mode);
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await sharedPreferences.setString(
      key: SharedPreferencesKey.themeMode,
      value: mode.name,
    );
  }
}

@Riverpod(keepAlive: true)
class BrightnessNotifier extends _$BrightnessNotifier
    with WidgetsBindingObserver {
  @override
  ui.Brightness build() {
    // プロバイダ構築時に監視を開始。
    final binding = WidgetsBinding.instance..addObserver(this);
    // プロバイダが破棄された時に監視を解除。
    ref.onDispose(() => binding.removeObserver(this));

    return _currentBrightness;
  }

  ui.Brightness get _currentBrightness {
    final binding = WidgetsBinding.instance;
    return binding.platformDispatcher.platformBrightness;
  }

  @override
  void didChangePlatformBrightness() {
    // `Brightness` の変更を検知してNotifierが持つ状態を更新。
    state = _currentBrightness;
    super.didChangePlatformBrightness();
  }
}

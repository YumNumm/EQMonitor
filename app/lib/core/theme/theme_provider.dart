import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  Future<void> update(ThemeMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(_prefsKey, mode.name);
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


@Riverpod(keepAlive: true)
class Brightness extends _$Brightness with WidgetsBindingObserver {
  @override
  Brightness build() {
    // プロバイダ構築時に監視を開始。
    final binding = WidgetsBinding.instance..addObserver(this);
    // プロバイダが破棄された時に監視を解除。
    ref.onDispose(() => binding.removeObserver(this));
    // 初期値として `resumed` を返している。
    return Brightness.light;
  }

  @override
  void didChangePlatformBrightness(Brightness state) {
    // `Brightness` の変更を検知してNotifierが持つ状態を更新。
    this.state = state;
    super.didChangeBrightnessState(state);
  }
}

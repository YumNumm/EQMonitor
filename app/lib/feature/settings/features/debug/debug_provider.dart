import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_provider.g.dart';

@riverpod
class Debug extends _$Debug {
  @override
  bool build() {
    final savedState = _getIsEnabled();
    if (savedState == null) {
      return kDebugMode;
    }
    return savedState;
  }

  static const _key = 'debug';

  bool? _getIsEnabled() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getBool(_key);
  }

  Future<void> save({
    required bool isEnabled,
  }) async {
    state = isEnabled;

    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_key, isEnabled);
  }
}

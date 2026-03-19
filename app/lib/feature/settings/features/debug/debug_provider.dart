import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_provider.g.dart';

@riverpod
class Debug extends _$Debug {
  @override
  Future<bool> build() async => _getIsEnabled();

  Future<bool> _getIsEnabled() async {
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    final value = await ds.getBool(key: SharedPreferencesKey.debug);
    return value ?? kDebugMode;
  }

  Future<void> save({required bool isEnabled}) async {
    state = AsyncValue.data(isEnabled);
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    await ds.setBool(key: SharedPreferencesKey.debug, value: isEnabled);
  }
}

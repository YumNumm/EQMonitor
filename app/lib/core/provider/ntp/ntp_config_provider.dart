import 'dart:convert';

import 'package:eqmonitor/core/provider/ntp/ntp_config_model.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ntp_config_provider.g.dart';

@Riverpod(keepAlive: true)
class NtpConfig extends _$NtpConfig {
  @override
  NtpConfigModel build() => _load();

  static const _prefsKey = 'ntp_config';

  NtpConfigModel _load() {
    final prefs = ref.read(sharedPreferencesProvider);
    final json = prefs.getString(_prefsKey);
    if (json == null) {
      return const NtpConfigModel();
    }
    try {
      return NtpConfigModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return const NtpConfigModel();
    }
  }

  Future<void> changeLookUpAddress(String url) async {
    state = state.copyWith(lookUpAddress: url);
    await _save(state);
  }

  Future<void> changeTimeout(Duration timeout) async {
    state = state.copyWith(timeout: timeout);
    await _save(state);
  }

  Future<void> changeInterval(Duration interval) async {
    state = state.copyWith(interval: interval);
    await _save(state);
  }

  Future<void> _save(NtpConfigModel config) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_prefsKey, jsonEncode(config.toJson()));
  }
}

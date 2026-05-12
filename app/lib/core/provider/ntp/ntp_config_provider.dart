import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_config_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ntp_config_provider.g.dart';

@Riverpod(keepAlive: true)
class NtpConfig extends _$NtpConfig {
  @override
  Future<NtpConfigModel> build() async => _load();

  Future<NtpConfigModel> _load() async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    final json = await sharedPreferences.getString(
      key: SharedPreferencesKey.ntpConfig,
    );
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
    final current = state.value ?? const NtpConfigModel();
    final updated = current.copyWith(lookUpAddress: url);
    state = AsyncValue.data(updated);
    await _save(updated);
  }

  Future<void> changeTimeout(Duration timeout) async {
    final current = state.value ?? const NtpConfigModel();
    final updated = current.copyWith(timeout: timeout);
    state = AsyncValue.data(updated);
    await _save(updated);
  }

  Future<void> changeInterval(Duration interval) async {
    final current = state.value ?? const NtpConfigModel();
    final updated = current.copyWith(interval: interval);
    state = AsyncValue.data(updated);
    await _save(updated);
  }

  Future<void> _save(NtpConfigModel config) async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await sharedPreferences.setString(
      key: SharedPreferencesKey.ntpConfig,
      value: jsonEncode(config.toJson()),
    );
  }
}

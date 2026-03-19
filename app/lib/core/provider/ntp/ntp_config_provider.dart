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
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    final json = await ds.getString(key: SharedPreferencesKey.ntpConfig);
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
    final current = state.valueOrNull ?? const NtpConfigModel();
    state = AsyncValue.data(current.copyWith(lookUpAddress: url));
    await _save(state.valueOrNull!);
  }

  Future<void> changeTimeout(Duration timeout) async {
    final current = state.valueOrNull ?? const NtpConfigModel();
    state = AsyncValue.data(current.copyWith(timeout: timeout));
    await _save(state.valueOrNull!);
  }

  Future<void> changeInterval(Duration interval) async {
    final current = state.valueOrNull ?? const NtpConfigModel();
    state = AsyncValue.data(current.copyWith(interval: interval));
    await _save(state.valueOrNull!);
  }

  Future<void> _save(NtpConfigModel config) async {
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    await ds.setString(
      key: SharedPreferencesKey.ntpConfig,
      value: jsonEncode(config.toJson()),
    );
  }
}

import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/api_endpoint_url.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/telegram_url_model.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_url_provider.g.dart';

@Riverpod(keepAlive: true)
class TelegramUrl extends _$TelegramUrl {
  @override
  Future<TelegramUrlModel> build() async => _load();

  TelegramUrlModel _defaultTelegramUrl() {
    final env = ref.read(buildConfigProvider);
    return TelegramUrlModel(
      restApiUrl: env.restApiUrl,
      wsApiUrl: env.wsApiUrl,
    );
  }

  Future<TelegramUrlModel> _load() async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    final jsonString = await sharedPreferences.getString(
      key: SharedPreferencesKey.telegramUrl,
    );
    if (jsonString == null) {
      return _defaultTelegramUrl();
    }
    try {
      return TelegramUrlModel.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return _defaultTelegramUrl();
    }
  }

  Future<void> _save(TelegramUrlModel value) async {
    final sharedPreferences = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await sharedPreferences.setString(
      key: SharedPreferencesKey.telegramUrl,
      value: jsonEncode(value.toJson()),
    );
  }

  static final updateMutation = Mutation<void>();

  Future<void> updateRestUrl(String url) async {
    final normalized = const ApiEndpointUrl().normalize(url);
    final current = await future;
    await updateServer(restApiUrl: normalized, wsApiUrl: current.wsApiUrl);
  }

  Future<void> updateServer({
    required String restApiUrl,
    required String wsApiUrl,
  }) async {
    final updated = TelegramUrlModel(
      restApiUrl: restApiUrl,
      wsApiUrl: wsApiUrl,
    );
    await _save(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> resetToDefault() async {
    final updated = _defaultTelegramUrl();
    await _save(updated);
    state = AsyncValue.data(updated);
  }
}

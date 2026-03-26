import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/telegram_url_model.dart';
import 'package:eqmonitor/core/util/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_url_provider.g.dart';

const _defaultTelegramUrl = TelegramUrlModel(
  restApiUrl: Env.restApiUrl,
  wsApiUrl: Env.wsApiUrl,
);

@Riverpod(keepAlive: true)
class TelegramUrl extends _$TelegramUrl {
  @override
  Future<TelegramUrlModel> build() async => _load();

  Future<TelegramUrlModel> _load() async {
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    final jsonString =
        await ds.getString(key: SharedPreferencesKey.telegramUrl);
    if (jsonString == null) {
      return _defaultTelegramUrl;
    }
    try {
      return TelegramUrlModel.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return _defaultTelegramUrl;
    }
  }

  Future<void> _save(TelegramUrlModel value) async {
    final ds = ref.read(sharedPreferencesDataSourceProvider);
    await ds.setString(
      key: SharedPreferencesKey.telegramUrl,
      value: jsonEncode(value.toJson()),
    );
  }

  Future<void> updateRestUrl(String url) async {
    final current = state.value ?? _defaultTelegramUrl;
    state = AsyncValue.data(current.copyWith(restApiUrl: url));
    await _save(state.value!);
  }

  Future<void> updateWebSocketUrl(String url) async {
    final current = state.value ?? _defaultTelegramUrl;
    state = AsyncValue.data(current.copyWith(wsApiUrl: url));
    await _save(state.value!);
  }
}

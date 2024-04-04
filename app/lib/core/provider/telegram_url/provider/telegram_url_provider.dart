import 'dart:convert';

import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/telegram_url_model.dart';
import 'package:eqmonitor/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_url_provider.g.dart';

@Riverpod(keepAlive: true)
class TelegramUrl extends _$TelegramUrl {
  @override
  TelegramUrlModel build() {
    final result = _load();
    if (result != null) {
      return result;
    }

    return TelegramUrlModel(
      restApiUrl: Env.restApiUrl,
      wsApiUrl: Env.wsApiUrl,
      apiAuthorization: Env.apiAuthorization,
    );
  }

  static const _key = 'telegram_url';

  Future<void> _save() async =>
      ref.read(sharedPreferencesProvider).setString(_key, jsonEncode(state));

  TelegramUrlModel? _load() {
    final jsonString = ref.read(sharedPreferencesProvider).getString(_key);
    if (jsonString == null) {
      return null;
    }
    try {
      return TelegramUrlModel.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return null;
    }
  }

  void updateRestUrl(String url) {
    state = state.copyWith(restApiUrl: url);
    _save();
  }
}

import 'dart:convert';

import 'package:eqmonitor/common/provider/shared_preferences.dart';
import 'package:eqmonitor/env/env.dart';
import 'package:eqmonitor/feature/home/providers/telegram_url/model/telegram_url_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'telegram_url_provider.g.dart';

@Riverpod(keepAlive: true)
class TelegramUrl extends _$TelegramUrl {
  @override
  TelegramUrlModel build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final result = _load();
    if (result != null) {
      return result;
    }

    ref.listenSelf((_, __) => _save());

    return TelegramUrlModel(
      restApiUrl: Env.restApiUrl,
      wsApiUrl: Env.wsApiUrl,
      apiAuthorization: Env.apiAuthorization,
    );
  }

  late final SharedPreferences _prefs;

  static const _key = 'telegram_url';

  Future<void> _save() async => _prefs.setString(_key, jsonEncode(state));

  TelegramUrlModel? _load() {
    final jsonString = _prefs.getString(_key);
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

  // ignore: avoid_setters_without_getters
  set setState(TelegramUrlModel model) => state = model;
}

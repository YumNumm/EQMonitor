import 'dart:convert';

import 'package:eqmonitor/common/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/home/features/debugger/debugger_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'debugger_provider.g.dart';

@riverpod
class Debugger extends _$Debugger {
  @override
  DebuggerModel build() {
    _prefs = ref.read(sharedPreferencesProvider);
    ref.listenSelf((_, next) async => save());
    return _getDebugger();
  }

  late SharedPreferences _prefs;

  static const _key = 'debugger';

  DebuggerModel _getDebugger() {
    final json = _prefs.getString(_key);
    if (json == null) {
      return const DebuggerModel();
    }
    try {
      return DebuggerModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } on Exception catch (_) {
      return const DebuggerModel();
    }
  }

  Future<void> save() async {
    await _prefs.setString(_key, jsonEncode(state.toJson()));
  }
}

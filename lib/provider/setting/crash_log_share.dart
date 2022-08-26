import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../init/shared_preferences.dart';

final crashLogShareProvider = StateNotifierProvider(
  (ref) => CrashLogShareProvider(ref.watch(sharedPreferencesProvder)),
);

/// ## クラッシュログの自動送信許可を管理するProvider
class CrashLogShareProvider extends StateNotifier<bool> {
  CrashLogShareProvider(this.prefs) : super(true) {
    loadSettingsFromSharedPrefrences();
  }
  final SharedPreferences prefs;

  static const String _prefsKey = 'crash_log_share';

  /// ## SharedPreferencesから設定を取得
  /// デフォルトはtrue
  Future<bool> loadSettingsFromSharedPrefrences() async {
    return state = prefs.getBool(_prefsKey) ?? true;
  }

  /// ## SharedPreferencesに設定を保存する
  Future<void> _saveSettingsToSharedPrefrences() async {
    await prefs.setBool(_prefsKey, state);
  }

  /// ## クラッシュログをシェアするかどうか
  /// 変更後、SharedPreferencesに設定を保存します
  void setCrashLogShare({required bool isCrashLogShare}) {
    state = isCrashLogShare;
    _saveSettingsToSharedPrefrences();
  }
}

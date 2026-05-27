import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_return_to_realtime_notifier.g.dart';

/// タイムシフト/リプレイ再生中にリアルタイムの EEW・揺れ検知イベントが発生した際、
/// 通常再生（ライブ）へ自動的に戻すかどうかの設定。
///
/// 防災アプリの性質上、デフォルトは有効（戻す）。
@Riverpod(keepAlive: true)
class AutoReturnToRealtimeNotifier extends _$AutoReturnToRealtimeNotifier {
  static const SharedPreferencesKey _key =
      SharedPreferencesKey.autoReturnToRealtime;

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_key.key) ?? true;
  }

  Future<void> set({required bool value}) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_key.key, value);
    state = value;
  }
}

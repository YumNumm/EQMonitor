import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
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
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(key: _key) ?? true;
  }

  Future<void> set({required bool value}) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(key: _key, value: value);
    state = AsyncData(value);
  }
}

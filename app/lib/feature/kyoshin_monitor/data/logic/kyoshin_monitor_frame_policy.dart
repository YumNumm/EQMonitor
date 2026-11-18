import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_frame_policy.g.dart';

@riverpod
KyoshinMonitorFramePolicy kyoshinMonitorFramePolicy(Ref ref) =>
    const KyoshinMonitorFramePolicy();

class const KyoshinMonitorFramePolicy() {
  /// [targetTime] の画像を既に取得・解析済みかどうか。
  ///
  /// 公開遅延の見積もりが変わるとタイマーが作り直され、境界を待たずに 1 枚
  /// 取りに行く。見積もりの変化が 1 秒未満だと、直前と同じ対象時刻が再び届く。
  /// 失敗した取得は [KyoshinMonitorState.lastImageFetchTargetTime] を
  /// 更新しないため、404 などの後の取り直しは妨げない。
  bool isAlreadyFetched({
    required KyoshinMonitorState? current,
    required DateTime targetTime,
  }) =>
      current?.lastImageFetchTargetTime?.isAtSameMomentAs(targetTime) ?? false;
}

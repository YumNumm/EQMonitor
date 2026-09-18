import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_monitor_timer_state.freezed.dart';
part 'kyoshin_monitor_timer_state.g.dart';

@freezed
abstract class KyoshinMonitorTimerState with _$KyoshinMonitorTimerState {
  const factory({
    /// 端末時計から見た `latest_time` のずれ (トリム平均)
    ///
    /// 通常は負の値。端末時計の誤差を含むため、そのまま現在時刻から引いては
    /// いけない。公開遅延は TimeSampleCalculator で求める。
    required Duration shift,

    /// `latest.json` 取得の往復時間 (トリム平均)
    required Duration roundTripTime,

    /// どのデータソースに対して測った値か
    required KyoshinMonitorSource source,

    /// 測定に使ったサンプル数
    required int sampleCount,
    required DateTime? lastSyncedAt,
  }) = _KyoshinMonitorTimerState;

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorTimerStateFromJson(json);
}

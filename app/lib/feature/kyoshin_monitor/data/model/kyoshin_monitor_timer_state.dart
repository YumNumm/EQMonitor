import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_time_sample.dart';
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
    /// いけない。[publishDelay] を使うこと。
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

extension KyoshinMonitorTimerStateX on KyoshinMonitorTimerState {
  /// サーバの公開遅延。
  ///
  /// [ntpOffset] は、この値を引く対象の時計と必ず揃えること
  /// (`AppClock` が NTP 補正済みなら NTP のオフセットを渡す)。
  Duration publishDelay(Duration? ntpOffset) =>
      KyoshinMonitorPublishDelay.resolve(shift: shift, ntpOffset: ntpOffset);
}

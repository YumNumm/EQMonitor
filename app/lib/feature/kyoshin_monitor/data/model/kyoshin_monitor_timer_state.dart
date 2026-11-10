import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_monitor_timer_state.freezed.dart';
part 'kyoshin_monitor_timer_state.g.dart';

@freezed
abstract class KyoshinMonitorTimerState with _$KyoshinMonitorTimerState {
  const factory({
    /// 端末時計から見た `latest_time` のずれ (サンプル中の最大値)
    ///
    /// 通常は負の値。端末時計の誤差を含むため、そのまま現在時刻から引いては
    /// いけない。公開遅延は TimeSampleCalculator で求める。
    required Duration shift,

    /// `latest.json` 取得の往復時間 (中央値)
    required Duration roundTripTime,

    /// どのデータソースに対して測った値か
    required KyoshinMonitorSource source,

    /// 測定に使ったサンプル数
    required int sampleCount,
    required DateTime? lastSyncedAt,

    /// 起動直後の連続測定が終わり、見積もりが確定した時刻 (端末時計)。
    ///
    /// 確定前は null。測り直しのたびに更新されるため、画像取得による
    /// 較正をやり直すきっかけとして使う。
    DateTime? settledAt,
  }) = _KyoshinMonitorTimerState;

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorTimerStateFromJson(json);
}

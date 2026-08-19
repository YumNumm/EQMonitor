import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_timer_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_offset_adjustment_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_timer_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/service/kyoshin_monitor_delay_adjust_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_offset_provider.g.dart';

/// 強震モニタ画像の取得に使う公開遅延。
///
/// `latest.json` の実測値 (`publishDelay`) に、404 フィードバックで学習した
/// 補正量を足したもの。測定がまだ無い場合は null。
///
/// NTP 補正の有無は `AppClock` と必ず揃える必要があるため、ここで
/// [Ntp] のオフセットを読んで [KyoshinMonitorTimerStateX.publishDelay] に渡す。
@riverpod
Duration? kyoshinMonitorEffectiveOffset(Ref ref) {
  final timerState = ref.watch(kyoshinMonitorTimerProvider).value;
  if (timerState == null) {
    return null;
  }
  final settings = ref.watch(kyoshinMonitorSettingsProvider).requireValue;

  // NTP が同期したら公開遅延を再計算する必要があるため watch する。
  ref.watch(ntpProvider);
  final ntpOffset = ref.read(ntpProvider.notifier).offset;
  final publishDelay = timerState.publishDelay(ntpOffset);

  final api = settings.api;
  switch (api.delayAdjustType) {
    case KyoshinMonitorDelayAdjustType.latestJson:
    case KyoshinMonitorDelayAdjustType.latestJsonMultiple:
      // 実測値をそのまま使う。
      return publishDelay;
    case KyoshinMonitorDelayAdjustType.imageFetch404DeviceTime:
    case KyoshinMonitorDelayAdjustType.imageFetch404Ntp:
      final adjustments = ref.watch(kyoshinMonitorOffsetAdjustmentProvider);
      return KyoshinMonitorDelayAdjuster.effectiveOffset(
        publishDelay: publishDelay,
        adjustment: api.autoOffsetIncrement
            ? adjustments[settings.delayProfile] ?? Duration.zero
            : Duration.zero,
        config: api.delayAdjustConfig,
      );
  }
}

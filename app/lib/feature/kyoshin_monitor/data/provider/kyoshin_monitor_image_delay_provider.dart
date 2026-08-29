import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_delay_resolver.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_image_request_resolver.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_time_sample_calculator.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_offset_adjustment_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_timer_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_request_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_image_delay_provider.g.dart';

/// 強震モニタ画像の取得に使う公開遅延。
@Riverpod(keepAlive: true)
Duration? kyoshinMonitorImageDelay(Ref ref) {
  final timerState = ref.watch(kyoshinMonitorTimerProvider).value;
  if (timerState == null) {
    return null;
  }
  final settings = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
  final request = ref.watch(kyoshinMonitorImageRequestProvider);

  ref.watch(ntpProvider);
  final ntpOffset = ref.read(ntpProvider).value?.offset ?? Duration.zero;
  final adjustments = ref.watch(kyoshinMonitorOffsetAdjustmentProvider);

  final publishDelay = ref
      .read(kyoshinMonitorTimeSampleCalculatorProvider)
      .publishDelay(shift: timerState.shift, ntpOffset: ntpOffset);
  final config = ref
      .read(kyoshinMonitorImageRequestResolverProvider)
      .delayAdjustConfig(settings.api);

  return switch (settings.api.delayAdjustType) {
    .latestJson || .latestJsonMultiple => publishDelay,
    .imageFetch404DeviceTime ||
    .imageFetch404Ntp => ref
        .read(kyoshinMonitorDelayResolverProvider)
        .imageDelay(
          publishDelay: publishDelay,
          adjustment: adjustments[request.delayProfile] ?? Duration.zero,
          config: config,
        ),
  };
}

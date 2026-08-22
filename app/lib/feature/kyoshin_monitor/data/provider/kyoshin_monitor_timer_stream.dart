import 'dart:async';
import 'dart:ui';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_delay_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_timer_stream.g.dart';

/// 強震モニタ画像の取得対象時刻を配信するストリーム。
@riverpod
Stream<DateTime> kyoshinMonitorTimerStream(Ref ref) {
  final controller = StreamController<DateTime>();

  ref.watch(appClockProvider);
  final appClock = ref.read(appClockProvider.notifier);

  final offset = ref.watch(kyoshinMonitorImageDelayProvider);

  // 取得頻度。1秒より長い場合は、その倍数の秒だけを対象にする。
  final fetchFrequency = ref.watch(
    kyoshinMonitorSettingsProvider.select(
      (v) => v.requireValue.api.imageFetchInterval.inSeconds,
    ),
  );

  Timer? timer;
  ref.onDispose(() => timer?.cancel());
  ref.onDispose(controller.close);

  if (offset == null) {
    // まだサーバ時刻を測れていない。測定できたら再構築される。
    return controller.stream;
  }

  final wholeSeconds = Duration(seconds: offset.inSeconds);
  final phase = offset - wholeSeconds;

  bool isBackground() => const [
    AppLifecycleState.paused,
    AppLifecycleState.detached,
    AppLifecycleState.inactive,
  ].contains(ref.read(appLifecycleProvider));

  void emit() {
    if (controller.isClosed) {
      return;
    }
    // 発火時点では `appClock.now()` が「秒境界 + phase」を指しているため、
    // 公開遅延を引くと端数が打ち消し合って秒境界に揃う。
    // ゆらぎを吸収するため秒未満を切り捨てる。
    final target = appClock.now().subtract(offset).truncateToSecond();
    if (fetchFrequency > 1 &&
        (target.millisecondsSinceEpoch ~/ 1000) % fetchFrequency != 0) {
      return;
    }
    controller.add(target);
  }

  void schedule() {
    if (controller.isClosed) {
      return;
    }
    final offset = ref.read(ntpProvider).value?.offset ?? Duration.zero;
    final now = appClock.now().subtract(offset);
    var fireAt = now.truncateToSecond().add(phase);
    while (!fireAt.isAfter(now)) {
      fireAt = fireAt.add(const Duration(seconds: 1));
    }
    timer = Timer(fireAt.difference(now), () {
      if (!isBackground()) {
        emit();
      }
      schedule();
    });
  }

  // 初回は境界を待たずに1枚取りに行く。
  if (!isBackground()) {
    emit();
  }
  schedule();

  return controller.stream;
}

extension _TruncateToSecond on DateTime {
  /// 秒未満を切り捨てる。
  DateTime truncateToSecond() => subtract(
    Duration(milliseconds: millisecond, microseconds: microsecond),
  );
}

import 'dart:async';
import 'dart:ui';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_offset_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_timer_stream.g.dart';

/// 強震モニタ画像の取得対象時刻を配信するストリーム。
///
/// NTP 補正済みの秒境界に同期して発火する。`Timer.periodic(1s)` だと発火位相が
/// 購読開始のタイミングで固定されてしまい、100ms 刻みのオフセット調整が
/// 実質 1 秒粒度に丸められてしまうため、毎回次の境界へ張り直す方式にしている。
///
/// 公開遅延の整数秒部を取得対象時刻から引き、端数は発火位相の遅れとして使う
/// (KyoshinEewViewer と同じ扱い)。たとえば公開遅延 1100ms なら
/// 「秒境界 + 100ms に発火し、その 1 秒前の画像を取る」となる。
@riverpod
Stream<DateTime> kyoshinMonitorTimerStream(Ref ref) {
  final controller = StreamController<DateTime>();

  // 再生モード(通常/タイムシフト/リプレイ)が変化したら対象時刻を作り直す。
  ref.watch(appClockProvider);
  final appClock = ref.read(appClockProvider.notifier);

  // 公開遅延が変わったら位相も変わるため監視する。
  final offset = ref.watch(kyoshinMonitorEffectiveOffsetProvider);

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

  /// 位相合わせに使う実時間。
  ///
  /// タイムシフト/リプレイの再生位置に引きずられないよう、`AppClock` ではなく
  /// NTP 補正済みの現在時刻を直接使う。
  DateTime realtimeNow() => ref.read(ntpProvider.notifier).now() ?? clock.now();

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
    final now = realtimeNow();
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

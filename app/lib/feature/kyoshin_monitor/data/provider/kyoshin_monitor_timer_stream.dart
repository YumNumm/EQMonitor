import 'dart:async';
import 'dart:ui';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/periodic_timer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_timer_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_timer_stream.g.dart';

@riverpod
Stream<DateTime> kyoshinMonitorTimerStream(Ref ref) async* {
  final streamController = StreamController<DateTime>();

  // 再生モード(通常/タイムシフト)が変化したら即座に対象時刻を再取得するため監視する。
  ref.watch(appClockProvider);
  final clock = ref.read(appClockProvider.notifier);

  final interval = ref.watch(
    kyoshinMonitorSettingsProvider.select(
      (v) => v.requireValue.api.imageFetchInterval,
    ),
  );

  ref
    ..listen(kyoshinMonitorTimerProvider, (_, next) async {
      if (next case AsyncData(:final value)) {
        final lifecycle = ref.read(appLifecycleProvider);
        final isBackground = [
          AppLifecycleState.paused,
          AppLifecycleState.detached,
          AppLifecycleState.inactive,
        ].contains(lifecycle);

        if (isBackground) {
          return;
        }

        final delay = value.delayFromDevice;
        streamController.add(clock.now().subtract(delay));
      }
    })
    ..listen(periodicTimerProvider(interval), (_, next) async {
      if (next case AsyncData()) {
        final lifecycle = ref.read(appLifecycleProvider);
        final isBackground = [
          AppLifecycleState.paused,
          AppLifecycleState.detached,
          AppLifecycleState.inactive,
        ].contains(lifecycle);
        if (isBackground) {
          return;
        }
        final delay = ref
            .read(kyoshinMonitorTimerProvider)
            .value
            ?.delayFromDevice;
        if (delay != null) {
          streamController.add(clock.now().subtract(delay));
        }
      }
    });

  final kyoshinMonitorTimerNotifier = ref.read(
    kyoshinMonitorTimerProvider,
  );
  final delay = kyoshinMonitorTimerNotifier.value?.delayFromDevice;
  if (delay != null) {
    streamController.add(clock.now().subtract(delay));
  }
  ref.onDispose(streamController.close);

  yield* streamController.stream;
}

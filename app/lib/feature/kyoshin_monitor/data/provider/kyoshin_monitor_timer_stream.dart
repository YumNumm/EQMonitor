import 'dart:async';

import 'package:eqmonitor/core/provider/periodic_timer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_timer_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_timer_stream.g.dart';

@riverpod
Stream<DateTime> kyoshinMonitorTimerStream(Ref ref) async* {
  final streamController = StreamController<DateTime>();

  final interval = ref.watch(
    kyoshinMonitorSettingsProvider.select((v) => v.api.imageFetchInterval),
  );

  ref
    ..listen(kyoshinMonitorTimerProvider, (_, next) async {
      if (next case AsyncData(:final value)) {
        final delay = value.delayFromDevice;
        streamController.add(DateTime.now().subtract(delay));
      }
    })
    ..listen(periodicTimerProvider(interval), (_, next) async {
      if (next case AsyncData()) {
        final delay = ref
            .read(kyoshinMonitorTimerProvider)
            .value
            ?.delayFromDevice;
        if (delay != null) {
          streamController.add(DateTime.now().subtract(delay));
        }
      }
    });

  final kyoshinMonitorTimerNotifier = ref.read(
    kyoshinMonitorTimerProvider,
  );
  final delay = kyoshinMonitorTimerNotifier.value?.delayFromDevice;
  if (delay != null) {
    streamController.add(DateTime.now().subtract(delay));
  }
  ref.onDispose(streamController.close);

  yield* streamController.stream;
}

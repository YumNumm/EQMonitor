import 'dart:async';

import 'package:eqmonitor/core/provider/periodic_timer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_timer_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_timer_stream.g.dart';

@riverpod
Stream<DateTime> kyoshinMonitorTimerStream(Ref ref) async* {
  final streamController = StreamController<DateTime>();

  const key = 'kyoshinMonitorTimerStream';

  ref
    ..listen(kyoshinMonitorTimerProvider, (_, next) async {
      if (next case AsyncData(:final value)) {
        final delay = value.delayFromDevice;
        streamController.add(DateTime.now().subtract(delay));
      }
    })
    ..listen(periodicTimerProvider(key), (_, next) async {
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
  ref
      .read(periodicTimerProvider(key).notifier)
      .setInterval(
        ref.read(kyoshinMonitorSettingsProvider).api.imageFetchInterval,
      );
  ref.onDispose(streamController.close);

  yield* streamController.stream;
}

import 'package:eqmonitor/core/provider/environment/environment.dart';

import 'dart:async';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/repository/kyoshin_monitor_repository.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/native_shake_snapshot.dart';
import 'package:eqmonitor/feature/shake_detection/data/repository/native_shake_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'local_shake_detection_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<NativeShakeSnapshot?> localShakeDetection(Ref ref) async* {
  if (!NativeShakeRepository.enabled ||
      !ref.watch(buildConfigProvider).isShakeDetectionAvailable) {
    yield null;
    return;
  }
  final live = ref.watch(isRealtimeModeProvider);
  final lifecycle = ref.watch(appLifecycleProvider);
  final settings = ref.watch(kyoshinMonitorSettingsProvider).value;
  if (!live ||
      settings == null ||
      !settings.useKmoni ||
      lifecycle != AppLifecycleState.resumed) {
    yield null;
    return;
  }
  final catalog = await ref.watch(kyoshinObservationPointsProvider.future);
  if (!ref.mounted) return;
  final repository = await NativeShakeRepository.create(
    catalog: catalog,
    images: ref.read(kyoshinMonitorRepositoryProvider),
    now: ref.read(appClockProvider.notifier).now(),
  );
  if (!ref.mounted) {
    await repository.dispose();
    return;
  }
  ref.onDispose(repository.dispose);
  ref.listen(kyoshinMonitorProvider, (_, next) async {
    final value = next.value;
    if (value != null)
      await repository.image(
        value: value,
        source: settings.monitorSource,
        now: ref.read(appClockProvider.notifier).now(),
      );
  }, fireImmediately: true);
  ref.listen(eewAliveTelegramProvider, (_, next) async {
    await repository.eews(
      items: next ?? [],
      now: ref.read(appClockProvider.notifier).now(),
    );
  }, fireImmediately: true);
  ref.listen(timeTickerProvider(), (_, next) async {
    if (next.value case final now?) await repository.tick(now);
  });
  // Subscribe before initialization so the first completed image cannot be lost.
  final controller = StreamController<NativeShakeSnapshot?>();
  final subscription = repository.updates.stream.listen(
    controller.add,
    onError: controller.addError,
  );
  ref.onDispose(() {
    unawaited(subscription.cancel());
    unawaited(controller.close());
  });
  controller.add(const NativeShakeSnapshot.empty());
  unawaited(
    repository.loadModel(ref.read(appClockProvider.notifier).now()).catchError((
      error,
      stack,
    ) {
      if (ref.mounted) controller.addError(error, stack);
    }),
  );
  yield* controller.stream;
}

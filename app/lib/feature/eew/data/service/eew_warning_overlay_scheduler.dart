import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_overlay_scheduler.g.dart';

abstract interface class EewWarningOverlayScheduledTask {
  void cancel();
}

abstract interface class EewWarningOverlayScheduler {
  EewWarningOverlayScheduledTask schedule({
    required Duration delay,
    required Future<void> Function() callback,
  });
}

class TimerEewWarningOverlayScheduledTask
    implements EewWarningOverlayScheduledTask {
  const new({required Timer timer})
    : _timer = timer;

  final Timer _timer;

  @override
  void cancel() => _timer.cancel();
}

class TimerEewWarningOverlayScheduler implements EewWarningOverlayScheduler {
  const new();

  @override
  EewWarningOverlayScheduledTask schedule({
    required Duration delay,
    required Future<void> Function() callback,
  }) => TimerEewWarningOverlayScheduledTask(
    timer: Timer(delay, () async => callback()),
  );
}

@riverpod
EewWarningOverlayScheduler eewWarningOverlayScheduler(Ref ref) =>
    const TimerEewWarningOverlayScheduler();

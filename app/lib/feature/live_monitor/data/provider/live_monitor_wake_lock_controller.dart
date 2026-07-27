import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_session_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/service/live_monitor_wake_lock_platform.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_wake_lock_controller.g.dart';

@Riverpod(keepAlive: true)
class LiveMonitorWakeLockController extends _$LiveMonitorWakeLockController {
  bool? appliedEnabled;
  int desiredGeneration = 0;
  Future<void> transitionQueue = Future.value();

  @override
  Future<void> build() async {
    final sessionActive = ref.watch(liveMonitorSessionProvider);
    final lifecycle = ref.watch(appLifecycleProvider);
    final settings = await ref.watch(liveMonitorSettingsProvider.future);
    final desired =
        sessionActive &&
        settings.keepScreenAwake &&
        lifecycle == AppLifecycleState.resumed;
    desiredGeneration += 1;
    final generation = desiredGeneration;
    final transition = transitionQueue.then(
      (_) => applyDesired(enabled: desired, generation: generation),
    );
    transitionQueue = transition;
    await transition;
  }

  Future<void> applyDesired({
    required bool enabled,
    required int generation,
  }) async {
    if (generation != desiredGeneration || enabled == appliedEnabled) {
      return;
    }
    try {
      await ref
          .read(liveMonitorWakeLockPlatformProvider)
          .setEnabled(enabled: enabled);
      appliedEnabled = enabled;
    } on Exception catch (error, stackTrace) {
      talker.error(
        '[LiveMonitor] failed to update wake lock',
        error,
        stackTrace,
      );
    }
  }
}

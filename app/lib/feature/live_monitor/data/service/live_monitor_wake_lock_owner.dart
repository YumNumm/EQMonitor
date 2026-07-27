import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/live_monitor/data/service/live_monitor_wake_lock_platform.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_wake_lock_owner.g.dart';

final class LiveMonitorWakeLockOwner {
  LiveMonitorWakeLockOwner({required this.platform});

  final LiveMonitorWakeLockPlatform platform;
  bool? appliedEnabled;
  int desiredGeneration = 0;
  Future<void> transitionQueue = Future.value();
  Future<void>? disposeTransition;

  Future<void> get disposed => disposeTransition ?? transitionQueue;

  Future<void> setDesired({required bool enabled}) {
    if (disposeTransition != null) {
      return disposed;
    }
    desiredGeneration += 1;
    final generation = desiredGeneration;
    final transition = transitionQueue.then(
      (_) => applyDesired(enabled: enabled, generation: generation),
    );
    transitionQueue = transition;
    return transition;
  }

  Future<void> dispose() {
    final existingTransition = disposeTransition;
    if (existingTransition != null) {
      return existingTransition;
    }
    desiredGeneration += 1;
    final generation = desiredGeneration;
    final transition = transitionQueue.then(
      (_) => applyDesired(enabled: false, generation: generation, force: true),
    );
    transitionQueue = transition;
    disposeTransition = transition;
    return transition;
  }

  Future<void> applyDesired({
    required bool enabled,
    required int generation,
    bool force = false,
  }) async {
    if (generation != desiredGeneration ||
        (force == false && enabled == appliedEnabled)) {
      return;
    }
    try {
      await platform.setEnabled(enabled: enabled);
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

@Riverpod(keepAlive: true)
LiveMonitorWakeLockOwner liveMonitorWakeLockOwner(Ref ref) {
  final owner = LiveMonitorWakeLockOwner(
    platform: ref.watch(liveMonitorWakeLockPlatformProvider),
  );
  ref.onDispose(owner.dispose);
  return owner;
}

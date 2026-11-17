import 'package:eqmonitor/core/provider/log/talker.dart';

class ScreenWakeLockOwner({
  required final Future<void> Function({required bool enabled}) setEnabled,
}) {
  bool? appliedEnabled;
  int desiredGeneration = 0;
  Future<void> transitionQueue = Future.value();
  Future<void>? disposeTransition;

  Future<void> get disposed => disposeTransition ?? transitionQueue;

  Future<void> setDesired({
    required bool enabled,
    bool force = false,
  }) {
    if (disposeTransition != null) {
      return disposed;
    }
    desiredGeneration += 1;
    final generation = desiredGeneration;
    final transition = transitionQueue.then(
      (_) =>
          applyDesired(enabled: enabled, generation: generation, force: force),
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
      await setEnabled(enabled: enabled);
      appliedEnabled = enabled;
    } on Exception catch (error, stackTrace) {
      talker.error(
        '[ScreenWakeLock] failed to update wake lock',
        error,
        stackTrace,
      );
    }
  }
}

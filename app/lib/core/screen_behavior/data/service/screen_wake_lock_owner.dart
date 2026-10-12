import 'package:eqmonitor/core/provider/log/talker.dart';

class ScreenWakeLockOwner {
  new({required this.setEnabled});

  final Future<void> Function({required bool enabled}) setEnabled;
  bool applicationDesired = false;
  bool sessionDesired = false;
  bool? appliedEnabled;
  int desiredGeneration = 0;
  Future<void> transitionQueue = Future.value();
  Future<void>? disposeTransition;

  Future<void> get disposed => disposeTransition ?? transitionQueue;

  Future<void> setDesired({required bool enabled}) {
    sessionDesired = enabled;
    return enqueueDesired();
  }

  Future<void> setApplicationDesired({
    required bool enabled,
    bool force = false,
  }) {
    applicationDesired = enabled;
    return enqueueDesired(force: force);
  }

  Future<void> enqueueDesired({bool force = false}) {
    final enabled = applicationDesired || sessionDesired;
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
        '[LiveMonitor] failed to update wake lock',
        error,
        stackTrace,
      );
    }
  }
}

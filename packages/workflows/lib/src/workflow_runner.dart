import 'dart:async';

import 'package:workflows/src/workflow_persistence.dart';
import 'package:workflows/src/workflow_step.dart';

/// Runs a workflow function with durable step execution.
///
/// Pass an `instanceId` that is stable across app restarts for the same
/// logical workflow execution. If the app dies mid-run, calling [run] again
/// with the same `instanceId` resumes from the last completed step.
final class WorkflowRunner {
  new({required WorkflowPersistence persistence})
    : _persistence = persistence;

  final WorkflowPersistence _persistence;

  /// Executes [workflow] with a [WorkflowStep] bound to [instanceId].
  ///
  /// [workflow] receives the step executor and can call it multiple times with
  /// different names. Already-completed steps are skipped automatically.
  Future<T> run<T>({
    required String instanceId,
    required FutureOr<T> Function(WorkflowStep step) workflow,
  }) {
    final step = WorkflowStep(
      instanceId: instanceId,
      persistence: _persistence,
    );
    return Future.value(workflow(step));
  }

  /// Clears all persisted state for [instanceId].
  /// Call this after the workflow has fully completed and cleanup is desired.
  Future<void> clear(String instanceId) =>
      _persistence.clearInstance(instanceId);
}

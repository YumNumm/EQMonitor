import 'dart:async';

import 'workflow_persistence.dart';

/// Provides durable step execution. Modelled on Cloudflare Workers Workflows
/// `WorkflowStep`, but runs on the client (no Cloudflare dependency).
///
/// Call [call] with a unique [name] and a callback that returns a
/// JSON-encodable value. The callback is executed at most once per instance:
/// subsequent calls with the same name return the cached result.
final class WorkflowStep {
  WorkflowStep({
    required String instanceId,
    required WorkflowPersistence persistence,
  })  : _instanceId = instanceId,
        _persistence = persistence;

  final String _instanceId;
  final WorkflowPersistence _persistence;

  /// Executes [callback] exactly once for this [name] and instance.
  ///
  /// If the step already completed its stored result is returned without
  /// re-running [callback]. [T] must be JSON-encodable.
  Future<T> call<T>(String name, FutureOr<T> Function() callback) async {
    final (:completed, :value) =
        await _persistence.getStepResult(_instanceId, name);
    if (completed) return value as T;

    final result = await callback();
    await _persistence.saveStepResult(_instanceId, name, result);
    return result;
  }
}

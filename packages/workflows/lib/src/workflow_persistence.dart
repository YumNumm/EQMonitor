import 'dart:convert';

/// Stores completed step results keyed by `instanceId` + step name.
///
/// Results are wrapped as `{"v": <result>}` so that null results can be
/// distinguished from "step not yet run" (absent key).
abstract interface class WorkflowPersistence {
  /// Returns the raw JSON string `{"v": ...}` if the step completed, or null.
  Future<String?> getRaw(String instanceId, String stepName);

  /// Persists `result` wrapped as `{"v": result}`.
  Future<void> saveRaw(String instanceId, String stepName, String raw);

  /// Removes all persisted state for `instanceId`.
  Future<void> clearInstance(String instanceId);
}

extension WorkflowPersistenceX on WorkflowPersistence {
  Future<({bool completed, Object? value})> getStepResult(
    String instanceId,
    String stepName,
  ) async {
    final raw = await getRaw(instanceId, stepName);
    if (raw == null) {
      return (completed: false, value: null);
    }
    final map = jsonDecode(raw) as Map<String, Object?>;
    return (completed: true, value: map['v']);
  }

  Future<void> saveStepResult(
    String instanceId,
    String stepName,
    Object? result,
  ) async {
    await saveRaw(instanceId, stepName, jsonEncode({'v': result}));
  }
}

/// In-memory implementation. Useful for testing.
final class InMemoryWorkflowPersistence implements WorkflowPersistence {
  final _store = <String, String>{};

  String _key(String instanceId, String stepName) => '$instanceId\x00$stepName';

  @override
  Future<String?> getRaw(String instanceId, String stepName) async =>
      _store[_key(instanceId, stepName)];

  @override
  Future<void> saveRaw(
    String instanceId,
    String stepName,
    String raw,
  ) async {
    _store[_key(instanceId, stepName)] = raw;
  }

  @override
  Future<void> clearInstance(String instanceId) async {
    _store.removeWhere((k, _) => k.startsWith('$instanceId\x00'));
  }
}

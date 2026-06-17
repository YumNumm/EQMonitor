import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:workflows/workflows.dart';

/// [WorkflowPersistence] backed by [SharedPreferencesAsync].
///
/// Step results are stored as `_wf:<instanceId>:<stepName>`.
/// A manifest key `_wf:__m__:<instanceId>` tracks which step names exist so
/// [clearInstance] can clean them up without a key-range scan.
final class SharedPreferencesWorkflowPersistence
    implements WorkflowPersistence {
  SharedPreferencesWorkflowPersistence(this._prefs);

  final SharedPreferencesAsync _prefs;

  static const _prefix = '_wf:';
  static const _manifestPrefix = '_wf:__m__:';

  String _key(String instanceId, String stepName) =>
      '$_prefix$instanceId:$stepName';

  @override
  Future<String?> getRaw(String instanceId, String stepName) async =>
      _prefs.getString(_key(instanceId, stepName));

  @override
  Future<void> saveRaw(String instanceId, String stepName, String raw) async {
    await _prefs.setString(_key(instanceId, stepName), raw);

    final manifestKey = '$_manifestPrefix$instanceId';
    final existing = _prefs.getString(manifestKey) ?? '';
    final steps = existing.split('\x00').where((s) => s.isNotEmpty).toSet()
      ..add(stepName);
    await _prefs.setString(manifestKey, steps.join('\x00'));
  }

  @override
  Future<void> clearInstance(String instanceId) async {
    final manifestKey = '$_manifestPrefix$instanceId';
    final manifest = _prefs.getString(manifestKey) ?? '';
    for (final stepName in manifest.split('\x00').where((s) => s.isNotEmpty)) {
      await _prefs.remove(_key(instanceId, stepName));
    }
    await _prefs.remove(manifestKey);
  }
}

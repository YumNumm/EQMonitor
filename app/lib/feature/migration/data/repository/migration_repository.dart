import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/migration/data/persistence/shared_preferences_workflow_persistence.dart';
import 'package:eqmonitor/feature/migration/data/workflow/v3_migration_workflow.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workflows/workflows.dart';

part 'migration_repository.g.dart';

@Riverpod(keepAlive: true)
MigrationRepository migrationRepository(Ref ref) =>
    MigrationRepository(ref.watch(sharedPreferencesProvider));

class MigrationRepository {
  MigrationRepository(this._prefs)
    : persistence = SharedPreferencesWorkflowPersistence(_prefs);

  final SharedPreferencesAsync _prefs;
  final SharedPreferencesWorkflowPersistence persistence;

  /// Returns the device ID written by v2.6, or null if absent / already cleared.
  String? readLegacyDeviceId() =>
      _prefs.getString(SharedPreferencesKey.legacyDeviceId.key);

  /// Returns true if the v3 migration workflow fully completed.
  Future<bool> isMigrationComplete() => isV3MigrationComplete(persistence);

  WorkflowRunner buildRunner() => WorkflowRunner(persistence: persistence);
}

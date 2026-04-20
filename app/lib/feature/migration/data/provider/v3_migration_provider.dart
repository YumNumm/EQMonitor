import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/migration/data/repository/migration_repository.dart';
import 'package:eqmonitor/feature/migration/data/workflow/v3_migration_workflow.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'v3_migration_provider.g.dart';

/// Migration states for the v2.6 → v3 flow.
enum V3MigrationState {
  /// Migration already completed in a previous run.
  alreadyDone,

  /// No legacy device ID found — user is new or already on v3.
  /// Caller should navigate to onboarding.
  noLegacyId,

  /// Migration completed successfully in this run.
  completed,

  /// Migration failed. Details are logged; caller may retry or show an error.
  failed,
}

/// Runs the v2.6 → v3 device migration once per app lifecycle.
///
/// - If migration was already completed (persisted), resolves immediately.
/// - If `old_device_key` is absent from legacy storage, resolves with
///   [V3MigrationState.noLegacyId] so the caller can start onboarding.
/// - Otherwise runs the durable workflow (GET → PUT → POST migrate).
@Riverpod(keepAlive: true)
Future<V3MigrationState> v3Migration(Ref ref) async {
  final migrationRepo = ref.watch(migrationRepositoryProvider);
  final deviceRepo = await ref.watch(deviceRepositoryProvider.future);
  final deviceId = await ref.watch(deviceIdProvider.future);

  if (await migrationRepo.isMigrationComplete()) {
    return V3MigrationState.alreadyDone;
  }

  final oldDeviceId = migrationRepo.readLegacyDeviceId();
  if (oldDeviceId == null || oldDeviceId.isEmpty) {
    return V3MigrationState.noLegacyId;
  }

  try {
    await runV3MigrationWorkflow(
      runner: migrationRepo.buildRunner(),
      repository: deviceRepo,
      deviceId: deviceId,
      oldDeviceId: oldDeviceId,
    );
    return V3MigrationState.completed;
  } on Exception {
    return V3MigrationState.failed;
  }
}

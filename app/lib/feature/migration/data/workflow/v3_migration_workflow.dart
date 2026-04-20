import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:workflows/workflows.dart';

/// Instance ID used to key the durable migration workflow.
const kV3MigrationInstanceId = 'v3-device-migration-v1';

/// Key under which the local "migration complete" flag is stored in
/// a [WorkflowPersistence] instance (used as a step result).
const _kMarkComplete = 'markLocalComplete';

/// Runs the v2.6 → v3 device migration as a durable workflow.
///
/// Steps:
/// 1. `ensureDeviceAbsent`  — GET /v2/device/{id}; records whether device
///    already existed.
/// 2. `registerDevice`      — PUT only when absent.
/// 3. `migrateLegacySettings` — POST /migrate with [oldDeviceId].
/// 4. `markLocalComplete`   — writes true to persistence.
///
/// Caller must ensure [oldDeviceId] was successfully retrieved from legacy
/// storage before calling this function. When legacy ID is unavailable, skip
/// this workflow entirely and navigate to onboarding instead.
Future<void> runV3MigrationWorkflow({
  required WorkflowRunner runner,
  required DeviceRepository repository,
  required String deviceId,
  required String oldDeviceId,
}) async {
  await runner.run(
    instanceId: kV3MigrationInstanceId,
    workflow: (step) async {
      // Step 1 — check whether device already exists
      final alreadyRegistered = await step<bool>(
        'ensureDeviceAbsent',
        () async {
          final result = await repository.getDevice(deviceId);
          return switch (result) {
            Success() => true,
            Failure(:final exception) when _isNotFound(exception) => false,
            Failure(:final exception, :final stackTrace) =>
              Error.throwWithStackTrace(exception, stackTrace ?? StackTrace.empty),
          };
        },
      );

      // Step 2 — register only when absent
      if (!alreadyRegistered) {
        await step<void>(
          'registerDevice',
          () async {
            final result = await repository.registerDevice(deviceId);
            switch (result) {
              case Success():
                break;
              case Failure(:final exception, :final stackTrace):
                Error.throwWithStackTrace(
                  exception,
                  stackTrace ?? StackTrace.empty,
                );
            }
          },
        );
      }

      // Step 3 — migrate legacy settings
      await step<void>(
        'migrateLegacySettings',
        () async {
          final result = await repository.migrateFromLegacy(
            deviceId: deviceId,
            oldDeviceId: oldDeviceId,
          );
          switch (result) {
            case Success():
              break;
            case Failure(:final exception, :final stackTrace):
              Error.throwWithStackTrace(
                exception,
                stackTrace ?? StackTrace.empty,
              );
          }
        },
      );

      // Step 4 — persist completion flag
      await step<bool>(_kMarkComplete, () => true);
    },
  );
}

/// Returns true when the migration workflow completed in a previous run.
Future<bool> isV3MigrationComplete(WorkflowPersistence persistence) async {
  final (:completed, value: _) = await persistence.getStepResult(
    kV3MigrationInstanceId,
    _kMarkComplete,
  );
  return completed;
}

bool _isNotFound(Exception e) =>
    e is DioException && e.response?.statusCode == 404;

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:workflows/workflows.dart';

/// v1 は 404/409 でも完了を保存していたため、その記録を再利用しない。
const kV3MigrationInstanceId = 'v3-device-migration-v2';

class const DeviceMigrationWorkflow() {
  /// 登録済みの移行先ごとに成功 step を保存し、中断後に再開する。
  /// 通信断でサーバーの成功応答を受け取れなかった場合の409は未確認とする。
  Future<void> run({
    required WorkflowRunner runner,
    required DeviceRepository repository,
    required String oldDeviceId,
    required String deviceId,
  }) async {
    await runner.run(
      instanceId: '$kV3MigrationInstanceId:$oldDeviceId:$deviceId',
      workflow: (step) async {
        await step<void>('migrateLegacySettings', () async {
          final result = await repository.migrateFromLegacy(
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
        });
        await step<bool>('markLocalComplete', () => true);
      },
    );
  }

  Future<bool> isComplete({
    required WorkflowPersistence persistence,
    required String oldDeviceId,
    required String deviceId,
  }) async {
    final (:completed, value: _) = await persistence.getStepResult(
      '$kV3MigrationInstanceId:$oldDeviceId:$deviceId',
      'markLocalComplete',
    );
    return completed;
  }
}

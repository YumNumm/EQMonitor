import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/exception/dio_exception_mapper.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/devices/data/retry/retry_controller.dart';
import 'package:eqmonitor/feature/devices/data/workflow/device_migration_workflow.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_provisioning_notifier.g.dart';

enum DeviceProvisioningStatus { required, notRequired }

@riverpod
bool deviceMigratedFromLegacy(Ref ref) {
  final repo = ref.watch(deviceProvisioningRepositoryProvider);
  return repo.wasMigratedFromLegacy();
}

@Riverpod(keepAlive: true)
class DeviceProvisioningNotifier extends _$DeviceProvisioningNotifier {

  late final _retryController = RetryController();
  RetryControllerState get retryState => _retryController.state;

  void reset() => _retryController.reset();

  @override
  Future<DeviceProvisioningStatus> build() async {
    final repo = ref.watch(deviceProvisioningRepositoryProvider);
    if (!repo.isProvisioned()) {
      return DeviceProvisioningStatus.required;
    }
    final authRepo = await ref.watch(deviceAuthRepositoryProvider.future);
    final token = await authRepo.readToken();
    if (token == null || token.isEmpty) {
      await repo.clearProvisioned();
      return DeviceProvisioningStatus.required;
    }
    return DeviceProvisioningStatus.notRequired;
  }


  static final provisionMutation = Mutation<void>();
  Future<void> provision() async {
    final repo = ref.read(deviceProvisioningRepositoryProvider);
    final deviceRepo = await ref.read(deviceRepositoryProvider.future);
    final deviceId = await ref.read(deviceIdProvider.future);

    await _retryController.run(() async {
      try {
        final legacy = repo.readLegacyDeviceId();
        if (legacy != null && legacy.isNotEmpty) {
          talker.info(
            '[Provisioning] legacy device detected; '
            'running v2→v3 migration workflow',
          );
          await runV3MigrationWorkflow(
            runner: repo.buildRunner(),
            repository: deviceRepo,
            deviceId: deviceId,
            oldDeviceId: legacy,
          );
          await repo.markMigratedFromLegacy();
          talker.info('[Provisioning] v2→v3 migration workflow completed');
        } else {
          final result = await deviceRepo.registerDevice(
            deviceId: deviceId,
            devicePlatform: kIsWeb
                ? .ios
                : Platform.isIOS
                ? .ios
                : .android,
            deviceLocale: .ja,
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
        }
        await repo.markProvisioned();
      } on DeviceProvisioningException catch (e, st) {
        talker.error('[Provisioning] failed', e, st);
        rethrow;
      } on DioException catch (e, st) {
        final mapped = mapDioToProvisioningException(e, st);
        talker.error('[Provisioning] failed', mapped, st);
        throw mapped;
      } catch (e, st) {
        talker.error('[Provisioning] unexpected failure', e, st);
        throw UnexpectedProvisioningException(cause: e, stackTrace: st);
      }
    });

    state = const AsyncData(DeviceProvisioningStatus.notRequired);

    try {
      await ref.read(pushTokenSyncProvider.notifier).sync();
    } on Object catch (_) {}
  }
}

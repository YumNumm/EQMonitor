import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_config_notifier.g.dart';

@Riverpod(keepAlive: true)
class EewWarningConfigNotifier extends _$EewWarningConfigNotifier {
  @override
  Future<EewWarningSettings> build() async {
    final status = await ref.watch(deviceProvisioningProvider.future);
    if (status != .notRequired) {
      throw StateError('Device not provisioned');
    }
    final repo = await ref.watch(notificationSlotRepositoryProvider.future);
    return repo.getEewWarningConfig();
  }

  static final updateConfigMutation = Mutation<void>();

  Future<void> updateConfig({
    EewWarningTarget? target,
    InterruptionLevel? nationwideInterruptionLevel,
  }) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    final result = await repo.patchEewWarningConfig(
      target: target,
      nationwideInterruptionLevel: nationwideInterruptionLevel,
    );
    state = AsyncData(result);
  }

  void synchronizeWithGlobalToggle() {
    state = const AsyncData(
      EewWarningSettings(
        target: EewWarningTarget.currentLocationOnly,
        nationwideInterruptionLevel: null,
      ),
    );
  }
}

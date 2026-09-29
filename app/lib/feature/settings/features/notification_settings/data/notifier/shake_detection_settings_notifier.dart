import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_consumers_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/shake_detection_settings_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'shake_detection_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetectionSettingsNotifier extends _$ShakeDetectionSettingsNotifier {
  @override
  Future<ShakeDetectionState> build() async {
    if (!ref.watch(buildConfigProvider).isShakeDetectionAvailable) {
      const disabled = (
        entries: <ShakeDetectionEntry>[],
        requiresReconfiguration: false,
      );
      await ref
          .read(deviceLocationConsumersRepositoryProvider)
          .updateShake(disabled);
      try {
        final status = await ref.watch(deviceProvisioningProvider.future);
        if (status == DeviceProvisioningStatus.notRequired) {
          final repository = await ref.watch(
            shakeDetectionSettingsRepositoryProvider.future,
          );
          await repository.disableNotifications();
        }
      } on Exception catch (error, stackTrace) {
        talker.error(
          'Failed to disable shake notifications',
          error,
          stackTrace,
        );
      }
      return disabled;
    }
    final status = await ref.watch(deviceProvisioningProvider.future);
    if (status != DeviceProvisioningStatus.notRequired)
      throw StateError('Device not provisioned');
    final repository = await ref.watch(
      shakeDetectionSettingsRepositoryProvider.future,
    );
    final result = await repository.load();
    await ref
        .read(deviceLocationConsumersRepositoryProvider)
        .updateShake(result);
    return result;
  }

  static final saveMutation = Mutation<void>();
  Future<void> save(List<ShakeDetectionEntry> entries) async {
    if (!ref.read(buildConfigProvider).isShakeDetectionAvailable) {
      return;
    }
    final repository = await ref.read(
      shakeDetectionSettingsRepositoryProvider.future,
    );
    final result = await repository.save(entries);
    state = AsyncData(result);
    await ref
        .read(deviceLocationConsumersRepositoryProvider)
        .updateShake(result);
  }
}

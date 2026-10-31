import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_consumers_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_availability_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/shake_detection_settings_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'shake_detection_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetectionSettingsNotifier extends _$ShakeDetectionSettingsNotifier {
  @override
  Future<ShakeDetectionState> build() async {
    final operationRef = ref;
    final isAvailable = await operationRef.watch(
      isShakeDetectionNotificationAvailableProvider.future,
    );
    if (!operationRef.mounted)
      throw StateError('Shake notification settings disposed');
    if (!isAvailable) {
      const disabled = (
        entries: <ShakeDetectionEntry>[],
        requiresReconfiguration: false,
      );
      await operationRef
          .read(deviceLocationConsumersRepositoryProvider)
          .updateShake(disabled);
      try {
        final status = await operationRef.watch(
          deviceProvisioningProvider.future,
        );
        if (status == DeviceProvisioningStatus.notRequired) {
          final repository = await operationRef.watch(
            shakeDetectionSettingsRepositoryProvider.future,
          );
          if (!operationRef.mounted) return disabled;
          await repository.disableNotifications(
            isCurrent: () => operationRef.mounted,
          );
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
    final status = await operationRef.watch(deviceProvisioningProvider.future);
    if (status != DeviceProvisioningStatus.notRequired)
      throw StateError('Device not provisioned');
    final repository = await operationRef.watch(
      shakeDetectionSettingsRepositoryProvider.future,
    );
    if (!operationRef.mounted)
      throw StateError('Shake notification settings disposed');
    final result = await repository.load();
    if (!operationRef.mounted)
      throw StateError('Shake notification settings disposed');
    await operationRef
        .read(deviceLocationConsumersRepositoryProvider)
        .updateShake(result);
    return result;
  }

  static final saveMutation = Mutation<void>();
  Future<void> save(List<ShakeDetectionEntry> entries) async {
    final operationRef = ref;
    if (!await operationRef.read(
      isShakeDetectionNotificationAvailableProvider.future,
    )) {
      throw StateError('Shake notification settings are unavailable');
    }
    if (!operationRef.mounted)
      throw StateError('Shake notification settings disposed');
    final repository = await operationRef.read(
      shakeDetectionSettingsRepositoryProvider.future,
    );
    if (!operationRef.mounted)
      throw StateError('Shake notification settings disposed');
    final result = await repository.save(
      entries,
      isCurrent: () => operationRef.mounted,
    );
    if (!operationRef.mounted) return;
    state = AsyncData(result);
    await operationRef
        .read(deviceLocationConsumersRepositoryProvider)
        .updateShake(result);
  }
}

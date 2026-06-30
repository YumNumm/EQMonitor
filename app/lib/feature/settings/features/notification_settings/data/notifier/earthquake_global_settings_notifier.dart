import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_global_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class EarthquakeGlobalSettingsNotifier
    extends _$EarthquakeGlobalSettingsNotifier {
  static final updateSettingsMutation = Mutation<void>();

  @override
  Future<EarthquakeGlobalSettings> build() async {
    final status = await ref.watch(deviceProvisioningProvider.future);
    if (status != DeviceProvisioningStatus.notRequired) {
      throw StateError('Device not provisioned');
    }
    final repo = await ref.watch(notificationSlotRepositoryProvider.future);
    return repo.getEarthquakeGlobalSettings();
  }

  Future<void> updateSettings({
    bool? enabled,
    String? defaultSound,
    InterruptionLevel? defaultInterruptionLevel,
    bool? estimatedIntensityEnabled,
    bool? collapseNotification,
  }) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    final result = await repo.patchEarthquakeGlobalSettings(
      enabled: enabled,
      defaultSound: defaultSound,
      defaultInterruptionLevel: defaultInterruptionLevel,
      estimatedIntensityEnabled: estimatedIntensityEnabled,
      collapseNotification: collapseNotification,
    );
    state = AsyncData(result);
  }
}

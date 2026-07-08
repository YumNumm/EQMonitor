import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'general_notification_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class GeneralNotificationSettingsNotifier
    extends _$GeneralNotificationSettingsNotifier {
  static final updateSettingsMutation = Mutation<void>();

  @override
  Future<GeneralNotificationSettings> build() async {
    final status = await ref.watch(deviceProvisioningProvider.future);
    if (status != DeviceProvisioningStatus.notRequired) {
      throw StateError('Device not provisioned');
    }
    final repo = await ref.watch(pushNotificationRepositoryProvider.future);
    final deviceId = await ref.read(deviceIdProvider.future);
    final result = await repo.getNotificationSettings(deviceId);
    return switch (result) {
      Success(:final value) => value,
      Failure(:final exception) => throw exception,
    };
  }

  Future<void> updateSettings({
    bool? notificationEnabled,
    bool? tsunamiEnabled,
    bool? trainingEnabled,
    bool? nankaiExtraordinaryEnabled,
    bool? nankaiRegularEnabled,
    bool? hokkaido3renOffshoreEnabled,
  }) async {
    final current = await future;
    final repo = await ref.read(pushNotificationRepositoryProvider.future);
    final deviceId = await ref.read(deviceIdProvider.future);
    final result = await repo.patchNotificationSettings(
      deviceId: deviceId,
      settings: current.copyWith(
        notificationEnabled:
            notificationEnabled ?? current.notificationEnabled,
        tsunamiEnabled: tsunamiEnabled ?? current.tsunamiEnabled,
        trainingEnabled: trainingEnabled ?? current.trainingEnabled,
        nankaiExtraordinaryEnabled:
            nankaiExtraordinaryEnabled ?? current.nankaiExtraordinaryEnabled,
        nankaiRegularEnabled:
            nankaiRegularEnabled ?? current.nankaiRegularEnabled,
        hokkaido3renOffshoreEnabled:
            hokkaido3renOffshoreEnabled ?? current.hokkaido3renOffshoreEnabled,
      ),
    );
    state = AsyncData(
      switch (result) {
        Success(:final value) => value,
        Failure(:final exception) => throw exception,
      },
    );
  }
}

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_consumers_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_availability_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/shake_detection_disable_confirmation_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/shake_detection_settings_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'shake_detection_settings_notifier.g.dart';

/// 揺れ検知の通知条件。
///
/// 起動時には構築しない。設定値が必要になった画面が watch したときに
/// サーバーから取得する。位置情報監視の起動時の判定は、端末に保存した
/// 最後の値（`DeviceLocationConsumersRepository`）で行う。
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
        final confirmation = operationRef.read(
          shakeDetectionDisableConfirmationRepositoryProvider,
        );
        // サーバー側の無効化は、確認できるまで起動のたびに試みる。
        // 確認済みなら問い合わせない。
        if (status == DeviceProvisioningStatus.notRequired &&
            !await confirmation.isConfirmed()) {
          final repository = await operationRef.watch(
            shakeDetectionSettingsRepositoryProvider.future,
          );
          if (!operationRef.mounted) return disabled;
          final isDisabled = await repository.disableNotifications(
            isCurrent: () => operationRef.mounted,
          );
          if (isDisabled && operationRef.mounted) {
            await confirmation.markConfirmed();
          }
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
    if (result.entries.any((entry) => entry.enabled)) {
      await operationRef
          .read(shakeDetectionDisableConfirmationRepositoryProvider)
          .clear();
    }
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
    // 保存が途中で失敗しても、サーバー側に有効な条件が残り得る。
    await operationRef
        .read(shakeDetectionDisableConfirmationRepositoryProvider)
        .clear();
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

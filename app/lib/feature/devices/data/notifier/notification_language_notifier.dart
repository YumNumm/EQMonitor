import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_language_notifier.g.dart';

@riverpod
class NotificationLanguageNotifier extends _$NotificationLanguageNotifier {
  @override
  Future<DeviceLocale> build() async {
    final status = await ref.watch(deviceProvisioningProvider.future);
    if (status != DeviceProvisioningStatus.notRequired) {
      throw StateError('Device not provisioned');
    }
    await ref.watch(deviceIdProvider.future);
    final repository = await ref.watch(deviceRepositoryProvider.future);
    final result = await repository.getDevice();
    return switch (result) {
      Success(:final value) => value.locale,
      Failure(:final exception) => throw exception,
    };
  }

  static final updateLocaleMutation = Mutation<void>();

  Future<void> updateLocale({required DeviceLocale locale}) async {
    final current = await future;
    if (current == locale) return;
    final repository = await ref.read(deviceRepositoryProvider.future);
    final result = await repository.updateLocale(locale: locale);
    if (!ref.mounted) return;
    switch (result) {
      case Success(:final value):
        state = AsyncData(value.locale);
      case Failure(:final exception):
        ref.invalidateSelf();
        throw exception;
    }
  }
}

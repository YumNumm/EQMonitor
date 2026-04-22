import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'general_notification_settings_notifier.g.dart';

@riverpod
class GeneralNotificationSettingsNotifier
    extends _$GeneralNotificationSettingsNotifier {
  static final saveMutation = Mutation<void>();

  @override
  Future<GeneralNotificationSettings> build() async {
    final deviceId = await ref.watch(deviceIdProvider.future);
    final repo = await ref.watch(pushNotificationRepositoryProvider.future);
    final result = await repo.getNotificationSettings(deviceId);
    return switch (result) {
      Success(:final value) => value,
      Failure(:final exception) => throw exception,
    };
  }

  Future<void> save({
    required bool tsunamiEnabled,
    required bool trainingEnabled,
  }) async {
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(pushNotificationRepositoryProvider.future);
    final result = await repo.patchNotificationSettings(
      deviceId: deviceId,
      settings: GeneralNotificationSettings(
        tsunamiEnabled: tsunamiEnabled,
        trainingEnabled: trainingEnabled,
      ),
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData(value);
      case Failure(:final exception):
        throw exception;
    }
  }
}

import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/custom_notification_sound.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_failure.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_inspection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/prepared_notification_sound.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/notification_sound_platform.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_sound_operation_coordinator.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_sound_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_sound_usage_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_notification_sounds_notifier.g.dart';

@Riverpod(keepAlive: true)
class CustomNotificationSoundsNotifier
    extends _$CustomNotificationSoundsNotifier {
  @override
  Future<List<CustomNotificationSound>> build() async {
    if (!ref.watch(customNotificationSoundsSupportedProvider)) return const [];
    return ref.watch(notificationSoundRepositoryProvider).list();
  }

  static final pickMutation = Mutation<NotificationSoundInspection?>();
  Future<NotificationSoundInspection?> pickAndInspect() =>
      ref.read(notificationSoundRepositoryProvider).pickAndInspect();

  static final prepareMutation = Mutation<PreparedNotificationSound>();
  Future<PreparedNotificationSound> prepare({
    required bool trimToMaxDuration,
  }) => ref
      .read(notificationSoundRepositoryProvider)
      .prepare(trimToMaxDuration: trimToMaxDuration);

  static final commitMutation = Mutation<CustomNotificationSound>();
  Future<CustomNotificationSound> commit({
    required String preparedId,
    required String displayName,
  }) async {
    final sound = await ref
        .read(notificationSoundRepositoryProvider)
        .commit(preparedId: preparedId, displayName: displayName);
    ref.invalidateSelf();
    return sound;
  }

  static final renameMutation = Mutation<void>();
  Future<void> rename({required String id, required String displayName}) async {
    await ref
        .read(notificationSoundOperationCoordinatorProvider)
        .run(
          () => ref
              .read(notificationSoundRepositoryProvider)
              .rename(id: id, displayName: displayName),
        );
    ref.invalidateSelf();
  }

  static final deleteMutation = Mutation<void>();
  Future<void> delete({required String id}) async {
    final repository = ref.read(notificationSoundRepositoryProvider);
    final coordinator = ref.read(notificationSoundOperationCoordinatorProvider);
    final usage = await ref.read(
      notificationSoundUsageRepositoryProvider.future,
    );
    await coordinator.run(() async {
      final sound = (await repository.list())
          .where((sound) => sound.id == id)
          .firstOrNull;
      if (sound == null) return;
      if (coordinator.isReserved(sound.fileName) ||
          await usage.isInUse(fileName: sound.fileName)) {
        throw const NotificationSoundException(.inUse);
      }
      if (coordinator.isReserved(sound.fileName)) {
        throw const NotificationSoundException(.inUse);
      }
      await repository.delete(id: id);
    });
    ref.invalidateSelf();
  }

  static final previewMutation = Mutation<void>();
  Future<void> preview({String? id, String? preparedId}) {
    final repository = ref.read(notificationSoundRepositoryProvider);
    if (preparedId != null)
      return repository.previewPrepared(preparedId: preparedId);
    if (id != null) return repository.previewSaved(id: id);
    return repository.stopPreview();
  }
}

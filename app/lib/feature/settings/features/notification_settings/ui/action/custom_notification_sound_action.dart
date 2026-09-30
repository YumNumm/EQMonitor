import 'package:eqmonitor/core/component/error/error_dialog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/custom_notification_sound.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_failure.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/custom_notification_sounds_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_sound_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_sound_operation_coordinator.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_sound_name_dialog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/custom_notification_sound_import_page.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_upgrade_dialog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/custom_notification_sounds_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_notification_sound_action.g.dart';

@riverpod
CustomNotificationSoundAction customNotificationSoundAction(Ref ref) =>
    const CustomNotificationSoundAction();

class const CustomNotificationSoundAction() {
  Future<void> select(
    WidgetRef ref,
    BuildContext context, {
    required String apiValue,
    required Future<void> Function(String) onChanged,
  }) async {
    final coordinator = ref.read(notificationSoundOperationCoordinatorProvider);
    coordinator.reserve(apiValue);
    try {
      // Validate new selections. Existing/snapshot names may remain unavailable.
      try {
        await coordinator.run(() async {}, soundNames: [apiValue]);
      } on NotificationSoundException catch (error, stackTrace) {
        if (context.mounted)
          await ref
              .read(errorDialogActionProvider)
              .show(context, error: error, stackTrace: stackTrace);
        return;
      }
      if (!context.mounted) return;
      try {
        await onChanged(apiValue);
      } catch (_) {
        // The settings Mutation listener presents persistence failures.
      }
    } finally {
      coordinator.release(apiValue);
    }
  }

  Future<void> manage(WidgetRef ref, BuildContext context) async {
    if (!ref.read(isProProvider)) {
      await const ProUpgradeDialogAction().show(context);
      return;
    }
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => const CustomNotificationSoundsPage(),
      ),
    );
  }

  Future<void> add(WidgetRef ref, BuildContext context) async {
    if (!ref.read(isProProvider)) {
      await const ProUpgradeDialogAction().show(context);
      return;
    }
    final repository = ref.read(notificationSoundRepositoryProvider);
    String? preparedId;
    var ownsImport = false;
    try {
      await repository.stopPreview();
      final inspection = await CustomNotificationSoundsNotifier.pickMutation
          .run(
            ref,
            (tsx) => tsx
                .get(customNotificationSoundsProvider.notifier)
                .pickAndInspect(),
          );
      if (inspection == null) return;
      ownsImport = true;
      if (!context.mounted) return;
      final needsTrim = inspection.durationMs > 29900;
      if (needsTrim) {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('通知音の長さ'),
            content: const Text('通知音に使える長さは30秒未満です。先頭29.9秒を使用します'),
            actions: [
              M3ETextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('キャンセル'),
              ),
              M3EFilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('先頭29.9秒を使用'),
              ),
            ],
          ),
        );
        if (confirmed != true || !context.mounted) return;
      }
      final prepared = await CustomNotificationSoundsNotifier.prepareMutation
          .run(
            ref,
            (tsx) => tsx
                .get(customNotificationSoundsProvider.notifier)
                .prepare(trimToMaxDuration: needsTrim),
          );
      preparedId = prepared.id;
      if (!context.mounted) return;
      await Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => CustomNotificationSoundImportPage(
            inspection: inspection,
            prepared: prepared,
          ),
        ),
      );
    } catch (error, stackTrace) {
      if (context.mounted)
        await ref
            .read(errorDialogActionProvider)
            .show(context, error: error, stackTrace: stackTrace);
    } finally {
      if (ownsImport)
        await discard(repository: repository, preparedId: preparedId);
    }
  }

  Future<void> commit(
    WidgetRef ref,
    BuildContext context, {
    required String preparedId,
    required String displayName,
  }) async {
    if (!ref.read(isProProvider)) {
      await const ProUpgradeDialogAction().show(context);
      return;
    }
    try {
      await CustomNotificationSoundsNotifier.commitMutation.run(
        ref,
        (tsx) => tsx
            .get(customNotificationSoundsProvider.notifier)
            .commit(preparedId: preparedId, displayName: displayName),
      );
      if (context.mounted) Navigator.of(context).pop();
    } catch (error, stackTrace) {
      if (context.mounted)
        await ref
            .read(errorDialogActionProvider)
            .show(context, error: error, stackTrace: stackTrace);
    }
  }

  Future<void> preview(
    WidgetRef ref,
    BuildContext context, {
    String? id,
    String? preparedId,
  }) async {
    try {
      await CustomNotificationSoundsNotifier.previewMutation.run(
        ref,
        (tsx) => tsx
            .get(customNotificationSoundsProvider.notifier)
            .preview(id: id, preparedId: preparedId),
      );
    } catch (error, stackTrace) {
      if (context.mounted)
        await ref
            .read(errorDialogActionProvider)
            .show(context, error: error, stackTrace: stackTrace);
    }
  }

  Future<void> rename(
    WidgetRef ref,
    BuildContext context, {
    required CustomNotificationSound sound,
  }) async {
    final name = await showDialog<String>(
      context: context,
      builder: (_) =>
          NotificationSoundNameDialog(initialName: sound.displayName),
    );
    if (name == null || !context.mounted) return;
    try {
      await CustomNotificationSoundsNotifier.renameMutation.run(
        ref,
        (tsx) => tsx
            .get(customNotificationSoundsProvider.notifier)
            .rename(id: sound.id, displayName: name),
      );
    } catch (error, stackTrace) {
      if (context.mounted)
        await ref
            .read(errorDialogActionProvider)
            .show(context, error: error, stackTrace: stackTrace);
    }
  }

  Future<void> delete(
    WidgetRef ref,
    BuildContext context, {
    required CustomNotificationSound sound,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('通知音を削除'),
        content: Text('「${sound.displayName}」を削除しますか？'),
        actions: [
          M3ETextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          M3EFilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      await CustomNotificationSoundsNotifier.deleteMutation.run(
        ref,
        (tsx) => tsx
            .get(customNotificationSoundsProvider.notifier)
            .delete(id: sound.id),
      );
    } catch (error, stackTrace) {
      if (context.mounted)
        await ref
            .read(errorDialogActionProvider)
            .show(context, error: error, stackTrace: stackTrace);
    }
  }

  Future<void> stopPreview({
    required NotificationSoundRepository repository,
  }) async {
    try {
      await repository.stopPreview();
    } on NotificationSoundException {
      return;
    }
  }

  Future<void> discard({
    required NotificationSoundRepository repository,
    String? preparedId,
  }) async {
    try {
      await repository.discard(preparedId: preparedId);
    } on NotificationSoundException {
      return;
    }
  }
}

import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_inspection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/prepared_notification_sound.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/custom_notification_sounds_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_sound_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/action/custom_notification_sound_action.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class CustomNotificationSoundImportPage extends HookConsumerWidget {
  const new({required this.inspection, required this.prepared, super.key});

  final NotificationSoundInspection inspection;
  final PreparedNotificationSound prepared;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = useTextEditingController(
      text: inspection.sourceDisplayName.replaceFirst(RegExp(r'\.[^.]+$'), ''),
    );
    useValueListenable(name);
    final action = ref.watch(customNotificationSoundActionProvider);
    final repository = ref.watch(notificationSoundRepositoryProvider);
    final busy = ref.watch(
      CustomNotificationSoundsNotifier.commitMutation,
    ) is MutationPending;
    final previewBusy = ref.watch(
      CustomNotificationSoundsNotifier.previewMutation,
    ) is MutationPending;
    useEffect(
      () =>
          () => action.stopPreview(repository: repository),
      [action, repository],
    );

    return PopScope(
      canPop: !busy,
      child: Scaffold(
        appBar: AppBar(title: const Text('通知音を追加')),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(inspection.sourceDisplayName),
            const SizedBox(height: 16),
            Text('通知音の長さ: ${(prepared.durationMs / 1000).toStringAsFixed(1)}秒'),
            const SizedBox(height: 16),
            TextField(
              controller: name,
              maxLength: 100,
              enabled: !busy,
              decoration: const InputDecoration(labelText: '名前'),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                M3ETextButton(
                  onPressed: busy || previewBusy
                      ? null
                      : () => action.preview(
                          ref,
                          context,
                          preparedId: prepared.id,
                        ),
                  child: const Text('試聴'),
                ),
                M3ETextButton(
                  onPressed: busy || previewBusy
                      ? null
                      : () => action.preview(ref, context),
                  child: const Text('停止'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            M3EFilledButton(
              onPressed: busy || name.text.trim().isEmpty
                  ? null
                  : () => action.commit(
                      ref,
                      context,
                      preparedId: prepared.id,
                      displayName: name.text,
                    ),
              child: Text(busy ? '保存中…' : '追加'),
            ),
            const SizedBox(height: 16),
            const Text('追加後、通知音の選択欄から選んでください'),
          ],
        ),
      ),
    );
  }
}

import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/custom_notification_sounds_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_sound_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/action/custom_notification_sound_action.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class CustomNotificationSoundsPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(customNotificationSoundsProvider);
    final action = ref.watch(customNotificationSoundActionProvider);
    final repository = ref.watch(notificationSoundRepositoryProvider);
    final busy =
        ref.watch(CustomNotificationSoundsNotifier.pickMutation)
            is MutationPending ||
        ref.watch(CustomNotificationSoundsNotifier.prepareMutation)
            is MutationPending ||
        ref.watch(CustomNotificationSoundsNotifier.renameMutation)
            is MutationPending ||
        ref.watch(CustomNotificationSoundsNotifier.deleteMutation)
            is MutationPending;
    useEffect(
      () =>
          () => action.stopPreview(repository: repository),
      [action, repository],
    );

    return PopScope(
      canPop: !busy,
      child: Scaffold(
        appBar: AppBar(title: const Text('追加した通知音')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            M3EFilledButton(
              onPressed: busy ? null : () => action.add(ref, context),
              child: const Text('ファイルから追加'),
            ),
            const SizedBox(height: 16),
            if (catalog.isLoading)
              const Center(child: CircularProgressIndicator()),
            if (catalog.hasError) ...[
              const Text('追加した通知音を読み込めません。時間をおいて再試行してください'),
              M3ETextButton(
                onPressed: () =>
                    ref.invalidate(customNotificationSoundsProvider),
                child: const Text('再試行'),
              ),
            ],
            if (catalog.value case final sounds?) ...[
              if (sounds.isEmpty) const Text('追加した通知音はありません'),
              for (final sound in sounds)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          sound.displayName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          sound.isAvailable
                              ? '${(sound.durationMs / 1000).toStringAsFixed(1)}秒'
                              : 'この端末では利用できません。ファイルを追加し直してください',
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            M3ETextButton(
                              onPressed: busy || !sound.isAvailable
                                  ? null
                                  : () => action.preview(
                                      ref,
                                      context,
                                      id: sound.id,
                                    ),
                              child: const Text('試聴'),
                            ),
                            M3ETextButton(
                              onPressed: busy
                                  ? null
                                  : () => action.preview(ref, context),
                              child: const Text('停止'),
                            ),
                            M3ETextButton(
                              onPressed: busy
                                  ? null
                                  : () => action.rename(
                                      ref,
                                      context,
                                      sound: sound,
                                    ),
                              child: const Text('名前を変更'),
                            ),
                            M3ETextButton(
                              onPressed: busy
                                  ? null
                                  : () => action.delete(
                                      ref,
                                      context,
                                      sound: sound,
                                    ),
                              child: const Text('削除'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/custom_notification_sounds_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/notification_sound_platform.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/action/custom_notification_sound_action.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class NotificationSoundLibraryControls extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(customNotificationSoundsSupportedProvider))
      return const SizedBox.shrink();
    final action = ref.watch(customNotificationSoundActionProvider);
    final busy =
        ref.watch(CustomNotificationSoundsNotifier.pickMutation)
            is MutationPending ||
        ref.watch(CustomNotificationSoundsNotifier.prepareMutation)
            is MutationPending;
    return Wrap(
      spacing: 8,
      children: [
        M3ETextButton(
          onPressed: busy ? null : () => action.add(ref, context),
          child: Text(busy ? '読み込み中…' : 'ファイルから追加'),
        ),
        M3ETextButton(
          onPressed: busy ? null : () => action.manage(ref, context),
          child: const Text('追加した通知音を管理'),
        ),
      ],
    );
  }
}

import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_selection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/custom_notification_sounds_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/notification_sound_options.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_sound_operation_coordinator.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/action/custom_notification_sound_action.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class NotificationSoundSelector extends HookConsumerWidget {
  const new({required this.apiValue, required this.onChanged, super.key});

  final String apiValue;
  final Future<void> Function(String) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(notificationSoundOptionsProvider);
    final catalog = ref.watch(customNotificationSoundsProvider);
    final current = options
        .where((option) => option.apiValue == apiValue)
        .firstOrNull;
    final items = [
      ...options,
      if (current == null) NotificationSoundSelection.unavailable(apiValue),
    ];
    final busy = useState(false);
    final coordinator = ref.watch(
      notificationSoundOperationCoordinatorProvider,
    );
    useEffect(() {
      coordinator.reserve(apiValue);
      return () => coordinator.release(apiValue);
    }, [coordinator, apiValue]);

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        ControlledDropdown<NotificationSoundSelection>(
          enabled: !busy.value,
          items: [
            for (final option in items)
              M3EDropdownItem(
                value: option,
                label: option.displayName,
                selected: option.apiValue == apiValue,
                disabled: !option.isAvailable,
              ),
          ],
          onSelectionChanged: (selected) async {
            if (selected.isEmpty) return;
            busy.value = true;
            try {
              await ref
                  .read(customNotificationSoundActionProvider)
                  .select(
                    ref,
                    context,
                    apiValue: selected.first.value.apiValue,
                    onChanged: onChanged,
                  );
            } finally {
              if (context.mounted) busy.value = false;
            }
          },
        ),
        if (catalog.hasError)
          Text('追加した通知音を読み込めません', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

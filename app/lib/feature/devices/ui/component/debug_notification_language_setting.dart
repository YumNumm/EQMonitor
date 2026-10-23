import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/notifier/notification_language_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class DebugNotificationLanguageSetting extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(notificationLanguageProvider);
    final mutation = ref.watch(
      NotificationLanguageNotifier.updateLocaleMutation,
    );
    final busy = mutation is MutationPending;

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const Text('通知の言語'),
        const Text('この端末に届く通知の言語を設定します'),
        const SizedBox(height: 8),
        switch (language) {
          AsyncData(:final value) when !language.isLoading =>
            ControlledDropdown<DeviceLocale>(
              enabled: !busy,
              items: [
                for (final locale in DeviceLocale.values)
                  M3EDropdownItem(
                    value: locale,
                    label: switch (locale) {
                      .ja => '日本語',
                      .en => 'English',
                      .zh => '中文',
                    },
                    selected: locale == value,
                  ),
              ],
              onSelectionChanged: (selected) async {
                if (selected.isEmpty || busy) return;
                await NotificationLanguageNotifier.updateLocaleMutation
                    .run(ref, (tsx) async {
                      await tsx
                          .get(notificationLanguageProvider.notifier)
                          .updateLocale(locale: selected.first.value);
                    })
                    .onError((error, stackTrace) {
                      talker.warning('Failed to update notification language');
                    });
              },
            ),
          AsyncError() when !language.isLoading => Column(
            crossAxisAlignment: .start,
            children: [
              const Text('通知の言語を読み込めませんでした'),
              M3ETextButton.icon(
                onPressed: () => ref.invalidate(notificationLanguageProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('再試行'),
              ),
            ],
          ),
          _ => const Center(child: AccessibleCircularProgressIndicator()),
        },
        if (busy) const Text('保存中…'),
        if (mutation is MutationError)
          const Text('通知の言語を保存できませんでした。もう一度選択してください。'),
        const SizedBox(height: 8),
      ],
    );
  }
}

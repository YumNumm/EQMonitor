import 'package:eqmonitor/core/component/sheet/app_sheet_route.dart';
import 'package:eqmonitor/feature/notification/data/action/test_notification_send_action.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/test_notification_sheet.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class TestNotificationTile extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingKind = useState<TestNotificationKind?>(null);

    return ListTile(
      title: const Text('テスト通知を送信'),
      subtitle: const Text('通知が正しく届くか確認できます'),
      leading: const Icon(Icons.send_outlined),
      trailing: pendingKind.value == null
          ? const Icon(Icons.chevron_right)
          : const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            ),
      onTap: pendingKind.value != null
          ? null
          : () async {
              await Navigator.of(context).push<void>(
                AppSheetRoute<void>(
                  initialExtent: 0.4,
                  builder: (sheetContext) => TestNotificationSheet(
                    onPressed: (kind, sheetContext) async {
                      pendingKind.value = kind;
                      try {
                        final sheetNavigator = Navigator.of(sheetContext);
                        if (kind == .normal) {
                          sheetNavigator.pop();
                        }
                        await ref
                            .read(testNotificationSendActionProvider)
                            .handle(
                              ref: ref,
                              context: context,
                              kind: kind,
                              onConfirmed: sheetNavigator.pop,
                            );
                      } finally {
                        if (context.mounted) {
                          pendingKind.value = null;
                        }
                      }
                    },
                  ),
                ),
              );
            },
    );
  }
}

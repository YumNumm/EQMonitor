import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/ui/component/test_notification_kind_buttons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

class TestNotificationSheet extends HookWidget {
  const new({required this.onPressed, super.key});

  final Future<void> Function(
    TestNotificationKind kind,
    BuildContext sheetContext,
  )
  onPressed;

  @override
  Widget build(BuildContext context) {
    final pendingKind = useState<TestNotificationKind?>(null);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
          tooltip: '閉じる',
        ),
        title: const Text('テスト通知'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('送信する通知の種類を選んでください'),
            const SizedBox(height: 16),
            TestNotificationKindButtons(
              pendingKind: pendingKind.value,
              onPressed: (kind) async {
                pendingKind.value = kind;
                await onPressed(kind, context);
                if (context.mounted) {
                  pendingKind.value = null;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

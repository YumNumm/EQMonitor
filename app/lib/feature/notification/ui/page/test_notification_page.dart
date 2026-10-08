import 'dart:io';

import 'package:eqmonitor/feature/notification/data/action/test_notification_send_action.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/ui/component/test_live_activity_panel.dart';
import 'package:eqmonitor/feature/notification/ui/component/test_notification_kind_buttons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class TestNotificationPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingKind = useState<TestNotificationKind?>(null);
    final isIOS = Platform.isIOS;

    return DefaultTabController(
      length: isIOS ? 2 : 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('テスト通知'),
          bottom: isIOS
              ? const TabBar(
                  tabs: [
                    Tab(text: 'プッシュ通知'),
                    Tab(text: 'Live Activity'),
                  ],
                )
              : null,
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  '通知条件の設定にかかわらず、この端末にサンプル通知を送信します。'
                  '端末の通知許可や通知音の設定は適用されます。',
                ),
                const SizedBox(height: 24),
                for (final kinds in const <List<TestNotificationKind>>[
                  [
                    .shindoReport,
                    .shindoReportWithHypocenter,
                    .hypocenterAndIntensity,
                    .longPeriodGroundMotion,
                  ],
                  [.eewForecast, .eewWarning],
                ]) ...[
                  TestNotificationKindButtons(
                    kinds: kinds,
                    pendingKind: pendingKind.value,
                    onPressed: (kind) async {
                      pendingKind.value = kind;
                      try {
                        await ref
                            .read(testNotificationSendActionProvider)
                            .handle(
                              ref: ref,
                              context: context,
                              kind: kind,
                            );
                      } finally {
                        if (context.mounted) {
                          pendingKind.value = null;
                        }
                      }
                    },
                  ),
                  if (kinds.length == 4) const Divider(height: 32),
                ],
              ],
            ),
            if (isIOS)
              ListView(
                padding: const EdgeInsets.all(16),
                children: const [TestLiveActivityPanel()],
              ),
          ],
        ),
      ),
    );
  }
}

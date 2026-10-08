import 'dart:io';

import 'package:eqmonitor/core/router/router.dart';
import 'package:material_ui/material_ui.dart';

class TestNotificationTile extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => ListTile(
    title: const Text('テスト通知を送信'),
    subtitle: Text(
      Platform.isIOS ? 'プッシュ通知とLive Activityを確認できます' : 'プッシュ通知を確認できます',
    ),
    leading: const Icon(Icons.send_outlined),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => const TestNotificationRoute().push<void>(context),
  );
}

import 'package:eqmonitor/common/fcm/silent_data_handle.dart';
import 'package:eqmonitor/common/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugHomeView extends ConsumerWidget {
  const DebugHomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EQMonitor Debug Menu'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('地震履歴'),
              onTap: () => const EarthquakeHistoryRoute().push<void>(context),
              leading: const Icon(Icons.history),
            ),
            ListTile(
              title: const Text('ホーム画面に戻る'),
              onTap: () => const HomeRoute().push<void>(context),
              leading: const Icon(Icons.home),
            ),
            ListTile(
              title: const Text('FCM Token'),
              leading: const Icon(Icons.notifications),
              onTap: () async {
                final token = NotificationController().firebaseToken;
                await showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('FCM Token'),
                    content: Text(token),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: token));
                          Navigator.pop(context);
                        },
                        child: const Text('Copy'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

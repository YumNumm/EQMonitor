import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/home/component/kmoni/kmoni_settings_dialog.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:eqmonitor/feature/home/features/telegram_ws/provider/telegram_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugWidget extends ConsumerWidget {
  const DebugWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(4),
      elevation: 1,
      shadowColor: Colors.transparent,
      // 角丸にして Border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.dividerColor.withOpacity(0.6),
          width: 0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetHeader(title: 'デバッグメニュー'),
            ListTile(
              title: const Text('Request Sample EEW Telegram'),
              subtitle: const Text('EventID: 20171213112000'),
              leading: const Icon(Icons.send),
              onTap: ref.read(telegramWsProvider.notifier).requestSample,
            ),
            ListTile(
              title: const Text('ログ'),
              leading: const Icon(Icons.list),
              onTap: () => context.push(const TalkerRoute().location),
            ),
            ListTile(
              title: const Text('Kmoni Debug Setting'),
              leading: const Icon(Icons.settings),
              onTap: () => showDialog<void>(
                context: context,
                builder: (context) => const KmoniSettingsDialogWidget(),
              ),
            ),
            ListTile(
              title: const Text('重大な通知権限'),
              leading: const Icon(Icons.notifications_active),
              onTap: () async {
                {
                  final result =
                      await FirebaseMessaging.instance.requestPermission(
                    criticalAlert: true,
                  );
                  if (context.mounted) {
                    await showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('重大な通知権限 (FirebaseMessaging)'),
                        content: Text(result.toString()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
            ),
            ListTile(
              title: const Text('Subscribe to YumNumm Notify'),
              leading: const Icon(Icons.notifications),
              onTap: () async {
                try {
                  await FirebaseMessaging.instance
                      .subscribeToTopic('yumnumm-notify');
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Subscribed to YumNumm Notify'),
                      ),
                    );
                  }
                } on Exception catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Failed to subscribe to YumNumm Notify $e'),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

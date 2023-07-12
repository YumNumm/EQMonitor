import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:eqmonitor/feature/home/features/telegram_ws/provider/telegram_provider.dart';
import 'package:flutter/material.dart';
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
          ],
        ),
      ),
    );
  }
}

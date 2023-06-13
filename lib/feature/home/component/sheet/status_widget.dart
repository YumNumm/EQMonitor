import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:eqmonitor/feature/home/features/telegram_ws/provider/telegram_provider.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class SheetStatusWidget extends ConsumerWidget {
  const SheetStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = ref
        .watch(kmoniViewModelProvider.select((value) => value.isInitialized));
    final latestTime = ref.watch(
      kmoniViewModelProvider.select((value) => value.lastUpdatedAt?.toLocal()),
    );
    final socketStatus = ref.watch(socketStatusProvider);
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(4),
      elevation: 1,
      shadowColor: Colors.transparent,
      // 角丸にして Border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
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
        child: Row(
          children: [
            // 現在時刻
            if (isInitialized && latestTime != null)
              Text(
                DateFormat('yyyy/MM/dd HH:mm:ss').format(latestTime),
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontFamily: FontFamily.jetBrainsMono,
                ),
              )
            else
              const CircularProgressIndicator.adaptive(),
            const Spacer(),
            // WS接続状態
            if (socketStatus.connected) ...[
              const Icon(
                Icons.cloud_sync_rounded,
                color: Colors.green,
              ),
              const SizedBox(width: 4),
              const Text('接続済み'),
            ] else ...[
              const Icon(
                Icons.cloud_off_rounded,
                color: Colors.red,
              ),
              const SizedBox(width: 4),
              const Text('接続試行中...')
            ],
          ],
        ),
      ),
    );
  }
}

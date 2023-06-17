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
    final isDelayAdjusting = ref.watch(
      kmoniViewModelProvider.select((value) => value.isDelayAdjusting),
    );
    final socketStatus = ref.watch(socketStatusProvider);
    final theme = Theme.of(context);

    Future<void> adjustKmoniDelay() async {
      // 遅延調整の実行
      try {
        final result = await ref
            .read(kmoniViewModelProvider.notifier)
            .syncDelayWithKmoni();
        // showSnackbar
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '[強震モニタ] 遅延調整を実行しました (${result.inMilliseconds}ms)',
              ),
              showCloseIcon: true,
            ),
          );
        }
      } on Exception {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('強震モニタ 遅延調整中にエラーが発生しました'),
              showCloseIcon: true,
            ),
          );
          return;
        }
      }
    }

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
        child: Row(
          children: [
            // kmoni
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: adjustKmoniDelay,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                    if (isDelayAdjusting) ...[
                      const SizedBox(width: 4),
                      const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
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

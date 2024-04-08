import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/kmoni/model/kmoni_view_model_state.dart';
import 'package:eqmonitor/core/provider/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:eqmonitor/core/provider/kmoni/viewmodel/kmoni_view_settings.dart';
import 'package:eqmonitor/core/provider/websocket/websocket_provider.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_client/web_socket_client.dart';

class SheetStatusWidget extends ConsumerWidget {
  const SheetStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = ref
        .watch(kmoniViewModelProvider.select((value) => value.isInitialized));
    final latestTime = ref.watch(
      kmoniViewModelProvider.select((value) => value.lastUpdatedAt?.toLocal()),
    );
    final status =
        ref.watch(kmoniViewModelProvider.select((value) => value.status));
    final isDelayAdjusting = ref.watch(
      kmoniViewModelProvider.select((value) => value.isDelayAdjusting),
    );
    final useKmoni =
        ref.watch(kmoniSettingsProvider.select((value) => value.useKmoni));
    final theme = Theme.of(context);

    Future<void> adjustKmoniDelay() async {
      // 遅延調整の実行
      try {
        final result = await ref
            .read(kmoniViewModelProvider.notifier)
            .syncDelayWithKmoni();
        // showSnackbar
        if (context.mounted && result != null) {
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

    return BorderedContainer(
      elevation: 1,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Row(
        children: [
          // kmoni
          if (useKmoni)
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: adjustKmoniDelay,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 現在時刻
                      ...switch (status) {
                        KmoniStatus.stopped => [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '強震モニタ 停止中',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        _ when isDelayAdjusting && latestTime != null => [
                            Flexible(
                              child: Text(
                                DateFormat('yyyy/MM/dd HH:mm:ss')
                                    .format(latestTime),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ],
                        _
                            when isInitialized &&
                                latestTime != null &&
                                status == KmoniStatus.delay =>
                          [
                            Flexible(
                              child: Text(
                                DateFormat('yyyy/MM/dd HH:mm:ss')
                                    .format(latestTime),
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        _ when isInitialized && latestTime != null => [
                            Flexible(
                              child: Text(
                                DateFormat('yyyy/MM/dd HH:mm:ss').format(
                                  latestTime,
                                ),
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  fontFamily: monoFont,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                          ],
                        _ => [
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ],
                      },
                    ],
                  ),
                ),
              ),
            )
          else
            const Spacer(),
          // WS接続状態
          const _WebsocketStatusWidget(),
        ],
      ),
    );
  }
}

class _WebsocketStatusWidget extends ConsumerWidget {
  const _WebsocketStatusWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final status = ref.watch(websocketStatusProvider);
    return switch (status) {
      Connecting() => Tooltip(
          message: 'WebSocket接続試行中',
          child: Row(
            children: [
              Icon(
                Icons.cloud_off_rounded,
                color: colorScheme.error,
              ),
              const SizedBox(width: 4),
              const Text('接続試行中...'),
            ],
          ),
        ),
      Connected() || Reconnected() => Tooltip(
          message: 'WebSocket接続済み',
          child: Row(
            children: [
              Icon(
                Icons.cloud_done_outlined,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 4),
              const Text('接続済み'),
            ],
          ),
        ),
      Reconnecting() => Tooltip(
          message: 'WebSocket再接続中',
          child: Row(
            children: [
              Icon(
                Icons.cloud_sync_outlined,
                color: colorScheme.error,
              ),
              const SizedBox(width: 4),
              const Text('再接続中...'),
            ],
          ),
        ),
      Disconnected() || Disconnecting() => Tooltip(
          message: 'WebSocket未接続',
          child: Row(
            children: [
              Icon(
                Icons.cloud_off_rounded,
                color: colorScheme.error,
              ),
              const SizedBox(width: 4),
              const Text('未接続'),
            ],
          ),
        ),
      _ => const Text('不明'),
    };
  }
}

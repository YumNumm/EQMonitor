import 'package:eqmonitor/core/provider/kmoni/model/kmoni_view_model_state.dart';
import 'package:eqmonitor/core/provider/kmoni/viewmodel/kmoni_settings.dart';
import 'package:eqmonitor/core/provider/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class KmoniStatusWidget extends ConsumerWidget {
  const KmoniStatusWidget({super.key});

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
    if (!useKmoni) {
      return const SizedBox.shrink();
    }
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

    return Flexible(
      child: Card(
        elevation: 0,
        color: theme.colorScheme.surfaceContainerHighest,
        child: Tooltip(
          message: '強震モニタ遅延調整',
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: adjustKmoniDelay,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: DefaultTextStyle(
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontFamily: monoFont,
                  letterSpacing: -0.5,
                ),
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
                          const Flexible(
                            child: Text(
                              '強震モニタ 取得停止中',
                            ),
                          ),
                        ],
                      _ when isDelayAdjusting && latestTime != null => [
                          Flexible(
                            child: Text(
                              DateFormat('表示時刻: yyyy/MM/dd HH:mm:ss')
                                  .format(latestTime),
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
                              DateFormat('表示時刻: yyyy/MM/dd HH:mm:ss')
                                  .format(latestTime),
                              style: const TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      _ when isInitialized && latestTime != null => [
                          Flexible(
                            child: Text(
                              DateFormat('表示時刻: yyyy/MM/dd HH:mm:ss').format(
                                latestTime,
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
          ),
        ),
      ),
    );
  }
}

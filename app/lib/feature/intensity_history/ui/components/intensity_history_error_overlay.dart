import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final intensityHistoryErrorOverlayActionProvider =
    Provider<IntensityHistoryErrorOverlayAction>(
      (_) => const IntensityHistoryErrorOverlayAction(),
    );

class IntensityHistoryErrorOverlayAction {
  const IntensityHistoryErrorOverlayAction();

  Future<void> showDetails({
    required BuildContext context,
    required Object error,
    required StackTrace? stackTrace,
  }) {
    final details = stackTrace == null ? '$error' : '$error\n\n$stackTrace';

    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('エラー詳細'),
        content: SingleChildScrollView(
          child: SelectableText(details),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }
}

class IntensityHistoryErrorOverlay extends ConsumerWidget {
  const IntensityHistoryErrorOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefectureHighestAsync = ref.watch(prefectureHighestProvider);
    final error = prefectureHighestAsync.error;
    final stackTrace = prefectureHighestAsync.stackTrace;

    if (error == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final action = ref.read(intensityHistoryErrorOverlayActionProvider);

    return Positioned(
      left: 12,
      right: 12,
      bottom: 72,
      child: SafeArea(
        top: false,
        child: Material(
          elevation: 4,
          color: colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.error_outline, color: colorScheme.error),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '震度情報を取得できません',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colorScheme.onErrorContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '最大震度の取得に失敗しました。地図は操作できます。',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onErrorContainer,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => action.showDetails(
                            context: context,
                            error: error,
                            stackTrace: stackTrace,
                          ),
                          child: const Text('詳細を見る'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

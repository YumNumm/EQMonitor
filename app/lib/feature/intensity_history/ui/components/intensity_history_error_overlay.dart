import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
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
    return showErrorDetailsSheet(context, error: error, stackTrace: stackTrace);
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
            padding: const EdgeInsets.all(12),
            child: Row(
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
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () => action.showDetails(
                    context: context,
                    error: error,
                    stackTrace: stackTrace,
                  ),
                  child: const Text('詳細を見る'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

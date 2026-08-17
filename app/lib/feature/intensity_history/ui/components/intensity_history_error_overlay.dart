import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final intensityHistoryErrorOverlayActionProvider =
    Provider<IntensityHistoryErrorOverlayAction>(
      (_) => const IntensityHistoryErrorOverlayAction(),
    );

class IntensityHistoryErrorOverlayAction {
  const new();

  Future<void> showDetails({
    required WidgetRef ref,
    required BuildContext context,
    required Object error,
    required StackTrace? stackTrace,
  }) {
    return ref
        .read(errorDetailsSheetActionProvider)
        .show(context, error: error, stackTrace: stackTrace);
  }
}

class IntensityHistoryErrorOverlay extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefectureHighestAsync = ref.watch(prefectureHighestProvider);
    final error = prefectureHighestAsync.error;
    final stackTrace = prefectureHighestAsync.stackTrace;

    if (error == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final action = ref.read(intensityHistoryErrorOverlayActionProvider);

    return Positioned(
      left: 12,
      right: 12,
      bottom: 72,
      child: SafeArea(
        top: false,
        child: Material(
          elevation: 4,
          color: designSystem.colorTheme.errorContainer,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: designSystem.colorTheme.error),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '震度情報を取得できません',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: designSystem.colorTheme.onErrorContainer,
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
                    ref: ref,
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

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final intensityHistoryErrorOverlayActionProvider =
    Provider<IntensityHistoryErrorOverlayAction>(
      (_) => const IntensityHistoryErrorOverlayAction(),
    );

class IntensityHistoryErrorOverlayAction {
  const new();

  Future<void> retry(WidgetRef ref) async {
    try {
      ref.invalidate(cityMaxIntensityProvider, asReload: true);
      await ref.read(cityMaxIntensityProvider.future);
    } on Object {
      // provider のエラー状態を画面に反映するため、Future の例外は伝播させない。
    }
  }

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
    final cityMaxIntensityAsync = ref.watch(cityMaxIntensityProvider);
    final error = cityMaxIntensityAsync.error;
    final stackTrace = cityMaxIntensityAsync.stackTrace;

    if (error == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final action = ref.read(intensityHistoryErrorOverlayActionProvider);

    if (!cityMaxIntensityAsync.hasValue) {
      return Positioned.fill(
        child: SafeArea(
          child: Center(
            child: ErrorCard(
              error: error,
              stackTrace: stackTrace,
              title: '震度情報を取得できません',
              onReload: () => action.retry(ref),
              showContact: false,
              showLoadingOverlayOnReload: false,
            ),
          ),
        ),
      );
    }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: designSystem.colorTheme.error,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '震度情報を更新できません',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: designSystem.colorTheme.onErrorContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Wrap(
                    spacing: 4,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await action.retry(ref);
                        },
                        child: const Text('再試行'),
                      ),
                      TextButton(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/estimated_intensity_dem_color_resolver.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_dem_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_dem_palette.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_color_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class const EstimatedIntensityDisplaySettings({
  required final bool hasDemArchive,
  super.key,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(
      earthquakeHistoryConfigProvider.select((config) => config.value?.details),
    );
    if (details == null) {
      return const SizedBox.shrink();
    }
    final mutation = ref.watch(
      EarthquakeHistoryConfigNotifier.saveDetailsMutation,
    );
    final busy = mutation is MutationPending;
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    return Column(
      crossAxisAlignment: .start,
      spacing: spacing.sm,
      children: [
        if (hasDemArchive) _ColoringPicker(details: details, enabled: !busy),
        FilterChip(
          selected: details.showStationsOnEstimatedIntensity,
          label: const Text('観測点を重ねて表示'),
          onSelected: busy
              ? null
              : (value) => HapticUtil.selection(
                  () => EarthquakeHistoryConfigNotifier.saveDetailsMutation.run(
                    ref,
                    (tsx) => tsx
                        .get(earthquakeHistoryConfigProvider.notifier)
                        .saveDetails(
                          details.copyWith(
                            showStationsOnEstimatedIntensity: value,
                          ),
                        ),
                  ),
                ),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: .shrinkWrap,
        ),
        if (mutation is MutationError)
          Text(
            '設定を保存できませんでした。もう一度お試しください。',
            style: designSystem.typography.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
      ],
    );
  }
}

class const _ColoringPicker({
  required final EarthquakeHistoryDetailsConfig details,
  required final bool enabled,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final classColors = designSystem.colorTheme.estimatedIntensity;
    final kyoshinColorMap = ref.watch(kyoshinColorMapProvider);
    final options =
        <
          ({
            EstimatedIntensityDemDisplayMode displayMode,
            EstimatedIntensityDemPalette palette,
            String title,
            String caption,
          })
        >[
          (
            displayMode: .intensityClass,
            palette: details.estimatedIntensityDemPalette,
            title: '震度階級',
            caption: '階級ごと',
          ),
          (
            displayMode: .tenth,
            palette: .intensityGradient,
            title: 'グラデーション',
            caption: '0.1 単位',
          ),
          (
            displayMode: .tenth,
            palette: .kyoshinMonitor,
            title: '強震モニタ',
            caption: '0.1 単位',
          ),
        ];

    return Column(
      crossAxisAlignment: .start,
      spacing: spacing.xs,
      children: [
        Text(
          '色分け',
          style: designSystem.typography.labelMedium.copyWith(
            color: designSystem.colorTheme.onSurfaceVariant,
          ),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: .stretch,
            spacing: spacing.sm,
            children: [
              for (final option in options)
                Expanded(
                  child: _ColoringTile(
                    title: option.title,
                    caption: option.caption,
                    colors: EstimatedIntensityDemColorResolver(
                      displayMode: option.displayMode,
                      palette: option.palette,
                      classColors: classColors,
                      kyoshinColorMap: kyoshinColorMap,
                    ).scaleColors(),
                    selected:
                        details.estimatedIntensityDemDisplayMode ==
                            option.displayMode &&
                        details.estimatedIntensityDemPalette == option.palette,
                    onTap: enabled
                        ? () => HapticUtil.selection(
                            () => EarthquakeHistoryConfigNotifier
                                .saveDetailsMutation
                                .run(
                                  ref,
                                  (tsx) => tsx
                                      .get(
                                        earthquakeHistoryConfigProvider
                                            .notifier,
                                      )
                                      .saveDetails(
                                        details.copyWith(
                                          estimatedIntensityDemDisplayMode:
                                              option.displayMode,
                                          estimatedIntensityDemPalette:
                                              option.palette,
                                        ),
                                      ),
                                ),
                          )
                        : null,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class const _ColoringTile({
  required final String title,
  required final String caption,
  required final List<Color> colors,
  required final bool selected,
  required final VoidCallback? onTap,
}) extends StatelessWidget {
  static const _previewHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return Semantics(
      button: true,
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: Material(
        color: selected
            ? colorTheme.secondaryContainer
            : colorTheme.surfaceContainerLow,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(designSystem.shape.md),
          side: BorderSide(
            color: selected ? colorTheme.primary : colorTheme.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        clipBehavior: .antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(spacing.sm),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(
                  height: _previewHeight,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(spacing.xs),
                      gradient: LinearGradient(
                        colors: [
                          for (final color in colors) ...[color, color],
                        ],
                        stops: [
                          for (
                            var index = 0;
                            index < colors.length;
                            index++
                          ) ...[
                            index / colors.length,
                            (index + 1) / colors.length,
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spacing.sm),
                Text(
                  title,
                  style: typography.labelMedium.copyWith(
                    fontWeight: .bold,
                    color: selected
                        ? colorTheme.onSecondaryContainer
                        : colorTheme.onSurface,
                  ),
                ),
                Text(
                  caption,
                  style: typography.labelSmall.copyWith(
                    color: selected
                        ? colorTheme.onSecondaryContainer
                        : colorTheme.onSurfaceVariant,
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

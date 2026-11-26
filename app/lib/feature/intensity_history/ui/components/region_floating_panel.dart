import 'dart:ui';

import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// 市区町村別最大震度マップの上部フローティングパネル。
///
/// - 未選択: 「市区町村別 最大観測震度」と集計の最終更新時刻を表示。
/// - 市区町村選択中: 都道府県名・市区町村名・最大震度バッジと最終更新時刻を表示。
class const RegionFloatingPanel({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCity = ref
        .watch(intensityHistoryControllerProvider)
        .selectedCity;
    final cityMaxIntensity = ref
        .watch(cityMaxIntensityProvider)
        .valueOrPrevious;

    return switch (selectedCity) {
      null => _NationwidePanel(cityMaxIntensity: cityMaxIntensity),
      final selectedCity => _CityPanel(
        selectedCity: selectedCity,
        cityMaxIntensity: cityMaxIntensity,
      ),
    };
  }
}

class const _RefreshedAtLabel({
  required final DateTime? aggregatedAt,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final aggregatedAt = this.aggregatedAt;
    if (aggregatedAt == null) {
      return const SizedBox.shrink();
    }
    return Text(
      '${aggregatedAt.formatWithTz(.monthDayHourMinute)} 更新',
      maxLines: 1,
      overflow: .ellipsis,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: context.designSystem.colorTheme.onSurface.withValues(alpha: 0.7),
        fontFamily: FontFamily.googleSansCode,
      ),
    );
  }
}

class const _NationwidePanel({
  required final CityMaxIntensity? cityMaxIntensity,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typography = context.designSystem.typography;

    return Card(
      color: context.designSystem.colorTheme.surface.withValues(alpha: 0.9),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '市区町村別 ',
                    style: typography.bodySmall.copyWith(
                      fontWeight: .bold,
                    ),
                  ),
                  TextSpan(
                    text: '最大観測震度',
                    style: typography.titleSmall,
                  ),
                ],
              ),
            ),
            _RefreshedAtLabel(aggregatedAt: cityMaxIntensity?.aggregatedAt),
          ],
        ),
      ),
    );
  }
}

class const _CityPanel({
  required final IntensityHistorySelectedCity selectedCity,
  required final CityMaxIntensity? cityMaxIntensity,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxIntensity = cityMaxIntensity?.intensityOfCity(selectedCity.code);

    return Card(
      color: context.designSystem.colorTheme.surface.withValues(alpha: 0.9),
      elevation: 0,
      clipBehavior: .hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.compose(
          outer: ImageFilter.blur(
            sigmaX: 8,
            sigmaY: 8,
            tileMode: .mirror,
          ),
          inner: ColorFilter.mode(
            context.designSystem.colorTheme.surfaceContainerLow.withValues(
              alpha: 0.7,
            ),
            .srcATop,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisSize: .min,
            children: [
              if (maxIntensity case final maxIntensity?) ...[
                JmaIntensityIcon(
                  intensity: maxIntensity,
                  type: IntensityIconType.filled,
                  size: 36,
                ),
                const SizedBox(width: 10),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Text(
                      selectedCity.prefectureName,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: context.designSystem.colorTheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      selectedCity.name,
                      maxLines: 2,
                      overflow: .ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: .bold,
                      ),
                    ),
                    _RefreshedAtLabel(
                      aggregatedAt: cityMaxIntensity?.aggregatedAt,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/city_detail_modal.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

/// 市区町村別最大震度マップの上部フローティングパネル。
///
/// - 未選択: 「全国」と集計の最終更新時刻を表示。
/// - 市区町村選択中: 都道府県名・市区町村名・最大震度バッジと最終更新時刻を表示。
class RegionFloatingPanel extends ConsumerWidget {
  const new({super.key});

  /// 集計の最終更新時刻の表示書式。
  static final refreshedAtFormat = DateFormat('MM/dd HH:mm');

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

/// 集計の最終更新時刻。`aggregated_at` が取得できなかった場合は何も出さない。
class _RefreshedAtLabel extends StatelessWidget {
  const new({required this.aggregatedAt});

  final DateTime? aggregatedAt;

  @override
  Widget build(BuildContext context) {
    final aggregatedAt = this.aggregatedAt;
    if (aggregatedAt == null) {
      return const SizedBox.shrink();
    }
    return Text(
      '最終更新 ${RegionFloatingPanel.refreshedAtFormat.format(aggregatedAt.toLocal())}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: context.designSystem.colorTheme.onSurface.withValues(alpha: 0.7),
      ),
    );
  }
}

class _NationwidePanel extends StatelessWidget {
  const new({required this.cityMaxIntensity});

  final CityMaxIntensity? cityMaxIntensity;

  @override
  Widget build(BuildContext context) {
    final typography = context.designSystem.typography;

    return Card(
      color: context.designSystem.colorTheme.surface.withValues(alpha: 0.9),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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

class _CityPanel extends StatelessWidget {
  const new({required this.selectedCity, required this.cityMaxIntensity});

  final IntensityHistorySelectedCity selectedCity;
  final CityMaxIntensity? cityMaxIntensity;

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
            tileMode: TileMode.mirror,
          ),
          inner: ColorFilter.mode(
            context.designSystem.colorTheme.surfaceContainerLow.withValues(
              alpha: 0.7,
            ),
            BlendMode.srcATop,
          ),
        ),
        child: Semantics(
          button: true,
          label: '${selectedCity.name}の詳細を表示',
          child: InkWell(
            onTap: () async {
              await CityDetailModalAction().show(
                context,
                cityCode: selectedCity.code,
                cityName: selectedCity.name,
                prefectureName: selectedCity.prefectureName,
                maxIntensity: maxIntensity,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          selectedCity.prefectureName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: context
                                .designSystem
                                .colorTheme
                                .onSurfaceVariant,
                          ),
                        ),
                        Text(
                          selectedCity.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/city_detail_modal.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 地域別最大震度マップの上部フローティングパネル。
///
/// - Lv1(全都道府県表示): 「全国」を表示。
/// - Lv2(特定都道府県フォーカス): 都道府県名・最高震度バッジ・観測件数を表示。
class RegionFloatingPanel extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intensityHistoryControllerProvider);
    final theme = Theme.of(context);

    return switch (state) {
      IntensityHistoryStatePrefecture() => _PrefecturePanel(theme: theme),
      IntensityHistoryStateCity(
        :final prefectureCode,
        :final prefectureName,
        :final selectedCityCode,
        :final selectedCityName,
      ) =>
        _CityPanel(
          prefectureCode: prefectureCode,
          prefectureName: prefectureName,
          selectedCityCode: selectedCityCode,
          selectedCityName: selectedCityName,
          theme: theme,
        ),
    };
  }
}

class _PrefecturePanel extends StatelessWidget {
  const new({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.designSystem.colorTheme.surface.withValues(alpha: 0.9),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          '全国',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _CityPanel extends ConsumerWidget {
  const new({
    required this.prefectureCode,
    required this.prefectureName,
    required this.selectedCityCode,
    required this.selectedCityName,
    required this.theme,
  });

  final String prefectureCode;
  final String prefectureName;
  final String? selectedCityCode;
  final String? selectedCityName;
  final ThemeData theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityCode = selectedCityCode;
    final cityName = selectedCityName;
    final selectedCity = cityCode != null && cityName != null
        ? (code: cityCode, name: cityName)
        : null;
    final prefectureHighestAsync = ref.watch(prefectureHighestProvider);
    final prefectureEntry = prefectureHighestAsync.valueOrPrevious
        ?.where((e) => e.code == prefectureCode)
        .firstOrNull;
    final cityHighestAsync = selectedCity != null
        ? ref.watch(cityHighestProvider(prefectureCode))
        : null;
    final selectedCityEntryCode = selectedCity?.code;
    final cityEntry = selectedCityEntryCode == null
        ? null
        : cityHighestAsync?.valueOrPrevious
              ?.where((e) => e.code == selectedCityEntryCode)
              .firstOrNull;
    final entry = selectedCity != null ? cityEntry : prefectureEntry;
    final displayName = selectedCity?.name ?? prefectureName;

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
          label: '$displayNameの詳細を表示',
          child: InkWell(
            onTap: () async {
              if (selectedCity != null) {
                await AreaDetailModalAction().showCity(
                  context,
                  cityCode: selectedCity.code,
                  cityName: selectedCity.name,
                  regionName: prefectureName,
                  summary: cityEntry,
                );
                return;
              }
              await AreaDetailModalAction().showPrefecture(
                context,
                prefectureCode: prefectureCode,
                prefectureName: prefectureName,
                summary: prefectureEntry,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (entry != null) ...[
                    JmaIntensityIcon(
                      intensity: entry.intensity,
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
                        if (selectedCity != null)
                          Text(
                            prefectureName,
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
                          displayName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (entry != null)
                          Text(
                            '${entry.count}件',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: context.designSystem.colorTheme.onSurface
                                  .withValues(alpha: 0.7),
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
      ),
    );
  }
}

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_forecast_region_intensity_filter_updater.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_area_selector.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_display_mode.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_area_filter.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// EEW震度予報区域レイヤー
///
/// `displayMode` に応じて、予報区を予想震度別、または府県予報区を
/// 警報発表区域として塗りつぶす。
class EewForecastRegionLayer extends HookConsumerWidget {
  const EewForecastRegionLayer({
    required this.eew,
    required this.displayMode,
    this.additionalRegions,
    super.key,
  });

  final EewTelegramItem? eew;
  final EewDisplayMode displayMode;
  final List<EewForecastRegionInfo>? additionalRegions;

  static const _sourceId = 'eqmonitor_map';
  static const _intensitySourceLayerId = 'areaForecastLocalE';
  static const _warningSourceLayerId = 'areaForecastLocalEew';
  static const _warningLayerId = 'eew-details-warning-fill';
  static const _warningLineLayerId = 'eew-details-warning-line';
  static const _areaFilterBuilder = EewAreaFilterBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(activeColorSetProvider).intensity;
    final warningAreaSelector = ref.watch(eewWarningAreaSelectorProvider);
    final isDarkMode = Theme.brightnessOf(context) == Brightness.dark;
    final intensityFilterUpdater = ref.watch(
      eewForecastRegionIntensityFilterUpdaterProvider,
    );

    final regionMaxIntensities = useMemoized(() {
      final regions = <EewForecastRegionInfo>[
        ...eew?.forecastIntensity?.regions ?? const [],
        ...?additionalRegions,
      ];
      return regions
          .groupListsBy((e) => e.code)
          .map(
            (key, values) => MapEntry(
              key,
              values.sortedBy<num>((e) => e.intensity.orderIndex).last,
            ),
          )
          .values
          .toList();
    }, [eew, additionalRegions]);

    final warningCodes = useMemoized(
      () => warningAreaSelector.selectPrefectureCodes(
        events: switch (eew) {
          final event? => [event],
          null => const <EewTelegramItem>[],
        },
      ),
      [warningAreaSelector, eew],
    );

    final enqueue = useMapOperationQueue();

    // 震度モード: 震度レベルごとに1レイヤー作成し、filter のみ更新する
    useEffect(() {
      if (styleController == null || displayMode != EewDisplayMode.intensity) {
        return null;
      }

      unawaited(
        enqueue(() async {
          await EewForecastRegionIntensityFilterUpdater.intensityLevels.map((
            intensity,
          ) {
            final color = colorModel.fromJmaIntensity(intensity).background;
            final codes = regionMaxIntensities
                .where((r) => r.intensity == intensity)
                .map((r) => r.code)
                .toList();
            return styleController.addLayer(
              FillStyleLayer(
                id: intensityFilterUpdater.detailLayerId(intensity),
                sourceId: _sourceId,
                sourceLayerId: _intensitySourceLayerId,
                filter: _areaFilterBuilder.build(codes),
                paint: {'fill-color': color.toHexString(), 'fill-opacity': 0.7},
              ),
              belowLayerId: BaseLayer.areaForecastLocalELine.name,
            );
          }).wait;
          await intensityFilterUpdater.update(
            styleController: styleController,
            regionMaxIntensities: regionMaxIntensities,
          );
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            for (final intensity
                in EewForecastRegionIntensityFilterUpdater.intensityLevels) {
              try {
                await styleController.removeLayer(
                  intensityFilterUpdater.detailLayerId(intensity),
                );
              } on Exception {
                // ignore
              }
            }
          }),
        );
      };
    }, [styleController, displayMode, colorModel]);

    // 震度モード: データ更新
    useEffect(() {
      if (styleController == null || displayMode != EewDisplayMode.intensity) {
        return null;
      }

      unawaited(
        enqueue(
          () => intensityFilterUpdater.update(
            styleController: styleController,
            regionMaxIntensities: regionMaxIntensities,
          ),
        ),
      );

      return null;
    }, [styleController, displayMode, regionMaxIntensities]);

    // 警報モード: fill + line の2レイヤー
    useEffect(() {
      if (styleController == null ||
          displayMode != EewDisplayMode.warning ||
          warningCodes.isEmpty) {
        return null;
      }

      final filter = <Object>[
        'in',
        ['get', 'code'],
        ['literal', warningCodes],
      ];

      unawaited(
        enqueue(() async {
          await styleController.addLayer(
            FillStyleLayer(
              id: _warningLayerId,
              sourceId: _sourceId,
              sourceLayerId: _warningSourceLayerId,
              filter: filter,
              paint: const {'fill-color': '#DD0000', 'fill-opacity': 1},
            ),
            belowLayerId: BaseLayer.areaForecastLocalEewLine.name,
          );
          await styleController.addLayer(
            LineStyleLayer(
              id: _warningLineLayerId,
              sourceId: _sourceId,
              sourceLayerId: _warningSourceLayerId,
              filter: filter,
              paint: {
                'line-color': isDarkMode ? '#FFFFFF' : '#222222',
                'line-width': 1,
              },
            ),
          );
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            try {
              await styleController.removeLayer(_warningLineLayerId);
            } on Exception {
              // ignore
            }
            try {
              await styleController.removeLayer(_warningLayerId);
            } on Exception {
              // ignore
            }
          }),
        );
      };
    }, [styleController, displayMode, warningCodes, isDarkMode]);

    return const SizedBox.shrink();
  }
}

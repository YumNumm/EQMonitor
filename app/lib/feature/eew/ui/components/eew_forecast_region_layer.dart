import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_display_mode.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_area_filter.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// EEW震度予報区域レイヤー
///
/// `displayMode` に応じて、府県予報区（areaForecastLocalE）を
/// 推計震度別 or 警報発表区域として塗りつぶす。
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
  static const _sourceLayerId = 'areaForecastLocalE';
  static const _warningLayerId = 'eew-details-warning-fill';
  static const _warningLineLayerId = 'eew-details-warning-line';

  static const List<JmaIntensity> _intensityLevels = [
    JmaIntensity.one,
    JmaIntensity.two,
    JmaIntensity.three,
    JmaIntensity.four,
    JmaIntensity.fiveLower,
    JmaIntensity.fiveUpper,
    JmaIntensity.sixLower,
    JmaIntensity.sixUpper,
    JmaIntensity.seven,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(intensityColorProvider);
    final isDarkMode = Theme.brightnessOf(context) == Brightness.dark;

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
              values
                  .sortedBy<num>((e) => e.intensity.orderIndex)
                  .last,
            ),
          )
          .values
          .toList();
    }, [eew, additionalRegions]);

    final warningCodes = useMemoized(() {
      final zones = eew?.warning?.regions ?? const [];
      return zones.where((z) => z.hadWarning).map((z) => z.code).toList();
    }, [eew]);

    final isIntensityInitialized = useRef(false);

    // 震度モード: 震度レベルごとに1レイヤー作成し、filter のみ更新する
    useEffect(
      () {
        if (styleController == null ||
            displayMode != EewDisplayMode.intensity) {
          return null;
        }

        unawaited(() async {
          await _intensityLevels.map((intensity) {
            final color = colorModel.fromJmaIntensity(intensity).background;
            final codes = regionMaxIntensities
                .where((r) => r.intensity == intensity)
                .map((r) => r.code)
                .toList();
            return styleController.addLayer(
              FillStyleLayer(
                id: intensity._detailLayerId,
                sourceId: _sourceId,
                sourceLayerId: _sourceLayerId,
                filter: buildEewAreaCodeFilter(codes),
                paint: {
                  'fill-color': color.toHexString(),
                  'fill-opacity': 0.7,
                },
              ),
              belowLayerId: BaseLayer.areaForecastLocalELine.name,
            );
          }).wait;
          isIntensityInitialized.value = true;
          await _updateIntensityFilters(
            styleController: styleController,
            regionMaxIntensities: regionMaxIntensities,
          );
        }());

        return () {
          isIntensityInitialized.value = false;
          unawaited(
            _intensityLevels.map((intensity) async {
              try {
                await styleController.removeLayer(
                  intensity._detailLayerId,
                );
              } on Exception {
                // ignore
              }
            }).wait,
          );
        };
      },
      [styleController, displayMode, colorModel],
    );

    // 震度モード: データ更新
    useEffect(
      () {
        if (styleController == null ||
            displayMode != EewDisplayMode.intensity ||
            !isIntensityInitialized.value) {
          return null;
        }

        unawaited(
          _updateIntensityFilters(
            styleController: styleController,
            regionMaxIntensities: regionMaxIntensities,
          ),
        );

        return null;
      },
      [styleController, displayMode, regionMaxIntensities],
    );

    final warningCleanupDone = useRef<Future<void>>(Future.value());

    // 警報モード: fill + line の2レイヤー
    useEffect(
      () {
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

        unawaited(() async {
          await warningCleanupDone.value;
          await styleController.addLayer(
            FillStyleLayer(
              id: _warningLayerId,
              sourceId: _sourceId,
              sourceLayerId: _sourceLayerId,
              filter: filter,
              paint: const {
                'fill-color': '#DD0000',
                'fill-opacity': 1,
              },
            ),
            belowLayerId: BaseLayer.areaForecastLocalELine.name,
          );
          await styleController.addLayer(
            LineStyleLayer(
              id: _warningLineLayerId,
              sourceId: _sourceId,
              sourceLayerId: _sourceLayerId,
              filter: filter,
              paint: {
                'line-color': isDarkMode ? '#FFFFFF' : '#222222',
                'line-width': 1,
              },
            ),
          );
        }());

        return () {
          warningCleanupDone.value = () async {
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
          }();
        };
      },
      [styleController, displayMode, warningCodes, isDarkMode],
    );

    return const SizedBox.shrink();
  }
}

Future<void> _updateIntensityFilters({
  required StyleController styleController,
  required List<EewForecastRegionInfo> regionMaxIntensities,
}) async {
  await EewForecastRegionLayer._intensityLevels.map((intensity) {
    final codes = regionMaxIntensities
        .where((r) => r.intensity == intensity)
        .map((r) => r.code)
        .toList();
    return styleController.updateFilter(
      id: intensity._detailLayerId,
      filter: buildEewAreaCodeFilter(codes),
    );
  }).wait;
}

extension on JmaIntensity {
  String get _detailLayerId => 'eew-details-intensity-fill-$name';
}

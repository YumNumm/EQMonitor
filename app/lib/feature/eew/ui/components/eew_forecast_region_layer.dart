import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_display_mode.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// EEW震度予報区域レイヤー
///
/// `displayMode` に応じて、府県地震予報区（areaForecastLocalEew）を
/// 予想震度別 or 警報発表区域として塗りつぶす。
class EewForecastRegionLayer extends HookConsumerWidget {
  const EewForecastRegionLayer({
    required this.eew,
    required this.displayMode,
    super.key,
  });

  final EewTelegramItem? eew;
  final EewDisplayMode displayMode;

  static const _sourceId = 'eqmonitor_map';
  static const _sourceLayerId = 'areaForecastLocalE';
  static const _intensityFillLayerId = 'eew-details-intensity-fill';
  static const _intensityLineLayerId = 'eew-details-intensity-line';
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

    // 震度別の match expression 用データを構築
    // code → 色 のマッピングを1つの match expression にまとめる
    final intensityData = useMemoized(() {
      final regions = eew?.forecastIntensity?.regions ?? const [];
      final maxByRegion = regions
          .groupListsBy((e) => e.code)
          .map(
            (key, values) => MapEntry(
              key,
              values.sortedBy((e) => e.intensity.orderIndex).last,
            ),
          )
          .values
          .toList();

      final matchEntries = <Object>[];
      final allCodes = <String>[];
      for (final intensity in _intensityLevels) {
        final codes = maxByRegion
            .where((r) => r.intensity == intensity)
            .map((r) => r.code)
            .toList();
        if (codes.isEmpty) {
          continue;
        }
        final color = colorModel.fromJmaIntensity(intensity).background;
        matchEntries
          ..add(codes.length == 1 ? codes.first : codes)
          ..add(color.toHexString());
        allCodes.addAll(codes);
      }
      return (matchEntries: matchEntries, allCodes: allCodes);
    }, [eew, colorModel]);

    final warningCodes = useMemoized(() {
      final zones = eew?.warning?.regions ?? const [];
      return zones.where((z) => z.hadWarning).map((z) => z.code).toList();
    }, [eew]);

    // 震度モード: fill + line の2レイヤーのみ
    // match expression で code → 色 を1レイヤーで表現
    useEffect(
      () {
        if (styleController == null ||
            displayMode != EewDisplayMode.intensity ||
            intensityData.allCodes.isEmpty) {
          return null;
        }

        var disposed = false;
        final fillColor = <Object>[
          'match',
          ['get', 'code'],
          ...intensityData.matchEntries,
          'transparent',
        ];
        final filter = <Object>[
          'in',
          ['get', 'code'],
          ['literal', intensityData.allCodes],
        ];

        unawaited(() async {
          if (disposed) {
            return;
          }
          await styleController.addLayer(
            FillStyleLayer(
              id: _intensityFillLayerId,
              sourceId: _sourceId,
              sourceLayerId: _sourceLayerId,
              filter: filter,
              paint: {
                'fill-color': fillColor,
                'fill-opacity': 0.7,
              },
            ),
          );
          if (disposed) {
            return;
          }
          await styleController.addLayer(
            LineStyleLayer(
              id: _intensityLineLayerId,
              sourceId: _sourceId,
              sourceLayerId: _sourceLayerId,
              filter: filter,
              paint: {
                'line-color': isDarkMode ? '#FFFFFF' : '#000000',
                'line-width': 1,
              },
            ),
          );
        }());

        return () {
          disposed = true;
          unawaited(() async {
            try {
              await styleController.removeLayer(_intensityLineLayerId);
            } on Exception {
              // ignore
            }
            try {
              await styleController.removeLayer(_intensityFillLayerId);
            } on Exception {
              // ignore
            }
          }());
        };
      },
      [styleController, displayMode, intensityData, isDarkMode],
    );

    // 警報モード: fill + line の2レイヤー
    useEffect(
      () {
        if (styleController == null ||
            displayMode != EewDisplayMode.warning ||
            warningCodes.isEmpty) {
          return null;
        }

        var disposed = false;
        final filter = <Object>[
          'in',
          ['get', 'code'],
          ['literal', warningCodes],
        ];

        unawaited(() async {
          if (disposed) {
            return;
          }
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
          if (disposed) {
            return;
          }
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
            aboveLayerId: _warningLayerId,
          );
        }());

        return () {
          disposed = true;
          unawaited(() async {
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
          }());
        };
      },
      [styleController, displayMode, warningCodes, isDarkMode],
    );

    return const SizedBox.shrink();
  }
}

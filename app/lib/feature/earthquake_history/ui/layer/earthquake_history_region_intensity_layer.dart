import 'dart:async';

import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の各地震度区域塗りつぶしレイヤー
///
/// ベクタータイルソース `japan` の `areaForecastLocalE` レイヤーを
/// 震度カラーで match 式により塗り分けます。
class EarthquakeHistoryRegionIntensityLayer extends HookConsumerWidget {
  const EarthquakeHistoryRegionIntensityLayer({
    required this.intensity,
    super.key,
  });

  final EarthquakeIntensity? intensity;

  static const _fillLayerId = 'eq-history-region-intensity-fill';
  static const _lineLayerId = 'eq-history-region-intensity-line';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(intensityColorProvider);

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          try {
            final fillColor = _buildFillColorExpression(intensity, colorModel);

            await styleController.addLayer(
              FillStyleLayer(
                id: _fillLayerId,
                sourceId: 'japan',
                sourceLayerId: 'areaForecastLocalE',
                paint: {
                  'fill-color': fillColor,
                  'fill-opacity': 0.6,
                },
              ),
            );

            await styleController.addLayer(
              const LineStyleLayer(
                id: _lineLayerId,
                sourceId: 'japan',
                sourceLayerId: 'areaForecastLocalE',
                paint: {
                  'line-color': '#ffffff',
                  'line-width': 0.5,
                  'line-opacity': 0.8,
                },
              ),
            );
          } on Exception catch (e) {
            talker.log(e);
          }
        }());

        return () async {
          try {
            await styleController.removeLayer(_lineLayerId);
            await styleController.removeLayer(_fillLayerId);
          } on Exception catch (e) {
            talker.log(e);
          }
        };
      },
      [styleController, intensity, colorModel],
    );

    return const SizedBox.shrink();
  }

  List<Object> _buildFillColorExpression(
    EarthquakeIntensity? intensity,
    IntensityColorModel colorModel,
  ) {
    final pairs = intensity?.forecastLocalEIntensityPairs ?? [];
    final args = <Object>[
      'match',
      <Object>['get', 'code'],
    ];

    for (final p in pairs) {
      args
        ..add(p.code)
        ..add(
          colorModel.fromJmaIntensity(p.intensity).background.toHexStringRGB(),
        );
    }

    // 震度なし区域は透明
    args.add('rgba(0,0,0,0)');
    return args;
  }
}

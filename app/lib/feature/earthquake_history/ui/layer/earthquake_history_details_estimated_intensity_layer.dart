import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/theme/model/estimated_intensity_colors.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の推計震度（PMTiles ラスタ）レイヤー
class EarthquakeHistoryDetailsEstimatedIntensityLayer
    extends HookConsumerWidget {
  const new({
    required this.tileUrl,
    super.key,
  });

  final String tileUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();
    final colors = ref.watch(
      activeColorSetProvider.select((colorSet) => colorSet.estimatedIntensity),
    );
    const style = EarthquakeHistoryEstimatedIntensityStyle();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      var disposed = false;

      unawaited(
        enqueue(
          () => style.replace(
            styleController: styleController,
            tileUrl: tileUrl,
            colors: colors,
            isDisposed: () => disposed,
          ),
        ),
      );

      return () {
        disposed = true;
        unawaited(
          enqueue(() => style.remove(styleController: styleController)),
        );
      };
    }, [styleController, tileUrl, colors]);

    return const SizedBox.shrink();
  }
}

class EarthquakeHistoryEstimatedIntensityStyle {
  const new();

  static const sourceId = 'earthquake-history-estimated-intensity';
  static const fillLayerId = 'earthquake-history-estimated-intensity-fill';
  static const lineLayerId = 'earthquake-history-estimated-intensity-line';

  /// タイル側の `name` 属性（`intensity:4` 〜 `intensity:7`）を
  /// テーマの推計震度色にマッピングする match 式。
  ///
  /// タイルの `fill` 属性は生成時の JMA 標準色が焼き込まれているため
  /// 使用せず、未知の階級のみタイル側の色にフォールバックする。
  List<Object> colorExpression({required EstimatedIntensityColors colors}) => [
    'match',
    ['get', 'name'],
    'intensity:4',
    colors.four.background.toHexStringRGB(),
    'intensity:5-',
    colors.fiveLower.background.toHexStringRGB(),
    'intensity:5+',
    colors.fiveUpper.background.toHexStringRGB(),
    'intensity:6-',
    colors.sixLower.background.toHexStringRGB(),
    'intensity:6+',
    colors.sixUpper.background.toHexStringRGB(),
    'intensity:7',
    colors.seven.background.toHexStringRGB(),
    ['get', 'fill'],
  ];

  Future<void> replace({
    required StyleController styleController,
    required String tileUrl,
    required EstimatedIntensityColors colors,
    required bool Function() isDisposed,
  }) async {
    await remove(styleController: styleController);
    if (isDisposed()) {
      return;
    }
    await styleController.addSource(
      VectorSource(id: sourceId, url: 'pmtiles://$tileUrl', volatile: true),
    );
    if (isDisposed()) {
      return;
    }
    final color = colorExpression(colors: colors);
    await MapStyleLayerReplacer.replace(
      styleController: styleController,
      layerIds: const [lineLayerId, fillLayerId],
      layers: [
        (
          layer: FillStyleLayer(
            id: fillLayerId,
            sourceId: sourceId,
            sourceLayerId: 'seismic_intensity',
            paint: {'fill-opacity': 1, 'fill-color': color},
          ),
          belowLayerId: BaseLayer.areaForecastLocalELine.name,
          aboveLayerId: null,
          atIndex: null,
        ),
        (
          layer: LineStyleLayer(
            id: lineLayerId,
            sourceId: sourceId,
            sourceLayerId: 'seismic_intensity',
            paint: {'line-opacity': 1, 'line-color': color, 'line-width': 0.5},
          ),
          belowLayerId: BaseLayer.areaForecastLocalELine.name,
          aboveLayerId: null,
          atIndex: null,
        ),
      ],
    );
  }

  Future<void> remove({required StyleController styleController}) =>
      MapStyleResourceRemover.remove(
        styleController: styleController,
        layerIds: const [lineLayerId, fillLayerId],
        sourceIds: const [sourceId],
      );
}

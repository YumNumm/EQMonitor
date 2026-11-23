import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/estimated_intensity_dem_color_resolver.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_dem_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_dem_palette.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_color_map.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

class const EarthquakeHistoryDetailsEstimatedIntensityDemLayer({
  required final String tileUrl,
  required final EstimatedIntensityDemDisplayMode displayMode,
  required final EstimatedIntensityDemPalette palette,
  super.key,
}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();
    final colors = ref.watch(
      activeColorSetProvider.select((colorSet) => colorSet.estimatedIntensity),
    );
    final kyoshinColorMap = ref.watch(kyoshinColorMapProvider);
    const style = EarthquakeHistoryEstimatedIntensityDemStyle();
    final color = useMemoized(
      () => style.colorExpression(
        resolver: EstimatedIntensityDemColorResolver(
          displayMode: displayMode,
          palette: palette,
          classColors: colors,
          kyoshinColorMap: kyoshinColorMap,
        ),
      ),
      [displayMode, palette, colors, kyoshinColorMap],
    );
    final colorRef = useRef(color)..value = color;
    final layerRef = useRef<ColorReliefStyleLayer?>(null);

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      var disposed = false;

      unawaited(
        enqueue(() async {
          final layer = await style.replace(
            styleController: styleController,
            tileUrl: tileUrl,
            color: () => colorRef.value,
            isDisposed: () => disposed,
          );
          if (!disposed) {
            layerRef.value = layer;
          }
        }),
      );

      return () {
        disposed = true;
        layerRef.value = null;
        unawaited(
          enqueue(() => style.remove(styleController: styleController)),
        );
      };
    }, [styleController, tileUrl, colorRef]);

    useEffect(() {
      unawaited(
        enqueue(() async {
          layerRef.value?.color = .raw(color);
        }),
      );
      return null;
    }, [color]);

    return const SizedBox.shrink();
  }
}

class const EarthquakeHistoryEstimatedIntensityDemStyle() {
  static const sourceId = 'earthquake-history-estimated-intensity-dem';
  static const layerId = 'earthquake-history-estimated-intensity-dem-color';
  static const tileSize = 512;
  static const maxZoom = 10.0;
  static const transparent = 'rgba(0, 0, 0, 0)';

  static const boundaryEpsilon = 0.001;

  // MapLibre Native の color-relief は DEM を線形補間で読み、nearest を指定できない。
  // 値の境界の両側に stop を置き、補間で生じる中間値が隣の色へにじむ幅を抑える。
  List<Object> colorExpression({
    required EstimatedIntensityDemColorResolver resolver,
  }) {
    final stops = <Object>[-10000, transparent];
    var previous = transparent;
    for (
      var tenths = EstimatedIntensityDemColorResolver.minTenths;
      tenths <= EstimatedIntensityDemColorResolver.maxTenths;
      tenths++
    ) {
      final color = resolver.resolve(tenths: tenths).toHexStringRGB();
      if (color == previous) {
        continue;
      }
      final boundary = (tenths - 0.5) / 10;
      stops
        ..add(boundary - boundaryEpsilon)
        ..add(previous)
        ..add(boundary)
        ..add(color);
      previous = color;
    }
    return [
      'interpolate',
      ['linear'],
      ['elevation'],
      ...stops,
    ];
  }

  Future<ColorReliefStyleLayer?> replace({
    required StyleController styleController,
    required String tileUrl,
    required List<Object> Function() color,
    required bool Function() isDisposed,
  }) async {
    await remove(styleController: styleController);
    if (isDisposed()) {
      return null;
    }
    await styleController.sources.add(
      RasterDemSource.url(
        id: sourceId,
        url: 'pmtiles://$tileUrl',
        tileSize: tileSize,
        maxZoom: maxZoom,
        volatile: true,
      ),
    );
    if (isDisposed()) {
      return null;
    }
    final layer = ColorReliefStyleLayer(
      id: layerId,
      sourceId: sourceId,
      opacity: const .literal(1),
      color: .raw(color()),
    );
    await MapStyleLayerReplacer.replace(
      styleController: styleController,
      layerIds: const [layerId],
      layers: [
        (layer: layer, belowLayerId: BaseLayer.areaForecastLocalELine.name),
      ],
    );
    return layer;
  }

  Future<void> remove({required StyleController styleController}) =>
      MapStyleResourceRemover.remove(
        styleController: styleController,
        layerIds: const [layerId],
        sourceIds: const [sourceId],
      );
}

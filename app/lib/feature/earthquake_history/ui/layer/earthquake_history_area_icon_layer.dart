import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_fill_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:eqmonitor/feature/map/features/icon/data/provider/intensity_icon_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

class const EarthquakeHistoryAreaIconLayer({
  required final Earthquake earthquake,
  required final EarthquakeHistoryMapLayerParameter parameter,
  required final double? stationMinZoom,
  final EarthquakeHistoryFillMode fillMode = EarthquakeHistoryFillMode.auto,
  final bool showingLpgmIntensity = false,
  super.key,
}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensity = earthquake.intensity;
    const modeResolver = EarthquakeHistoryMapLayerModeResolver();
    final mode = modeResolver.resolveFillLayerMode(
      earthquake: earthquake,
      fillMode: fillMode,
      showingLpgmIntensity: showingLpgmIntensity,
    );

    final hasStations = modeResolver
        .resolveAvailability(
          earthquake: earthquake,
          showingLpgmIntensity: showingLpgmIntensity,
        )
        .station;
    final hiddenFromZoom = hasStations ? stationMinZoom : null;

    final styleController = MapController.maybeOf(context)?.style;
    final iconData = ref.watch(intensityIconProvider).value;
    final enqueue = useMapOperationQueue();
    final layerBuilder = useMemoized(
      () => const EarthquakeHistoryAreaIconLayerBuilder(
        modeResolver: modeResolver,
        fillLayerBuilder: EarthquakeHistoryFillLayerBuilder(
          modeResolver: modeResolver,
        ),
      ),
    );

    useEffect(
      () {
        if (styleController == null || intensity == null || iconData == null) {
          return null;
        }
        var disposed = false;
        final layerIds = <String>[];

        unawaited(
          enqueue(() async {
            try {
              if (disposed) {
                return;
              }
              await styleController.addImages(iconData.toMapStyleImages);
              for (final layer in layerBuilder.build(
                intensity: intensity,
                mode: mode,
                showingLpgmIntensity: showingLpgmIntensity,
                parameter: parameter,
                stationMinZoom: hiddenFromZoom,
              )) {
                if (disposed) {
                  return;
                }
                await styleController.layers.add(
                  layer,
                  belowLayerId: BaseLayer.areaIconAnchor.name,
                );
                layerIds.add(layer.id);
              }
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );

        return () {
          disposed = true;
          unawaited(
            enqueue(() async {
              for (final id in layerIds.reversed) {
                try {
                  await styleController.layers.remove(id);
                } on Exception catch (e) {
                  talker.log(e);
                }
              }
              layerIds.clear();
            }),
          );
        };
      },
      [
        styleController,
        intensity,
        iconData,
        mode,
        showingLpgmIntensity,
        parameter,
        hiddenFromZoom,
        layerBuilder,
        enqueue,
      ],
    );

    return const SizedBox.shrink();
  }
}

class const EarthquakeHistoryAreaIconLayerBuilder({
  required final EarthquakeHistoryMapLayerModeResolver modeResolver,
  required final EarthquakeHistoryFillLayerBuilder fillLayerBuilder,
}) {
  static const sourceId = 'eqmonitor_map';
  static const regionSourceLayerId = 'areaForecastLocalELabel';
  static const citySourceLayerId = 'areaInformationCityQuakeLabel';

  List<StyleLayer> build({
    required EarthquakeIntensity intensity,
    required EarthquakeHistoryMapLayerMode mode,
    required bool showingLpgmIntensity,
    required EarthquakeHistoryMapLayerParameter parameter,
    required double? stationMinZoom,
  }) {
    final regionZoom = modeResolver.regionIconZoomRange(
      mode: mode,
      regionToCity: parameter.regionToCity,
      stationMinZoom: stationMinZoom,
    );
    final cityZoom = modeResolver.cityIconZoomRange(
      mode: mode,
      regionToCity: parameter.regionToCity,
      stationMinZoom: stationMinZoom,
    );
    final levels = showingLpgmIntensity
        ? [
            for (final level in fillLayerBuilder.sortedLpgmLevels(intensity))
              (
                idPrefix: 'eq-history-lpgm-${level.name}',
                imageId:
                    'JmaLpgmIntensity.${IntensityIconType.filled.name}.${level.name}',
                regionCodes: fillLayerBuilder.lpgmRegionCodes(intensity, level),
                cityCodes: fillLayerBuilder.lpgmCityCodes(intensity, level),
              ),
          ]
        : [
            for (final level in fillLayerBuilder.sortedJmaLevels(intensity))
              (
                idPrefix: 'eq-history-jma-${level.name}',
                imageId:
                    'JmaIntensity.${IntensityIconType.filled.name}.${level.name}',
                regionCodes: fillLayerBuilder.jmaRegionCodes(intensity, level),
                cityCodes: fillLayerBuilder.jmaCityCodes(intensity, level),
              ),
          ];

    // 衝突時は上の layer が優先して配置されるため、震度の小さい順に積む。
    return [
      if (regionZoom != null)
        for (final level in levels)
          if (level.regionCodes.isNotEmpty)
            buildIconLayer(
              id: '${level.idPrefix}-region-icon',
              sourceLayerId: regionSourceLayerId,
              filter: fillLayerBuilder.regionCodeFilter(level.regionCodes),
              imageId: level.imageId,
              zoom: regionZoom,
              parameter: parameter,
            ),
      if (cityZoom != null)
        for (final level in levels)
          if (level.cityCodes.isNotEmpty)
            buildIconLayer(
              id: '${level.idPrefix}-city-icon',
              sourceLayerId: citySourceLayerId,
              filter: fillLayerBuilder.cityCodeFilter(level.cityCodes),
              imageId: level.imageId,
              zoom: cityZoom,
              parameter: parameter,
            ),
    ];
  }

  SymbolStyleLayer buildIconLayer({
    required String id,
    required String sourceLayerId,
    required List<Object> filter,
    required String imageId,
    required ({double min, double max}) zoom,
    required EarthquakeHistoryMapLayerParameter parameter,
  }) => SymbolStyleLayer(
    id: id,
    sourceId: sourceId,
    sourceLayerId: sourceLayerId,
    filter: .raw(filter),
    minZoom: zoom.min,
    maxZoom: zoom.max,
    iconImage: .literal(imageId),
    iconSize: .literal(parameter.areaIconSize),
    iconAllowOverlap: const .literal(false),
    iconPadding: const .literal([0]),
  );
}

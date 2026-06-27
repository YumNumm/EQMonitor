import 'dart:async';

import 'package:eqmonitor/feature/home/data/model/home_map_label_parameter.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_map_label_parameter_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class HomeMapLabelLayer extends HookConsumerWidget {
  const HomeMapLabelLayer({super.key});

  static const _regionLabelLayerId = 'home-map-region-label';
  static const _cityLabelLayerId = 'home-map-city-label';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final paramAsync = ref.watch(homeMapLabelParameterProvider);
    final param = paramAsync.value ?? const HomeMapLabelParameter();

    final isInitialized = useRef(false);
    final latestParam = useRef(param);
    latestParam.value = param;

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          await _addLayers(
            styleController: styleController,
            param: latestParam.value,
          );
          isInitialized.value = true;
        }());

        return () async {
          for (final id in [_regionLabelLayerId, _cityLabelLayerId]) {
            try {
              await styleController.removeLayer(id);
            } on Exception catch (_) {}
          }
        };
      },
      [styleController],
    );

    useEffect(
      () {
        if (styleController == null || !isInitialized.value) {
          return null;
        }
        unawaited(_updateLayers(
          styleController: styleController,
          param: param,
        ));
        return null;
      },
      [styleController, param],
    );

    return const SizedBox.shrink();
  }

  static Future<void> _addLayers({
    required StyleController styleController,
    required HomeMapLabelParameter param,
  }) async {
    if (param.showRegionLabel) {
      await styleController.addLayer(
        SymbolStyleLayer(
          id: _regionLabelLayerId,
          sourceId: 'eqmonitor_map',
          sourceLayerId: 'areaForecastLocalE',
          minZoom: param.regionLabelMinZoom,
          layout: {
            'text-field': ['get', 'name'],
            'text-size': param.regionTextSize,
            'text-font': ['Noto Sans CJK JP Bold'],
            'text-allow-overlap': false,
            'text-ignore-placement': false,
          },
          paint: {
            'text-color': '#ffffff',
            'text-halo-color': '#000000',
            'text-halo-width': param.textHaloWidth,
          },
        ),
      );
    }

    if (param.showCityLabel) {
      await styleController.addLayer(
        SymbolStyleLayer(
          id: _cityLabelLayerId,
          sourceId: 'eqmonitor_map',
          sourceLayerId: 'areaInformationCityQuake',
          minZoom: param.cityLabelMinZoom,
          layout: {
            'text-field': ['get', 'name'],
            'text-size': param.cityTextSize,
            'text-font': ['Noto Sans CJK JP Regular'],
            'text-allow-overlap': false,
            'text-ignore-placement': false,
          },
          paint: {
            'text-color': '#ffffff',
            'text-halo-color': '#000000',
            'text-halo-width': param.textHaloWidth,
          },
        ),
      );
    }
  }

  static Future<void> _updateLayers({
    required StyleController styleController,
    required HomeMapLabelParameter param,
  }) async {
    for (final id in [_regionLabelLayerId, _cityLabelLayerId]) {
      try {
        await styleController.removeLayer(id);
      } on Exception catch (_) {}
    }
    await _addLayers(styleController: styleController, param: param);
  }
}

import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewEstimatedIntensityLayer extends HookConsumerWidget {
  const EewEstimatedIntensityLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final intensityData = ref.watch(estimatedIntensityProvider);
    final colorModel = ref.watch(intensityColorProvider);

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(_initializeLayers(styleController, colorModel));

        return () => _cleanupLayers(styleController);
      },
      [styleController],
    );

    useEffect(
      () {
        if (styleController == null || intensityData.value == null) {
          return null;
        }

        unawaited(
          _updateLayers(styleController, intensityData.value!, colorModel),
        );

        return null;
      },
      [styleController, intensityData, colorModel],
    );

    return const SizedBox.shrink();
  }

  Future<void> _initializeLayers(
    StyleController style,
    IntensityColorModel intensityColorModel,
  ) async {
    for (final intensity in JmaForecastIntensity.values) {
      final layerId = _getLayerId(intensity);
      final color = intensityColorModel
          .fromJmaForecastIntensity(intensity)
          .background;

      await style.addLayer(
        FillStyleLayer(
          id: layerId,
          sourceId: 'eqmonitor_map',
          paint: {
            'fill-color': _colorToHex(color),
            'fill-opacity': 0.5,
          },
        ),
      );
    }
  }

  Future<void> _updateLayers(
    StyleController style,
    List<EstimatedIntensityPoint> points,
    IntensityColorModel intensityColorModel,
  ) async {
    for (final intensity in JmaForecastIntensity.values) {
      final layerId = _getLayerId(intensity);

      await style.removeLayer(layerId);

      final color = intensityColorModel
          .fromJmaForecastIntensity(intensity)
          .background;

      await style.addLayer(
        FillStyleLayer(
          id: layerId,
          sourceId: 'eqmonitor_map',
          paint: {
            'fill-color': _colorToHex(color),
            'fill-opacity': 0.5,
          },
        ),
      );
    }
  }

  String _getLayerId(JmaForecastIntensity intensity) {
    final base = intensity.type
        .replaceAll('-', 'low')
        .replaceAll('+', 'high')
        .replaceAll('不明', 'unknown');
    return 'eew-estimated-intensity-fill-$base';
  }

  String _colorToHex(Color color) {
    final r = (color.r * 255).round();
    final g = (color.g * 255).round();
    final b = (color.b * 255).round();
    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  Future<void> _cleanupLayers(StyleController style) async {
    for (final intensity in JmaForecastIntensity.values) {
      await style.removeLayer(_getLayerId(intensity));
    }
  }
}

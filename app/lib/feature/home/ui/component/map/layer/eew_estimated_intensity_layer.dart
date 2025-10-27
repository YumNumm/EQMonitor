import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
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

        _initializeLayers(styleController, colorModel);

        return () => _cleanupLayers(styleController);
      },
      [styleController],
    );

    useEffect(
      () {
        if (styleController == null || intensityData.value == null) {
          return null;
        }

        _updateLayers(styleController, intensityData.value!, colorModel);

        return null;
      },
      [styleController, intensityData, colorModel],
    );

    return const SizedBox.shrink();
  }

  Future<void> _initializeLayers(
    StyleController style,
    dynamic intensityColorModel,
  ) async {
    for (final intensity in JmaForecastIntensity.values) {
      final layerId = _getLayerId(intensity);
      final color = intensityColorModel
          .fromJmaForecastIntensity(intensity)
          .background as Color;

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
    dynamic intensityColorModel,
  ) async {
    final grouped = _groupByRegionCode(points);

    for (final intensity in JmaForecastIntensity.values) {
      final layerId = _getLayerId(intensity);

      await style.removeLayer(layerId);

      final color = intensityColorModel
          .fromJmaForecastIntensity(intensity)
          .background as Color;

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

  Map<JmaForecastIntensity, List<String>> _groupByRegionCode(
    List<EstimatedIntensityPoint> points,
  ) {
    final regionsGrouped = points.groupListsBy((e) => e.regionCode);

    final regionsIntensityMax = <String, JmaForecastIntensity>{};

    for (final entry in regionsGrouped.entries) {
      final intensities = entry.value
          .map((e) => _intensityToForecastIntensity(e.intensity))
          .whereType<JmaForecastIntensity>()
          .toList();

      if (intensities.isEmpty) {
        continue;
      }

      final maxIntensity = intensities.reduce(
        (value, element) => _compareIntensity(value, element) >= 0 ? value : element,
      );
      regionsIntensityMax[entry.key] = maxIntensity;
    }

    final result = <JmaForecastIntensity, List<String>>{};
    for (final entry in regionsIntensityMax.entries) {
      final intensity = entry.value;
      result.putIfAbsent(intensity, () => []).add(entry.key);
    }

    return result;
  }

  JmaForecastIntensity? _intensityToForecastIntensity(double intensity) {
    if (intensity < 0.5) {
      return JmaForecastIntensity.zero;
    } else if (intensity < 1.5) {
      return JmaForecastIntensity.one;
    } else if (intensity < 2.5) {
      return JmaForecastIntensity.two;
    } else if (intensity < 3.5) {
      return JmaForecastIntensity.three;
    } else if (intensity < 4.5) {
      return JmaForecastIntensity.four;
    } else if (intensity < 5.0) {
      return JmaForecastIntensity.fiveLower;
    } else if (intensity < 5.5) {
      return JmaForecastIntensity.fiveUpper;
    } else if (intensity < 6.0) {
      return JmaForecastIntensity.sixLower;
    } else if (intensity < 6.5) {
      return JmaForecastIntensity.sixUpper;
    } else {
      return JmaForecastIntensity.seven;
    }
  }

  int _compareIntensity(
    JmaForecastIntensity a,
    JmaForecastIntensity b,
  ) {
    final order = [
      JmaForecastIntensity.zero,
      JmaForecastIntensity.one,
      JmaForecastIntensity.two,
      JmaForecastIntensity.three,
      JmaForecastIntensity.four,
      JmaForecastIntensity.fiveLower,
      JmaForecastIntensity.fiveUpper,
      JmaForecastIntensity.sixLower,
      JmaForecastIntensity.sixUpper,
      JmaForecastIntensity.seven,
    ];
    return order.indexOf(a).compareTo(order.indexOf(b));
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
    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'.toUpperCase();
  }

  Future<void> _cleanupLayers(StyleController style) async {
    for (final intensity in JmaForecastIntensity.values) {
      await style.removeLayer(_getLayerId(intensity));
    }
  }
}


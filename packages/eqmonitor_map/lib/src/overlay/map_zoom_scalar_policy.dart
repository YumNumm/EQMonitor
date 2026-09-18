import 'package:flutter/foundation.dart';

/// A clamped linear size scale over one zoom interval.
@immutable
final class MapZoomLinearRange {
  const MapZoomLinearRange._({
    required this.startZoom,
    required this.startValue,
    required this.endZoom,
    required this.endValue,
  });

  final double startZoom;
  final double startValue;
  final double endZoom;
  final double endValue;

  double valueAt({required double zoom}) {
    if (!zoom.isFinite) {
      throw ArgumentError.value(zoom, 'zoom', 'must be finite');
    }
    if (zoom <= startZoom) {
      return startValue;
    }
    if (zoom >= endZoom) {
      return endValue;
    }
    final progress = (zoom - startZoom) / (endZoom - startZoom);
    return startValue + (endValue - startValue) * progress;
  }

  @override
  bool operator ==(Object other) =>
      other is MapZoomLinearRange &&
      other.startZoom == startZoom &&
      other.startValue == startValue &&
      other.endZoom == endZoom &&
      other.endValue == endValue;

  @override
  int get hashCode => Object.hash(startZoom, startValue, endZoom, endValue);
}

/// A zoom-threshold opacity step using the MapLibre boundary convention.
@immutable
final class MapZoomStep {
  const MapZoomStep._({
    required this.thresholdZoom,
    required this.belowValue,
    required this.atOrAboveValue,
  });

  final double thresholdZoom;
  final double belowValue;
  final double atOrAboveValue;

  double valueAt({required double zoom}) {
    if (!zoom.isFinite) {
      throw ArgumentError.value(zoom, 'zoom', 'must be finite');
    }
    return zoom < thresholdZoom ? belowValue : atOrAboveValue;
  }

  @override
  bool operator ==(Object other) =>
      other is MapZoomStep &&
      other.thresholdZoom == thresholdZoom &&
      other.belowValue == belowValue &&
      other.atOrAboveValue == atOrAboveValue;

  @override
  int get hashCode => Object.hash(thresholdZoom, belowValue, atOrAboveValue);
}

MapZoomLinearRange createMapZoomLinearRange({
  required double startZoom,
  required double startValue,
  required double endZoom,
  required double endValue,
}) {
  final values = [startZoom, startValue, endZoom, endValue];
  if (values.any((value) => !value.isFinite)) {
    throw ArgumentError.value(values, 'linearRange', 'must be finite');
  }
  if (startZoom >= endZoom) {
    throw ArgumentError.value(startZoom, 'startZoom', 'must be below endZoom');
  }
  if (startValue <= 0 || endValue <= 0) {
    throw ArgumentError.value(
      [startValue, endValue],
      'linearRange.values',
      'must be positive',
    );
  }
  return MapZoomLinearRange._(
    startZoom: startZoom,
    startValue: startValue,
    endZoom: endZoom,
    endValue: endValue,
  );
}

MapZoomStep createMapZoomStep({
  required double thresholdZoom,
  required double belowValue,
  required double atOrAboveValue,
}) {
  final values = [thresholdZoom, belowValue, atOrAboveValue];
  if (values.any((value) => !value.isFinite)) {
    throw ArgumentError.value(values, 'step', 'must be finite');
  }
  if (belowValue < 0 ||
      belowValue > 1 ||
      atOrAboveValue < 0 ||
      atOrAboveValue > 1) {
    throw ArgumentError.value(
      [belowValue, atOrAboveValue],
      'step.values',
      'must be in the closed unit interval',
    );
  }
  return MapZoomStep._(
    thresholdZoom: thresholdZoom,
    belowValue: belowValue,
    atOrAboveValue: atOrAboveValue,
  );
}

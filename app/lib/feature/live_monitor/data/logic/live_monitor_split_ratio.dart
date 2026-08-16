import 'package:flutter/widgets.dart';

typedef LiveMonitorSplitViewportEnvironment = ({
  Size screenSize,
  EdgeInsets viewPadding,
  EdgeInsets viewInsets,
  Orientation orientation,
});

typedef LiveMonitorSplitViewportMeasurement = ({
  Offset globalOrigin,
  Size viewportSize,
  Size screenSize,
  EdgeInsets viewPadding,
  EdgeInsets viewInsets,
  Orientation orientation,
});

class LiveMonitorSplitRatioCalculator {
  const LiveMonitorSplitRatioCalculator();

  double updateRatio({
    required double current,
    required double primaryDelta,
    required double availableExtent,
  }) {
    if (availableExtent <= 0) {
      return current.clamp(0.2, 0.8);
    }
    return (current + primaryDelta / availableExtent).clamp(0.2, 0.8);
  }

  Rect? displayFeatureLocalBounds({
    required Rect screenBounds,
    required Offset splitViewGlobalOrigin,
    required Size splitViewSize,
  }) {
    if (splitViewSize.width <= 0 || splitViewSize.height <= 0) {
      return null;
    }
    final localBounds = screenBounds.shift(
      Offset(-splitViewGlobalOrigin.dx, -splitViewGlobalOrigin.dy),
    );
    if (localBounds.right <= 0 ||
        localBounds.left >= splitViewSize.width ||
        localBounds.bottom <= 0 ||
        localBounds.top >= splitViewSize.height) {
      return null;
    }
    return Rect.fromLTRB(
      localBounds.left.clamp(0, splitViewSize.width).toDouble(),
      localBounds.top.clamp(0, splitViewSize.height).toDouble(),
      localBounds.right.clamp(0, splitViewSize.width).toDouble(),
      localBounds.bottom.clamp(0, splitViewSize.height).toDouble(),
    );
  }

  bool isMeasurementCurrent({
    required Size measuredViewportSize,
    required Size currentViewportSize,
  }) => measuredViewportSize == currentViewportSize;

  bool shouldReportMeasurement({
    required LiveMonitorSplitViewportMeasurement? previous,
    required LiveMonitorSplitViewportMeasurement current,
  }) => previous != current;
}

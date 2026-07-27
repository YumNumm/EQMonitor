import 'dart:ui';

double updateLiveMonitorSplitRatio({
  required double current,
  required double primaryDelta,
  required double availableExtent,
}) {
  if (availableExtent <= 0) {
    return current.clamp(0.2, 0.8);
  }
  return (current + primaryDelta / availableExtent).clamp(0.2, 0.8);
}

Rect? liveMonitorDisplayFeatureLocalBounds({
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

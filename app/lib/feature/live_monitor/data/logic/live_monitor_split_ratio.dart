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

class ChuckBuildModePolicy {
  const new({required bool isDebugMode})
    : captureTraffic = true,
      showInspector = true,
      showNotification = isDebugMode;

  final bool captureTraffic;
  final bool showInspector;
  final bool showNotification;
}

enum LiveMonitorExitRequestSource { panel, systemBack }

bool shouldContinueLiveMonitorExit({
  required LiveMonitorExitRequestSource source,
  required bool isPanelOpen,
}) => source == .systemBack || isPanelOpen;

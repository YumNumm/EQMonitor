enum LiveMonitorExitRequestSource { panel, systemBack }

enum LiveMonitorExitDraftDecision { continueExit, confirmDiscard, cancel }

class LiveMonitorExitPolicy {
  const LiveMonitorExitPolicy();

  bool shouldContinueExit({
    required LiveMonitorExitRequestSource source,
    required bool isPanelOpen,
  }) => source == .systemBack || isPanelOpen;

  LiveMonitorExitDraftDecision resolveExitDraft({
    required bool didCommit,
    required String? exitingRaw,
    required int? exitingRevision,
    required String? currentRaw,
    required int? currentRevision,
  }) {
    if (exitingRaw == null || currentRaw == null) {
      return .continueExit;
    }
    if (currentRaw != exitingRaw || currentRevision != exitingRevision) {
      return .cancel;
    }
    return didCommit ? .cancel : .confirmDiscard;
  }
}

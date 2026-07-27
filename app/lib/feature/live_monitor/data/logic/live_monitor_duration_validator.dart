enum LiveMonitorDurationValidationError { empty, notInteger, outOfRange }

typedef LiveMonitorDurationValidation = ({
  int? seconds,
  LiveMonitorDurationValidationError? error,
});

LiveMonitorDurationValidation validateLiveMonitorDuration(String raw) {
  if (raw.isEmpty) {
    return (seconds: null, error: .empty);
  }
  final seconds = int.tryParse(raw);
  if (seconds == null) {
    return (seconds: null, error: .notInteger);
  }
  if (seconds < 3 || seconds > 300) {
    return (seconds: null, error: .outOfRange);
  }
  return (seconds: seconds, error: null);
}

bool shouldApplyCommittedLiveMonitorDuration({
  required bool didCommit,
  required bool hasFocus,
  required String currentRaw,
  required int? currentRevision,
  required String committedRaw,
  required int? committedRevision,
}) =>
    didCommit &&
    !hasFocus &&
    isCurrentLiveMonitorDurationGeneration(
      currentRaw: currentRaw,
      currentRevision: currentRevision,
      committedRaw: committedRaw,
      committedRevision: committedRevision,
    );

bool shouldClearLiveMonitorDurationDraft({
  required bool didCommit,
  required String? currentRaw,
  required int? currentRevision,
  required String committedRaw,
  required int? committedRevision,
}) =>
    didCommit &&
    committedRevision != null &&
    isCurrentLiveMonitorDurationGeneration(
      currentRaw: currentRaw,
      currentRevision: currentRevision,
      committedRaw: committedRaw,
      committedRevision: committedRevision,
    );

bool isCurrentLiveMonitorDurationGeneration({
  required String? currentRaw,
  required int? currentRevision,
  required String committedRaw,
  required int? committedRevision,
}) => currentRaw == committedRaw && currentRevision == committedRevision;

enum LiveMonitorDurationValidationError { empty, notInteger, outOfRange }

typedef LiveMonitorDurationValidation = ({
  int? seconds,
  LiveMonitorDurationValidationError? error,
});

class LiveMonitorDurationValidator {
  const LiveMonitorDurationValidator();

  LiveMonitorDurationValidation validate(String raw) {
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

  bool shouldApplyCommitted({
    required bool didCommit,
    required bool hasFocus,
    required String currentRaw,
    required int? currentRevision,
    required String committedRaw,
    required int? committedRevision,
  }) =>
      didCommit &&
      !hasFocus &&
      isCurrentGeneration(
        currentRaw: currentRaw,
        currentRevision: currentRevision,
        committedRaw: committedRaw,
        committedRevision: committedRevision,
      );

  bool shouldClearDraft({
    required bool didCommit,
    required String? currentRaw,
    required int? currentRevision,
    required String committedRaw,
    required int? committedRevision,
  }) =>
      didCommit &&
      committedRevision != null &&
      isCurrentGeneration(
        currentRaw: currentRaw,
        currentRevision: currentRevision,
        committedRaw: committedRaw,
        committedRevision: committedRevision,
      );

  bool isCurrentGeneration({
    required String? currentRaw,
    required int? currentRevision,
    required String committedRaw,
    required int? committedRevision,
  }) => currentRaw == committedRaw && currentRevision == committedRevision;
}

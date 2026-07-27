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
  required bool hasFocus,
  required String currentRaw,
  required String committedRaw,
}) => !hasFocus && currentRaw == committedRaw;

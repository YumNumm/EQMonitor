enum EstimatedIntensityArchiveCleanupDiagnostic {
  bodyCancellationFailed,
  partWriterCloseFailed,
  hashStreamCancellationFailed,
  guardCloseFailed,
  httpAbortFailed,
  stagingDirectoryDeleteFailed,
  httpCloseFailed,
}

typedef EstimatedIntensityArchiveDiagnosticReporter = void Function(
  EstimatedIntensityArchiveCleanupDiagnostic diagnostic,
);

void ignoreEstimatedIntensityArchiveDiagnostic(
  EstimatedIntensityArchiveCleanupDiagnostic diagnostic,
) {}

/// Reporter failureもdownload resultを変更しない。
void reportEstimatedIntensityArchiveDiagnostic({
  required EstimatedIntensityArchiveDiagnosticReporter reporter,
  required EstimatedIntensityArchiveCleanupDiagnostic diagnostic,
}) {
  try {
    reporter(diagnostic);
  } catch (_) {}
}

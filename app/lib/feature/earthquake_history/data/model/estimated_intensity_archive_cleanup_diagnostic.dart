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

abstract final class EstimatedIntensityArchiveDiagnostics {
  static void ignore(EstimatedIntensityArchiveCleanupDiagnostic diagnostic) {}

  /// Reporter failureもdownload resultを変更しない。
  static void report({
    required EstimatedIntensityArchiveDiagnosticReporter reporter,
    required EstimatedIntensityArchiveCleanupDiagnostic diagnostic,
  }) {
    try {
      reporter(diagnostic);
    } catch (_) {}
  }
}

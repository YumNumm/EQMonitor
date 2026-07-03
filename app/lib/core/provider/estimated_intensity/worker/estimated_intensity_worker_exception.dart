final class EstimatedIntensityWorkerException implements Exception {
  const EstimatedIntensityWorkerException(this.message, [this.stackTrace]);

  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() => message;
}

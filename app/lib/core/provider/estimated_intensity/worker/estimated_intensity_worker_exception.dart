final class const EstimatedIntensityWorkerException(
  final String message, [
  final StackTrace? stackTrace,
]) implements Exception {
  @override
  String toString() => message;
}

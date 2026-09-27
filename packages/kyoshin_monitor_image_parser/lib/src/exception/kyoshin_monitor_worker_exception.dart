final class const KyoshinMonitorWorkerException(
  final String message, [
  final StackTrace? stackTrace,
]) implements Exception {
  @override
  String toString() => message;
}

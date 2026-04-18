final class KyoshinMonitorWorkerException implements Exception {
  const KyoshinMonitorWorkerException(this.message, [this.stackTrace]);

  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() => message;
}

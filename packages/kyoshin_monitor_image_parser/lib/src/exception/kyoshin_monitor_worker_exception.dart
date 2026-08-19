final class KyoshinMonitorWorkerException implements Exception {
  const new(this.message, [this.stackTrace]);

  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() => message;
}

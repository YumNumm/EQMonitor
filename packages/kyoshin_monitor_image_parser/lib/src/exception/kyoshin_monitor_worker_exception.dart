final class const KyoshinMonitorWorkerException(
  final String message, [
  final StackTrace? stackTrace,
]) implements Exception {
  @override
  String toString() => message;
}

/// 解析用 Isolate が終了しており、以後の解析要求に応答できないことを表す。
///
/// 呼び出し側は Isolate を起動し直す必要がある。
final class const KyoshinMonitorWorkerExitedException() implements Exception {
  @override
  String toString() => 'kyoshin_monitor_analyzer isolate exited';
}

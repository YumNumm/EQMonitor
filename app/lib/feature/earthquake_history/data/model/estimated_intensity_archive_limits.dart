import 'dart:async';

/// Archive取得時のcaller-owned上限。安全上の既定値は持たない。
final class EstimatedIntensityArchiveDownloadLimits {
  new({
    required this.maxArchiveBytes,
    required this.connectTimeout,
    required this.headerTimeout,
    required this.idleTimeout,
    required this.totalTimeout,
  }) {
    if (maxArchiveBytes <= 0) {
      throw ArgumentError.value(maxArchiveBytes, 'maxArchiveBytes');
    }
    for (final timeout in {
      'connectTimeout': connectTimeout,
      'headerTimeout': headerTimeout,
      'idleTimeout': idleTimeout,
      'totalTimeout': totalTimeout,
    }.entries) {
      if (timeout.value <= Duration.zero) {
        throw ArgumentError.value(timeout.value, timeout.key);
      }
    }
  }

  final int maxArchiveBytes;
  final Duration connectTimeout;
  final Duration headerTimeout;
  final Duration idleTimeout;
  final Duration totalTimeout;
}

/// Lifecycle ownerが一回のdownload停止を通知するためのsignal。
final class EstimatedIntensityArchiveDownloadCancellation {
  final StreamController<void> _controller = StreamController<void>.broadcast(
    sync: true,
  );
  var _isCancelled = false;

  bool get isCancelled => _isCancelled;

  Stream<void> get onCancel => _controller.stream;

  Future<void> cancel() async {
    if (!_isCancelled) {
      _isCancelled = true;
      _controller.add(null);
      await _controller.close();
    }
  }
}

import 'dart:async';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_operation.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_stop_reason.dart';

/// 一回のHTTP操作にcancel/total timeoutを結び付けるlifecycle owner。
final class EstimatedIntensityArchiveDownloadGuard {
  new({
    required this.operation,
    required Duration totalTimeout,
    EstimatedIntensityArchiveDownloadCancellation? cancellation,
  }) : cancelled = cancellation?.isCancelled ?? false {
    cancellationSubscription = cancellation?.onCancel.listen((_) {
      cancelled = true;
      if (!_stopRequested.isCompleted) {
        _stopRequested.complete(.cancelled);
      }
      operation.abort();
    });
    if (cancellation?.isCancelled ?? false) {
      cancelled = true;
      _stopRequested.complete(.cancelled);
      operation.abort();
    }
    totalTimer = Timer(totalTimeout, () {
      timedOut = true;
      if (!_stopRequested.isCompleted) {
        _stopRequested.complete(.timeout);
      }
      operation.abort();
    });
  }

  final EstimatedIntensityArchiveHttpOperation operation;
  late final Timer totalTimer;
  final Completer<EstimatedIntensityArchiveStopReason> _stopRequested =
      Completer<EstimatedIntensityArchiveStopReason>();
  StreamSubscription<void>? cancellationSubscription;
  bool cancelled;
  var timedOut = false;

  EstimatedIntensityArchiveStopReason get stopReason => cancelled
      ? EstimatedIntensityArchiveStopReason.cancelled
      : timedOut
      ? EstimatedIntensityArchiveStopReason.timeout
      : EstimatedIntensityArchiveStopReason.none;

  Future<EstimatedIntensityArchiveStopReason> get stopRequested =>
      _stopRequested.future;

  /// 停止時はpending I/Oの収束後にだけ呼出元へ戻す。
  ///
  /// [abort]はHTTPなど安全に中断できるI/Oにのみ指定する。
  Future<T> settle<T>({
    required Future<T> pending,
    Future<void> Function()? abort,
  }) async {
    if (stopReason != EstimatedIntensityArchiveStopReason.none) {
      try {
        await abort?.call();
      } catch (_) {}
      try {
        await pending;
      } catch (_) {}
      throw EstimatedIntensityArchiveStoppedException(stopReason);
    }
    try {
      return await Future.any([
        pending,
        stopRequested.then<T>(
          (reason) => throw EstimatedIntensityArchiveStoppedException(reason),
        ),
      ]);
    } on EstimatedIntensityArchiveStoppedException {
      try {
        await abort?.call();
      } catch (_) {}
      try {
        await pending;
      } catch (_) {}
      rethrow;
    }
  }

  Future<void> close() async {
    totalTimer.cancel();
    await cancellationSubscription?.cancel();
  }
}

final class EstimatedIntensityArchiveStoppedException implements Exception {
  const new(this.reason);

  final EstimatedIntensityArchiveStopReason reason;
}

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
      operation.abort();
    });
    if (cancellation?.isCancelled ?? false) {
      cancelled = true;
      operation.abort();
    }
    totalTimer = Timer(totalTimeout, () {
      timedOut = true;
      operation.abort();
    });
  }

  final EstimatedIntensityArchiveHttpOperation operation;
  late final Timer totalTimer;
  StreamSubscription<void>? cancellationSubscription;
  bool cancelled;
  var timedOut = false;

  EstimatedIntensityArchiveStopReason get stopReason => cancelled
      ? EstimatedIntensityArchiveStopReason.cancelled
      : timedOut
      ? EstimatedIntensityArchiveStopReason.timeout
      : EstimatedIntensityArchiveStopReason.none;

  Future<void> close() async {
    totalTimer.cancel();
    await cancellationSubscription?.cancel();
  }
}

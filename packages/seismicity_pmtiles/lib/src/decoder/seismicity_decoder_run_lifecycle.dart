import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_result.dart';

sealed class const SeismicityDecoderRunSignal();

final class const SeismicityDecoderRunSuccessSignal({
  required final SeismicityPmTilesDataset dataset,
}) extends SeismicityDecoderRunSignal;

final class const SeismicityDecoderRunSourceFailureSignal({
  required final SeismicityPmTilesException exception,
}) extends SeismicityDecoderRunSignal;

final class const SeismicityDecoderRunWorkerFailureSignal({
  required final SeismicityPmTilesException exception,
}) extends SeismicityDecoderRunSignal;

final class const SeismicityDecoderRunCancelSignal()
    extends SeismicityDecoderRunSignal;

final class const SeismicityDecoderRunCleanupSucceededSignal()
    extends SeismicityDecoderRunSignal;

final class const SeismicityDecoderRunCleanupFailedSignal({
  required final SeismicityPmTilesException exception,
}) extends SeismicityDecoderRunSignal;

final class const SeismicityDecoderRunDecision({
  required final SeismicityPmTilesResult<SeismicityPmTilesDataset>? result,
  required final bool closeArchive,
  required final bool cancelWorker,
  required final bool closeWorker,
  required final bool waitRetired,
  required final bool publishResult,
  required final bool completeStates,
});

/// Pure first-result + exactly-once cleanup ownership for the decoder runner.
final class SeismicityDecoderRunLifecycle {
  SeismicityPmTilesResult<SeismicityPmTilesDataset>? _result;
  var _cleanupStarted = false;
  var _statesCompleted = false;

  SeismicityDecoderRunDecision handle({
    required SeismicityDecoderRunSignal signal,
  }) {
    return switch (signal) {
      SeismicityDecoderRunSuccessSignal(:final dataset) => decideTerminal(
        next: SeismicityPmTilesResult<SeismicityPmTilesDataset>.success(
          value: dataset,
        ),
        cancelWorker: false,
      ),
      SeismicityDecoderRunSourceFailureSignal(:final exception) =>
        decideTerminal(
          next: SeismicityPmTilesResult<SeismicityPmTilesDataset>.failure(
            exception: exception,
          ),
          cancelWorker: false,
        ),
      SeismicityDecoderRunWorkerFailureSignal(:final exception) =>
        decideTerminal(
          next: SeismicityPmTilesResult<SeismicityPmTilesDataset>.failure(
            exception: exception,
          ),
          cancelWorker: false,
        ),
      SeismicityDecoderRunCancelSignal() => decideTerminal(
        next: const SeismicityPmTilesResult<SeismicityPmTilesDataset>.failure(
          exception: SeismicityPmTilesException.decoderWorkerFailed(
            reason: 'cancelled',
          ),
        ),
        cancelWorker: true,
      ),
      SeismicityDecoderRunCleanupSucceededSignal() => decideCleanupFinished(
        replacement: null,
      ),
      SeismicityDecoderRunCleanupFailedSignal(:final exception) =>
        decideCleanupFinished(
          replacement:
              SeismicityPmTilesResult<SeismicityPmTilesDataset>.failure(
                exception: exception,
              ),
        ),
    };
  }

  SeismicityDecoderRunDecision decideTerminal({
    required SeismicityPmTilesResult<SeismicityPmTilesDataset> next,
    required bool cancelWorker,
  }) {
    _result ??= next;
    if (_cleanupStarted) {
      return SeismicityDecoderRunDecision(
        result: _result,
        closeArchive: false,
        cancelWorker: false,
        closeWorker: false,
        waitRetired: false,
        publishResult: false,
        completeStates: false,
      );
    }
    _cleanupStarted = true;
    return SeismicityDecoderRunDecision(
      result: _result,
      closeArchive: true,
      cancelWorker: cancelWorker,
      closeWorker: true,
      waitRetired: true,
      publishResult: false,
      completeStates: false,
    );
  }

  SeismicityDecoderRunDecision decideCleanupFinished({
    required SeismicityPmTilesResult<SeismicityPmTilesDataset>? replacement,
  }) {
    if (_statesCompleted) {
      return SeismicityDecoderRunDecision(
        result: _result,
        closeArchive: false,
        cancelWorker: false,
        closeWorker: false,
        waitRetired: false,
        publishResult: false,
        completeStates: false,
      );
    }
    final current = _result;
    if (replacement != null &&
        current is SeismicityPmTilesSuccess<SeismicityPmTilesDataset>) {
      _result = replacement;
    }
    _statesCompleted = true;
    return SeismicityDecoderRunDecision(
      result: _result,
      closeArchive: false,
      cancelWorker: false,
      closeWorker: false,
      waitRetired: false,
      publishResult: true,
      completeStates: true,
    );
  }
}

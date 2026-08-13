import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_run_lifecycle.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_result.dart';
import 'package:test/test.dart';

void main() {
  const dataset = SeismicityPmTilesDataset(
    archiveRevision: 'rev-47',
    schemaVersion: 1,
    dataZoom: 0,
    featureCount: 0,
    chunks: [],
  );
  const sourceFailure = SeismicityPmTilesException.corruptArchive(
    reason: 'source',
  );
  const workerFailure = SeismicityPmTilesException.decoderWorkerFailed(
    reason: 'worker',
  );
  const cleanupFailure = SeismicityPmTilesException.corruptArchive(
    reason: 'cleanup',
  );

  test('success starts cleanup once then publishes after cleanup', () {
    final lifecycle = SeismicityDecoderRunLifecycle();
    final first = lifecycle.handle(
      signal: const SeismicityDecoderRunSuccessSignal(dataset: dataset),
    );
    expect(first.closeArchive, isTrue);
    expect(first.cancelWorker, isFalse);
    expect(first.closeWorker, isTrue);
    expect(first.waitRetired, isTrue);
    expect(first.publishResult, isFalse);
    expect(first.completeStates, isFalse);
    expect(
      first.result,
      const SeismicityPmTilesResult<SeismicityPmTilesDataset>.success(
        value: dataset,
      ),
    );

    final repeated = lifecycle.handle(
      signal: const SeismicityDecoderRunCancelSignal(),
    );
    expect(repeated.closeArchive, isFalse);
    expect(repeated.cancelWorker, isFalse);
    expect(repeated.closeWorker, isFalse);
    expect(repeated.waitRetired, isFalse);
    expect(repeated.result, same(first.result));

    final done = lifecycle.handle(
      signal: const SeismicityDecoderRunCleanupSucceededSignal(),
    );
    expect(done.publishResult, isTrue);
    expect(done.completeStates, isTrue);
    expect(done.result, same(first.result));

    final again = lifecycle.handle(
      signal: const SeismicityDecoderRunCleanupSucceededSignal(),
    );
    expect(again.publishResult, isFalse);
    expect(again.completeStates, isFalse);
  });

  test('source and worker failures preserve first result', () {
    final lifecycle = SeismicityDecoderRunLifecycle();
    final source = lifecycle.handle(
      signal: const SeismicityDecoderRunSourceFailureSignal(
        exception: sourceFailure,
      ),
    );
    expect(source.closeArchive, isTrue);
    expect(source.cancelWorker, isFalse);
    expect(
      source.result,
      const SeismicityPmTilesResult<SeismicityPmTilesDataset>.failure(
        exception: sourceFailure,
      ),
    );

    final worker = lifecycle.handle(
      signal: const SeismicityDecoderRunWorkerFailureSignal(
        exception: workerFailure,
      ),
    );
    expect(worker.closeArchive, isFalse);
    expect(worker.result, same(source.result));
  });

  test('cancel before terminal requests worker cancel once', () {
    final lifecycle = SeismicityDecoderRunLifecycle();
    final cancel = lifecycle.handle(
      signal: const SeismicityDecoderRunCancelSignal(),
    );
    expect(cancel.closeArchive, isTrue);
    expect(cancel.cancelWorker, isTrue);
    expect(cancel.closeWorker, isTrue);
    expect(cancel.waitRetired, isTrue);
    expect(cancel.publishResult, isFalse);

    final success = lifecycle.handle(
      signal: const SeismicityDecoderRunSuccessSignal(dataset: dataset),
    );
    expect(success.closeArchive, isFalse);
    expect(success.cancelWorker, isFalse);
    expect(success.result, same(cancel.result));
  });

  test('cleanup failure replaces success only', () {
    final successLifecycle = SeismicityDecoderRunLifecycle();
    successLifecycle.handle(
      signal: const SeismicityDecoderRunSuccessSignal(dataset: dataset),
    );
    final replaced = successLifecycle.handle(
      signal: const SeismicityDecoderRunCleanupFailedSignal(
        exception: cleanupFailure,
      ),
    );
    expect(replaced.publishResult, isTrue);
    expect(replaced.completeStates, isTrue);
    expect(
      replaced.result,
      isA<SeismicityPmTilesFailure<SeismicityPmTilesDataset>>().having(
        (result) => result.exception,
        'exception',
        cleanupFailure,
      ),
    );

    final failureLifecycle = SeismicityDecoderRunLifecycle();
    final primary = failureLifecycle.handle(
      signal: const SeismicityDecoderRunSourceFailureSignal(
        exception: sourceFailure,
      ),
    );
    final kept = failureLifecycle.handle(
      signal: const SeismicityDecoderRunCleanupFailedSignal(
        exception: cleanupFailure,
      ),
    );
    expect(kept.publishResult, isTrue);
    expect(kept.completeStates, isTrue);
    expect(kept.result, same(primary.result));
  });
}

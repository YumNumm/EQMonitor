import 'dart:async';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decode_operation.dart';
import 'package:test/test.dart';

void main() {
  final fixtures = _Task46Fixtures();

  test(
    'public view exposes ordered progress one result and closed stream',
    () async {
      final controller = SeismicityPmTilesDecodeOperationController();
      final SeismicityPmTilesDecodeOperation operation = controller.operation;
      final states = fixtures.collect(stream: operation.states);

      const firstProgress = SeismicityPmTilesDecodeProgress(
        decodedTileCount: 1,
        rawFeatureCount: 2,
        uniqueFeatureCount: 2,
      );
      const secondProgress = SeismicityPmTilesDecodeProgress(
        decodedTileCount: 2,
        rawFeatureCount: 3,
        uniqueFeatureCount: 3,
      );
      const dataset = SeismicityPmTilesDataset(
        archiveRevision: 'rev-46',
        schemaVersion: 1,
        dataZoom: 0,
        featureCount: 0,
        chunks: [],
      );

      controller.emit(state: const SeismicityPmTilesLoadState.openingSource());
      controller.emit(
        state: const SeismicityPmTilesLoadState.readingDirectory(),
      );
      controller.emitProgress(progress: firstProgress);
      controller.emitProgress(progress: secondProgress);
      controller.completeSuccess(dataset: dataset);
      controller.completeSuccess(dataset: dataset);

      expect(await states, [
        const SeismicityPmTilesLoadState.openingSource(),
        const SeismicityPmTilesLoadState.readingDirectory(),
        const SeismicityPmTilesLoadState.decoding(progress: firstProgress),
        const SeismicityPmTilesLoadState.decoding(progress: secondProgress),
        const SeismicityPmTilesLoadState.completed(),
      ]);
      expect(
        await operation.result,
        const SeismicityPmTilesResult.success(value: dataset),
      );
    },
  );

  test('cancel is idempotent and only delegates once', () async {
    var cancelCount = 0;
    final controller = SeismicityPmTilesDecodeOperationController(
      onCancel: () async {
        cancelCount += 1;
      },
    );
    final SeismicityPmTilesDecodeOperation operation = controller.operation;
    final first = operation.cancel();
    final second = operation.cancel();
    await Future.wait<void>([first, second]);
    expect(identical(first, second), isTrue);
    expect(cancelCount, 1);
  });

  test('sync cancel failure stays memoized for later calls', () async {
    var cancelCount = 0;
    final controller = SeismicityPmTilesDecodeOperationController(
      onCancel: () {
        cancelCount += 1;
        throw StateError('sync-cancel-failure');
      },
    );
    final SeismicityPmTilesDecodeOperation operation = controller.operation;
    final first = operation.cancel();
    final second = operation.cancel();
    await expectLater(first, throwsA(isA<StateError>()));
    await expectLater(second, throwsA(isA<StateError>()));
    expect(identical(first, second), isTrue);
    expect(cancelCount, 1);
  });

  test('failure and cancel complete one terminal result', () async {
    const failure = SeismicityPmTilesException.corruptArchive(reason: 'boom');
    final failed = SeismicityPmTilesDecodeOperationController();
    final failedStates = fixtures.collect(stream: failed.states);
    failed.completeFailure(exception: failure);
    failed.completeFailure(exception: failure);
    expect(await failedStates, [
      const SeismicityPmTilesLoadState.failed(exception: failure),
    ]);
    expect(
      await failed.result,
      const SeismicityPmTilesResult<SeismicityPmTilesDataset>.failure(
        exception: failure,
      ),
    );

    final cancelledException = SeismicityPmTilesException.cancelled(
      source: const SeismicityPmTilesSource.file(path: 'archive.pmtiles'),
    );
    final cancelled = SeismicityPmTilesDecodeOperationController();
    final cancelledStates = fixtures.collect(stream: cancelled.states);
    cancelled.completeCancelled(exception: cancelledException);
    expect(await cancelledStates, [
      const SeismicityPmTilesLoadState.cancelled(),
    ]);
    expect(
      await cancelled.result,
      SeismicityPmTilesResult<SeismicityPmTilesDataset>.failure(
        exception: cancelledException,
      ),
    );
  });
}

final class _Task46Fixtures {
  Future<List<SeismicityPmTilesLoadState>> collect({
    required Stream<SeismicityPmTilesLoadState> stream,
  }) {
    final values = <SeismicityPmTilesLoadState>[];
    final done = Completer<List<SeismicityPmTilesLoadState>>();
    stream.listen(
      values.add,
      onDone: () {
        if (!done.isCompleted) {
          done.complete(values);
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        if (!done.isCompleted) {
          done.completeError(error, stackTrace);
        }
      },
    );
    return done.future;
  }
}

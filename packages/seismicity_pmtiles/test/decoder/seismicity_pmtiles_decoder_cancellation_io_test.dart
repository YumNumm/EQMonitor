import 'dart:async';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decode_operation.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decoder_runner.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_load_state.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_result.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';

import '../support/controlled_seismicity_archive.dart';
import '../support/controlled_seismicity_decoder_worker_factory.dart';
import '../support/controlled_seismicity_decoder_worker_handle.dart';

void main() {
  final fixtures = _Task59Fixtures();

  test('cancels before spawn completes and retires late handle once', () async {
    final setup = fixtures.start();
    await fixtures.waitUntil(() => setup.factory.spawnCount == 1);
    expect(setup.handle.cancelCount, 0);

    final first = setup.operation.cancel();
    final second = setup.operation.cancel();
    expect(identical(first, second), isTrue);
    await Future.wait<void>([first, second]);

    await fixtures.waitUntil(() => setup.archive.closeCount == 1);
    setup.factory.succeedSpawn();
    setup.handle.succeedCancel();
    setup.handle.succeedClose();
    setup.handle.succeedRetired();

    final result = await setup.operation.result;
    final states = await setup.states;
    fixtures.expectCancelled(result: result, states: states);
    expect(setup.factory.spawnCount, 1);
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.cancelCount, 1);
    expect(setup.handle.closeCount, 1);
    expect(setup.archive.readRequests, isEmpty);
    expect(setup.handle.decodeCount, 0);
  });

  test('cancels during enumeration and releases blocked I/O once', () async {
    final setup = fixtures.start(
      archiveMutator: (archive) {
        archive.pauseBeforeNextEnumeration();
      },
    );
    await fixtures.waitUntil(() => setup.factory.spawnCount == 1);
    setup.factory.succeedSpawn();
    await fixtures.waitUntil(() => setup.archive.zoomRequests.isNotEmpty);

    final first = setup.operation.cancel();
    final second = setup.operation.cancel();
    expect(identical(first, second), isTrue);
    setup.handle.succeedCancel();
    setup.handle.succeedClose();
    setup.handle.succeedRetired();
    await Future.wait<void>([first, second]);

    final result = await setup.operation.result;
    final states = await setup.states;
    fixtures.expectCancelled(result: result, states: states);
    expect(setup.factory.spawnCount, 1);
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.cancelCount, 1);
    expect(setup.handle.closeCount, 1);
    expect(setup.archive.readRequests, isEmpty);
    expect(setup.handle.decodeCount, 0);
  });

  test('cancels during tile read without further requests', () async {
    final setup = fixtures.start(
      archiveMutator: (archive) {
        archive.pauseBeforeNextRead();
      },
    );
    await fixtures.waitUntil(() => setup.factory.spawnCount == 1);
    setup.factory.succeedSpawn();
    await fixtures.waitUntil(() => setup.archive.readRequests.isNotEmpty);

    final first = setup.operation.cancel();
    final second = setup.operation.cancel();
    expect(identical(first, second), isTrue);
    setup.handle.succeedCancel();
    setup.handle.succeedClose();
    setup.handle.succeedRetired();
    await Future.wait<void>([first, second]);

    final result = await setup.operation.result;
    final states = await setup.states;
    fixtures.expectCancelled(result: result, states: states);
    expect(setup.factory.spawnCount, 1);
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.cancelCount, 1);
    expect(setup.handle.closeCount, 1);
    expect(setup.archive.readRequests, [1]);
    expect(setup.handle.decodeCount, 0);
  });
}

final class _Task59Setup {
  _Task59Setup({
    required this.archive,
    required this.handle,
    required this.factory,
    required this.operation,
    required this.states,
  });

  final ControlledSeismicityArchive archive;
  final ControlledSeismicityDecoderWorkerHandle handle;
  final ControlledSeismicityDecoderWorkerFactory factory;
  final SeismicityPmTilesDecodeOperation operation;
  final Future<List<SeismicityPmTilesLoadState>> states;
}

final class _Task59Fixtures {
  final source = SeismicityPmTilesSource.network(
    archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
  );

  SeismicityPmTilesArchiveDescriptor descriptor() =>
      SeismicityPmTilesArchiveDescriptor(
        source: source,
        schemaVersion: 1,
        dataZoom: 2,
        expectedSizeBytes: 64,
        expectedFeatureCount: 0,
        archiveRevision: 'rev-task-59',
        periodFrom: DateTime.utc(2024),
        periodTo: DateTime.utc(2025),
      );

  _Task59Setup start({
    void Function(ControlledSeismicityArchive archive)? archiveMutator,
  }) {
    final archive = ControlledSeismicityArchive(
      descriptor: descriptor(),
      occupiedTileIds: const [1, 2],
      tileBytes: {
        1: Uint8List.fromList([1]),
        2: Uint8List.fromList([2]),
      },
    );
    archiveMutator?.call(archive);
    final handle = ControlledSeismicityDecoderWorkerHandle();
    final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final runner = SeismicityPmTilesDecoderRunner(factory: factory);
    final operation = runner.start(archive: archive, chunkCapacity: 4);
    return _Task59Setup(
      archive: archive,
      handle: handle,
      factory: factory,
      operation: operation,
      states: operation.states.toList(),
    );
  }

  void expectCancelled({
    required SeismicityPmTilesResult<SeismicityPmTilesDataset> result,
    required List<SeismicityPmTilesLoadState> states,
  }) {
    expect(
      result,
      isA<SeismicityPmTilesFailure<SeismicityPmTilesDataset>>().having(
        (value) => value.exception,
        'exception',
        isA<SeismicityPmTilesDecoderWorkerFailedException>().having(
          (value) => value.reason,
          'reason',
          'cancelled',
        ),
      ),
    );
    expect(states, contains(const SeismicityPmTilesLoadState.cancelled()));
    expect(
      states,
      isNot(contains(const SeismicityPmTilesLoadState.completed())),
    );
    expect(states.whereType<SeismicityPmTilesLoadCancelled>().length, 1);
  }

  Future<void> waitUntil(bool Function() predicate) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        throw StateError('Timed out waiting for Task 59 signal.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}

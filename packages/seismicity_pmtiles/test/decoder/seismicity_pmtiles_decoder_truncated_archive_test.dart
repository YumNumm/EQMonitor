import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decoder_runner.dart';
import 'package:test/test.dart';

import '../support/controlled_seismicity_isolate_launcher.dart';
import '../support/seismicity_archive_fixture_builder.dart';

void main() {
  final fixtures = _Task63Fixtures();

  for (final case_ in fixtures.cases()) {
    test(
      'rejects truncated ${case_.name} before publication',
      () async {
        final controlled = ControlledSeismicityIsolateLauncher();
        final outcome = await fixtures.runPipeline(
          bytes: case_.bytes,
          descriptor: case_.descriptor,
          launcher: controlled,
        );

        expect(outcome.opened, isFalse);
        expect(outcome.decodeStarted, isFalse);
        expect(outcome.result, isNull);
        expect(outcome.states, isEmpty);
        expect(
          outcome.openFailure,
          case_.matcher,
        );
        expect(controlled.launchCount, 0);
        expect(controlled.killCount, 0);
      },
    );
  }

  test('public facade remains the decode entry after open', () {
    expect(
      SeismicityPmTilesDecoder().start,
      isA<
        SeismicityPmTilesDecodeOperation Function({
          required SeismicityPmTilesArchive archive,
          required int chunkCapacity,
        })
      >(),
    );
  });
}

final class _Task63Case {
  const _Task63Case({
    required this.name,
    required this.bytes,
    required this.descriptor,
    required this.matcher,
  });

  final String name;
  final Uint8List bytes;
  final SeismicityPmTilesArchiveDescriptor descriptor;
  final Matcher matcher;
}

final class _Task63PipelineOutcome {
  const _Task63PipelineOutcome({
    required this.opened,
    required this.decodeStarted,
    required this.openFailure,
    required this.result,
    required this.states,
  });

  final bool opened;
  final bool decodeStarted;
  final Object? openFailure;
  final SeismicityPmTilesResult<SeismicityPmTilesDataset>? result;
  final List<SeismicityPmTilesLoadState> states;
}

final class _Task63Fixtures {
  final builder = SeismicityArchiveFixtureBuilder();

  List<_Task63Case> cases() {
    final fixture = builder.buildGzipZ2(
      schemaVersion: 1,
      expectedFeatureCount: 2,
      archiveRevision: 'rev-task-63',
      periodFrom: DateTime.utc(2024),
      periodTo: DateTime.utc(2025),
    );
    return [
      _Task63Case(
        name: 'header',
        bytes: fixture.truncatedHeader,
        descriptor: fixture.descriptor.copyWith(
          expectedSizeBytes: fixture.truncatedHeader.length,
        ),
        matcher: isA<SeismicityPmTilesInvalidRangeException>()
            .having((error) => error.offset, 'offset', 0)
            .having((error) => error.length, 'length', 127)
            .having(
              (error) => error.sizeBytes,
              'sizeBytes',
              fixture.truncatedHeader.length,
            ),
      ),
      _Task63Case(
        name: 'root directory',
        bytes: fixture.truncatedDirectory,
        descriptor: fixture.descriptor.copyWith(
          expectedSizeBytes: fixture.truncatedDirectory.length,
        ),
        matcher: isA<SeismicityPmTilesCorruptArchiveException>().having(
          (error) => error.reason,
          'reason',
          'The root directory section exceeds the archive bounds.',
        ),
      ),
      _Task63Case(
        name: 'tile data',
        bytes: fixture.truncatedTileData,
        descriptor: fixture.descriptor.copyWith(
          expectedSizeBytes: fixture.truncatedTileData.length,
        ),
        matcher: isA<SeismicityPmTilesCorruptArchiveException>().having(
          (error) => error.reason,
          'reason',
          'The tile data section exceeds the archive bounds.',
        ),
      ),
    ];
  }

  Future<_Task63PipelineOutcome> runPipeline({
    required Uint8List bytes,
    required SeismicityPmTilesArchiveDescriptor descriptor,
    required ControlledSeismicityIsolateLauncher launcher,
  }) async {
    try {
      final archive = await openAssetArchive(
        bytes: bytes,
        descriptor: descriptor,
      );
      // Truncations must fail before open; if they ever open, decode through
      // the same runner path as the public facade with a spawn probe.
      final operation = SeismicityPmTilesDecoderRunner(
        factory: IsolateSeismicityDecoderWorkerFactory(
          launcher: launcher,
          probe: launcher,
        ),
      ).start(archive: archive, chunkCapacity: 1);
      final states = await operation.states.toList();
      final result = await operation.result;
      await archive.close();
      return _Task63PipelineOutcome(
        opened: true,
        decodeStarted: true,
        openFailure: null,
        result: result,
        states: states,
      );
    } on SeismicityPmTilesException catch (error) {
      return _Task63PipelineOutcome(
        opened: false,
        decodeStarted: false,
        openFailure: error,
        result: null,
        states: const [],
      );
    }
  }

  Future<SeismicityPmTilesArchive> openAssetArchive({
    required Uint8List bytes,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) async {
    final factory = SeismicityRandomAccessReaderFactory(
      assetLoader: ({required String assetKey}) async {
        expect(assetKey, SeismicityArchiveFixtureBuilder.assetKey);
        return bytes;
      },
      dio: Dio(),
      networkMaxCacheBytes: 1024,
    );
    final opened = await factory.create(
      descriptor: descriptor,
      cancelToken: CancelToken(),
    );
    final reader = switch (opened) {
      SeismicityPmTilesSuccess(:final value) => value,
      SeismicityPmTilesFailure(:final exception) => throw exception,
    };
    return SeismicityPmTilesArchive.open(
      reader: reader,
      descriptor: descriptor,
    );
  }
}

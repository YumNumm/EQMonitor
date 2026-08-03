import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

void main() {
  late Directory tempDirectory;
  late File archiveFile;
  late FileRandomAccessReader reader;

  setUp(() async {
    tempDirectory = await Directory.systemTemp.createTemp(
      'seismicity_pmtiles_file_reader_',
    );
    archiveFile = File('${tempDirectory.path}/archive.pmtiles');
    await archiveFile.writeAsBytes(List<int>.generate(64, (index) => index));
    reader = await FileRandomAccessReader.open(
      source: SeismicityPmTilesFileSource(path: archiveFile.path),
    );
  });

  tearDown(() async {
    await reader.close();
    await tempDirectory.delete(recursive: true);
  });

  test('reads the requested exact range from a temporary file', () async {
    expect(reader.sizeBytes, 64);
    expect(
      await reader.readAt(offset: 12, length: 5),
      orderedEquals([12, 13, 14, 15, 16]),
    );
  });

  test('serializes concurrent reads on the shared file position', () async {
    final reads = List<Future<List<int>>>.generate(128, (index) {
      final offset = index % 56;
      return reader.readAt(offset: offset, length: 8);
    });

    final results = await Future.wait(reads);

    for (var index = 0; index < results.length; index++) {
      final offset = index % 56;
      expect(
        results[index],
        orderedEquals(List<int>.generate(8, (i) => i + offset)),
      );
    }
  });

  test('rejects invalid and overflowing ranges before reading', () async {
    final invalidRanges = <({int offset, int length})>[
      (offset: -1, length: 1),
      (offset: 0, length: 0),
      (offset: 63, length: 2),
      (offset: 9223372036854775807, length: 2),
    ];

    for (final range in invalidRanges) {
      await expectLater(
        reader.readAt(offset: range.offset, length: range.length),
        throwsA(
          isA<SeismicityPmTilesInvalidRangeException>()
              .having((exception) => exception.offset, 'offset', range.offset)
              .having((exception) => exception.length, 'length', range.length)
              .having((exception) => exception.sizeBytes, 'sizeBytes', 64),
        ),
      );
    }
  });

  test('fails when the file no longer contains the exact range', () async {
    await archiveFile.writeAsBytes([0, 1, 2, 3]);

    await expectLater(
      reader.readAt(offset: 4, length: 4),
      throwsA(
        isA<SeismicityPmTilesSourceReadFailedException>().having(
          (exception) => exception.reason,
          'reason',
          contains('Expected 4 bytes'),
        ),
      ),
    );
  });

  test('rejects reads after close and close is idempotent', () async {
    await Future.wait([reader.close(), reader.close()]);

    await expectLater(
      reader.readAt(offset: 0, length: 1),
      throwsA(isA<SeismicityPmTilesSourceReadFailedException>()),
    );
  });

  test('finishes an accepted read before close under contention', () async {
    const source = SeismicityPmTilesFileSource(path: 'controlled.pmtiles');
    final controlledFile = _ControllableRandomAccessFile();
    final controlledReader = FileRandomAccessReader(
      file: controlledFile,
      sizeBytes: 4,
      source: source,
    );

    final acceptedRead = controlledReader.readAt(offset: 0, length: 4);
    await controlledFile._readStarted.future;
    final closeFuture = controlledReader.close();

    await expectLater(
      controlledReader.readAt(offset: 0, length: 1),
      throwsA(isA<SeismicityPmTilesSourceReadFailedException>()),
    );
    expect(controlledFile._closeCalled, isFalse);

    controlledFile._allowRead.complete();

    expect(await acceptedRead, orderedEquals([10, 11, 12, 13]));
    await closeFuture;
    expect(controlledFile._closeCalled, isTrue);
  });
}

final class _ControllableRandomAccessFile extends Fake
    implements RandomAccessFile {
  final _readStarted = Completer<void>();
  final _allowRead = Completer<void>();
  var _closeCalled = false;

  @override
  Future<RandomAccessFile> setPosition(int position) async => this;

  @override
  Future<Uint8List> read(int bytes) async {
    _readStarted.complete();
    await _allowRead.future;
    return Uint8List.fromList([10, 11, 12, 13]);
  }

  @override
  Future<void> close() async {
    _closeCalled = true;
  }
}

import 'dart:typed_data';

import 'package:pmtiles_v3/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_directory_decoder.dart';
import 'package:test/test.dart';

import 'seismicity_pmtiles_directory_writer.dart';

void main() {
  const writer = SeismicityPmTilesDirectoryWriter();
  const decoder = PmTilesV3DirectoryDecoder();

  test('encodes delta IDs, runs, lengths, reused and explicit offsets', () {
    final bytes = writer.write(
      tileIds: const [5, 42, 69],
      runLengths: const [1, 2, 0],
      lengths: const [42, 5, 8],
      offsets: const [1337, 1379, 10],
    );
    expect(
      bytes,
      Uint8List.fromList([
        3,
        5,
        37,
        27,
        1,
        2,
        0,
        42,
        5,
        8,
        0xBA,
        0x0A,
        0,
        11,
      ]),
    );

    final two = writer.write(
      tileIds: const [1, 4],
      runLengths: const [1, 1],
      lengths: const [3, 2],
      offsets: const [0, 3],
    );
    expect(two, Uint8List.fromList([2, 1, 3, 1, 1, 3, 2, 1, 0]));
    final decoded = decoder.decode(
      bytes: two,
      compression: PmTilesV3CompressionDecoder.none,
    );
    expect(decoded.map((entry) => entry.tileId), [1, 4]);
    expect(decoded.map((entry) => entry.runLength), [1, 1]);
    expect(decoded.map((entry) => entry.length), [3, 2]);
    expect(decoded.map((entry) => entry.offset), [0, 3]);
  });

  test('rejects unsorted IDs, negatives, invalid lengths, and overflows', () {
    expect(
      () => writer.write(
        tileIds: const [2, 1],
        runLengths: const [1, 1],
        lengths: const [1, 1],
        offsets: const [0, 1],
      ),
      throwsArgumentError,
    );
    expect(
      () => writer.write(
        tileIds: const [-1],
        runLengths: const [1],
        lengths: const [1],
        offsets: const [0],
      ),
      throwsArgumentError,
    );
    expect(
      () => writer.write(
        tileIds: const [1],
        runLengths: const [-1],
        lengths: const [1],
        offsets: const [0],
      ),
      throwsArgumentError,
    );
    expect(
      () => writer.write(
        tileIds: const [1],
        runLengths: const [1],
        lengths: const [0],
        offsets: const [0],
      ),
      throwsArgumentError,
    );
    expect(
      () => writer.encodeUnsignedVarint(value: -1),
      throwsArgumentError,
    );
    expect(
      () => writer.encodeUnsignedVarint(
        value: SeismicityPmTilesDirectoryWriter.maxUnsignedVarint + 1,
      ),
      throwsArgumentError,
    );
    expect(
      () => writer.checkedAdd(
        left: SeismicityPmTilesDirectoryWriter.maxUnsignedVarint,
        right: 1,
        field: 'entry range',
      ),
      throwsArgumentError,
    );
    expect(
      () => writer.write(
        tileIds: const [1],
        runLengths: const [1],
        lengths: const [1],
        offsets: const [SeismicityPmTilesDirectoryWriter.maxUnsignedVarint],
      ),
      throwsArgumentError,
    );
  });
}

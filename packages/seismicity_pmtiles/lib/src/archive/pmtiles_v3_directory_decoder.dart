import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_directory_entry.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_tile_id.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class PmTilesV3DirectoryDecoder {
  const PmTilesV3DirectoryDecoder({
    this.compressionDecoder = const PmTilesV3CompressionDecoder(),
    this.tileId = const PmTilesV3TileId(),
  });

  static const maxSignedInteger = 0x7FFFFFFFFFFFFFFF;

  final PmTilesV3CompressionDecoder compressionDecoder;
  final PmTilesV3TileId tileId;

  List<PmTilesV3DirectoryEntry> decode({
    required Uint8List bytes,
    required int compression,
  }) {
    final decoded = compressionDecoder.decode(
      bytes: bytes,
      compression: compression,
    );
    final countResult = decodeVarintAt(bytes: decoded, offset: 0);
    final count = countResult.value;
    if (count <= 0) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'A PMTiles directory must contain at least one entry.',
      );
    }
    if (count > (decoded.length - countResult.nextOffset) ~/ 4) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'PMTiles directory entry count exceeds the encoded data.',
      );
    }
    return decodeEntries(
      bytes: decoded,
      count: count,
      initialOffset: countResult.nextOffset,
    );
  }

  List<PmTilesV3DirectoryEntry> decodeEntries({
    required Uint8List bytes,
    required int count,
    required int initialOffset,
  }) {
    var cursor = initialOffset;
    final tileIds = List<int>.filled(count, 0);
    var previousTileId = 0;
    for (var index = 0; index < count; index++) {
      final result = decodeVarintAt(bytes: bytes, offset: cursor);
      cursor = result.nextOffset;
      if (index > 0 && result.value == 0) {
        throw const SeismicityPmTilesException.corruptArchive(
          reason: 'PMTiles directory tile IDs must be strictly increasing.',
        );
      }
      previousTileId = checkedAdd(
        left: previousTileId,
        right: result.value,
        field: 'tile ID',
      );
      tileId.validateDecoded(tileId: previousTileId);
      tileIds[index] = previousTileId;
    }
    final runResult = decodeValues(
      bytes: bytes,
      count: count,
      initialOffset: cursor,
    );
    final lengthResult = decodeValues(
      bytes: bytes,
      count: count,
      initialOffset: runResult.nextOffset,
    );
    final offsetResult = decodeOffsets(
      bytes: bytes,
      lengths: lengthResult.values,
      initialOffset: lengthResult.nextOffset,
    );
    if (offsetResult.nextOffset != bytes.length) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'PMTiles directory contains trailing bytes.',
      );
    }
    return buildEntries(
      tileIds: tileIds,
      runLengths: runResult.values,
      lengths: lengthResult.values,
      offsets: offsetResult.values,
    );
  }

  ({List<int> values, int nextOffset}) decodeValues({
    required Uint8List bytes,
    required int count,
    required int initialOffset,
  }) {
    var cursor = initialOffset;
    final values = List<int>.filled(count, 0);
    for (var index = 0; index < count; index++) {
      final result = decodeVarintAt(bytes: bytes, offset: cursor);
      values[index] = result.value;
      cursor = result.nextOffset;
    }
    return (values: values, nextOffset: cursor);
  }

  ({List<int> values, int nextOffset}) decodeOffsets({
    required Uint8List bytes,
    required List<int> lengths,
    required int initialOffset,
  }) {
    var cursor = initialOffset;
    var nextContiguousOffset = 0;
    final offsets = List<int>.filled(lengths.length, 0);
    for (var index = 0; index < lengths.length; index++) {
      final result = decodeVarintAt(bytes: bytes, offset: cursor);
      cursor = result.nextOffset;
      if (lengths[index] <= 0) {
        throw const SeismicityPmTilesException.corruptArchive(
          reason: 'PMTiles directory entry length must be greater than zero.',
        );
      }
      if (index == 0 && result.value == 0) {
        throw const SeismicityPmTilesException.corruptArchive(
          reason: 'The first PMTiles directory offset cannot use a sentinel.',
        );
      }
      final offset = result.value == 0
          ? nextContiguousOffset
          : result.value - 1;
      offsets[index] = offset;
      nextContiguousOffset = checkedAdd(
        left: offset,
        right: lengths[index],
        field: 'entry range',
      );
    }
    return (values: offsets, nextOffset: cursor);
  }

  List<PmTilesV3DirectoryEntry> buildEntries({
    required List<int> tileIds,
    required List<int> runLengths,
    required List<int> lengths,
    required List<int> offsets,
  }) {
    final entries = List<PmTilesV3DirectoryEntry>.generate(
      tileIds.length,
      (index) => PmTilesV3DirectoryEntry(
        tileId: tileIds[index],
        offset: offsets[index],
        length: lengths[index],
        runLength: runLengths[index],
      ),
      growable: false,
    );
    validateRuns(entries: entries);
    return List<PmTilesV3DirectoryEntry>.unmodifiable(entries);
  }

  void validateRuns({required List<PmTilesV3DirectoryEntry> entries}) {
    for (var index = 0; index < entries.length; index++) {
      final entry = entries[index];
      if (entry.runLength == 0) {
        continue;
      }
      final runEnd = checkedAdd(
        left: entry.tileId,
        right: entry.runLength,
        field: 'tile run',
      );
      if (runEnd > PmTilesV3TileId.maxValue + 1) {
        throw const SeismicityPmTilesException.corruptArchive(
          reason: 'A PMTiles tile run exceeds the zoom 0-31 tile ID range.',
        );
      }
      if (index + 1 < entries.length && runEnd > entries[index + 1].tileId) {
        throw const SeismicityPmTilesException.corruptArchive(
          reason: 'PMTiles directory tile runs must not overlap.',
        );
      }
    }
  }

  ({int value, int nextOffset}) decodeVarintAt({
    required Uint8List bytes,
    required int offset,
  }) {
    var value = 0;
    var cursor = offset;
    for (var byteIndex = 0; byteIndex < 9; byteIndex++) {
      if (cursor >= bytes.length) {
        throw const SeismicityPmTilesException.corruptArchive(
          reason: 'Truncated PMTiles directory varint.',
        );
      }
      final byte = bytes[cursor];
      final payload = byte & 0x7F;
      value |= payload << (byteIndex * 7);
      cursor++;
      if ((byte & 0x80) == 0) {
        if (byteIndex > 0 && payload == 0) {
          throw const SeismicityPmTilesException.corruptArchive(
            reason: 'Non-canonical PMTiles directory varint.',
          );
        }
        return (value: value, nextOffset: cursor);
      }
    }
    throw const SeismicityPmTilesException.corruptArchive(
      reason: 'PMTiles directory varint exceeds the signed 63-bit range.',
    );
  }

  int checkedAdd({
    required int left,
    required int right,
    required String field,
  }) {
    if (left < 0 || right < 0 || right > maxSignedInteger - left) {
      throw SeismicityPmTilesException.corruptArchive(
        reason: 'PMTiles $field overflows the supported integer range.',
      );
    }
    return left + right;
  }
}

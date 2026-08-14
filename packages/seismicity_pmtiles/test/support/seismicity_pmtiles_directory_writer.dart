import 'dart:typed_data';

import 'package:pmtiles_v3/src/archive/pmtiles_v3_tile_id.dart';

/// Test-only checked encoder for PMTiles v3 root-directory bytes.
final class SeismicityPmTilesDirectoryWriter {
  const SeismicityPmTilesDirectoryWriter();

  static const maxUnsignedVarint = 0x7FFFFFFFFFFFFFFF;
  static const int maxTileIdExclusive = PmTilesV3TileId.maxValue + 1;

  Uint8List write({
    required List<int> tileIds,
    required List<int> runLengths,
    required List<int> lengths,
    required List<int> offsets,
  }) {
    final count = tileIds.length;
    if (count == 0 ||
        runLengths.length != count ||
        lengths.length != count ||
        offsets.length != count) {
      throw ArgumentError('Directory columns must be non-empty and aligned.');
    }
    validateRuns(tileIds: tileIds, runLengths: runLengths);
    final output = BytesBuilder(copy: false)
      ..add(encodeUnsignedVarint(value: count));
    var previousTileId = 0;
    for (var index = 0; index < count; index++) {
      final tileId = tileIds[index];
      rejectNegative(value: tileId, field: 'tileId');
      if (index > 0 && tileId <= previousTileId) {
        throw ArgumentError('Directory tile IDs must be strictly increasing.');
      }
      output.add(
        encodeUnsignedVarint(
          value: checkedSubtract(
            left: tileId,
            right: previousTileId,
            field: 'tile ID delta',
          ),
        ),
      );
      previousTileId = tileId;
    }
    for (final runLength in runLengths) {
      rejectNegative(value: runLength, field: 'runLength');
      output.add(encodeUnsignedVarint(value: runLength));
    }
    for (final length in lengths) {
      if (length <= 0) {
        throw ArgumentError(
          'Directory entry length must be greater than zero.',
        );
      }
      output.add(encodeUnsignedVarint(value: length));
    }
    var nextContiguousOffset = 0;
    for (var index = 0; index < count; index++) {
      final offset = offsets[index];
      rejectNegative(value: offset, field: 'offset');
      final encodedOffset = index > 0 && offset == nextContiguousOffset
          ? 0
          : checkedAdd(left: offset, right: 1, field: 'encoded offset');
      if (index == 0 && encodedOffset == 0) {
        throw ArgumentError(
          'The first directory offset cannot use a sentinel.',
        );
      }
      output.add(encodeUnsignedVarint(value: encodedOffset));
      nextContiguousOffset = checkedAdd(
        left: offset,
        right: lengths[index],
        field: 'entry range',
      );
    }
    return output.toBytes();
  }

  void validateRuns({
    required List<int> tileIds,
    required List<int> runLengths,
  }) {
    for (var index = 0; index < tileIds.length; index++) {
      final runLength = runLengths[index];
      rejectNegative(value: runLength, field: 'runLength');
      if (runLength == 0) {
        continue;
      }
      final runEnd = checkedAdd(
        left: tileIds[index],
        right: runLength,
        field: 'tile run',
      );
      if (runEnd > maxTileIdExclusive) {
        throw ArgumentError('A directory tile run exceeds the tile ID range.');
      }
      if (index + 1 < tileIds.length && runEnd > tileIds[index + 1]) {
        throw ArgumentError('Directory tile runs must not overlap.');
      }
    }
  }

  Uint8List encodeUnsignedVarint({required int value}) {
    rejectNegative(value: value, field: 'varint');
    if (value > maxUnsignedVarint) {
      throw ArgumentError('Unsigned varint exceeds the checked maximum.');
    }
    final output = <int>[];
    var remaining = value;
    do {
      var byte = remaining & 0x7F;
      remaining >>= 7;
      if (remaining > 0) {
        byte |= 0x80;
      }
      output.add(byte);
    } while (remaining > 0);
    return Uint8List.fromList(output);
  }

  int checkedAdd({
    required int left,
    required int right,
    required String field,
  }) {
    rejectNegative(value: left, field: field);
    rejectNegative(value: right, field: field);
    final sum = left + right;
    if (sum < left || sum > maxUnsignedVarint) {
      throw ArgumentError('Checked addition overflow for $field.');
    }
    return sum;
  }

  int checkedSubtract({
    required int left,
    required int right,
    required String field,
  }) {
    rejectNegative(value: left, field: field);
    rejectNegative(value: right, field: field);
    if (left < right) {
      throw ArgumentError('Checked subtraction underflow for $field.');
    }
    return left - right;
  }

  void rejectNegative({required int value, required String field}) {
    if (value < 0) {
      throw ArgumentError('$field must not be negative.');
    }
  }
}

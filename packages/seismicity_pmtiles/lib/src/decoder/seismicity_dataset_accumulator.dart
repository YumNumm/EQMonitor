import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_builder.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_uuid_index.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:uuid/uuid.dart';

typedef SeismicityChunkFactory =
    SeismicityChunkBuilder Function({required int capacity});

final class SeismicityDatasetAccumulator {
  SeismicityDatasetAccumulator({
    required int expectedUniqueCount,
    required int chunkCapacity,
    SeismicityChunkFactory createChunk = SeismicityChunkBuilder.new,
    void Function()? beforeIndexInsert,
  }) : _expectedUniqueCount = expectedUniqueCount,
       _chunkCapacity = chunkCapacity,
       _createChunk = createChunk,
       _beforeIndexInsert = beforeIndexInsert,
       _index = SeismicityUuidIndex(expectedUniqueCount: expectedUniqueCount) {
    if (chunkCapacity <= 0 || chunkCapacity > 0x3fffffff) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid dataset chunk capacity.',
      );
    }
  }

  final int _expectedUniqueCount;
  final int _chunkCapacity;
  final SeismicityChunkFactory _createChunk;
  final void Function()? _beforeIndexInsert;
  final SeismicityUuidIndex _index;
  final _chunks = <SeismicityChunkBuilder>[];
  var _rawCount = 0;
  var _uniqueCount = 0;
  var _poisoned = false;

  int get rawCount => readAccumulatorValue(
    poisoned: _poisoned,
    value: _rawCount,
  );
  int get uniqueCount => readAccumulatorValue(
    poisoned: _poisoned,
    value: _uniqueCount,
  );

  bool add({required SeismicityDecodedHypocenter record}) {
    ensureAccumulatorUsable(poisoned: _poisoned);
    bool equals({required int rowIndex, required Uint8List candidate}) =>
        _chunks[rowIndex ~/ _chunkCapacity].uuidEquals(
          rowIndex: rowIndex % _chunkCapacity,
          candidate: candidate,
        );
    final existing = _index.find(id: record.hypocenterId, equals: equals);
    if (existing != null) {
      final matches = _chunks[existing ~/ _chunkCapacity].matches(
        localIndex: existing % _chunkCapacity,
        record: record,
      );
      if (!matches) {
        throw SeismicityPmTilesException.duplicateConflict(
          hypocenterId: Uuid.unparse(record.hypocenterId),
        );
      }
      _rawCount++;
      return false;
    }
    if (_uniqueCount >= _expectedUniqueCount) {
      throw SeismicityPmTilesException.featureCountMismatch(
        expected: _expectedUniqueCount,
        actual: _uniqueCount + 1,
      );
    }

    final needsChunk = _chunks.isEmpty || _chunks.last.isFull;
    final chunk = needsChunk
        ? _createChunk(capacity: _chunkCapacity)
        : _chunks.last;
    try {
      chunk.add(record: record);
      if (needsChunk) {
        _chunks.add(chunk);
      }
      _beforeIndexInsert?.call();
      _index.insert(
        id: record.hypocenterId,
        rowIndex: _uniqueCount,
        equals: equals,
      );
    } on SeismicityPmTilesException {
      _poisoned = true;
      rethrow;
    }
    _rawCount++;
    _uniqueCount++;
    return true;
  }

  List<SeismicityPmTilesChunk> buildChunks() {
    ensureAccumulatorUsable(poisoned: _poisoned);
    if (_uniqueCount != _expectedUniqueCount) {
      throw SeismicityPmTilesException.featureCountMismatch(
        expected: _expectedUniqueCount,
        actual: _uniqueCount,
      );
    }
    return _chunks.map((chunk) => chunk.build()).toList(growable: false);
  }
}

int readAccumulatorValue({required bool poisoned, required int value}) {
  ensureAccumulatorUsable(poisoned: poisoned);
  return value;
}

void ensureAccumulatorUsable({required bool poisoned}) {
  if (poisoned) {
    throw const SeismicityPmTilesException.invalidDescriptor(
      reason: 'Dataset accumulator is poisoned.',
    );
  }
}

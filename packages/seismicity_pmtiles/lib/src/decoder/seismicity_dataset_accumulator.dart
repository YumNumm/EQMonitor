import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_builder.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_uuid_index.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:uuid/uuid.dart';

final class SeismicityDatasetAccumulator {
  SeismicityDatasetAccumulator({
    required int expectedUniqueCount,
    required int chunkCapacity,
  }) : _expectedUniqueCount = expectedUniqueCount,
       _chunkCapacity = chunkCapacity,
       _index = SeismicityUuidIndex(expectedUniqueCount: expectedUniqueCount) {
    if (chunkCapacity <= 0 || chunkCapacity > 0x3fffffff) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid dataset chunk capacity.',
      );
    }
  }

  final int _expectedUniqueCount;
  final int _chunkCapacity;
  final SeismicityUuidIndex _index;
  final _chunks = <SeismicityChunkBuilder>[];
  var _rawCount = 0;
  var _uniqueCount = 0;

  int get rawCount => _rawCount;
  int get uniqueCount => _uniqueCount;

  bool add({required SeismicityDecodedHypocenter record}) {
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
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Dataset unique count exceeds the descriptor.',
      );
    }

    final needsChunk = _chunks.isEmpty || _chunks.last.isFull;
    final chunk = needsChunk
        ? SeismicityChunkBuilder(capacity: _chunkCapacity)
        : _chunks.last;
    chunk.add(record: record);
    if (needsChunk) {
      _chunks.add(chunk);
    }
    _index.insert(
      id: record.hypocenterId,
      rowIndex: _uniqueCount,
      equals: equals,
    );
    _rawCount++;
    _uniqueCount++;
    return true;
  }

  List<SeismicityPmTilesChunk> buildChunks() =>
      _chunks.map((chunk) => chunk.build()).toList(growable: false);
}

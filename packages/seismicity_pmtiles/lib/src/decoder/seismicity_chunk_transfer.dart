import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk_validator.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class SeismicityChunkTransfer {
  SeismicityChunkTransfer._(this._columns);

  factory SeismicityChunkTransfer.fromChunk({
    required SeismicityPmTilesChunk chunk,
  }) => SeismicityChunkTransfer._([
    for (final column in <TypedData>[
      chunk.hypocenterIds,
      chunk.latitudes,
      chunk.longitudes,
      chunk.depthsKm,
      chunk.depthValidity,
      chunk.magnitudes,
      chunk.magnitudeValidity,
      chunk.originTimeUnixMilliseconds,
      chunk.maxIntensityDictionaryIndexes,
      chunk.maxIntensityValidity,
      chunk.maxIntensityDictionaryUtf8,
      chunk.maxIntensityDictionaryOffsets,
    ])
      TransferableTypedData.fromList([
        column.buffer.asUint8List(column.offsetInBytes, column.lengthInBytes),
      ]),
  ]);

  final List<TransferableTypedData> _columns;

  SeismicityPmTilesChunk materialize() {
    final buffers = [
      for (final column in _columns) column.materialize(),
    ];
    const elementSizes = [
      Uint8List.bytesPerElement,
      Float64List.bytesPerElement,
      Float64List.bytesPerElement,
      Float32List.bytesPerElement,
      Uint8List.bytesPerElement,
      Float32List.bytesPerElement,
      Uint8List.bytesPerElement,
      Int64List.bytesPerElement,
      Uint32List.bytesPerElement,
      Uint8List.bytesPerElement,
      Uint8List.bytesPerElement,
      Uint32List.bytesPerElement,
    ];
    for (var index = 0; index < buffers.length; index++) {
      if (buffers[index].lengthInBytes % elementSizes[index] != 0) {
        throw const SeismicityPmTilesException.corruptArchive(
          reason: 'A transferred chunk column has an invalid byte length.',
        );
      }
    }
    final chunk = SeismicityPmTilesChunk(
      hypocenterIds: Uint8List.view(buffers[0]),
      latitudes: Float64List.view(buffers[1]),
      longitudes: Float64List.view(buffers[2]),
      depthsKm: Float32List.view(buffers[3]),
      depthValidity: Uint8List.view(buffers[4]),
      magnitudes: Float32List.view(buffers[5]),
      magnitudeValidity: Uint8List.view(buffers[6]),
      originTimeUnixMilliseconds: Int64List.view(buffers[7]),
      maxIntensityDictionaryIndexes: Uint32List.view(buffers[8]),
      maxIntensityValidity: Uint8List.view(buffers[9]),
      maxIntensityDictionaryUtf8: Uint8List.view(buffers[10]),
      maxIntensityDictionaryOffsets: Uint32List.view(buffers[11]),
    );
    const SeismicityPmTilesChunkValidator().validate(chunk: chunk);
    return chunk;
  }
}

import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_canonical_property_chunk.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_fixed_columns.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_intensity_dictionary.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk_validator.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class SeismicityChunkBuilder {
  SeismicityChunkBuilder({required int capacity})
    : _fixed = SeismicityChunkFixedColumns(capacity: capacity),
      _canonical = SeismicityCanonicalPropertyChunk(capacity: capacity),
      _intensities = SeismicityChunkIntensityDictionary(capacity: capacity);

  final SeismicityChunkFixedColumns _fixed;
  final SeismicityCanonicalPropertyChunk _canonical;
  final SeismicityChunkIntensityDictionary _intensities;

  int get length => _fixed.length;
  bool get isFull => _fixed.isFull;

  void add({required SeismicityDecodedHypocenter record}) {
    if (_fixed.isFull || _canonical.isFull || _intensities.isFull) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Public chunk capacity exceeded.',
      );
    }
    _fixed.add(row: record);
    _canonical.add(row: record);
    _intensities.add(maxIntensityUtf8: record.maxIntensityUtf8);
  }

  bool uuidEquals({required int rowIndex, required Uint8List candidate}) =>
      _fixed.uuidEquals(rowIndex: rowIndex, candidate: candidate);

  bool matches({
    required int localIndex,
    required SeismicityDecodedHypocenter record,
  }) =>
      _fixed.originTimeEquals(
        rowIndex: localIndex,
        candidate: record.originTimeUnixMilliseconds,
      ) &&
      _intensities.matches(
        localIndex: localIndex,
        maxIntensityUtf8: record.maxIntensityUtf8,
      ) &&
      _canonical.matches(localIndex: localIndex, record: record);

  SeismicityPmTilesChunk build() {
    final fixed = _fixed.build();
    final intensities = _intensities.build();
    final chunk = SeismicityPmTilesChunk(
      hypocenterIds: fixed.hypocenterIds,
      latitudes: fixed.latitudes,
      longitudes: fixed.longitudes,
      depthsKm: fixed.depthsKm,
      depthValidity: fixed.depthValidity,
      magnitudes: fixed.magnitudes,
      magnitudeValidity: fixed.magnitudeValidity,
      originTimeUnixMilliseconds: fixed.originTimeUnixMilliseconds,
      maxIntensityDictionaryIndexes: intensities.dictionaryIndexes,
      maxIntensityValidity: intensities.validity,
      maxIntensityDictionaryUtf8: intensities.dictionaryUtf8,
      maxIntensityDictionaryOffsets: intensities.dictionaryOffsets,
    );
    const SeismicityPmTilesChunkValidator().validate(chunk: chunk);
    return chunk;
  }
}

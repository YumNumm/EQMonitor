import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_canonical_property_chunk.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_fixed_columns.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_intensity_dictionary.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk_validator.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class SeismicityChunkBuilder {
  new({
    required int capacity,
    this._beforeCanonicalAdd,
    this._beforeIntensityAdd,
  }) : _fixed = SeismicityChunkFixedColumns(capacity: capacity),
       _canonical = SeismicityCanonicalPropertyChunk(capacity: capacity),
       _intensities = SeismicityChunkIntensityDictionary(capacity: capacity);

  final void Function()? _beforeCanonicalAdd;
  final void Function()? _beforeIntensityAdd;
  final SeismicityChunkFixedColumns _fixed;
  final SeismicityCanonicalPropertyChunk _canonical;
  final SeismicityChunkIntensityDictionary _intensities;
  var _poisoned = false;

  int get length {
    ensureSeismicityChunkBuilderUsable(poisoned: _poisoned);
    return _fixed.length;
  }

  bool get isFull {
    ensureSeismicityChunkBuilderUsable(poisoned: _poisoned);
    return _fixed.isFull;
  }

  void add({required SeismicityDecodedHypocenter record}) {
    ensureSeismicityChunkBuilderUsable(poisoned: _poisoned);
    if (_fixed.isFull || _canonical.isFull || _intensities.isFull) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Public chunk capacity exceeded.',
      );
    }
    _fixed.add(row: record);
    try {
      _beforeCanonicalAdd?.call();
      _canonical.add(row: record);
      _beforeIntensityAdd?.call();
      _intensities.add(maxIntensityUtf8: record.maxIntensityUtf8);
    } on SeismicityPmTilesException {
      _poisoned = true;
      rethrow;
    }
  }

  bool uuidEquals({required int rowIndex, required Uint8List candidate}) {
    ensureSeismicityChunkBuilderUsable(poisoned: _poisoned);
    return _fixed.uuidEquals(rowIndex: rowIndex, candidate: candidate);
  }

  bool originTimeEquals({required int rowIndex, required int candidate}) {
    ensureSeismicityChunkBuilderUsable(poisoned: _poisoned);
    return _fixed.originTimeEquals(rowIndex: rowIndex, candidate: candidate);
  }

  bool matches({
    required int localIndex,
    required SeismicityDecodedHypocenter record,
  }) {
    ensureSeismicityChunkBuilderUsable(poisoned: _poisoned);
    return _fixed.originTimeEquals(
          rowIndex: localIndex,
          candidate: record.originTimeUnixMilliseconds,
        ) &&
        _intensities.matches(
          localIndex: localIndex,
          maxIntensityUtf8: record.maxIntensityUtf8,
        ) &&
        _canonical.matches(localIndex: localIndex, record: record);
  }

  SeismicityPmTilesChunk build() {
    ensureSeismicityChunkBuilderUsable(poisoned: _poisoned);
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

void ensureSeismicityChunkBuilderUsable({required bool poisoned}) {
  if (poisoned) {
    throw const SeismicityPmTilesException.invalidDescriptor(
      reason: 'Public chunk builder is poisoned.',
    );
  }
}

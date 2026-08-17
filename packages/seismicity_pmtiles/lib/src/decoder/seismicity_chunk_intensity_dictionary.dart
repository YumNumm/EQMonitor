import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_canonical_string_columns.dart'
    show
        SeismicityCanonicalUtf8ColumnData,
        allocateSeismicityStringColumn,
        matchesCanonicalUtf8,
        translateSeismicityStringColumnAllocation;
import 'package:seismicity_pmtiles/src/decoder/seismicity_utf8_dictionary.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_validity_bitmap.dart';

final class SeismicityChunkIntensityDictionary {
  new({required int capacity})
    : _dictionary = SeismicityUtf8Dictionary(
        maxBytes: 0xffffffff,
        maxEntries: capacity,
      ) {
    final storage = translateSeismicityStringColumnAllocation(
      allocate: () => allocateSeismicityStringColumn(
        () => (
          indexes: Uint32List(capacity),
          validity: Uint8List(requiredByteLength(valueCount: capacity)),
        ),
      ),
    );
    _indexes = storage.indexes;
    _validity = storage.validity;
  }

  final SeismicityUtf8Dictionary _dictionary;
  late final Uint32List _indexes;
  late final Uint8List _validity;
  var _length = 0;

  int get length => _length;
  bool get isFull => _length == _indexes.length;

  void add({required Uint8List? maxIntensityUtf8}) {
    if (isFull) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Max-intensity dictionary capacity exceeded.',
      );
    }
    if (maxIntensityUtf8 != null) {
      _indexes[_length] = _dictionary.indexFor(valueUtf8: maxIntensityUtf8);
      setValid(bytes: _validity, index: _length);
    }
    _length++;
  }

  bool matches({
    required int localIndex,
    required Uint8List? maxIntensityUtf8,
  }) => matchesCanonicalUtf8(
    dictionary: _dictionary,
    indexes: _indexes,
    validity: _validity,
    index: localIndex,
    candidate: maxIntensityUtf8,
  );

  SeismicityCanonicalUtf8ColumnData build() {
    final dictionary = _dictionary.build();
    return translateSeismicityStringColumnAllocation(
      allocate: () => allocateSeismicityStringColumn(
        () => (
          dictionaryIndexes: _indexes.sublist(0, _length),
          validity: _validity.sublist(
            0,
            requiredByteLength(valueCount: _length),
          ),
          dictionaryUtf8: dictionary.bytes,
          dictionaryOffsets: dictionary.entryOffsets,
        ),
      ),
    );
  }
}

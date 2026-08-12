import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_utf8_dictionary.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_validity_bitmap.dart';

typedef SeismicityCanonicalUtf8ColumnData = ({
  Uint32List dictionaryIndexes,
  Uint8List validity,
  Uint8List dictionaryUtf8,
  Uint32List dictionaryOffsets,
});

typedef SeismicityCanonicalStringColumnData = ({
  SeismicityCanonicalUtf8ColumnData determinationFlag,
  SeismicityCanonicalUtf8ColumnData earthquakeEventId,
});

final class SeismicityCanonicalStringColumns {
  SeismicityCanonicalStringColumns({required int capacity})
    : _determinationFlags = SeismicityUtf8Dictionary(
        maxBytes: 0xffffffff,
        maxEntries: capacity,
      ),
      _earthquakeEventIds = SeismicityUtf8Dictionary(
        maxBytes: 0xffffffff,
        maxEntries: capacity,
      ) {
    final bitmapLength = requiredByteLength(valueCount: capacity);
    _determinationFlagIndexes = Uint32List(capacity);
    _determinationFlagValidity = Uint8List(bitmapLength);
    _earthquakeEventIdIndexes = Uint32List(capacity);
    _earthquakeEventIdValidity = Uint8List(bitmapLength);
  }

  final SeismicityUtf8Dictionary _determinationFlags;
  final SeismicityUtf8Dictionary _earthquakeEventIds;
  late final Uint32List _determinationFlagIndexes;
  late final Uint8List _determinationFlagValidity;
  late final Uint32List _earthquakeEventIdIndexes;
  late final Uint8List _earthquakeEventIdValidity;
  var _length = 0;
  int get length => _length;
  bool get isFull => _length == _determinationFlagIndexes.length;

  void add({
    required Uint8List? determinationFlagUtf8,
    required Uint8List? earthquakeEventIdUtf8,
  }) {
    if (isFull || earthquakeEventIdUtf8?.isEmpty == true) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid canonical string-column row.',
      );
    }
    if (determinationFlagUtf8 != null) {
      _determinationFlagIndexes[_length] = _determinationFlags.indexFor(
        valueUtf8: determinationFlagUtf8,
      );
      setValid(bytes: _determinationFlagValidity, index: _length);
    }
    if (earthquakeEventIdUtf8 != null) {
      _earthquakeEventIdIndexes[_length] = _earthquakeEventIds.indexFor(
        valueUtf8: earthquakeEventIdUtf8,
      );
      setValid(bytes: _earthquakeEventIdValidity, index: _length);
    }
    _length++;
  }

  SeismicityCanonicalStringColumnData build() {
    final bitmapLength = requiredByteLength(valueCount: _length);
    final determinationFlags = _determinationFlags.build();
    final earthquakeEventIds = _earthquakeEventIds.build();
    return (
      determinationFlag: (
        dictionaryIndexes: _determinationFlagIndexes.sublist(0, _length),
        validity: _determinationFlagValidity.sublist(0, bitmapLength),
        dictionaryUtf8: determinationFlags.bytes,
        dictionaryOffsets: determinationFlags.entryOffsets,
      ),
      earthquakeEventId: (
        dictionaryIndexes: _earthquakeEventIdIndexes.sublist(0, _length),
        validity: _earthquakeEventIdValidity.sublist(0, bitmapLength),
        dictionaryUtf8: earthquakeEventIds.bytes,
        dictionaryOffsets: earthquakeEventIds.entryOffsets,
      ),
    );
  }
}

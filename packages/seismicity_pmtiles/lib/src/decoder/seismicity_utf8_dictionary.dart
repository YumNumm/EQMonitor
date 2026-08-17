// Descriptor-bound allocation failures must remain typed at this boundary.
// ignore_for_file: avoid_catching_errors

import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_utf8_arena.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_uuid_index.dart'
    show seismicityUuidHash;
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class SeismicityUtf8Dictionary {
  SeismicityUtf8Dictionary({
    required int maxBytes,
    required int maxEntries,
    Uint32List Function(int length)? allocateSlots,
  }) : _maxEntries = maxEntries,
       _arena = SeismicityUtf8Arena(
         maxBytes: maxBytes,
         maxEntries: maxEntries,
       ) {
    if (maxEntries < 0 || maxEntries > 0x3fffffff) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid UTF-8 dictionary capacity.',
      );
    }
    var capacity = 1;
    final requiredCapacity = maxEntries * 2;
    while (capacity < requiredCapacity) {
      capacity <<= 1;
    }
    try {
      _slots = (allocateSlots ?? Uint32List.new)(capacity);
    } on OutOfMemoryError {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Cannot allocate UTF-8 dictionary index.',
      );
    } on RangeError {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Cannot allocate UTF-8 dictionary index.',
      );
    }
  }

  final int _maxEntries;
  final SeismicityUtf8Arena _arena;
  late final Uint32List _slots;
  var _length = 0;

  int indexFor({required Uint8List valueUtf8}) {
    final mask = _slots.length - 1;
    var slot = seismicityUuidHash(id: valueUtf8) & mask;
    while (_slots[slot] != 0) {
      final index = _slots[slot] - 1;
      if (_arena.equalsAt(index: index, candidateUtf8: valueUtf8)) {
        return index;
      }
      slot = (slot + 1) & mask;
    }
    if (_length >= _maxEntries) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'UTF-8 dictionary capacity exceeded.',
      );
    }
    final index = _arena.append(valueUtf8: valueUtf8);
    _slots[slot] = index + 1;
    _length++;
    return index;
  }

  bool equalsAt({required int index, required Uint8List candidateUtf8}) =>
      _arena.equalsAt(index: index, candidateUtf8: candidateUtf8);

  ({Uint8List bytes, Uint32List entryOffsets}) build() => _arena.build();
}

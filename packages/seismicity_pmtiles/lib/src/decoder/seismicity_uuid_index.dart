// Descriptor-bound allocation failures must remain typed at this boundary.
// ignore_for_file: avoid_catching_errors

import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

typedef SeismicityUuidEquals =
    bool Function({required int rowIndex, required Uint8List candidate});

final class SeismicityUuidIndex {
  SeismicityUuidIndex({
    required int expectedUniqueCount,
    Uint32List Function(int length)? allocateSlots,
  }) : _expectedUniqueCount = expectedUniqueCount {
    if (expectedUniqueCount < 0 || expectedUniqueCount > 0x3fffffff) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid UUID index capacity.',
      );
    }
    var capacity = 1;
    final requiredCapacity = expectedUniqueCount * 2;
    while (capacity < requiredCapacity) {
      capacity <<= 1;
    }
    try {
      _slots = (allocateSlots ?? Uint32List.new)(capacity);
    } on OutOfMemoryError {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Cannot allocate UUID index.',
      );
    } on RangeError {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Cannot allocate UUID index.',
      );
    }
  }

  final int _expectedUniqueCount;
  late final Uint32List _slots;
  var _length = 0;

  int? find({required Uint8List id, required SeismicityUuidEquals equals}) {
    if (id.length != 16) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'A UUID index key must contain 16 bytes.',
      );
    }
    final mask = _slots.length - 1;
    var slot = seismicityUuidHash(id: id) & mask;
    while (true) {
      final stored = _slots[slot];
      if (stored == 0) {
        return null;
      }
      final rowIndex = stored - 1;
      if (equals(rowIndex: rowIndex, candidate: id)) {
        return rowIndex;
      }
      slot = (slot + 1) & mask;
    }
  }

  void insert({
    required Uint8List id,
    required int rowIndex,
    required SeismicityUuidEquals equals,
  }) {
    if (rowIndex < 0 || rowIndex >= _expectedUniqueCount) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'UUID index row is outside the descriptor capacity.',
      );
    }
    if (find(id: id, equals: equals) != null ||
        _length >= _expectedUniqueCount) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Duplicate or full UUID index.',
      );
    }
    final mask = _slots.length - 1;
    var slot = seismicityUuidHash(id: id) & mask;
    while (_slots[slot] != 0) {
      slot = (slot + 1) & mask;
    }
    _slots[slot] = rowIndex + 1;
    _length++;
  }
}

int seismicityUuidHash({required Uint8List id}) {
  var hash = 0x811c9dc5;
  for (final byte in id) {
    hash = ((hash ^ byte) * 0x01000193) & 0xffffffff;
  }
  return hash;
}

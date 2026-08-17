// Arena allocations are descriptor-bound and must fail through the typed API.
// ignore_for_file: avoid_catching_errors

import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class SeismicityUtf8Arena {
  new({
    required int maxBytes,
    required int maxEntries,
    Uint8List Function(int length)? allocateBuildBytes,
    Uint32List Function(int length)? allocateBuildOffsets,
  }) : _maxBytes = maxBytes,
       _maxEntries = maxEntries,
       _allocateBuildBytes = allocateBuildBytes ?? Uint8List.new,
       _allocateBuildOffsets = allocateBuildOffsets ?? Uint32List.new {
    if (maxBytes < 0 ||
        maxBytes > 0xffffffff ||
        maxEntries < 0 ||
        maxEntries > 0xffffffff) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid UTF-8 arena limits.',
      );
    }
  }

  final int _maxBytes;
  final int _maxEntries;
  final Uint8List Function(int length) _allocateBuildBytes;
  final Uint32List Function(int length) _allocateBuildOffsets;
  var _bytes = Uint8List(0);
  var _entryOffsets = Uint32List(1);
  var _byteLength = 0;
  var _entryCount = 0;

  int append({required Uint8List valueUtf8}) {
    if (_entryCount >= _maxEntries ||
        valueUtf8.length > _maxBytes - _byteLength) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'UTF-8 arena limit exceeded.',
      );
    }
    final requiredBytes = _byteLength + valueUtf8.length;
    final requiredOffsets = _entryCount + 2;
    try {
      if (requiredBytes > _bytes.length) {
        var capacity = _bytes.isEmpty ? 1 : _bytes.length;
        while (capacity < requiredBytes) {
          capacity = capacity > _maxBytes ~/ 2 ? _maxBytes : capacity * 2;
        }
        final grown = Uint8List(capacity);
        grown.setRange(0, _byteLength, _bytes);
        _bytes = grown;
      }
      if (requiredOffsets > _entryOffsets.length) {
        var capacity = _entryOffsets.length;
        final limit = _maxEntries + 1;
        while (capacity < requiredOffsets) {
          capacity = capacity > limit ~/ 2 ? limit : capacity * 2;
        }
        final grown = Uint32List(capacity);
        grown.setRange(0, _entryCount + 1, _entryOffsets);
        _entryOffsets = grown;
      }
    } on OutOfMemoryError {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Cannot allocate UTF-8 arena.',
      );
    } on RangeError {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Cannot allocate UTF-8 arena.',
      );
    }
    final entryIndex = _entryCount;
    _bytes.setRange(_byteLength, requiredBytes, valueUtf8);
    _byteLength = requiredBytes;
    _entryCount++;
    _entryOffsets[_entryCount] = _byteLength;
    return entryIndex;
  }

  bool equalsAt({required int index, required Uint8List candidateUtf8}) {
    if (index < 0 || index >= _entryCount) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'UTF-8 arena index is outside the stored entries.',
      );
    }
    final start = _entryOffsets[index];
    final end = _entryOffsets[index + 1];
    if (end - start != candidateUtf8.length) {
      return false;
    }
    for (var offset = 0; offset < candidateUtf8.length; offset++) {
      if (_bytes[start + offset] != candidateUtf8[offset]) {
        return false;
      }
    }
    return true;
  }

  ({Uint8List bytes, Uint32List entryOffsets}) build() {
    try {
      final bytes = _allocateBuildBytes(_byteLength)
        ..setRange(0, _byteLength, _bytes);
      final entryOffsets = _allocateBuildOffsets(_entryCount + 1)
        ..setRange(0, _entryCount + 1, _entryOffsets);
      return (bytes: bytes, entryOffsets: entryOffsets);
    } on OutOfMemoryError {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Cannot allocate UTF-8 arena output.',
      );
    } on RangeError {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Cannot allocate UTF-8 arena output.',
      );
    }
  }
}

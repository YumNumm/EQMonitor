// Descriptor-bound allocation errors must remain typed at this boundary.
// ignore_for_file: avoid_catching_errors

import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_validity_bitmap.dart';

typedef SeismicityCanonicalFixedColumnData = ({
  Int64List globalXs,
  Int64List globalYs,
  Float64List magnitudes,
  Uint8List magnitudeValidity,
  Float64List depthsKm,
  Uint8List depthValidity,
  Uint8List geometryClampedValues,
  Uint8List geometryClampedValidity,
});

typedef SeismicityFixedColumnAllocator = T Function<T>(T Function() create);

final class SeismicityCanonicalFixedColumns {
  SeismicityCanonicalFixedColumns({
    required int capacity,
    SeismicityFixedColumnAllocator? allocate,
  }) : _allocate = allocate ?? allocateSeismicityCanonicalFixedColumnData {
    if (capacity < 0 || capacity > 0x3fffffff) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid canonical fixed-column capacity.',
      );
    }
    final bitmapLength = requiredByteLength(valueCount: capacity);
    _storage = translateSeismicityCanonicalFixedColumnAllocation(
      allocate: () => _allocate(
        () => (
          globalXs: Int64List(capacity),
          globalYs: Int64List(capacity),
          magnitudes: Float64List(capacity),
          magnitudeValidity: Uint8List(bitmapLength),
          depthsKm: Float64List(capacity),
          depthValidity: Uint8List(bitmapLength),
          geometryClampedValues: Uint8List(bitmapLength),
          geometryClampedValidity: Uint8List(bitmapLength),
        ),
      ),
    );
  }

  final SeismicityFixedColumnAllocator _allocate;
  late final SeismicityCanonicalFixedColumnData _storage;
  var _length = 0;

  int get length => _length;
  bool get isFull => _length == _storage.globalXs.length;

  void add({required SeismicityDecodedHypocenter row}) {
    if (isFull) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Canonical fixed-column capacity exceeded.',
      );
    }
    _storage.globalXs[_length] = row.point.globalX;
    _storage.globalYs[_length] = row.point.globalY;
    final magnitude = row.magnitude;
    if (magnitude != null) {
      final value = magnitude.canonicalValue;
      _storage.magnitudes[_length] = value == 0 ? 0 : value;
      setValid(bytes: _storage.magnitudeValidity, index: _length);
    }
    final depthKm = row.depthKm;
    if (depthKm != null) {
      final value = depthKm.canonicalValue;
      _storage.depthsKm[_length] = value == 0 ? 0 : value;
      setValid(bytes: _storage.depthValidity, index: _length);
    }
    final geometryClamped = row.geometryClamped;
    if (geometryClamped != null) {
      if (geometryClamped) {
        setValid(bytes: _storage.geometryClampedValues, index: _length);
      }
      setValid(bytes: _storage.geometryClampedValidity, index: _length);
    }
    _length++;
  }

  SeismicityCanonicalFixedColumnData build() {
    final bitmapLength = requiredByteLength(valueCount: _length);
    return translateSeismicityCanonicalFixedColumnAllocation(
      allocate: () => _allocate(
        () => (
          globalXs: _storage.globalXs.sublist(0, _length),
          globalYs: _storage.globalYs.sublist(0, _length),
          magnitudes: _storage.magnitudes.sublist(0, _length),
          magnitudeValidity: _storage.magnitudeValidity.sublist(
            0,
            bitmapLength,
          ),
          depthsKm: _storage.depthsKm.sublist(0, _length),
          depthValidity: _storage.depthValidity.sublist(0, bitmapLength),
          geometryClampedValues: _storage.geometryClampedValues.sublist(
            0,
            bitmapLength,
          ),
          geometryClampedValidity: _storage.geometryClampedValidity.sublist(
            0,
            bitmapLength,
          ),
        ),
      ),
    );
  }
}

T allocateSeismicityCanonicalFixedColumnData<T>(T Function() create) =>
    create();

T translateSeismicityCanonicalFixedColumnAllocation<T>({
  required T Function() allocate,
}) {
  try {
    return allocate();
  } on OutOfMemoryError {
    throw const SeismicityPmTilesException.invalidDescriptor(
      reason: 'Cannot allocate canonical fixed columns.',
    );
  } on RangeError {
    throw const SeismicityPmTilesException.invalidDescriptor(
      reason: 'Cannot allocate canonical fixed columns.',
    );
  }
}

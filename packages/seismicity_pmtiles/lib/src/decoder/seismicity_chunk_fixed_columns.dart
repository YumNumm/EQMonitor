import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_validity_bitmap.dart';

typedef SeismicityChunkFixedColumnData = ({
  Uint8List hypocenterIds,
  Float64List latitudes,
  Float64List longitudes,
  Float32List depthsKm,
  Uint8List depthValidity,
  Float32List magnitudes,
  Uint8List magnitudeValidity,
  Int64List originTimeUnixMilliseconds,
});

final class SeismicityChunkFixedColumns {
  SeismicityChunkFixedColumns({required int capacity}) {
    if (capacity <= 0 || capacity > 0x3fffffff) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid public fixed-column capacity.',
      );
    }
    final bitmapLength = requiredByteLength(valueCount: capacity);
    _storage = (
      hypocenterIds: Uint8List(capacity * 16),
      latitudes: Float64List(capacity),
      longitudes: Float64List(capacity),
      depthsKm: Float32List(capacity)..fillRange(0, capacity, double.nan),
      depthValidity: Uint8List(bitmapLength),
      magnitudes: Float32List(capacity)..fillRange(0, capacity, double.nan),
      magnitudeValidity: Uint8List(bitmapLength),
      originTimeUnixMilliseconds: Int64List(capacity),
    );
  }

  late final SeismicityChunkFixedColumnData _storage;
  var _length = 0;
  int get length => _length;
  bool get isFull => _length == _storage.latitudes.length;

  void add({required SeismicityDecodedHypocenter row}) {
    if (isFull) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Public fixed-column capacity exceeded.',
      );
    }
    final idOffset = _length * 16;
    _storage.hypocenterIds.setRange(idOffset, idOffset + 16, row.hypocenterId);
    _storage.latitudes[_length] = row.point.latitude;
    _storage.longitudes[_length] = row.point.longitude;
    final depth = row.depthKm?.storageValue;
    if (depth != null) {
      _storage.depthsKm[_length] = depth;
      setValid(bytes: _storage.depthValidity, index: _length);
    }
    final magnitude = row.magnitude?.storageValue;
    if (magnitude != null) {
      _storage.magnitudes[_length] = magnitude;
      setValid(bytes: _storage.magnitudeValidity, index: _length);
    }
    _storage.originTimeUnixMilliseconds[_length] =
        row.originTimeUnixMilliseconds;
    _length++;
  }

  SeismicityChunkFixedColumnData build() {
    final bitmapLength = requiredByteLength(valueCount: _length);
    return (
      hypocenterIds: _storage.hypocenterIds.sublist(0, _length * 16),
      latitudes: _storage.latitudes.sublist(0, _length),
      longitudes: _storage.longitudes.sublist(0, _length),
      depthsKm: _storage.depthsKm.sublist(0, _length),
      depthValidity: _storage.depthValidity.sublist(0, bitmapLength),
      magnitudes: _storage.magnitudes.sublist(0, _length),
      magnitudeValidity: _storage.magnitudeValidity.sublist(0, bitmapLength),
      originTimeUnixMilliseconds: _storage.originTimeUnixMilliseconds.sublist(
        0,
        _length,
      ),
    );
  }
}

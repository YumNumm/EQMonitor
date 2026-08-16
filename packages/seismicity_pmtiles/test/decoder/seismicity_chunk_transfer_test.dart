import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_transfer.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:test/test.dart';

void main() {
  test('transfers exact typed chunk bytes once across an isolate', () async {
    final source = chunk();
    final transfer = SeismicityChunkTransfer.fromChunk(chunk: source);
    final received = await Isolate.run(() => transfer);
    final actual = received.materialize();

    for (final (actualColumn, sourceColumn) in [
      (actual.hypocenterIds, source.hypocenterIds),
      (actual.latitudes, source.latitudes),
      (actual.longitudes, source.longitudes),
      (actual.depthsKm, source.depthsKm),
      (actual.depthValidity, source.depthValidity),
      (actual.magnitudes, source.magnitudes),
      (actual.magnitudeValidity, source.magnitudeValidity),
      (
        actual.originTimeUnixMilliseconds,
        source.originTimeUnixMilliseconds,
      ),
      (
        actual.maxIntensityDictionaryIndexes,
        source.maxIntensityDictionaryIndexes,
      ),
      (actual.maxIntensityValidity, source.maxIntensityValidity),
      (actual.maxIntensityDictionaryUtf8, source.maxIntensityDictionaryUtf8),
      (
        actual.maxIntensityDictionaryOffsets,
        source.maxIntensityDictionaryOffsets,
      ),
    ]) {
      expect(actualColumn.runtimeType, sourceColumn.runtimeType);
      expect(typedBytes(actualColumn), typedBytes(sourceColumn));
    }
    expect(actual.depthValidity, [1]);
    expect(actual.magnitudeValidity, [2]);
    expect(actual.maxIntensityValidity, [1]);
    expect(actual.maxIntensityDictionaryUtf8, utf8.encode('5強'));
    expect(actual.maxIntensityDictionaryOffsets, [0, 4]);
    expect(received.materialize, throwsArgumentError);
  });
}

Uint8List typedBytes(TypedData data) => data.buffer.asUint8List(
  data.offsetInBytes,
  data.lengthInBytes,
);

SeismicityPmTilesChunk chunk() => SeismicityPmTilesChunk(
  hypocenterIds: u8(List.generate(32, (index) => index)),
  latitudes: f64([35, 36]),
  longitudes: f64([139, 140]),
  depthsKm: f32([10, double.nan]),
  depthValidity: u8([1]),
  magnitudes: f32([double.nan, 5.1]),
  magnitudeValidity: u8([2]),
  originTimeUnixMilliseconds: i64([1, 2]),
  maxIntensityDictionaryIndexes: u32([0, 99]),
  maxIntensityValidity: u8([1]),
  maxIntensityDictionaryUtf8: u8(utf8.encode('5強')),
  maxIntensityDictionaryOffsets: u32([0, 4]),
);

Uint8List u8(List<int> values) => Uint8List.sublistView(
  Uint8List.fromList([255, ...values, 255]),
  1,
  values.length + 1,
);
Float64List f64(List<double> values) => Float64List.sublistView(
  Float64List.fromList([0, ...values, 0]),
  1,
  values.length + 1,
);
Float32List f32(List<double> values) => Float32List.sublistView(
  Float32List.fromList([0, ...values, 0]),
  1,
  values.length + 1,
);
Int64List i64(List<int> values) => Int64List.sublistView(
  Int64List.fromList([0, ...values, 0]),
  1,
  values.length + 1,
);
Uint32List u32(List<int> values) => Uint32List.sublistView(
  Uint32List.fromList([99, ...values, 99]),
  1,
  values.length + 1,
);

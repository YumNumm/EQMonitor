import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_value_decoder.dart';
import 'package:uuid/uuid.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

typedef SeismicityDecodedHypocenterProperties = ({
  Uint8List hypocenterId,
  int originTimeUnixMilliseconds,
  ({double canonicalValue, double storageValue})? magnitude,
  ({double canonicalValue, double storageValue})? depthKm,
  Uint8List? maxIntensityUtf8,
  Uint8List? determinationFlagUtf8,
  Uint8List? earthquakeEventIdUtf8,
  bool? geometryClamped,
});

final class SeismicityMvtPropertyDecoder {
  const SeismicityMvtPropertyDecoder();

  SeismicityDecodedHypocenterProperties decode({
    required List<int> tags,
    required List<String> keys,
    required List<VectorTile_Value> values,
    required int tileId,
    required int featureIndex,
  }) {
    const valueDecoder = SeismicityMvtValueDecoder();
    Uint8List? hypocenterId;
    int? originTime;
    ({double canonicalValue, double storageValue})? magnitude;
    ({double canonicalValue, double storageValue})? depthKm;
    Uint8List? maxIntensity;
    Uint8List? determinationFlag;
    Uint8List? earthquakeEventId;
    bool? geometryClamped;

    for (var index = 0; index < tags.length; index += 2) {
      final field = keys[tags[index]];
      final value = values[tags[index + 1]];
      String string() => valueDecoder.requireString(
        value: value,
        tileId: tileId,
        featureIndex: featureIndex,
        field: field,
      );
      Uint8List bytes() => Uint8List.fromList(utf8.encode(string()));
      ({double canonicalValue, double storageValue}) number() =>
          valueDecoder.requireFiniteFloat32Number(
            value: value,
            tileId: tileId,
            featureIndex: featureIndex,
            field: field,
          );
      switch (field) {
        case 'hypocenter_id':
          hypocenterId = Uuid.parseAsByteList(string());
        case 'origin_time_unix_ms':
          originTime = valueDecoder.requireSafeInteger(
            value: value,
            tileId: tileId,
            featureIndex: featureIndex,
            field: field,
          );
        case 'magnitude':
          magnitude = number();
        case 'depth_km':
          depthKm = number();
        case 'max_intensity':
          maxIntensity = bytes();
        case 'determination_flag':
          determinationFlag = bytes();
        case 'earthquake_event_id':
          earthquakeEventId = bytes();
        case 'geometry_clamped':
          geometryClamped = valueDecoder.requireBool(
            value: value,
            tileId: tileId,
            featureIndex: featureIndex,
            field: field,
          );
      }
    }
    return switch ((hypocenterId, originTime)) {
      (final id?, final time?) => (
        hypocenterId: id,
        originTimeUnixMilliseconds: time,
        magnitude: magnitude,
        depthKm: depthKm,
        maxIntensityUtf8: maxIntensity,
        determinationFlagUtf8: determinationFlag,
        earthquakeEventIdUtf8: earthquakeEventId,
        geometryClamped: geometryClamped,
      ),
      _ => throw StateError('Missing required schema-v1 property.'),
    };
  }
}

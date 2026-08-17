import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_value_decoder.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_schema_v1_validator.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
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
  const new();

  SeismicityDecodedHypocenterProperties decode({
    required List<int> tags,
    required List<String> keys,
    required List<VectorTile_Value> values,
    required int tileId,
    required int featureIndex,
  }) {
    const valueDecoder = SeismicityMvtValueDecoder();
    Never fail({required String field, required String reason}) =>
        throw SeismicityPmTilesException.invalidHypocenterFeature(
          tileId: tileId,
          featureIndex: featureIndex,
          field: field,
          reason: reason,
        );
    if (tags.length.isOdd) {
      fail(field: 'tags', reason: 'odd_tag_count');
    }
    Uint8List? hypocenterId;
    int? originTime;
    ({double canonicalValue, double storageValue})? magnitude;
    ({double canonicalValue, double storageValue})? depthKm;
    Uint8List? maxIntensity;
    Uint8List? determinationFlag;
    Uint8List? earthquakeEventId;
    bool? geometryClamped;
    var seenFields = 0;

    for (var index = 0; index < tags.length; index += 2) {
      final keyIndex = tags[index];
      if (keyIndex < 0 || keyIndex >= keys.length) {
        fail(field: 'tags', reason: 'key_index_out_of_range');
      }
      final field = keys[keyIndex];
      const SeismicitySchemaV1Validator().validatePropertyName(
        name: field,
        tileId: tileId,
        featureIndex: featureIndex,
      );
      final fieldBit = switch (field) {
        'hypocenter_id' => 1,
        'origin_time_unix_ms' => 2,
        'magnitude' => 4,
        'depth_km' => 8,
        'max_intensity' => 16,
        'determination_flag' => 32,
        'earthquake_event_id' => 64,
        'geometry_clamped' => 128,
        _ => 0,
      };
      if ((seenFields & fieldBit) != 0) {
        fail(field: field, reason: 'duplicate_property');
      }
      seenFields |= fieldBit;
      final valueIndex = tags[index + 1];
      if (valueIndex < 0 || valueIndex >= values.length) {
        fail(field: field, reason: 'value_index_out_of_range');
      }
      final value = values[valueIndex];
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
          final source = string();
          try {
            final parsed = Uuid.parseAsByteList(source);
            if (Uuid.unparse(parsed) != source) {
              fail(field: field, reason: 'invalid_uuid');
            }
            hypocenterId = parsed;
          } on FormatException {
            fail(field: field, reason: 'invalid_uuid');
          }
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
          if (earthquakeEventId.isEmpty) {
            fail(field: field, reason: 'empty_string');
          }
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
      (null, _) => fail(
        field: 'hypocenter_id',
        reason: 'missing_required_property',
      ),
      (_, null) => fail(
        field: 'origin_time_unix_ms',
        reason: 'missing_required_property',
      ),
    };
  }
}

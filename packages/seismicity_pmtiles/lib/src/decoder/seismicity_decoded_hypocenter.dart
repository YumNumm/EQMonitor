import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_point_decoder.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class SeismicityDecodedHypocenter {
  new({
    required this.tileId,
    required this.featureIndex,
    required this.hypocenterId,
    required this.point,
    required this.originTimeUnixMilliseconds,
    required this.magnitude,
    required this.depthKm,
    required this.maxIntensityUtf8,
    required this.determinationFlagUtf8,
    required this.earthquakeEventIdUtf8,
    required this.geometryClamped,
  }) {
    Never fail({required String field, required String reason}) =>
        throw SeismicityPmTilesException.invalidHypocenterFeature(
          tileId: tileId,
          featureIndex: featureIndex,
          field: field,
          reason: reason,
        );
    if (hypocenterId.length != 16) {
      fail(field: 'hypocenter_id', reason: 'invalid_uuid');
    }
    if (earthquakeEventIdUtf8 case final value? when value.isEmpty) {
      fail(field: 'earthquake_event_id', reason: 'empty_string');
    }
  }

  final int tileId;
  final int featureIndex;
  final Uint8List hypocenterId;
  final SeismicityMvtPoint point;
  final int originTimeUnixMilliseconds;
  final ({double canonicalValue, double storageValue})? magnitude;
  final ({double canonicalValue, double storageValue})? depthKm;
  final Uint8List? maxIntensityUtf8;
  final Uint8List? determinationFlagUtf8;
  final Uint8List? earthquakeEventIdUtf8;
  final bool? geometryClamped;
}

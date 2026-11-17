import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_point_decoder.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class SeismicityDecodedHypocenter({
  required final int tileId,
  required final int featureIndex,
  required final Uint8List hypocenterId,
  required final SeismicityMvtPoint point,
  required final int originTimeUnixMilliseconds,
  required final ({double canonicalValue, double storageValue})? magnitude,
  required final ({double canonicalValue, double storageValue})? depthKm,
  required final Uint8List? maxIntensityUtf8,
  required final Uint8List? determinationFlagUtf8,
  required final Uint8List? earthquakeEventIdUtf8,
  required final bool? geometryClamped,
}) {
  this {
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
}

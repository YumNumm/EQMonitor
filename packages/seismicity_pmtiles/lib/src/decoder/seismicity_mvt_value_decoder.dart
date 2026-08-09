import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

final class SeismicityMvtValueDecoder {
  const SeismicityMvtValueDecoder();

  String requireString({
    required VectorTile_Value value,
    required int tileId,
    required int featureIndex,
    required String field,
  }) {
    validateScalarCardinality(
      value: value,
      tileId: tileId,
      featureIndex: featureIndex,
      field: field,
    );
    if (!value.hasStringValue()) {
      throw SeismicityPmTilesException.invalidHypocenterFeature(
        tileId: tileId,
        featureIndex: featureIndex,
        field: field,
        reason: 'wrong_scalar_type',
      );
    }
    return value.stringValue;
  }

  bool requireBool({
    required VectorTile_Value value,
    required int tileId,
    required int featureIndex,
    required String field,
  }) {
    validateScalarCardinality(
      value: value,
      tileId: tileId,
      featureIndex: featureIndex,
      field: field,
    );
    if (!value.hasBoolValue()) {
      throw SeismicityPmTilesException.invalidHypocenterFeature(
        tileId: tileId,
        featureIndex: featureIndex,
        field: field,
        reason: 'wrong_scalar_type',
      );
    }
    return value.boolValue;
  }

  void validateScalarCardinality({
    required VectorTile_Value value,
    required int tileId,
    required int featureIndex,
    required String field,
  }) {
    var count = 0;
    if (value.hasStringValue()) {
      count++;
    }
    if (value.hasFloatValue()) {
      count++;
    }
    if (value.hasDoubleValue()) {
      count++;
    }
    if (value.hasIntValue()) {
      count++;
    }
    if (value.hasUintValue()) {
      count++;
    }
    if (value.hasSintValue()) {
      count++;
    }
    if (value.hasBoolValue()) {
      count++;
    }
    if (count != 1) {
      throw SeismicityPmTilesException.invalidHypocenterFeature(
        tileId: tileId,
        featureIndex: featureIndex,
        field: field,
        reason: 'invalid_scalar_cardinality',
      );
    }
  }
}

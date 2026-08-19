import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

final class SeismicityMvtValueDecoder {
  const new();

  static final _float32Buffer = Float32List(1);

  String requireString({
    required VectorTile_Value value,
    required int tileId,
    required int featureIndex,
    required String field,
  }) {
    value.validateScalarCardinality(
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
    value.validateScalarCardinality(
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

  ({double canonicalValue, double storageValue}) requireFiniteFloat32Number({
    required VectorTile_Value value,
    required int tileId,
    required int featureIndex,
    required String field,
  }) {
    value.validateScalarCardinality(
      tileId: tileId,
      featureIndex: featureIndex,
      field: field,
    );
    final double decoded;
    if (value.hasFloatValue()) {
      decoded = value.floatValue;
    } else if (value.hasDoubleValue()) {
      decoded = value.doubleValue;
    } else if (value.hasIntValue()) {
      decoded = value.intValue.toDouble();
    } else if (value.hasUintValue() && !value.uintValue.isNegative) {
      decoded = value.uintValue.toDouble();
    } else if (value.hasSintValue()) {
      decoded = value.sintValue.toDouble();
    } else {
      throw SeismicityPmTilesException.invalidHypocenterFeature(
        tileId: tileId,
        featureIndex: featureIndex,
        field: field,
        reason: value.hasUintValue() ? 'unsafe_integer' : 'wrong_scalar_type',
      );
    }
    if (!decoded.isFinite) {
      throw SeismicityPmTilesException.invalidHypocenterFeature(
        tileId: tileId,
        featureIndex: featureIndex,
        field: field,
        reason: 'non_finite_number',
      );
    }
    final canonicalValue = decoded == 0 ? 0.0 : decoded;
    _float32Buffer[0] = canonicalValue;
    final storageValue = _float32Buffer[0];
    if (!storageValue.isFinite) {
      throw SeismicityPmTilesException.invalidHypocenterFeature(
        tileId: tileId,
        featureIndex: featureIndex,
        field: field,
        reason: 'float32_overflow',
      );
    }
    return (canonicalValue: canonicalValue, storageValue: storageValue);
  }

  int requireSafeInteger({
    required VectorTile_Value value,
    required int tileId,
    required int featureIndex,
    required String field,
  }) {
    value.validateScalarCardinality(
      tileId: tileId,
      featureIndex: featureIndex,
      field: field,
    );
    if (value.hasIntValue()) {
      return value.intValue.toInt();
    }
    if (value.hasSintValue()) {
      return value.sintValue.toInt();
    }
    if (value.hasUintValue() && !value.uintValue.isNegative) {
      return value.uintValue.toInt();
    }
    if (value.hasDoubleValue()) {
      final decoded = value.doubleValue;
      if (decoded.isFinite &&
          decoded == decoded.truncateToDouble() &&
          decoded.abs() <= 9007199254740991) {
        return decoded.toInt();
      }
    }
    final numericButUnsafe = value.hasDoubleValue() || value.hasUintValue();
    throw SeismicityPmTilesException.invalidHypocenterFeature(
      tileId: tileId,
      featureIndex: featureIndex,
      field: field,
      reason: numericButUnsafe ? 'unsafe_integer' : 'wrong_scalar_type',
    );
  }
}

// 無名extensionに置き、共有validatorをimport先へ公開しない。
extension on VectorTile_Value {
  void validateScalarCardinality({
    required int tileId,
    required int featureIndex,
    required String field,
  }) {
    var count = 0;
    if (hasStringValue()) {
      count++;
    }
    if (hasFloatValue()) {
      count++;
    }
    if (hasDoubleValue()) {
      count++;
    }
    if (hasIntValue()) {
      count++;
    }
    if (hasUintValue()) {
      count++;
    }
    if (hasSintValue()) {
      count++;
    }
    if (hasBoolValue()) {
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

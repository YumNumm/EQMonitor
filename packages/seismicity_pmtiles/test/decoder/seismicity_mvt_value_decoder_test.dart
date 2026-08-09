import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_value_decoder.dart';
import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

void main() {
  const decoder = SeismicityMvtValueDecoder();
  String string(VectorTile_Value value) => decoder.requireString(
    value: value,
    tileId: 5,
    featureIndex: 0,
    field: 'depth_km',
  );
  bool boolean(VectorTile_Value value) => decoder.requireBool(
    value: value,
    tileId: 5,
    featureIndex: 0,
    field: 'depth_km',
  );
  ({double canonicalValue, double storageValue}) number(
    VectorTile_Value value,
  ) => decoder.requireFiniteFloat32Number(
    value: value,
    tileId: 5,
    featureIndex: 0,
    field: 'depth_km',
  );
  int safeInteger(VectorTile_Value value) => decoder.requireSafeInteger(
    value: value,
    tileId: 5,
    featureIndex: 0,
    field: 'depth_km',
  );

  test('decodes exact strings, booleans, and every numeric scalar', () {
    expect(string(raw(string: '')), '');
    expect(string(raw(string: '震源')), '震源');
    expect(boolean(raw(boolean: false)), isFalse);
    expect(boolean(raw(boolean: true)), isTrue);
    final cases = [
      (raw(float: 1.5), 1.5),
      (raw(double: -2.25), -2.25),
      (integer(field: 'intValue', value: '-3'), -3.0),
      (integer(field: 'uintValue', value: '4'), 4.0),
      (integer(field: 'sintValue', value: '-5'), -5.0),
    ];
    for (final (value, expected) in cases) {
      expect(
        number(value),
        (canonicalValue: expected, storageValue: expected),
      );
    }
    final zero = number(raw(double: double.parse('-0')));
    expect(zero, (canonicalValue: 0.0, storageValue: 0.0));
    expect(zero.canonicalValue.isNegative, isFalse);
    expect(zero.storageValue.isNegative, isFalse);
  });

  test('decodes safe integer-family and integral double values', () {
    final cases = [
      (
        integer(field: 'intValue', value: '-9223372036854775808'),
        -9223372036854775808,
      ),
      (
        integer(field: 'intValue', value: '9223372036854775807'),
        9223372036854775807,
      ),
      (integer(field: 'uintValue', value: '42'), 42),
      (integer(field: 'sintValue', value: '-42'), -42),
      (raw(double: 9007199254740991), 9007199254740991),
      (raw(double: -9007199254740991), -9007199254740991),
    ];
    for (final (value, expected) in cases) {
      expect(safeInteger(value), expected);
    }
  });

}

VectorTile_Value integer({required String field, required String value}) {
  final tag = switch (field) {
    'intValue' => 4,
    'uintValue' => 5,
    'sintValue' => 6,
    _ => throw ArgumentError.value(field),
  };
  return VectorTile_Value.fromJson('{"$tag":"$value"}');
}

VectorTile_Value raw({
  String? string,
  double? float,
  double? double,
  bool? boolean,
}) => createVectorTileValue(
  stringValue: string,
  floatValue: float,
  doubleValue: double,
  boolValue: boolean,
);

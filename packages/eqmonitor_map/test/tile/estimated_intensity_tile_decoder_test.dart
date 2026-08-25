import 'dart:typed_data';

import 'package:eqmonitor_map/src/mesh/fill_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/estimated_intensity_tile_decoder.dart';
import 'package:eqmonitor_map/src/tile/estimated_intensity_tile_geometry.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mvt/support/mvt_fixture_builder.dart';

const _builder = MvtFixtureBuilder();
const _classes = [
  'intensity:4',
  'intensity:5-',
  'intensity:5+',
  'intensity:6-',
  'intensity:6+',
  'intensity:7',
];
const _mvtLimits = MvtDecodeLimits(
  maxLayers: 4,
  maxFeaturesPerLayer: 16,
  maxRingsPerFeature: 4,
  maxVerticesPerRing: 32,
  maxCommandsPerFeature: 64,
  maxLayerNameBytes: 64,
  maxKeysPerLayer: 8,
  maxValuesPerLayer: 16,
  maxTagsPerFeature: 8,
  maxPropertyStringBytes: 32,
);
const _limits = EstimatedIntensityTileDecodeLimits(
  mvtLimits: _mvtLimits,
  fillLimits: FillMeshBuilderLimits(
    maxHolesPerPolygon: 4,
    maxVerticesPerFeature: 32,
    maxVerticesPerSegment: 128,
  ),
  lineLimits: LineMeshBuilderLimits(maxVerticesPerSegment: 128),
  lineMiterLimit: 4,
);

void main() {
  test('6 classをstyle非依存meshへ変換しfill propertyを無視する', () {
    final bytes = _tile(
      features: [
        for (var index = 0; index < _classes.length; index++)
          _triangle(tags: index == 0 ? [0, index, 1, 6] : [0, index]),
      ],
      keys: const ['name', 'fill'],
      values: [..._classes.map(_builder.stringValue), _builder.intValue(99)],
    );

    final result = decodeEstimatedIntensityTileSync(bytes, _limits);

    expect(result, isA<EstimatedIntensityTileReady>());
    final ready = result as EstimatedIntensityTileReady;
    expect(ready.extent, 4096);
    expect(
      ready.classes.map((geometry) => geometry.intensityClass),
      EstimatedIntensityClass.values,
    );
    for (final geometry in ready.classes) {
      expect(geometry.fillMeshes.single.vertexCount, 3);
      expect(geometry.boundaryMeshes.single.indices, hasLength(18));
    }
  });

  test('required layer absentとpresent emptyを区別する', () {
    final absent = _builder.buildTile(
      layers: [_builder.buildLayer(name: 'Seismic_Intensity')],
    );
    expect(
      () => decodeEstimatedIntensityTileSync(absent, _limits),
      throwsA(
        isA<EstimatedIntensityTileDecodeException>().having(
          (error) => error.failure,
          'failure',
          EstimatedIntensityTileDecodeFailure.missingSourceLayer,
        ),
      ),
    );

    final empty = decodeEstimatedIntensityTileSync(
      _tile(features: const []),
      _limits,
    );
    expect(empty, isA<EstimatedIntensityTileEmpty>());
    expect((empty as EstimatedIntensityTileEmpty).extent, 4096);
  });

  for (final testCase
      in <
        ({
          String name,
          Uint8List bytes,
          EstimatedIntensityTileDecodeFailure failure,
        })
      >[
        (
          name: 'wrong geometry',
          bytes: _tile(
            features: [
              _line(tags: const [0, 0]),
            ],
            keys: const ['name'],
            values: [_builder.stringValue(_classes.first)],
          ),
          failure: EstimatedIntensityTileDecodeFailure.wrongGeometry,
        ),
        (
          name: 'missing name',
          bytes: _tile(features: [_triangle()]),
          failure: EstimatedIntensityTileDecodeFailure.missingName,
        ),
        (
          name: 'unknown class',
          bytes: _tile(
            features: [
              _triangle(tags: const [0, 0]),
            ],
            keys: const ['name'],
            values: [_builder.stringValue('intensity:3')],
          ),
          failure: EstimatedIntensityTileDecodeFailure.unknownClass,
        ),
        (
          name: 'duplicate conflicting property',
          bytes: _tile(
            features: [
              _triangle(tags: const [0, 0, 0, 1]),
            ],
            keys: const ['name'],
            values: [
              _builder.stringValue('intensity:4'),
              _builder.stringValue('intensity:7'),
            ],
          ),
          failure: EstimatedIntensityTileDecodeFailure.invalidMvt,
        ),
        (
          name: 'invalid geometry',
          bytes: _tile(
            features: [
              _degenerateTriangle(tags: const [0, 0]),
            ],
            keys: const ['name'],
            values: [_builder.stringValue(_classes.first)],
          ),
          failure: EstimatedIntensityTileDecodeFailure.invalidGeometry,
        ),
      ]) {
    test('${testCase.name}はtile全体をfail closedにする', () {
      expect(
        () => decodeEstimatedIntensityTileSync(testCase.bytes, _limits),
        throwsA(
          isA<EstimatedIntensityTileDecodeException>().having(
            (error) => error.failure,
            'failure',
            testCase.failure,
          ),
        ),
      );
    });
  }

  test('MVTとmeshの上限超過をresource limitへ集約する', () {
    final bytes = _tile(
      features: [
        _triangle(tags: const [0, 0]),
      ],
      keys: const ['name'],
      values: [_builder.stringValue(_classes.first)],
    );
    final constrainedLimits = [
      _limits.copyWith(
        mvtLimits: _mvtLimits.copyWith(maxFeaturesPerLayer: 0),
      ),
      _limits.copyWith(
        fillLimits: _limits.fillLimits.copyWith(maxVerticesPerFeature: 2),
      ),
      _limits.copyWith(
        lineLimits: _limits.lineLimits.copyWith(maxVerticesPerSegment: 5),
      ),
    ];

    for (final limits in constrainedLimits) {
      expect(
        () => decodeEstimatedIntensityTileSync(bytes, limits),
        throwsA(
          isA<EstimatedIntensityTileDecodeException>().having(
            (error) => error.failure,
            'failure',
            EstimatedIntensityTileDecodeFailure.resourceLimitExceeded,
          ),
        ),
      );
    }
  });
}

Uint8List _tile({
  required List<Uint8List> features,
  List<String> keys = const [],
  List<Uint8List> values = const [],
}) => _builder.buildTile(
  layers: [
    _builder.buildLayer(
      name: 'seismic_intensity',
      features: features,
      keys: keys,
      values: values,
    ),
  ],
);

Uint8List _triangle({List<int> tags = const []}) => _builder.feature(
  geomType: MvtFixtureBuilder.geomTypePolygon,
  tags: tags,
  rawCommands: [
    ..._builder.moveTo([(0, 0)]),
    ..._builder.lineTo([(10, 0), (-10, 10)]),
    ..._builder.closePath(),
  ],
);

Uint8List _degenerateTriangle({required List<int> tags}) => _builder.feature(
  geomType: MvtFixtureBuilder.geomTypePolygon,
  tags: tags,
  rawCommands: [
    ..._builder.moveTo([(0, 0)]),
    ..._builder.lineTo([(10, 0), (10, 0)]),
    ..._builder.closePath(),
  ],
);

Uint8List _line({required List<int> tags}) => _builder.feature(
  geomType: MvtFixtureBuilder.geomTypeLineString,
  tags: tags,
  rawCommands: [
    ..._builder.moveTo([(0, 0)]),
    ..._builder.lineTo([(10, 0)]),
  ],
);

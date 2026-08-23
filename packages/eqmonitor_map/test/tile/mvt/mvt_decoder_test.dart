// Fixtureの抽出手順:
//
// `utils/map_converter/data/pmtiles/earthquake_tsunami_all.pmtiles`
// (tippecanoe -Z1 -z7で生成、layer: AreaForecastLocalE/AreaForecastLocalEEW/
// AreaInformationCity_quake/AreaTsunami)から、Task 2で実装した
// `packages/pmtiles_v3`の`PmTilesV3Archive.open`→`readTile`で実tileを
// 生byte(gzip展開済み)のまま切り出した。archiveのheaderは`minZoom=1
// maxZoom=7`、`occupiedTileIdsAtZoom`でzoom 6/7の占有tile IDを列挙し、
// 各tile IDをHilbert曲線の総当たりでz/x/yへ逆変換のうえ`readTile`した。
// 使ったスクリプトはpmtiles_v3の`PmTilesV3FileRandomAccessReader.open` +
// `PmTilesV3Archive.open(reader:, limits: const PmTilesV3Limits(
// maxDirectoryDepth: 3, rootDirectoryWindowLength: 16384))` +
// `archive.readTile(z:, x:, y:)`を呼ぶだけの一時スクリプトで、
// コミットはしていない(再現に必要な手順は上記の通り)。
//
// - `fixtures/earthquake_tsunami_all_z6_x59_y27.mvt`: z=6, x=59, y=27
//   (547 bytes)。4 layer全部に1 featureずつ入っており、Polygon 3層+
//   LineString 1層の最小構成として選んだ。
// - `fixtures/earthquake_tsunami_all_z7_x112_y56.mvt`: z=7, x=112, y=56
//   (123 bytes)。AreaTsunami(LineString)のみを含む最小の単一layer tile。
import 'dart:io';
import 'dart:typed_data';

import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_exception.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decoder.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/mvt_fixture_builder.dart';

const _builder = MvtFixtureBuilder();

const _limits = MvtDecodeLimits(
  maxLayers: 16,
  maxFeaturesPerLayer: 64,
  maxRingsPerFeature: 16,
  maxVerticesPerRing: 256,
  maxCommandsPerFeature: 1024,
  maxLayerNameBytes: 64,
  maxKeysPerLayer: 64,
  maxValuesPerLayer: 20000,
  maxTagsPerFeature: 64,
  maxPropertyStringBytes: 256,
);

/// 符号付き面積の2倍(shoelace公式)。ringの巻き方向を符号で比較するのに使う。
double _signedArea2(Int32List ring) {
  var sum = 0.0;
  final vertexCount = ring.length ~/ 2;
  for (var i = 0; i < vertexCount; i++) {
    final x1 = ring[i * 2];
    final y1 = ring[i * 2 + 1];
    final nextIndex = (i + 1) % vertexCount;
    final x2 = ring[nextIndex * 2];
    final y2 = ring[nextIndex * 2 + 1];
    sum += (x1 * y2 - x2 * y1).toDouble();
  }
  return sum;
}

Uint8List _propertyTile({
  List<int> tags = const [0, 0],
  Uint8List? value,
  List<Uint8List>? values,
}) {
  final feature = _builder.feature(
    geomType: MvtFixtureBuilder.geomTypePoint,
    rawCommands: _builder.moveTo([(1, 2)]),
    tags: tags,
  );
  return _builder.buildTile(
    layers: [
      _builder.layer(
        fields: [
          _builder.key('code'),
          ...(values ?? [value ?? _builder.stringValue('1300')]),
          _builder.encodeTag(fieldNumber: 2, wireType: 2),
          _builder.encodeLengthDelimited(feature),
          _builder.encodeTag(fieldNumber: 1, wireType: 2),
          _builder.encodeLengthDelimited(Uint8List.fromList('areas'.codeUnits)),
          _builder.encodeTag(fieldNumber: 15, wireType: 0),
          _builder.encodeVarint(2),
        ],
      ),
    ],
  );
}

void main() {
  group('real PMTiles fixtures', () {
    test('decodes a 4-layer tile extracted from earthquake_tsunami_all', () {
      final bytes = File(
        'test/tile/mvt/fixtures/earthquake_tsunami_all_z6_x59_y27.mvt',
      ).readAsBytesSync();

      final tile = decodeMvtTile(bytes, limits: _limits);

      expect(tile.layers.map((layer) => layer.name), [
        'AreaForecastLocalE',
        'AreaForecastLocalEEW',
        'AreaInformationCity_quake',
        'AreaTsunami',
      ]);
      for (final layer in tile.layers) {
        expect(layer.version, 2);
        expect(layer.extent, 4096);
        expect(layer.features, hasLength(1));
      }
      expect(
        tile.layers
            .take(3)
            .every((l) => l.features.single.type == MvtGeometryType.polygon),
        isTrue,
      );
      expect(tile.layers.last.features.single.type, MvtGeometryType.lineString);
      for (final layer in tile.layers) {
        final rings = layer.features.single.rings;
        expect(rings, isNotEmpty);
        for (final ring in rings) {
          expect(ring.length.isEven, isTrue);
          expect(ring.length ~/ 2, greaterThanOrEqualTo(2));
        }
      }
    });

    test('decodes a single-layer LineString-only tile', () {
      final bytes = File(
        'test/tile/mvt/fixtures/earthquake_tsunami_all_z7_x112_y56.mvt',
      ).readAsBytesSync();

      final tile = decodeMvtTile(bytes, limits: _limits);

      expect(tile.layers, hasLength(1));
      final layer = tile.layers.single;
      expect(layer.name, 'AreaTsunami');
      expect(layer.version, 2);
      expect(layer.extent, 4096);
      expect(layer.features.single.type, MvtGeometryType.lineString);
      expect(layer.features.single.rings.single.length ~/ 2, 3);
    });
  });

  group('valid synthetic geometry', () {
    test('decodes a single point', () {
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePoint,
        rawCommands: _builder.moveTo([(5, 7)]),
      );
      final tile = _tileWithOneLayer(name: 'points', features: [feature]);

      final decoded = decodeMvtTile(tile, limits: _limits);

      final rings = decoded.layers.single.features.single.rings;
      expect(rings.single, [5, 7]);
    });

    test(
      'decodes a MultiPoint as a single ring of interleaved coordinates',
      () {
        final feature = _builder.buildFeature(
          geomType: MvtFixtureBuilder.geomTypePoint,
          rawCommands: _builder.moveTo([(1, 1), (2, -1), (-3, 4)]),
        );
        final tile = _tileWithOneLayer(name: 'points', features: [feature]);

        final decoded = decodeMvtTile(tile, limits: _limits);

        final rings = decoded.layers.single.features.single.rings;
        expect(rings, hasLength(1));
        // cursorは前の点からの相対移動を累積する。
        expect(rings.single, [1, 1, 3, 0, 0, 4]);
      },
    );

    test('decodes a LineString with multiple parts (MultiLineString)', () {
      // cursorはpart(ring)をまたいで累積するため、絶対座標(10, 10)から
      // 始めるにはcursorの現在地(4, 4)からの相対値(6, 6)を渡す。
      final rawCommands = [
        ..._builder.moveTo([(0, 0)]),
        ..._builder.lineTo([(4, 0), (0, 4)]),
        ..._builder.moveTo([(6, 6)]),
        ..._builder.lineTo([(1, 1)]),
      ];
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypeLineString,
        rawCommands: rawCommands,
      );
      final tile = _tileWithOneLayer(name: 'lines', features: [feature]);

      final decoded = decodeMvtTile(tile, limits: _limits);

      final rings = decoded.layers.single.features.single.rings;
      expect(rings, hasLength(2));
      expect(rings[0], [0, 0, 4, 0, 4, 4]);
      expect(rings[1], [10, 10, 11, 11]);
    });

    test('decodes a Polygon ring without duplicating the implicit close', () {
      final rawCommands = [
        ..._builder.moveTo([(0, 0)]),
        ..._builder.lineTo([(4, 0), (0, 4), (-4, 0)]),
        ..._builder.closePath(),
      ];
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePolygon,
        rawCommands: rawCommands,
      );
      final tile = _tileWithOneLayer(name: 'polygons', features: [feature]);

      final decoded = decodeMvtTile(tile, limits: _limits);

      final rings = decoded.layers.single.features.single.rings;
      expect(rings.single, [0, 0, 4, 0, 4, 4, 0, 4]);
    });

    test('decodes a Polygon with a hole and preserves ring winding', () {
      // 外周: (0,0)-(10,0)-(10,10)-(0,10) は反時計回り(shoelace > 0)。
      // 穴  : (2,2)-(2,8)-(8,8)-(8,2) は時計回り(shoelace < 0)。
      // ClosePathはcursorを動かさないため、外周最後の頂点(0,10)から
      // 穴の開始点(2,2)へ移すMoveToのdeltaは(2, -8)になる。
      final rawCommands = [
        ..._builder.moveTo([(0, 0)]),
        ..._builder.lineTo([(10, 0), (0, 10), (-10, 0)]),
        ..._builder.closePath(),
        ..._builder.moveTo([(2, -8)]),
        ..._builder.lineTo([(0, 6), (6, 0), (0, -6)]),
        ..._builder.closePath(),
      ];
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePolygon,
        rawCommands: rawCommands,
      );
      final tile = _tileWithOneLayer(name: 'polygons', features: [feature]);

      final decoded = decodeMvtTile(tile, limits: _limits);

      final rings = decoded.layers.single.features.single.rings;
      expect(rings, hasLength(2));
      expect(_signedArea2(rings[0]), greaterThan(0));
      expect(_signedArea2(rings[1]), lessThan(0));
    });

    test(
      'reads the extent declared by the layer instead of a fixed default',
      () {
        final feature = _builder.buildFeature(
          geomType: MvtFixtureBuilder.geomTypePoint,
          rawCommands: _builder.moveTo([(0, 0)]),
        );
        final layer = _builder.buildLayer(
          name: 'custom_extent',
          extent: 2048,
          features: [feature],
        );
        final tile = _builder.buildTile(layers: [layer]);

        final decoded = decodeMvtTile(tile, limits: _limits);

        expect(decoded.layers.single.extent, 2048);
      },
    );

    test('falls back to the MVT default extent when the layer omits it', () {
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePoint,
        rawCommands: _builder.moveTo([(0, 0)]),
      );
      final layer = _builder.buildLayer(
        name: 'no_extent',
        features: [feature],
      );
      final tile = _builder.buildTile(layers: [layer]);

      final decoded = decodeMvtTile(tile, limits: _limits);

      expect(decoded.layers.single.extent, mvtDefaultExtent);
      expect(mvtDefaultExtent, 4096);
    });

    test('ignores an unknown field number while decoding the rest', () {
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePoint,
        rawCommands: _builder.moveTo([(1, 2)]),
      );
      final layerBody = _builder.buildLayer(
        name: 'with_unknown_field',
        features: [feature],
      );
      final withUnknownVarintField = BytesBuilder(copy: false)
        ..add(layerBody)
        ..add(_builder.encodeTag(fieldNumber: 200, wireType: 0))
        ..add(_builder.encodeVarint(12345));
      final tile = _builder.buildTile(
        layers: [withUnknownVarintField.toBytes()],
      );

      final decoded = decodeMvtTile(tile, limits: _limits);

      expect(decoded.layers.single.name, 'with_unknown_field');
      expect(decoded.layers.single.features.single.rings.single, [1, 2]);
    });

    test('resolves tags when features precede keys and values', () {
      final tile = _builder.buildTile(
        layers: [
          _builder.layer(
            fields: [
              _builder.layerFeature(
                _builder.feature(
                  geomType: MvtFixtureBuilder.geomTypePoint,
                  rawCommands: _builder.moveTo([(1, 2)]),
                  tags: [0, 0],
                  propertiesBeforeGeometry: true,
                ),
              ),
              _builder.key('code'),
              _builder.stringValue('1300'),
              _builder.encodeTag(fieldNumber: 15, wireType: 0),
              _builder.encodeVarint(2),
              _builder.encodeTag(fieldNumber: 1, wireType: 2),
              _builder.encodeLengthDelimited(
                Uint8List.fromList('areas'.codeUnits),
              ),
            ],
          ),
        ],
      );

      final properties = decodeMvtTile(
        tile,
        limits: _limits,
      ).layers.single.features.single.properties;

      expect(properties, {'code': '1300'});
      expect(() => properties['code'] = 'changed', throwsUnsupportedError);
    });

    test('omits non-string values from properties', () {
      final tile = _builder.buildTile(
        layers: [
          _builder.layer(
            fields: [
              _builder.key('numeric'),
              _builder.intValue(1),
              _builder.encodeTag(fieldNumber: 2, wireType: 2),
              _builder.encodeLengthDelimited(
                _builder.feature(
                  geomType: MvtFixtureBuilder.geomTypePoint,
                  rawCommands: _builder.moveTo([(1, 2)]),
                  tags: [0, 0],
                ),
              ),
              _builder.encodeTag(fieldNumber: 1, wireType: 2),
              _builder.encodeLengthDelimited(
                Uint8List.fromList('areas'.codeUnits),
              ),
              _builder.encodeTag(fieldNumber: 15, wireType: 0),
              _builder.encodeVarint(2),
            ],
          ),
        ],
      );

      final properties = decodeMvtTile(
        tile,
        limits: _limits,
      ).layers.single.features.single.properties;

      expect(properties, isEmpty);
    });
  });

  group('property rejection', () {
    test('rejects a feature with an odd number of tags', () {
      final tile = _propertyTile(tags: [0]);

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtDecodeException>()),
      );
    });

    test('rejects a tag key index outside the layer key table', () {
      final tile = _propertyTile(tags: [1, 0]);

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtDecodeException>()),
      );
    });

    test('rejects a tag value index outside the layer value table', () {
      final tile = _propertyTile(tags: [0, 1]);

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtDecodeException>()),
      );
    });

    test('rejects duplicate property keys in a feature', () {
      final tile = _propertyTile(tags: [0, 0, 0, 0]);

      expect(
        () => decodeMvtTile(
          tile,
          limits: _limits.copyWith(maxTagsPerFeature: 4),
        ),
        throwsA(isA<MvtDecodeException>()),
      );
    });

    test(
      'rejects duplicate property keys when the first Value is non-string',
      () {
        final valueTables = [
          [_builder.intValue(1), _builder.stringValue('second')],
          [_builder.intValue(1), _builder.intValue(2)],
        ];
        for (final values in valueTables) {
          final tile = _propertyTile(tags: [0, 0, 0, 1], values: values);

          expect(
            () => decodeMvtTile(
              tile,
              limits: _limits.copyWith(maxTagsPerFeature: 4),
            ),
            throwsA(isA<MvtDecodeException>()),
          );
        }
      },
    );

    test('rejects a Value containing multiple fields', () {
      final tile = _propertyTile(
        value: _builder.value(
          fields: [_builder.valueStringField('a'), _builder.valueIntField(1)],
        ),
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtDecodeException>()),
      );
    });

    test('rejects an invalid UTF-8 property string', () {
      final tile = _propertyTile(
        value: _builder.stringValueBytes(Uint8List.fromList([0xFF])),
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtDecodeException>()),
      );
    });

    test('rejects a property string exceeding maxPropertyStringBytes', () {
      final tile = _propertyTile(value: _builder.stringValue('12345'));

      expect(
        () => decodeMvtTile(
          tile,
          limits: _limits.copyWith(maxPropertyStringBytes: 4),
        ),
        throwsA(isA<MvtLimitExceededException>()),
      );
    });

    test('rejects a layer exceeding maxKeysPerLayer', () {
      final tile = _builder.buildTile(
        layers: [
          _builder.layer(
            fields: [
              _builder.key('a'),
              _builder.key('b'),
              _builder.key('c'),
              _builder.encodeTag(fieldNumber: 1, wireType: 2),
              _builder.encodeLengthDelimited(
                Uint8List.fromList('areas'.codeUnits),
              ),
              _builder.encodeTag(fieldNumber: 15, wireType: 0),
              _builder.encodeVarint(2),
            ],
          ),
        ],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits.copyWith(maxKeysPerLayer: 2)),
        throwsA(isA<MvtLimitExceededException>()),
      );
    });

    test('rejects a layer exceeding maxValuesPerLayer', () {
      final tile = _builder.buildTile(
        layers: [
          _builder.layer(
            fields: [
              _builder.stringValue('a'),
              _builder.stringValue('b'),
              _builder.stringValue('c'),
              _builder.encodeTag(fieldNumber: 1, wireType: 2),
              _builder.encodeLengthDelimited(
                Uint8List.fromList('areas'.codeUnits),
              ),
              _builder.encodeTag(fieldNumber: 15, wireType: 0),
              _builder.encodeVarint(2),
            ],
          ),
        ],
      );

      expect(
        () => decodeMvtTile(
          tile,
          limits: _limits.copyWith(maxValuesPerLayer: 2),
        ),
        throwsA(isA<MvtLimitExceededException>()),
      );
    });

    test('rejects a feature exceeding maxTagsPerFeature', () {
      final tile = _propertyTile(tags: [0, 0, 0, 0]);

      expect(
        () =>
            decodeMvtTile(tile, limits: _limits.copyWith(maxTagsPerFeature: 2)),
        throwsA(isA<MvtLimitExceededException>()),
      );
    });
  });

  group('limit enforcement', () {
    test('rejects a tile exceeding maxLayers', () {
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePoint,
        rawCommands: _builder.moveTo([(0, 0)]),
      );
      final layers = List.generate(
        _limits.maxLayers + 1,
        (i) => _builder.buildLayer(name: 'layer_$i', features: [feature]),
      );
      final tile = _builder.buildTile(layers: layers);

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtLimitExceededException>()),
      );
    });

    test('rejects a layer exceeding maxFeaturesPerLayer', () {
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePoint,
        rawCommands: _builder.moveTo([(0, 0)]),
      );
      final layer = _builder.buildLayer(
        name: 'too_many_features',
        features: List.filled(_limits.maxFeaturesPerLayer + 1, feature),
      );
      final tile = _builder.buildTile(layers: [layer]);

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtLimitExceededException>()),
      );
    });

    test('rejects a feature exceeding maxRingsPerFeature', () {
      final rawCommands = <int>[];
      for (var i = 0; i <= _limits.maxRingsPerFeature; i++) {
        rawCommands
          ..addAll(_builder.moveTo([(1, 0)]))
          ..addAll(_builder.lineTo([(1, 0)]));
      }
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypeLineString,
        rawCommands: rawCommands,
      );
      final tile = _tileWithOneLayer(
        name: 'too_many_rings',
        features: [feature],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtLimitExceededException>()),
      );
    });

    test('rejects a ring exceeding maxVerticesPerRing', () {
      final points = List.generate(
        _limits.maxVerticesPerRing + 1,
        (_) => (1, 0),
      );
      final rawCommands = [
        ..._builder.moveTo([(0, 0)]),
        ..._builder.lineTo(points),
      ];
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypeLineString,
        rawCommands: rawCommands,
      );
      final tile = _tileWithOneLayer(
        name: 'too_many_vertices',
        features: [feature],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtLimitExceededException>()),
      );
    });

    test(
      'rejects a feature whose single command declares a huge count '
      'before allocating vertices (maxCommandsPerFeature)',
      () {
        final rawCommands = _builder.moveTo(
          List.generate(_limits.maxCommandsPerFeature + 1, (_) => (1, 0)),
        );
        final feature = _builder.buildFeature(
          geomType: MvtFixtureBuilder.geomTypePoint,
          rawCommands: rawCommands,
        );
        final tile = _tileWithOneLayer(
          name: 'too_many_commands',
          features: [feature],
        );

        expect(
          () => decodeMvtTile(tile, limits: _limits),
          throwsA(isA<MvtLimitExceededException>()),
        );
      },
    );

    test('rejects a layer name exceeding maxLayerNameBytes', () {
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePoint,
        rawCommands: _builder.moveTo([(0, 0)]),
      );
      final layer = _builder.buildLayer(
        name: List.filled(_limits.maxLayerNameBytes + 1, 'x').join(),
        features: [feature],
      );
      final tile = _builder.buildTile(layers: [layer]);

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtLimitExceededException>()),
      );
    });
  });

  group('malformed rejection', () {
    test('rejects a tile truncated mid-varint', () {
      final truncated = Uint8List.fromList([0x1A, 0x80]);

      expect(
        () => decodeMvtTile(truncated, limits: _limits),
        throwsA(isA<MvtMalformedProtobufException>()),
      );
    });

    test('rejects a length-delimited field exceeding the buffer bounds', () {
      final layer = _builder.buildLayer(name: 'valid');
      final truncated = Uint8List.sublistView(
        _builder.buildTile(layers: [layer]),
        0,
        layer.length,
      );

      expect(
        () => decodeMvtTile(truncated, limits: _limits),
        throwsA(isA<MvtMalformedProtobufException>()),
      );
    });

    test('rejects an unsupported protobuf wire type', () {
      final malformed = BytesBuilder(copy: false)
        ..add(_builder.encodeTag(fieldNumber: 3, wireType: 3));
      // wire type 3 (deprecated group start) は非対応。

      expect(
        () => decodeMvtTile(malformed.toBytes(), limits: _limits),
        throwsA(isA<MvtMalformedProtobufException>()),
      );
    });

    test('rejects a layer missing the required name field', () {
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePoint,
        rawCommands: _builder.moveTo([(0, 0)]),
      );
      final layer = BytesBuilder(copy: false)
        ..add(_builder.encodeTag(fieldNumber: 2, wireType: 2))
        ..add(_builder.encodeLengthDelimited(feature))
        ..add(_builder.encodeTag(fieldNumber: 15, wireType: 0))
        ..add(_builder.encodeVarint(2));
      final tile = _builder.buildTile(layers: [layer.toBytes()]);

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtMalformedProtobufException>()),
      );
    });

    test('rejects a layer missing the required version field', () {
      final layer = _builder.buildLayer(name: 'no_version', version: null);
      final tile = _builder.buildTile(layers: [layer]);

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtMalformedProtobufException>()),
      );
    });

    test('rejects a layer whose version is neither 1 nor 2', () {
      final layer = _builder.buildLayer(name: 'bad_version', version: 3);
      final tile = _builder.buildTile(layers: [layer]);

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(
          isA<MvtUnsupportedLayerVersionException>().having(
            (e) => e.version,
            'version',
            3,
          ),
        ),
      );
    });

    test('rejects an unsupported geometry type', () {
      final feature = _builder.buildFeature(
        geomType: 0,
        rawCommands: _builder.moveTo([(0, 0)]),
      );
      final tile = _tileWithOneLayer(
        name: 'bad_geom_type',
        features: [feature],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtInvalidGeometryCommandException>()),
      );
    });

    test('rejects a feature with no geometry commands', () {
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePoint,
        rawCommands: const [],
      );
      final tile = _tileWithOneLayer(
        name: 'empty_geometry',
        features: [feature],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtInvalidGeometryCommandException>()),
      );
    });

    test('rejects an unsupported geometry command id', () {
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePoint,
        rawCommands: [_builder.commandHeader(id: 5, count: 1), 0, 0],
      );
      final tile = _tileWithOneLayer(
        name: 'bad_command_id',
        features: [feature],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtInvalidGeometryCommandException>()),
      );
    });

    test('rejects a Point feature followed by a trailing command', () {
      final rawCommands = [
        ..._builder.moveTo([(0, 0)]),
        ..._builder.moveTo([(1, 1)]),
      ];
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePoint,
        rawCommands: rawCommands,
      );
      final tile = _tileWithOneLayer(
        name: 'point_with_extra',
        features: [feature],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtInvalidGeometryCommandException>()),
      );
    });

    test('rejects a LineString whose MoveTo repeats more than once', () {
      final rawCommands = [
        ..._builder.moveTo([(0, 0), (1, 1)]),
        ..._builder.lineTo([(1, 0)]),
      ];
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypeLineString,
        rawCommands: rawCommands,
      );
      final tile = _tileWithOneLayer(
        name: 'bad_moveto_count',
        features: [feature],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtInvalidGeometryCommandException>()),
      );
    });

    test('rejects a LineString part with no LineTo', () {
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypeLineString,
        rawCommands: _builder.moveTo([(0, 0)]),
      );
      final tile = _tileWithOneLayer(
        name: 'moveto_only_line',
        features: [feature],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtInvalidGeometryCommandException>()),
      );
    });

    test('rejects a LineTo command that appears before any MoveTo', () {
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypeLineString,
        rawCommands: _builder.lineTo([(1, 0)]),
      );
      final tile = _tileWithOneLayer(name: 'lineto_first', features: [feature]);

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtInvalidGeometryCommandException>()),
      );
    });

    test('rejects a ClosePath command inside LineString geometry', () {
      final rawCommands = [
        ..._builder.moveTo([(0, 0)]),
        ..._builder.lineTo([(1, 0)]),
        ..._builder.closePath(),
      ];
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypeLineString,
        rawCommands: rawCommands,
      );
      final tile = _tileWithOneLayer(
        name: 'closepath_in_line',
        features: [feature],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtInvalidGeometryCommandException>()),
      );
    });

    test('rejects a Polygon ring that is never closed by ClosePath', () {
      final rawCommands = [
        ..._builder.moveTo([(0, 0)]),
        ..._builder.lineTo([(4, 0), (0, 4)]),
      ];
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePolygon,
        rawCommands: rawCommands,
      );
      final tile = _tileWithOneLayer(
        name: 'unclosed_ring',
        features: [feature],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtInvalidGeometryCommandException>()),
      );
    });

    test('rejects a ClosePath whose count is not exactly 1', () {
      final rawCommands = [
        ..._builder.moveTo([(0, 0)]),
        ..._builder.lineTo([(4, 0), (0, 4)]),
        _builder.commandHeader(id: 7, count: 2),
      ];
      final feature = _builder.buildFeature(
        geomType: MvtFixtureBuilder.geomTypePolygon,
        rawCommands: rawCommands,
      );
      final tile = _tileWithOneLayer(
        name: 'bad_closepath_count',
        features: [feature],
      );

      expect(
        () => decodeMvtTile(tile, limits: _limits),
        throwsA(isA<MvtInvalidGeometryCommandException>()),
      );
    });
  });
}

Uint8List _tileWithOneLayer({
  required String name,
  required List<Uint8List> features,
}) {
  final layer = _builder.buildLayer(name: name, features: features);
  return _builder.buildTile(layers: [layer]);
}

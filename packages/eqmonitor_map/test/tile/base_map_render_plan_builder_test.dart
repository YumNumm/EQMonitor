import 'dart:typed_data';

import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/base_map_render_plan_builder.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mvt/support/mvt_fixture_builder.dart';
import 'support/base_map_render_tile_test_support.dart';

void main() {
  const builder = MvtFixtureBuilder();
  const limits = BaseMapTileDecodeLimits(
    mvtLimits: MvtDecodeLimits(
      maxLayers: 16,
      maxFeaturesPerLayer: 64,
      maxRingsPerFeature: 16,
      maxVerticesPerRing: 256,
      maxCommandsPerFeature: 1024,
      maxLayerNameBytes: 64,
      maxKeysPerLayer: 64,
      maxValuesPerLayer: 64,
      maxTagsPerFeature: 64,
      maxPropertyStringBytes: 64,
    ),
    fillLimits: FillMeshBuilderLimits(
      maxHolesPerPolygon: 16,
      maxVerticesPerFeature: 4096,
      maxVerticesPerSegment: 65536,
      maxIntersectionChecks: 1 << 16,
    ),
    lineLimits: LineMeshBuilderLimits(maxVerticesPerSegment: 65536),
    lineMiterLimit: 4,
  );

  test('uses fallback tile ID and decoded extent as matrix input', () {
    final feature = builder.buildFeature(
      geomType: MvtFixtureBuilder.geomTypePolygon,
      rawCommands: [
        ...builder.moveTo([(0, 0)]),
        ...builder.lineTo([(2048, 0), (-2048, 2048)]),
        ...builder.closePath(),
      ],
    );
    final geometry = decodeBaseMapTileSync(
      builder.buildTile(
        layers: [
          builder.buildLayer(
            name: 'countries',
            extent: 2048,
            features: [feature],
          ),
        ],
      ),
      limits,
    );
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const ancestor = CanonicalTileId(z: 4, x: 7, y: 6);
    cache.put(
      sourceInstanceId: sourceId,
      tileId: ancestor,
      geometry: geometry,
      token: cache.beginDecode(),
    );
    final plans = buildBaseMapRenderPlans(
      requestedCover: [
        requested(tileId: ancestor.children()[0]),
        requested(tileId: ancestor.children()[1]),
      ],
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
      zoom: 5.25,
    );
    expect(
      plans.map((plan) => plan.layerGeometry.styleLayerId),
      ['countriesFill', 'countriesLine'],
    );
    final countriesFill = plans.singleWhere(
      (plan) => plan.layerGeometry.styleLayerId == 'countriesFill',
    );

    expect(
      countriesFill.transformInput.tileId,
      const UnwrappedTileId(wrap: 0, canonical: ancestor),
    );
    expect(countriesFill.transformInput.extent, 2048);
    expect(countriesFill.transformInput.zoom, 5.25);
    expect(countriesFill.layerGeometry.extent, 2048);
  });

  test('rejects a mesh-bearing layer without an extent', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const tileId = CanonicalTileId(z: 0, x: 0, y: 0);
    cache.put(
      sourceInstanceId: sourceId,
      tileId: tileId,
      geometry: BaseMapTileGeometry(
        layers: [
          BaseMapTileFillLayerGeometry(
            styleLayerId: 'countriesFill',
            extent: null,
            meshes: [
              FillMesh(
                positions: Float32List.fromList([0, 0, 1, 0, 0, 1]),
                indices: Uint16List.fromList([0, 1, 2]),
                vertexCount: 3,
              ),
            ],
          ),
        ],
      ),
      token: cache.beginDecode(),
    );

    expect(
      () => buildBaseMapRenderPlans(
        requestedCover: [requested(tileId: tileId)],
        sourceInstanceId: sourceId,
        cache: cache,
        maxParentSteps: 2,
        zoom: 0,
      ),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          'countriesFill has meshes without an MVT extent.',
        ),
      ),
    );
  });
}

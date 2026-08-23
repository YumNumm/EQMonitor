import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_material_parameters.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';
import 'package:eqmonitor_map/src/tile/base_map_render_plan_builder.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const zoom = 5.0;
  const camera = MapCamera(
    centerLongitude: 139.7,
    centerLatitude: 35.7,
    zoom: zoom,
  );
  final viewport = MapViewport(
    logicalSize: const Size(400, 800),
    devicePixelRatio: 2,
  );
  final sourceInstanceId = createMapSourceInstanceId(value: 'archive#1');

  MapFrameSnapshot frameOf({MapCamera camera = camera}) =>
      captureMapFrameSnapshot(
        clock: SystemMapClock.start(
          domain: createMapClockDomainId(value: 'test'),
        ),
        frameNumber: 7,
        camera: camera,
        viewport: viewport,
        revisions: const [],
        lifecycle: MapAppLifecycle.active,
        contextGeneration: 0,
      );

  UnwrappedTileId tile(int x, int y) => UnwrappedTileId(
    wrap: 0,
    canonical: CanonicalTileId(z: 5, x: x, y: y),
  );

  final fillMesh = FillMesh(
    positions: Float32List.fromList([0, 0, 4096, 0, 0, 4096]),
    indices: Uint16List.fromList([0, 1, 2]),
    vertexCount: 3,
  );
  final lineMesh = LineMesh(
    positions: Float32List.fromList([0, 0, 4096, 4096]),
    extrudes: Float32List.fromList([0, 1, 0, 1]),
    indices: Uint16List.fromList([0, 1, 0]),
    vertexCount: 2,
  );

  BaseMapLayerSpec specOf(String styleLayerId) => baseMapLayerSpecs.singleWhere(
    (spec) => spec.styleLayerId == styleLayerId,
  );

  BaseMapLayerRenderPlan planOf({
    required String styleLayerId,
    required UnwrappedTileId tileId,
    double planZoom = zoom,
    int extent = 4096,
    int segments = 1,
  }) {
    final spec = specOf(styleLayerId);
    final layer = switch (spec.kind) {
      BaseMapLayerKind.fill => BaseMapTileFillLayerGeometry(
        styleLayerId: styleLayerId,
        extent: extent,
        meshes: List.filled(segments, fillMesh),
      ),
      BaseMapLayerKind.line => BaseMapTileLineLayerGeometry(
        styleLayerId: styleLayerId,
        extent: extent,
        meshes: List.filled(segments, lineMesh),
      ),
      BaseMapLayerKind.background => throw ArgumentError(styleLayerId),
    };
    return BaseMapLayerRenderPlan(
      tileGeometry: BaseMapTileGeometry(layers: [layer]),
      layerGeometry: layer,
      transformInput: BaseMapTileTransformInput(
        tileId: tileId,
        zoom: planZoom,
        extent: extent,
      ),
    );
  }

  /// planのlayer geometryを実際のpackerへ通す、cacheを持たないresolver。
  Map<String, List<MapPackedMesh>> packOf(BaseMapLayerRenderPlan plan) {
    final layer = plan.layerGeometry;
    return {
      layer.styleLayerId: switch (layer) {
        BaseMapTileFillLayerGeometry(:final meshes) => [
          for (final mesh in meshes) packBaseMapFillMesh(mesh),
        ],
        BaseMapTileLineLayerGeometry(:final meshes) => [
          for (final mesh in meshes) packBaseMapLineMesh(mesh),
        ],
      },
    };
  }

  MapRenderSubmission submissionOf({
    required List<BaseMapLayerRenderPlan> plans,
    MapFrameSnapshot? frame,
    BaseMapPackedMeshResolver? packedMeshesFor,
    double lineHalfWidthLogicalPixels = 1,
  }) => buildBaseMapRenderSubmission(
    frame: frame ?? frameOf(),
    plans: plans,
    sourceInstanceId: sourceInstanceId,
    packedMeshesFor: packedMeshesFor ?? packOf,
    lineHalfWidthLogicalPixels: lineHalfWidthLogicalPixels,
  );

  group('phase policy', () {
    test('base map draws in the first phase and declares labelForeground', () {
      expect(mapSceneRenderPhasePolicy.rankOf(mapSceneBasePhaseId), 0);
      expect(mapSceneRenderPhasePolicy.orderedPhases.length, 5);
    });
  });

  group('batching', () {
    test('groups every tile of one layer into a single batch', () {
      final submission = submissionOf(
        plans: [
          planOf(styleLayerId: 'countriesFill', tileId: tile(28, 12)),
          planOf(styleLayerId: 'countriesFill', tileId: tile(29, 12)),
          planOf(styleLayerId: 'countriesLine', tileId: tile(28, 12)),
          planOf(styleLayerId: 'countriesLine', tileId: tile(29, 12)),
        ],
      );

      expect(submission.batches.length, 2);
      expect(submission.batches[0].packets.length, 2);
      expect(submission.batches[1].packets.length, 2);
      expect(
        submission.batches.map((b) => b.compatibility.batchKey.materialKey),
        ['countriesFill', 'countriesLine'],
      );
    });

    test('orders batches by the declaration order of baseMapLayerSpecs', () {
      // 宣言順に反した順序で plan を渡しても、canonical 順へ並べ直される。
      final submission = submissionOf(
        plans: [
          planOf(
            styleLayerId: 'areaInformationCityQuakeLine',
            tileId: tile(28, 12),
          ),
          planOf(styleLayerId: 'countriesFill', tileId: tile(28, 12)),
          planOf(styleLayerId: 'areaForecastLocalEFill', tileId: tile(28, 12)),
        ],
      );

      expect(
        submission.batches.map((b) => b.compatibility.batchKey.materialKey),
        [
          'countriesFill',
          'areaForecastLocalEFill',
          'areaInformationCityQuakeLine',
        ],
      );
      expect(
        submission.batches.map(
          (b) => b.packets.first.sortKey.declarationOrderWithinPhase,
        ),
        [0, 2, 5],
      );
    });

    test('never merges a fill layer with a line layer', () {
      final submission = submissionOf(
        plans: [
          planOf(styleLayerId: 'countriesFill', tileId: tile(28, 12)),
          planOf(styleLayerId: 'countriesLine', tileId: tile(28, 12)),
        ],
      );

      expect(submission.batches.length, 2);
      expect(
        submission.batches[0].compatibility.layout,
        same(baseMapFillPackedMeshLayout),
      );
      expect(
        submission.batches[1].compatibility.layout,
        same(baseMapLinePackedMeshLayout),
      );
      expect(
        submission.batches.map((b) => b.compatibility.pipeline.key),
        ['base-map-fill', 'base-map-line'],
      );
    });

    test('keeps mesh segments of one layer inside the same batch', () {
      final submission = submissionOf(
        plans: [
          planOf(
            styleLayerId: 'countriesFill',
            tileId: tile(28, 12),
            segments: 3,
          ),
        ],
      );

      expect(submission.batches.single.packets.length, 3);
      expect(
        submission.batches.single.packets.map((p) => p.sortKey.featureOrder),
        [0, 1, 2],
      );
    });

    test('empty plans produce a submission with no batches', () {
      expect(submissionOf(plans: []).batches, isEmpty);
    });
  });

  group('sort keys', () {
    test('assigns tile order by first appearance across layers', () {
      final submission = submissionOf(
        plans: [
          planOf(styleLayerId: 'countriesFill', tileId: tile(28, 12)),
          planOf(styleLayerId: 'countriesFill', tileId: tile(29, 12)),
          // line layer は逆順に並べても、tile order は初出順に従う。
          planOf(styleLayerId: 'countriesLine', tileId: tile(29, 12)),
          planOf(styleLayerId: 'countriesLine', tileId: tile(28, 12)),
        ],
      );

      expect(
        submission.batches[1].packets.map(
          (p) => p.sortKey.overscaledTileOrder,
        ),
        [0, 1],
      );
    });

    test('base map packets all use source order zero', () {
      final submission = submissionOf(
        plans: [planOf(styleLayerId: 'countriesFill', tileId: tile(28, 12))],
      );

      expect(submission.batches.single.packets.single.sortKey.sourceOrder, 0);
    });
  });

  group('model transforms', () {
    test('carries one transform per packet, distinct across tiles', () {
      final submission = submissionOf(
        plans: [
          planOf(styleLayerId: 'countriesFill', tileId: tile(28, 12)),
          planOf(styleLayerId: 'countriesFill', tileId: tile(29, 12)),
        ],
      );

      final transforms = submission.batches.single.instanceTransforms;
      expect(transforms.length, 2);
      expect(transforms[0].length, 16);
      expect(transforms[0], isNot(transforms[1]));
      expect(transforms[0].every((value) => value.isFinite), isTrue);
    });

    test('shares one transform between layers of the same tile', () {
      final submission = submissionOf(
        plans: [
          planOf(styleLayerId: 'countriesFill', tileId: tile(28, 12)),
          planOf(styleLayerId: 'countriesLine', tileId: tile(28, 12)),
        ],
      );

      expect(
        submission.batches[0].instanceTransforms.single,
        submission.batches[1].instanceTransforms.single,
      );
    });

    test('rejects plans built for a different camera zoom', () {
      expect(
        () => submissionOf(
          plans: [
            planOf(
              styleLayerId: 'countriesFill',
              tileId: tile(28, 12),
              planZoom: zoom + 1,
            ),
          ],
        ),
        throwsArgumentError,
      );
    });
  });

  group('material parameters', () {
    test('fill and line layers get their own uniform encodings', () {
      final submission = submissionOf(
        plans: [
          planOf(styleLayerId: 'countriesFill', tileId: tile(28, 12)),
          planOf(styleLayerId: 'countriesLine', tileId: tile(28, 12)),
        ],
      );

      expect(
        submission.batches[0].compatibility.materialParameters.bytes.length,
        baseMapFillMaterialByteLength,
      );
      expect(
        submission.batches[1].compatibility.materialParameters.bytes.length,
        baseMapLineMaterialByteLength,
      );
    });

    test('resolves the line half width from the frame viewport on the CPU', () {
      final submission = submissionOf(
        plans: [planOf(styleLayerId: 'countriesLine', tileId: tile(28, 12))],
        lineHalfWidthLogicalPixels: 2,
      );

      final decoded = decodeBaseMapLineMaterialBytes(
        Uint8List.fromList(
          submission.batches.single.compatibility.materialParameters.bytes,
        ),
      );
      expect(decoded.halfWidthNdcX, closeTo(2 * 2 / 400, 1e-6));
      expect(decoded.halfWidthNdcY, closeTo(2 * 2 / 800, 1e-6));
    });
  });

  group('fail closed', () {
    test('rejects a style layer that is not declared in the spec table', () {
      final unknown = BaseMapTileFillLayerGeometry(
        styleLayerId: 'notALayer',
        extent: 4096,
        meshes: [fillMesh],
      );
      expect(
        () => submissionOf(
          plans: [
            BaseMapLayerRenderPlan(
              tileGeometry: BaseMapTileGeometry(layers: [unknown]),
              layerGeometry: unknown,
              transformInput: BaseMapTileTransformInput(
                tileId: tile(28, 12),
                zoom: zoom,
                extent: 4096,
              ),
            ),
          ],
        ),
        throwsArgumentError,
      );
    });

    test('rejects a resolver that returns no packed mesh', () {
      expect(
        () => submissionOf(
          plans: [planOf(styleLayerId: 'countriesFill', tileId: tile(28, 12))],
          packedMeshesFor: (plan) => const {},
        ),
        throwsArgumentError,
      );
    });

    test('rejects a resolver that returns the wrong layout for the kind', () {
      expect(
        () => submissionOf(
          plans: [planOf(styleLayerId: 'countriesFill', tileId: tile(28, 12))],
          packedMeshesFor: (plan) => {
            plan.layerGeometry.styleLayerId: [packBaseMapLineMesh(lineMesh)],
          },
        ),
        throwsArgumentError,
      );
    });
  });
}

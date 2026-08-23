import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';
import 'package:eqmonitor_map/src/tile/earthquake_area_tile_geometry.dart';
import 'package:eqmonitor_map/src/tile/earthquake_overlay_exact_tile_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final viewport = MapViewport(
    logicalSize: const Size(400, 800),
    devicePixelRatio: 2,
  );
  final clock = SystemMapClock.start(
    domain: createMapClockDomainId(value: 'earthquake-fill-test'),
  );

  MapFrameSnapshot frameAt(double zoom) => captureMapFrameSnapshot(
    clock: clock,
    frameNumber: 7,
    camera: MapCamera(
      centerLongitude: 139.7,
      centerLatitude: 35.7,
      zoom: zoom,
    ),
    viewport: viewport,
    revisions: const [],
    lifecycle: MapAppLifecycle.active,
    contextGeneration: 0,
  );

  EarthquakeMapOverlaySnapshot snapshot() => createEarthquakeMapOverlaySnapshot(
    sourceId: 'event-1',
    revision: 3,
    regionToCityZoom: 6,
    stationMinZoom: 6,
    regionStyles: const [
      EarthquakeAreaStyle(
        code: '130',
        color: Color(0x80FF0000),
        opacity: 0.6,
      ),
    ],
    cityStyles: const [
      EarthquakeAreaStyle(
        code: '13101',
        color: Color(0xFF0000FF),
        opacity: 0.4,
      ),
    ],
    stations: const [],
  );

  EarthquakeOverlayExactTileHit hit({required String code}) =>
      EarthquakeOverlayExactTileHit(
        tileId: const UnwrappedTileId(
          wrap: 0,
          canonical: CanonicalTileId(z: 6, x: 56, y: 25),
        ),
        canonicalTileId: const CanonicalTileId(z: 6, x: 56, y: 25),
        sourceInstanceId: 'archive-1',
        areaGeometry: EarthquakeAreaTileLayerGeometry(
          extent: 4096,
          features: [
            CodedFillGeometry(
              code: code,
              meshes: [
                FillMesh(
                  positions: Float32List.fromList([
                    0,
                    0,
                    4096,
                    0,
                    0,
                    4096,
                  ]),
                  indices: Uint16List.fromList([0, 1, 2]),
                  vertexCount: 3,
                ),
              ],
            ),
          ],
        ),
      );

  test('keeps RGB unpremultiplied and multiplies only alpha by opacity', () {
    final submission = buildEarthquakeAreaRenderSubmission(
      frame: frameAt(5.999),
      snapshot: snapshot(),
      exactTileResults: [hit(code: '130')],
    );

    final values = decodeEarthquakeAreaFillMaterialBytes(
      submission.batches.single.compatibility.materialParameters.bytes,
    );

    expect(values.red, closeTo(1, 1e-6));
    expect(values.green, closeTo(0, 1e-6));
    expect(values.blue, closeTo(0, 1e-6));
    // 0x80 alphaは8bit正規化で128/255。仕様上の0.5はその概数なので、
    // color alpha × opacityの積(約0.3)を8bit量子化幅内で検証する。
    expect(values.alpha, closeTo(0.5 * 0.6, 2e-3));
  });

  test('uses only region below the boundary and only city at the boundary', () {
    final region = buildEarthquakeAreaRenderSubmission(
      frame: frameAt(5.999),
      snapshot: snapshot(),
      exactTileResults: [
        hit(code: '130'),
        hit(code: '13101'),
      ],
    );
    final city = buildEarthquakeAreaRenderSubmission(
      frame: frameAt(6),
      snapshot: snapshot(),
      exactTileResults: [
        hit(code: '130'),
        hit(code: '13101'),
      ],
    );

    expect(region.batches, hasLength(1));
    expect(
      region.batches.single.compatibility.phase,
      mapSceneRenderPhasePolicy.rankOf(mapSceneEarthquakeRegionPhaseId),
    );
    expect(region.batches.single.packets.single.sortKey.featureOrder, 0);
    expect(city.batches, hasLength(1));
    expect(
      city.batches.single.compatibility.phase,
      mapSceneRenderPhasePolicy.rankOf(mapSceneEarthquakeCityPhaseId),
    );
    expect(city.batches.single.packets.single.sortKey.featureOrder, 0);
  });

  test('uses the shared policy version and earthquake material key', () {
    final submission = buildEarthquakeAreaRenderSubmission(
      frame: frameAt(5),
      snapshot: snapshot(),
      exactTileResults: [hit(code: '130')],
    );
    final batch = submission.batches.single;

    expect(
      batch.compatibility.phasePolicyVersion,
      mapSceneRenderPhasePolicy.version,
    );
    expect(
      batch.compatibility.batchKey.materialKey,
      earthquakeAreaFillMaterialKey,
    );
    expect(batch.compatibility.pipeline, earthquakeAreaFillPipelineKey);
  });
}

import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';
import 'package:eqmonitor_map/src/geo/tile_matrix.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_packed_mesh_cache.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';
import 'package:eqmonitor_map/src/tile/earthquake_overlay_exact_tile_resolver.dart';

/// 震度区域Fillが使うmaterial key。
const earthquakeAreaFillMaterialKey = 'earthquake-area-fill';

/// 震度区域Fillのpipeline key。
final MapRenderPipelineKey earthquakeAreaFillPipelineKey =
    createMapRenderPipelineKey(version: 1, key: earthquakeAreaFillMaterialKey);

const earthquakeAreaRenderContractVersion = 1;
const earthquakeAreaRenderBatchVersion = 1;
const earthquakeAreaRenderBatchKeyVersion = 1;
const earthquakeAreaMaterialParameterVersion = 1;
const earthquakeAreaFillMaterialByteLength = 16;

final MapNodeKey earthquakeAreaRenderNodeKey = createMapNodeKey(
  value: 'earthquake-area',
);

/// `earthquake_area_fill.fmat`へ渡す非premultiplied RGBA。
final class EarthquakeAreaFillMaterialValues {
  const new({
    required this.red,
    required this.green,
    required this.blue,
    required this.alpha,
  });

  final double red;
  final double green;
  final double blue;
  final double alpha;
}

/// snapshotとexact tile結果から震度区域Fill submissionを構築する。
MapRenderSubmission buildEarthquakeAreaRenderSubmission({
  required MapFrameSnapshot frame,
  required EarthquakeMapOverlaySnapshot snapshot,
  required List<EarthquakeOverlayExactTileResult> exactTileResults,
  required EarthquakeAreaPackedMeshResolver packedMeshFor,
}) {
  final regionMode = frame.camera.zoom < snapshot.regionToCityZoom;
  final layerMode = regionMode
      ? EarthquakeAreaLayerMode.region
      : EarthquakeAreaLayerMode.city;
  final styles = regionMode ? snapshot.regionStyles : snapshot.cityStyles;
  final phase = mapSceneRenderPhasePolicy.rankOf(
    regionMode
        ? mapSceneEarthquakeRegionPhaseId
        : mapSceneEarthquakeCityPhaseId,
  );
  final packets = buildEarthquakeAreaRenderPackets(
    frame: frame,
    styles: styles,
    exactTileResults: exactTileResults,
    phase: phase,
    layerMode: layerMode,
    packedMeshFor: packedMeshFor,
  );
  final submission = createMapRenderSubmission(
    frame: frame,
    batches: buildCanonicalRenderBatches(
      version: earthquakeAreaRenderBatchVersion,
      policy: mapSceneRenderPhasePolicy,
      packets: packets,
    ),
  );
  validateMapRenderSubmission(submission: submission);
  return submission;
}

/// batch化前の震度区域Fill packetを組み立てる。
List<MapRenderPacket> buildEarthquakeAreaRenderPackets({
  required MapFrameSnapshot frame,
  required List<EarthquakeAreaStyle> styles,
  required List<EarthquakeOverlayExactTileResult> exactTileResults,
  required int phase,
  required EarthquakeAreaLayerMode layerMode,
  required EarthquakeAreaPackedMeshResolver packedMeshFor,
}) {
  final styleEntriesByCode = {
    for (final (index, style) in styles.indexed)
      style.code: (style: style, declarationOrder: index),
  };
  final packets = <MapRenderPacket>[];

  for (final (tileOrder, result) in exactTileResults.indexed) {
    if (result is! EarthquakeOverlayExactTileHit) {
      continue;
    }
    final extent = result.areaGeometry.extent;
    if (extent == null) {
      continue;
    }
    final transform = baseMapTileViewProjectionMatrixFor(
      camera: frame.camera,
      viewport: frame.viewport,
      tileId: result.tileId,
      zoom: frame.camera.zoom,
      extent: extent,
    ).storage;
    var featureOrder = 0;
    for (final (featureIndex, feature)
        in result.areaGeometry.features.indexed) {
      final styleEntry = styleEntriesByCode[feature.code];
      if (styleEntry == null) {
        continue;
      }
      final parameters = earthquakeAreaMaterialParametersFor(
        style: styleEntry.style,
      );
      final batchKey = createMapRenderBatchKey(
        version: earthquakeAreaRenderBatchKeyVersion,
        nodeKey: earthquakeAreaRenderNodeKey,
        scopeKey: result.sourceInstanceId,
        materialKey: earthquakeAreaFillMaterialKey,
        phasePolicyVersion: mapSceneRenderPhasePolicy.version,
        phase: phase,
      );
      for (final (meshIndex, mesh) in feature.meshes.indexed) {
        packets.add(
          createMapRenderPacket(
            contractVersion: earthquakeAreaRenderContractVersion,
            sortKey: MapRenderSortKey(
              phasePolicyVersion: mapSceneRenderPhasePolicy.version,
              phase: phase,
              declarationOrderWithinPhase: styleEntry.declarationOrder,
              sourceOrder: 0,
              overscaledTileOrder: tileOrder,
              featureOrder: featureOrder++,
            ),
            batchKey: batchKey,
            pipeline: earthquakeAreaFillPipelineKey,
            mesh: packedMeshFor(
              sourceInstanceId: result.sourceInstanceId,
              tileId: result.canonicalTileId,
              layerMode: layerMode,
              featureIndex: featureIndex,
              meshIndex: meshIndex,
              mesh: mesh,
            ),
            modelTransform: transform,
            materialParameters: parameters,
          ),
        );
      }
    }
  }
  return List.unmodifiable(packets);
}

/// RGBは非premultipliedのまま、alphaだけopacityを掛けてbyte列へ詰める。
MapMaterialParameterBlock earthquakeAreaMaterialParametersFor({
  required EarthquakeAreaStyle style,
}) => createMapMaterialParameterBlock(
  version: earthquakeAreaMaterialParameterVersion,
  bytes: encodeEarthquakeAreaFillMaterialBytes(style: style),
);

Uint8List encodeEarthquakeAreaFillMaterialBytes({
  required EarthquakeAreaStyle style,
}) {
  final bytes = Uint8List(earthquakeAreaFillMaterialByteLength);
  ByteData.sublistView(bytes)
    ..setFloat32(0, style.color.r, Endian.little)
    ..setFloat32(4, style.color.g, Endian.little)
    ..setFloat32(8, style.color.b, Endian.little)
    ..setFloat32(12, style.color.a * style.opacity, Endian.little);
  return bytes;
}

EarthquakeAreaFillMaterialValues decodeEarthquakeAreaFillMaterialBytes(
  Uint8List bytes,
) {
  if (bytes.length != earthquakeAreaFillMaterialByteLength) {
    throw ArgumentError.value(
      bytes.length,
      'bytes',
      'must be $earthquakeAreaFillMaterialByteLength bytes',
    );
  }
  final data = ByteData.sublistView(bytes);
  return EarthquakeAreaFillMaterialValues(
    red: data.getFloat32(0, Endian.little),
    green: data.getFloat32(4, Endian.little),
    blue: data.getFloat32(8, Endian.little),
    alpha: data.getFloat32(12, Endian.little),
  );
}

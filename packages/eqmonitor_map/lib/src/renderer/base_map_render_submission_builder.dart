import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_phase.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/geo/tile_matrix.dart';
import 'package:eqmonitor_map/src/renderer/base_map_material_parameters.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:eqmonitor_map/src/tile/base_map_render_plan_builder.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';

/// base mapのgeometryを置くrender phase。
///
/// v1はbase mapとlabelの2 phaseしか持たない。`labelForeground`は
/// [createMapRenderPhasePolicy]が必須にしているため、labelを実装する前から
/// policyへ宣言しておく(#1594で実際にpacketが載る)。
final MapRenderPhaseId baseMapRenderPhaseId = createMapRenderPhaseId(
  value: 'base',
);

/// base mapのphase policy。
///
/// 描画順とhit test順の唯一の権威は`MapRenderSortKey`であり、その先頭要素が
/// このpolicy上のphase rankである(設計正本「描画」節)。
final MapRenderPhasePolicy baseMapRenderPhasePolicy =
    createMapRenderPhasePolicy(
  version: 1,
  orderedPhases: [baseMapRenderPhaseId, MapRenderPhaseId.labelForeground],
);

/// `MapRenderPacket.contractVersion`。packetの意味づけを変える改訂で上げる。
const baseMapRenderContractVersion = 1;

/// `MapRenderBatch.version`。
const baseMapRenderBatchVersion = 1;

/// `MapRenderBatchKey.version`。
const baseMapRenderBatchKeyVersion = 1;

/// Fill layer群のpipeline key。`assets/base_map_fill.fmat`に対応する。
final MapRenderPipelineKey baseMapFillPipelineKey =
    createMapRenderPipelineKey(version: 1, key: 'base-map-fill');

/// Line layer群のpipeline key。`assets/base_map_line.fmat`に対応する。
final MapRenderPipelineKey baseMapLinePipelineKey =
    createMapRenderPipelineKey(version: 1, key: 'base-map-line');

/// base map treeのnode key。
///
/// #1593時点のbase mapは単一のPMTiles sourceを描くだけなので固定値でよい。
/// 宣言的な`MapNode`treeから複数sourceを描くようになったら、nodeごとのkeyを
/// packetへ伝播させる(#1595)。
final MapNodeKey baseMapRenderNodeKey = createMapNodeKey(value: 'base-map');

/// `(sourceInstanceId, CanonicalTileId)`単位でpacked meshを引く関数。
///
/// 戻り値は`styleLayerId`→segmentごとの[MapPackedMesh]。`BaseMapPackedMeshCache`
/// をそのまま渡す想定だが、builderがcacheの実装へ依存しないようにfunction型で
/// 受け取る(builderのtestはcacheを組み立てずにfakeを渡せる)。
typedef BaseMapPackedMeshResolver =
    Map<String, List<MapPackedMesh>> Function(BaseMapLayerRenderPlan plan);

/// [plans]から`MapRenderSubmission`を組み立てる。
///
/// `MapRenderBatchAdapter`へ渡すのはこの戻り値だけであり、adapterはFlutter
/// Sceneの型をここへ持ち込まない(設計正本「domain、reconciler、packed meshは
/// Flutter Scene型へ依存させず、`MapSceneRendererAdapter`境界でGeometry/
/// Material/bufferへ変換する」)。
///
/// [frame]の`camera`/`viewport`は[plans]を組んだときと同じ値でなければならない。
/// 食い違ったまま描くと、tile行列が現frameのcameraと無関係な位置へ地物を置く
/// ため`ArgumentError`でfail closedにする。
MapRenderSubmission buildBaseMapRenderSubmission({
  required MapFrameSnapshot frame,
  required List<BaseMapLayerRenderPlan> plans,
  required MapSourceInstanceId sourceInstanceId,
  required BaseMapPackedMeshResolver packedMeshesFor,
  required double lineHalfWidthLogicalPixels,
}) {
  final packets = buildBaseMapRenderPackets(
    frame: frame,
    plans: plans,
    sourceInstanceId: sourceInstanceId,
    packedMeshesFor: packedMeshesFor,
    lineHalfWidthLogicalPixels: lineHalfWidthLogicalPixels,
  );
  final submission = createMapRenderSubmission(
    frame: frame,
    batches: buildCanonicalRenderBatches(
      version: baseMapRenderBatchVersion,
      policy: baseMapRenderPhasePolicy,
      packets: packets,
    ),
  );
  validateMapRenderSubmission(submission: submission);
  return submission;
}

/// [buildBaseMapRenderSubmission]がbatchへ束ねる前のpacket列。
///
/// canonical順のsort・batch結合は`buildCanonicalRenderBatches`が行うため、
/// ここでは宣言順(`baseMapLayerSpecs`順 × tile順 × segment順)のまま返す。
List<MapRenderPacket> buildBaseMapRenderPackets({
  required MapFrameSnapshot frame,
  required List<BaseMapLayerRenderPlan> plans,
  required MapSourceInstanceId sourceInstanceId,
  required BaseMapPackedMeshResolver packedMeshesFor,
  required double lineHalfWidthLogicalPixels,
}) {
  final phase = baseMapRenderPhasePolicy.rankOf(baseMapRenderPhaseId);
  final tileOrders = <UnwrappedTileId, int>{};
  for (final plan in plans) {
    tileOrders.putIfAbsent(
      plan.transformInput.tileId,
      () => tileOrders.length,
    );
  }

  final modelTransforms = <(UnwrappedTileId, int), Float64List>{};
  final materialParameters = <String, MapMaterialParameterBlock>{};
  final packets = <MapRenderPacket>[];
  for (final plan in plans) {
    final styleLayerId = plan.layerGeometry.styleLayerId;
    final spec = _baseMapLayerSpecsByStyleLayerId[styleLayerId];
    if (spec == null) {
      throw ArgumentError.value(
        styleLayerId,
        'plans',
        'is not declared in baseMapLayerSpecs',
      );
    }
    final declarationOrder =
        _baseMapDeclarationOrderByStyleLayerId[styleLayerId]!;
    final transformInput = plan.transformInput;
    if (transformInput.zoom != frame.camera.zoom) {
      throw ArgumentError.value(
        transformInput.zoom,
        'plans',
        'was built for a different camera zoom than the frame snapshot',
      );
    }

    final meshes = packedMeshesFor(plan)[styleLayerId];
    if (meshes == null || meshes.isEmpty) {
      throw ArgumentError.value(
        styleLayerId,
        'packedMeshesFor',
        'returned no packed mesh for a planned layer',
      );
    }
    final expectedLayout = switch (spec.kind) {
      BaseMapLayerKind.background => throw ArgumentError.value(
        styleLayerId,
        'plans',
        'background is not drawable',
      ),
      BaseMapLayerKind.fill => baseMapFillPackedMeshLayout,
      BaseMapLayerKind.line => baseMapLinePackedMeshLayout,
    };

    final modelTransform = modelTransforms.putIfAbsent(
      (transformInput.tileId, transformInput.extent),
      () => baseMapTileViewProjectionMatrixFor(
        camera: frame.camera,
        viewport: frame.viewport,
        tileId: transformInput.tileId,
        zoom: transformInput.zoom,
        extent: transformInput.extent,
      ).storage,
    );
    final parameters = materialParameters.putIfAbsent(
      styleLayerId,
      () => baseMapMaterialParametersFor(
        spec: spec,
        lineHalfWidthLogicalPixels: lineHalfWidthLogicalPixels,
        viewport: frame.viewport,
      ),
    );
    final batchKey = createMapRenderBatchKey(
      version: baseMapRenderBatchKeyVersion,
      nodeKey: baseMapRenderNodeKey,
      // tile識別子をkeyへ入れない。入れるとtileごとにbatchが割れ、
      // `tile × layer × material`単位でbatchするという設計原則を満たせない。
      // 各packetのtile位置は`MapRenderBatch.instanceTransforms`が持つ。
      scopeKey: sourceInstanceId.value,
      materialKey: styleLayerId,
      phasePolicyVersion: baseMapRenderPhasePolicy.version,
      phase: phase,
    );

    for (final (segment, mesh) in meshes.indexed) {
      if (!haveCompatibleMapPackedMeshLayouts(mesh.layout, expectedLayout)) {
        throw ArgumentError.value(
          styleLayerId,
          'packedMeshesFor',
          'returned a packed mesh whose layout does not match the layer kind',
        );
      }
      packets.add(
        createMapRenderPacket(
          contractVersion: baseMapRenderContractVersion,
          sortKey: MapRenderSortKey(
            phasePolicyVersion: baseMapRenderPhasePolicy.version,
            phase: phase,
            declarationOrderWithinPhase: declarationOrder,
            // base mapは単一source。複数sourceを描くのは#1595。
            sourceOrder: 0,
            overscaledTileOrder: tileOrders[transformInput.tileId]!,
            featureOrder: segment,
          ),
          batchKey: batchKey,
          pipeline: switch (spec.kind) {
            BaseMapLayerKind.background => throw ArgumentError.value(
              styleLayerId,
              'plans',
              'background is not drawable',
            ),
            BaseMapLayerKind.fill => baseMapFillPipelineKey,
            BaseMapLayerKind.line => baseMapLinePipelineKey,
          },
          mesh: mesh,
          modelTransform: modelTransform,
          materialParameters: parameters,
        ),
      );
    }
  }
  return List.unmodifiable(packets);
}

final _baseMapLayerSpecsByStyleLayerId = <String, BaseMapLayerSpec>{
  for (final spec in baseMapLayerSpecs) spec.styleLayerId: spec,
};

/// `baseMapLayerSpecs`からbackgroundを除いた行の並び順。
///
/// `MapRenderSortKey.declarationOrderWithinPhase`はphase内の宣言順であり、
/// base mapのphaseに載るのは非background行だけなので、backgroundを詰めた
/// index(=1つずれる)ではなく除外後のindexを使う。
final _baseMapDeclarationOrderByStyleLayerId = <String, int>{
  for (final (order, spec)
      in baseMapLayerSpecs
          .where((spec) => spec.kind != BaseMapLayerKind.background)
          .indexed)
    spec.styleLayerId: order,
};

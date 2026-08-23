import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_base_map_adapter.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_gpu_resource_ledger.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math.dart' as scene_math;

/// batchごとに独立したFlutter Scene materialを引く関数。
///
/// 同じmaterial keyでもparameter blockが異なる震度色は別material instanceを
/// 返せるよう、keyだけでなくbatch全体を渡す。
typedef FlutterSceneMapMaterialResolver = scene.PreprocessedMaterial? Function(
  MapRenderBatch batch,
);

enum FlutterSceneMeshBatchKind { baseMap, earthquakeAreaFill }

/// GPU呼び出し前に確定するScene mesh nodeのplan。
final class FlutterSceneMeshBatchPlan {
  const new({
    required this.batch,
    required this.kind,
    required this.translucentSortPriority,
  });

  final MapRenderBatch batch;
  final FlutterSceneMeshBatchKind kind;
  final int translucentSortPriority;
}

/// frame submissionをcanonicalなmesh batch planへ変換する。
List<FlutterSceneMeshBatchPlan> buildFlutterSceneMeshBatchPlans({
  required MapSceneFrameSubmission submission,
}) {
  validateMapSceneFrameSubmission(submission: submission);
  if (submission.observationBatch != null) {
    throw UnsupportedError('Observation batches are implemented by Task 7.');
  }

  return List.unmodifiable([
    for (final batch in submission.baseMap.batches)
      FlutterSceneMeshBatchPlan(
        batch: batch,
        kind: FlutterSceneMeshBatchKind.baseMap,
        translucentSortPriority: mapSceneTranslucentSortPriorityFor(
          phase: batch.compatibility.phase,
        ),
      ),
    for (final batch in submission.earthquakeFill.batches)
      FlutterSceneMeshBatchPlan(
        batch: batch,
        kind: FlutterSceneMeshBatchKind.earthquakeAreaFill,
        translucentSortPriority: mapSceneTranslucentSortPriorityFor(
          phase: batch.compatibility.phase,
        ),
      ),
  ]);
}

/// base mapとoverlayを1つのFlutter Sceneへ送る唯一のowner。
final class FlutterSceneMapAdapter {
  new({
    required scene.Scene sceneGraph,
    required FlutterSceneMapMaterialResolver materialFor,
    required int maxFramesInFlight,
  }) : this._(
         sceneGraph,
         materialFor,
         MapGpuResourceLedger<scene.MeshGeometry>(
           maxFramesInFlight: maxFramesInFlight,
         ),
       );

  new _(this._sceneGraph, this._materialFor, this._geometries);

  final scene.Scene _sceneGraph;
  final FlutterSceneMapMaterialResolver _materialFor;
  final MapGpuResourceLedger<scene.MeshGeometry> _geometries;

  var _uploadedGeometryCount = 0;
  var _retiredGeometryCount = 0;

  int get uploadedGeometryCount => _uploadedGeometryCount;
  int get retiredGeometryCount => _retiredGeometryCount;
  int get liveGeometryCount => _geometries.liveResourceCount;

  void submitFrame({required MapSceneFrameSubmission submission}) {
    final plans = buildFlutterSceneMeshBatchPlans(submission: submission);
    final resolved = resolveFlutterSceneMaterials(
      plans: plans,
      materialFor: _materialFor,
    );
    final frame = submission.frame;
    _retiredGeometryCount += _geometries
        .beginFrame(
          contextGeneration: frame.contextGeneration,
          frameNumber: frame.frameNumber,
        )
        .length;

    final nodes = <scene.Node>[];
    for (final entry in resolved) {
      applyFlutterSceneMeshBatchMaterial(
        plan: entry.plan,
        material: entry.material,
      );
      for (final (index, packet) in entry.plan.batch.packets.indexed) {
        final node = scene.Node(
          localTransform: scene_math.Matrix4.fromList(
            entry.plan.batch.instanceTransforms[index],
          ),
          mesh: scene.Mesh(_geometryFor(packet.mesh), entry.material),
        );
        applyFlutterSceneTranslucentSortPriority(
          node: node,
          phase: entry.plan.batch.compatibility.phase,
          priority: entry.plan.translucentSortPriority,
        );
        nodes.add(node);
      }
    }

    _sceneGraph
      ..removeAll()
      ..addAll(nodes);
    _retiredGeometryCount += _geometries.retireIdle().length;
  }

  void retireAllGpuResources() {
    _retiredGeometryCount += _geometries.retireAll().length;
    _sceneGraph.removeAll();
  }

  scene.MeshGeometry _geometryFor(MapPackedMesh mesh) {
    final cached = _geometries.lookup(key: mesh);
    if (cached != null) {
      return cached;
    }
    final args = unpackBaseMapSceneGeometryArgs(mesh);
    final geometry = scene.MeshGeometry.fromArrays(
      positions: args.positions,
      texCoords: args.extrudes,
      indices: args.indices,
    );
    _geometries.put(key: mesh, resource: geometry);
    _uploadedGeometryCount++;
    return geometry;
  }
}

/// 共有phase policyとの一致を検証してから実Nodeへpriorityを設定する。
void applyFlutterSceneTranslucentSortPriority({
  required scene.Node node,
  required int phase,
  required int priority,
}) {
  validateMapSceneTranslucentSortPriority(
    phase: phase,
    priority: priority,
  );
  node.translucentSortPriority = priority;
}

typedef FlutterSceneResolvedMeshBatch = ({
  FlutterSceneMeshBatchPlan plan,
  scene.PreprocessedMaterial material,
});

List<FlutterSceneResolvedMeshBatch> resolveFlutterSceneMaterials({
  required List<FlutterSceneMeshBatchPlan> plans,
  required FlutterSceneMapMaterialResolver materialFor,
}) {
  final resolved = <FlutterSceneResolvedMeshBatch>[];
  for (final plan in plans) {
    final material = materialFor(plan.batch);
    if (material == null) {
      throw StateError(
        'No Flutter Scene material is loaded for '
        '"${plan.batch.compatibility.batchKey.materialKey}".',
      );
    }
    resolved.add((plan: plan, material: material));
  }
  return List.unmodifiable(resolved);
}

void applyFlutterSceneMeshBatchMaterial({
  required FlutterSceneMeshBatchPlan plan,
  required scene.PreprocessedMaterial material,
}) {
  final compatibility = plan.batch.compatibility;
  switch (plan.kind) {
    case FlutterSceneMeshBatchKind.baseMap:
      applyBaseMapMaterialParameters(
        material: material,
        pipelineKey: compatibility.pipeline.key,
        bytes: compatibility.materialParameters.bytes,
      );
    case FlutterSceneMeshBatchKind.earthquakeAreaFill:
      final values = decodeEarthquakeAreaFillMaterialBytes(
        compatibility.materialParameters.bytes,
      );
      material.parameters.setVec4(
        'fill_color',
        scene_math.Vector4(
          values.red,
          values.green,
          values.blue,
          values.alpha,
        ),
      );
  }
}

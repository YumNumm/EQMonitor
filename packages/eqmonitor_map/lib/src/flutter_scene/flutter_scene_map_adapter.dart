import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_base_map_adapter.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/renderer/base_map_material_parameters.dart';
import 'package:eqmonitor_map/src/renderer/base_map_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_gpu_resource_ledger.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math.dart' as scene_math;

/// batchごとに独立したFlutter Scene material bindingを引く関数。
///
/// 同じmaterial keyでもparameter blockが異なる震度色は別material instanceを
/// 返せるよう、keyだけでなくbatch全体を渡す。bindingはmaterialと、そのmaterial
/// 自身のreflected parameter blockを一体で返す。
typedef FlutterSceneMapMaterialResolver =
    FlutterSceneMapMaterialBinding? Function(
      MapRenderBatch batch,
    );

/// Scene materialと、そのmaterial自身のtyped parameter blockの組。
abstract interface class FlutterSceneMapMaterialBinding {
  scene.Material get material;
  scene.MaterialParameters get parameters;
}

/// productionのpreprocessed materialをparameter blockと一体で公開するbinding。
final class FlutterScenePreprocessedMaterialBinding
    implements FlutterSceneMapMaterialBinding {
  const FlutterScenePreprocessedMaterialBinding(this.preprocessedMaterial);

  final scene.PreprocessedMaterial preprocessedMaterial;

  @override
  scene.Material get material => preprocessedMaterial;

  @override
  scene.MaterialParameters get parameters => preprocessedMaterial.parameters;
}

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
    required scene.SceneGraph sceneGraph,
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

  final scene.SceneGraph _sceneGraph;
  final FlutterSceneMapMaterialResolver _materialFor;
  final MapGpuResourceLedger<scene.MeshGeometry> _geometries;

  var _uploadedGeometryCount = 0;
  var _retiredGeometryCount = 0;

  int get uploadedGeometryCount => _uploadedGeometryCount;
  int get retiredGeometryCount => _retiredGeometryCount;
  int get liveGeometryCount => _geometries.liveResourceCount;

  void submitFrame({required MapSceneFrameSubmission submission}) {
    final plans = buildFlutterSceneMeshBatchPlans(submission: submission);
    preflightFlutterSceneMeshBatchPlans(plans: plans);
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
        parameters: entry.material.parameters,
      );
      for (final (index, packet) in entry.plan.batch.packets.indexed) {
        final node = scene.Node(
          localTransform: scene_math.Matrix4.fromList(
            entry.plan.batch.instanceTransforms[index],
          ),
          mesh: scene.Mesh(_geometryFor(packet.mesh), entry.material.material),
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

/// 全batchのpipelineとparameter blockをmutation前に検証する。
///
/// decodeをmaterial適用ループまで遅らせると、後続batchの不整合が判明する前に
/// 先行batchと共有するmaterialが部分更新される。byte列は不変なので、ここで
/// 全件decodeが成功した後の適用では同じ検証エラーは発生しない。
void preflightFlutterSceneMeshBatchPlans({
  required List<FlutterSceneMeshBatchPlan> plans,
}) {
  for (final plan in plans) {
    final compatibility = plan.batch.compatibility;
    final parameters = compatibility.materialParameters;
    switch (plan.kind) {
      case FlutterSceneMeshBatchKind.baseMap:
        if (parameters.version != baseMapMaterialParameterVersion) {
          throw ArgumentError.value(
            parameters.version,
            'materialParameters.version',
            'is not the supported base map version',
          );
        }
        if (compatibility.pipeline == baseMapFillPipelineKey) {
          decodeBaseMapFillMaterialBytes(parameters.bytes);
          continue;
        }
        if (compatibility.pipeline == baseMapLinePipelineKey) {
          decodeBaseMapLineMaterialBytes(parameters.bytes);
          continue;
        }
        throw ArgumentError.value(
          compatibility.pipeline,
          'pipeline',
          'is not a supported base map pipeline',
        );
      case FlutterSceneMeshBatchKind.earthquakeAreaFill:
        if (compatibility.pipeline != earthquakeAreaFillPipelineKey ||
            parameters.version != earthquakeAreaMaterialParameterVersion) {
          throw ArgumentError.value(
            compatibility.pipeline,
            'earthquakeAreaFill',
            'has an unsupported pipeline or parameter version',
          );
        }
        decodeEarthquakeAreaFillMaterialBytes(parameters.bytes);
    }
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
  FlutterSceneMapMaterialBinding material,
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
    validateFlutterSceneMaterialParameterAvailability(
      plan: plan,
      material: material,
    );
    resolved.add((plan: plan, material: material));
  }
  return List.unmodifiable(resolved);
}

/// materialがpipelineの必須parameterを期待型で公開していることを検証する。
void validateFlutterSceneMaterialParameterAvailability({
  required FlutterSceneMeshBatchPlan plan,
  required FlutterSceneMapMaterialBinding material,
}) {
  final requiredParameters = switch (plan.batch.compatibility.pipeline) {
    final pipeline when pipeline == baseMapFillPipelineKey => const {
      'fill_color': scene.FmatType.vec4,
    },
    final pipeline when pipeline == baseMapLinePipelineKey => const {
      'line_color': scene.FmatType.vec4,
      'half_width_ndc': scene.FmatType.vec2,
    },
    final pipeline when pipeline == earthquakeAreaFillPipelineKey => const {
      'fill_color': scene.FmatType.vec4,
    },
    _ => const <String, scene.FmatType>{},
  };
  for (final required in requiredParameters.entries) {
    final actualType = material.parameters.parameterTypeOf(required.key);
    if (actualType != required.value) {
      throw StateError(
        'Flutter Scene material parameter "${required.key}" for '
        '"${plan.batch.compatibility.pipeline.key}" must be '
        '${required.value.glslType}, got ${actualType?.glslType ?? 'missing'}.',
      );
    }
  }
}

void applyFlutterSceneMeshBatchMaterial({
  required FlutterSceneMeshBatchPlan plan,
  required scene.MaterialParameters parameters,
}) {
  final compatibility = plan.batch.compatibility;
  switch (plan.kind) {
    case FlutterSceneMeshBatchKind.baseMap:
      applyBaseMapMaterialParameters(
        parameters: parameters,
        pipelineKey: compatibility.pipeline.key,
        bytes: compatibility.materialParameters.bytes,
      );
    case FlutterSceneMeshBatchKind.earthquakeAreaFill:
      final values = decodeEarthquakeAreaFillMaterialBytes(
        compatibility.materialParameters.bytes,
      );
      parameters.setVec4(
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

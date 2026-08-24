import 'dart:async';
import 'dart:typed_data';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_base_map_adapter.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/renderer/base_map_material_parameters.dart';
import 'package:eqmonitor_map/src/renderer/base_map_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_gpu_resource_ledger.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch.dart';
import 'package:flutter_scene/gpu.dart' as scene_gpu;
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

/// 呼出時点までのScene GPU submission完了を待つbarrier。
typedef FlutterSceneGpuCompletionBarrier = Future<void> Function();

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

/// 観測点shader materialのpreflightとframe uniform更新境界。
abstract interface class FlutterSceneObservationMaterialBinding {
  scene.ShaderMaterial get material;

  void preflight({required ObservationPointBatch batch});

  void setFrameUniform(ByteData bytes);
}

/// shader bundleの必須symbolを解決したproduction observation binding。
final class FlutterSceneShaderObservationMaterialBinding
    implements FlutterSceneObservationMaterialBinding {
  factory FlutterSceneShaderObservationMaterialBinding.fromShaderLibrary({
    required scene_gpu.ShaderLibrary shaderLibrary,
  }) {
    final vertex = shaderLibrary[earthquakeObservationVertexShaderSymbol];
    final fragment = shaderLibrary[earthquakeObservationFragmentShaderSymbol];
    if (vertex == null || fragment == null) {
      throw StateError(
        'Observation shader bundle must provide '
        '$earthquakeObservationVertexShaderSymbol and '
        '$earthquakeObservationFragmentShaderSymbol.',
      );
    }
    return FlutterSceneShaderObservationMaterialBinding._(
      vertexShader: vertex,
      fragmentShader: fragment,
    );
  }

  FlutterSceneShaderObservationMaterialBinding._({
    required scene_gpu.Shader vertexShader,
    required scene_gpu.Shader fragmentShader,
  }) : _vertexShader = vertexShader,
       material = scene.ShaderMaterial(
         vertexShader: vertexShader,
         fragmentShader: fragmentShader,
         cullingMode: scene_gpu.CullMode.none,
         isOpaqueOverride: false,
       );

  final scene_gpu.Shader _vertexShader;

  @override
  final scene.ShaderMaterial material;

  @override
  void preflight({required ObservationPointBatch batch}) {
    validateObservationPointBatchAbi(batch: batch);
    observationPointVertexLayout.toGpuLayout();
    final frameSlot = _vertexShader.getUniformSlot(
      observationFrameUniformBlockName,
    );
    if (frameSlot.sizeInBytes != observationFrameUniformByteLength ||
        frameSlot.getMemberOffsetInBytes('camera_world') != 0 ||
        frameSlot.getMemberOffsetInBytes('viewport_stroke') != 16) {
      throw StateError(
        'ObservationFrame must be a 32-byte block with vec4 members at '
        'offsets 0 and 16.',
      );
    }
  }

  @override
  void setFrameUniform(ByteData bytes) {
    material.setUniformBlock(
      observationFrameUniformBlockName,
      bytes,
      stage: scene.ShaderStage.vertex,
    );
  }
}

/// 観測点quadと28-byte instance streamの固定layout。
const observationPointVertexLayout = scene.VertexLayoutDescriptor(
  buffers: [
    scene.VertexBufferDescriptor(
      strideInBytes: 8,
      attributes: [
        scene.VertexAttributeDescriptor(
          name: 'corner',
          format: scene_gpu.VertexFormat.float32x2,
        ),
      ],
    ),
    scene.VertexBufferDescriptor(
      strideInBytes: observationPointInstanceStrideInBytes,
      stepMode: scene_gpu.VertexStepMode.instance,
      attributes: [
        scene.VertexAttributeDescriptor(
          name: 'centerMercator',
          format: scene_gpu.VertexFormat.float32x2,
        ),
        scene.VertexAttributeDescriptor(
          name: 'color',
          format: scene_gpu.VertexFormat.float32x4,
          offsetInBytes: 8,
        ),
        scene.VertexAttributeDescriptor(
          name: 'radiusLogicalPixels',
          format: scene_gpu.VertexFormat.float32,
          offsetInBytes: 24,
        ),
      ],
    ),
  ],
);

/// typed batchのCPU ABIをScene/GPU mutation前に検証する。
void validateObservationPointBatchAbi({required ObservationPointBatch batch}) {
  if (batch.instanceCount <= 0 ||
      batch.instanceStrideInBytes != observationPointInstanceStrideInBytes ||
      batch.instanceData.lengthInBytes !=
          batch.instanceCount * observationPointInstanceStrideInBytes ||
      batch.frameUniform.lengthInBytes != observationFrameUniformByteLength) {
    throw ArgumentError.value(batch, 'batch', 'has an invalid observation ABI');
  }
}

/// 1 context/revisionにつき1個だけ保持するStaticInstanceGeometry owner。
final class FlutterSceneObservationGeometryOwner {
  FlutterSceneObservationGeometryOwner({required int maxFramesInFlight})
    : _maxFramesInFlight = maxFramesInFlight {
    if (maxFramesInFlight < 1) {
      throw ArgumentError.value(
        maxFramesInFlight,
        'maxFramesInFlight',
        'must be at least 1',
      );
    }
  }

  final int _maxFramesInFlight;
  final _entries = <_FlutterSceneObservationGeometryEntry>[];
  int? _currentFrame;
  int? _currentContextGeneration;
  var _retiredGeometryCount = 0;

  int get liveGeometryCount => _entries.length;
  int get retiredGeometryCount => _retiredGeometryCount;

  void beginFrame({
    required int contextGeneration,
    required int frameNumber,
  }) {
    if (contextGeneration.isNegative || frameNumber.isNegative) {
      throw ArgumentError(
        'contextGeneration and frameNumber must be non-negative',
      );
    }
    final previousFrame = _currentFrame;
    if (previousFrame != null && frameNumber < previousFrame) {
      throw ArgumentError.value(
        frameNumber,
        'frameNumber',
        'must not decrease',
      );
    }
    final previousContextGeneration = _currentContextGeneration;
    if (previousContextGeneration != null &&
        contextGeneration != previousContextGeneration) {
      for (final entry in _entries) {
        if (entry.contextGeneration == previousContextGeneration) {
          entry.retireScheduled = true;
        }
      }
    }
    _currentFrame = frameNumber;
    _currentContextGeneration = contextGeneration;
  }

  scene.StaticInstanceGeometry geometryFor({
    required ObservationPointBatch batch,
  }) {
    final frameNumber = _currentFrame;
    final contextGeneration = _currentContextGeneration;
    if (frameNumber == null || contextGeneration == null) {
      throw StateError('beginFrame() must precede geometryFor().');
    }
    for (final entry in _entries) {
      if (!entry.retireScheduled &&
          entry.contextGeneration == contextGeneration &&
          identical(entry.instanceGeneration, batch.instanceGeneration)) {
        if (entry.geometry.isRetired) {
          throw StateError(
            'A retired observation geometry cannot be reused.',
          );
        }
        entry.lastUsedFrame = frameNumber;
        return entry.geometry;
      }
    }

    final geometry = createFlutterSceneObservationGeometry(batch: batch);
    _entries.add(
      _FlutterSceneObservationGeometryEntry(
        contextGeneration: contextGeneration,
        instanceGeneration: batch.instanceGeneration,
        geometry: geometry,
        lastUsedFrame: frameNumber,
      ),
    );
    return geometry;
  }

  List<scene.StaticInstanceGeometry> retireIdle() {
    final frameNumber = _currentFrame;
    if (frameNumber == null) {
      throw StateError('beginFrame() must precede retireIdle().');
    }
    final deadline = frameNumber - _maxFramesInFlight;
    final retired = <scene.StaticInstanceGeometry>[];
    _entries.removeWhere((entry) {
      if (entry.lastUsedFrame >= deadline) {
        return false;
      }
      entry.geometry.retire();
      retired.add(entry.geometry);
      return true;
    });
    _retiredGeometryCount += retired.length;
    return retired;
  }

  void scheduleRetireAll() {
    final frameNumber = _currentFrame;
    if (frameNumber == null) {
      return;
    }
    for (final entry in _entries) {
      entry
        ..retireScheduled = true
        ..lastUsedFrame = frameNumber;
    }
  }

  Future<void> retireScheduledAfter({required Future<void> completion}) {
    final geometries = <scene.StaticInstanceGeometry>[];
    _entries.removeWhere((entry) {
      if (!entry.retireScheduled) {
        return false;
      }
      geometries.add(entry.geometry);
      return true;
    });
    var didRetire = false;
    void retireOnce() {
      if (didRetire) {
        return;
      }
      didRetire = true;
      for (final geometry in geometries) {
        geometry.retire();
      }
      _retiredGeometryCount += geometries.length;
    }

    return completion.then<void>(
      (_) => retireOnce(),
      onError: (Object _, StackTrace _) => retireOnce(),
    );
  }
}

final class _FlutterSceneObservationGeometryEntry {
  _FlutterSceneObservationGeometryEntry({
    required this.contextGeneration,
    required this.instanceGeneration,
    required this.geometry,
    required this.lastUsedFrame,
  }) : retireScheduled = false;

  final int contextGeneration;
  final ObservationPointInstanceGeneration instanceGeneration;
  final scene.StaticInstanceGeometry geometry;
  int lastUsedFrame;
  bool retireScheduled;
}

/// GPU uploadを伴わずStaticInstanceGeometryを構築する。
scene.StaticInstanceGeometry createFlutterSceneObservationGeometry({
  required ObservationPointBatch batch,
}) {
  validateObservationPointBatchAbi(batch: batch);
  return scene.StaticInstanceGeometry(
    vertices: Float32List.fromList(const [-1, -1, 1, -1, 1, 1, -1, 1]),
    indices: Uint16List.fromList(const [0, 1, 2, 0, 2, 3]),
    instanceData: batch.instanceData,
    instanceCount: batch.instanceCount,
    layout: observationPointVertexLayout,
  );
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
  final observation = submission.observationBatch;
  if (observation != null && observation is! ObservationPointBatch) {
    throw ArgumentError.value(
      observation,
      'observationBatch',
      'must be an ObservationPointBatch',
    );
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
    FlutterSceneObservationMaterialBinding? observationMaterial,
    FlutterSceneGpuCompletionBarrier waitForGpuCompletion =
        scene.waitForPendingGpuSubmissions,
  }) : this._(
         sceneGraph,
         materialFor,
         observationMaterial,
         MapGpuResourceLedger<scene.MeshGeometry>(
           maxFramesInFlight: maxFramesInFlight,
         ),
         FlutterSceneObservationGeometryOwner(
           maxFramesInFlight: maxFramesInFlight,
         ),
         waitForGpuCompletion,
       );

  new _(
    this._sceneGraph,
    this._materialFor,
    this._observationMaterial,
    this._geometries,
    this._observationGeometries,
    this._waitForGpuCompletion,
  );

  final scene.SceneGraph _sceneGraph;
  final FlutterSceneMapMaterialResolver _materialFor;
  final FlutterSceneObservationMaterialBinding? _observationMaterial;
  final MapGpuResourceLedger<scene.MeshGeometry> _geometries;
  final FlutterSceneObservationGeometryOwner _observationGeometries;
  final FlutterSceneGpuCompletionBarrier _waitForGpuCompletion;

  var _uploadedGeometryCount = 0;
  var _retiredGeometryCount = 0;
  var _uploadedObservationGeometryCount = 0;

  int get uploadedGeometryCount => _uploadedGeometryCount;
  int get retiredGeometryCount => _retiredGeometryCount;
  int get liveGeometryCount => _geometries.liveResourceCount;
  int get uploadedObservationGeometryCount => _uploadedObservationGeometryCount;
  int get retiredObservationGeometryCount =>
      _observationGeometries.retiredGeometryCount;
  int get liveObservationGeometryCount =>
      _observationGeometries.liveGeometryCount;

  void submitFrame({required MapSceneFrameSubmission submission}) {
    final plans = buildFlutterSceneMeshBatchPlans(submission: submission);
    preflightFlutterSceneMeshBatchPlans(plans: plans);
    final resolved = resolveFlutterSceneMaterials(
      plans: plans,
      materialFor: _materialFor,
    );
    final observation = switch (submission.observationBatch) {
      final ObservationPointBatch batch => batch,
      null => null,
      final other => throw ArgumentError.value(
        other,
        'observationBatch',
        'must be an ObservationPointBatch',
      ),
    };
    final observationMaterial = switch (observation) {
      null => null,
      _ =>
        _observationMaterial ??
            (throw StateError(
              'No Flutter Scene observation material is loaded.',
            )),
    };
    if (observation != null) {
      validateObservationPointBatchAbi(batch: observation);
      observationMaterial?.preflight(batch: observation);
    }
    final frame = submission.frame;
    _retiredGeometryCount += _geometries
        .beginFrame(
          contextGeneration: frame.contextGeneration,
          frameNumber: frame.frameNumber,
        )
        .length;
    _observationGeometries.beginFrame(
      contextGeneration: frame.contextGeneration,
      frameNumber: frame.frameNumber,
    );

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
    if (observation != null && observationMaterial != null) {
      final before = _observationGeometries.liveGeometryCount;
      final geometry = _observationGeometries.geometryFor(batch: observation);
      if (_observationGeometries.liveGeometryCount > before) {
        _uploadedObservationGeometryCount++;
      }
      observationMaterial.setFrameUniform(observation.frameUniform);
      final node = scene.Node(
        mesh: scene.Mesh(geometry, observationMaterial.material),
      );
      applyFlutterSceneTranslucentSortPriority(
        node: node,
        phase: observation.phase,
        priority: observation.translucentSortPriority,
      );
      nodes.add(node);
    }

    _sceneGraph
      ..removeAll()
      ..addAll(nodes);
    _retiredGeometryCount += _geometries.retireIdle().length;
    _observationGeometries.retireIdle();
  }

  void retireAllGpuResources() {
    _sceneGraph.removeAll();
    _retiredGeometryCount += _geometries.retireAll().length;
    _observationGeometries.scheduleRetireAll();
    if (_observationGeometries.liveGeometryCount == 0) {
      return;
    }
    final completion = _waitForGpuCompletion();
    unawaited(
      _observationGeometries.retireScheduledAfter(
        completion: completion,
      ),
    );
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

import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_async_generation.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_observation.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_renderer_adapter.dart';
import 'package:eqmonitor_map/src/renderer/spike_mesh_frame.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math.dart' as scene_math;

class SceneSpikeRuntimeObservation {
  const SceneSpikeRuntimeObservation({
    required this.capability,
    required this.status,
    required this.detail,
  });

  final SceneSpikeCapability capability;
  final SceneSpikeCapabilityStatus status;
  final String detail;
}

abstract interface class SceneSpikeRuntimeObservationSink {
  void record(SceneSpikeRuntimeObservation observation);
}

abstract interface class SceneSpikeControllerAdapter
    implements MapSceneRendererAdapter {
  scene.Scene? get sceneGraph;

  int? get customMaterialAppResourceGeneration;

  Future<bool> initializeCustomMaterial({
    required int appResourceGeneration,
    required SceneSpikeAsyncGenerationToken token,
  });

  Future<bool> rebuildApplicationResources({
    required int appResourceGeneration,
    required SceneSpikeAsyncGenerationToken token,
  });
}

class FlutterSceneSpikeAdapter implements SceneSpikeControllerAdapter {
  factory FlutterSceneSpikeAdapter({
    required SpikeMeshFrame initialFrame,
    required SceneSpikeRuntimeObservationSink observationSink,
  }) {
    final sceneGraph = scene.Scene();
    final geometry = scene.MeshGeometry.fromArrays(
      positions: initialFrame.positions,
      colors: initialFrame.colors,
      storage: scene.GeometryStorage.updatable,
    );
    final material = scene.UnlitMaterial()
      ..baseColorFactor = scene_math.Vector4(1, 1, 1, 1)
      ..vertexColorWeight = 1
      ..doubleSided = true;
    final node = scene.Node(mesh: scene.Mesh(geometry, material))
      ..localTransform = scene_math.Matrix4.translationValues(-0.6, 0, 0);
    sceneGraph.add(node);
    observationSink.record(
      const SceneSpikeRuntimeObservation(
        capability: .proceduralOrthographicMesh,
        status: .passed,
        detail: 'Procedural updatable quad was created.',
      ),
    );
    observationSink.record(
      const SceneSpikeRuntimeObservation(
        capability: .unlitMaterial,
        status: .passed,
        detail: 'Unlit vertex-color material was created.',
      ),
    );
    return FlutterSceneSpikeAdapter._(
      sceneGraph: sceneGraph,
      geometry: geometry,
      unlitNode: node,
      initialFrame: initialFrame,
      observationSink: observationSink,
    );
  }

  FlutterSceneSpikeAdapter._({
    required this.sceneGraph,
    required scene.MeshGeometry geometry,
    required scene.Node unlitNode,
    required SpikeMeshFrame initialFrame,
    required SceneSpikeRuntimeObservationSink observationSink,
  }) : _geometry = geometry,
       _unlitNode = unlitNode,
       _currentFrame = initialFrame,
       _observationSink = observationSink,
       _vertexCount = initialFrame.positions.length ~/ 3;

  @override
  final scene.Scene sceneGraph;
  final SceneSpikeRuntimeObservationSink _observationSink;
  final int _vertexCount;
  scene.MeshGeometry _geometry;
  scene.Node _unlitNode;
  scene.Node? _customMaterialNode;
  SpikeMeshFrame _currentFrame;
  var _isAttached = false;
  var _isForeground = false;
  var _isRebuilding = false;
  var _isDisposed = false;
  int? _pendingAppResourceGeneration;
  int? _customMaterialAppResourceGeneration;

  @override
  int? get customMaterialAppResourceGeneration =>
      _isDisposed ? null : _customMaterialAppResourceGeneration;

  @override
  Future<bool> initializeCustomMaterial({
    required int appResourceGeneration,
    required SceneSpikeAsyncGenerationToken token,
  }) async {
    try {
      final material = await scene.loadFmatMaterial('assets/map_spike.fmat');
      if (!token.isCurrent) {
        return false;
      }
      material.parameters.setVec4(
        'tint',
        scene_math.Vector4(1, 1, 1, 1),
      );
      if (!token.isCurrent) {
        return false;
      }
      final previousNode = _customMaterialNode;
      if (previousNode != null) {
        sceneGraph.remove(previousNode);
      }
      final node = scene.Node(mesh: scene.Mesh(_geometry, material))
        ..localTransform = scene_math.Matrix4.translationValues(0.6, 0, 0);
      sceneGraph.add(node);
      _customMaterialNode = node;
      _customMaterialAppResourceGeneration = appResourceGeneration;
      return true;
    } catch (_) {
      if (!token.isCurrent) {
        return false;
      }
      rethrow;
    }
  }

  @override
  Future<bool> rebuildApplicationResources({
    required int appResourceGeneration,
    required SceneSpikeAsyncGenerationToken token,
  }) async {
    if (_pendingAppResourceGeneration != appResourceGeneration) {
      throw StateError('App resource rebuild was not requested.');
    }
    final replacement = scene.MeshGeometry.fromArrays(
      positions: _currentFrame.positions,
      colors: _currentFrame.colors,
      storage: scene.GeometryStorage.updatable,
    );
    final replacementMaterial = scene.UnlitMaterial()
      ..baseColorFactor = scene_math.Vector4(1, 1, 1, 1)
      ..vertexColorWeight = 1
      ..doubleSided = true;
    final replacementNode = scene.Node(
      mesh: scene.Mesh(replacement, replacementMaterial),
    )..localTransform = scene_math.Matrix4.translationValues(-0.6, 0, 0);
    late scene.PreprocessedMaterial customMaterial;
    try {
      customMaterial = await scene.loadFmatMaterial(
        'assets/map_spike.fmat',
      );
    } catch (_) {
      if (!token.isCurrent) {
        return false;
      }
      rethrow;
    }
    if (!token.isCurrent) {
      return false;
    }
    customMaterial.parameters.setVec4(
      'tint',
      scene_math.Vector4(1, 1, 1, 1),
    );
    final replacementCustomNode = scene.Node(
      mesh: scene.Mesh(replacement, customMaterial),
    )..localTransform = scene_math.Matrix4.translationValues(0.6, 0, 0);
    if (!token.isCurrent) {
      return false;
    }
    final customNode = _customMaterialNode;
    sceneGraph.remove(_unlitNode);
    if (customNode != null) {
      sceneGraph.remove(customNode);
    }
    sceneGraph
      ..add(replacementNode)
      ..add(replacementCustomNode);
    _geometry = replacement;
    _unlitNode = replacementNode;
    _customMaterialNode = replacementCustomNode;
    _customMaterialAppResourceGeneration = appResourceGeneration;
    completeAppResourceRebuild(
      appResourceGeneration: appResourceGeneration,
    );
    return true;
  }

  @override
  void attach({required Size logicalSize, required double devicePixelRatio}) {
    if (_isDisposed) {
      throw StateError('Disposed Scene adapter cannot attach.');
    }
    if (!logicalSize.width.isFinite ||
        !logicalSize.height.isFinite ||
        logicalSize.width <= 0 ||
        logicalSize.height <= 0) {
      throw ArgumentError.value(logicalSize, 'logicalSize');
    }
    if (!devicePixelRatio.isFinite || devicePixelRatio <= 0) {
      throw ArgumentError.value(devicePixelRatio, 'devicePixelRatio');
    }
    _isAttached = true;
    _isForeground = true;
  }

  @override
  void updateMesh({required SpikeMeshFrame frame}) {
    final positionRange = frame.positionDirtyRange;
    final colorRange = frame.colorDirtyRange;
    try {
      SceneSpikeMeshUpdateValidator.validate(
        frame: frame,
        expectedVertexCount: _vertexCount,
        mayUpload:
            _isAttached && _isForeground && !_isRebuilding && !_isDisposed,
      );
    } on SceneSpikeMeshUpdateException catch (error) {
      _observationSink.record(
        SceneSpikeRuntimeObservation(
          capability: .partialPositionAndColorUpdate,
          status: .failed,
          detail: error.detail,
        ),
      );
      throw StateError(error.detail);
    }
    if (positionRange != null) {
      _geometry.updatePositions(
        frame.positions,
        dirtyStart: positionRange.start,
        dirtyCount: positionRange.count,
      );
    }
    if (colorRange != null) {
      _geometry.updateColors(
        frame.colors,
        dirtyStart: colorRange.start,
        dirtyCount: colorRange.count,
      );
    }
    _currentFrame = frame;
    _observationSink.record(
      const SceneSpikeRuntimeObservation(
        capability: .partialPositionAndColorUpdate,
        status: .passed,
        detail: 'Dirty vertex ranges were uploaded in place.',
      ),
    );
  }

  @override
  void setForeground({required bool isForeground}) {
    if (!_isAttached || _isDisposed) {
      return;
    }
    _isForeground = isForeground;
  }

  @override
  void requestAppResourceRebuild({required int appResourceGeneration}) {
    if (!_isAttached || _isDisposed || appResourceGeneration < 1) {
      throw StateError('App resource rebuild cannot start.');
    }
    _isRebuilding = true;
    _pendingAppResourceGeneration = appResourceGeneration;
  }

  @override
  void completeAppResourceRebuild({required int appResourceGeneration}) {
    if (!_isRebuilding ||
        _pendingAppResourceGeneration != appResourceGeneration) {
      throw StateError('App resource rebuild generation does not match.');
    }
    _pendingAppResourceGeneration = null;
    _isRebuilding = false;
  }

  @override
  void detach() {
    if (_isDisposed) {
      return;
    }
    _isAttached = false;
    _isForeground = false;
    _isRebuilding = false;
    _pendingAppResourceGeneration = null;
  }

  @override
  void dispose() {
    _isAttached = false;
    _isForeground = false;
    _isRebuilding = false;
    _pendingAppResourceGeneration = null;
    _isDisposed = true;
    _customMaterialAppResourceGeneration = null;
  }
}

class SceneSpikeMeshUpdateException implements Exception {
  const SceneSpikeMeshUpdateException(this.detail);

  final String detail;
}

class SceneSpikeMeshUpdateValidator {
  const SceneSpikeMeshUpdateValidator._();

  static void validate({
    required SpikeMeshFrame frame,
    required int expectedVertexCount,
    required bool mayUpload,
  }) {
    if (!mayUpload) {
      throw const SceneSpikeMeshUpdateException(
        'Mesh update is not allowed in the current lifecycle.',
      );
    }
    if (frame.positions.length ~/ 3 != expectedVertexCount ||
        frame.positions.length % 3 != 0 ||
        frame.colors.length ~/ 4 != expectedVertexCount ||
        frame.colors.length % 4 != 0) {
      throw const SceneSpikeMeshUpdateException(
        'Mesh update changed the vertex count.',
      );
    }
    final positionRange = frame.positionDirtyRange;
    final colorRange = frame.colorDirtyRange;
    if (positionRange == null && colorRange == null) {
      throw const SceneSpikeMeshUpdateException(
        'Mesh update has no dirty range.',
      );
    }
    if ((positionRange != null &&
            positionRange.start + positionRange.count > expectedVertexCount) ||
        (colorRange != null &&
            colorRange.start + colorRange.count > expectedVertexCount)) {
      throw const SceneSpikeMeshUpdateException(
        'Dirty range exceeds the fixed vertex count.',
      );
    }
  }
}

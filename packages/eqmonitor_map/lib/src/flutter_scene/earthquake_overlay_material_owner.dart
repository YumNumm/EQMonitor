import 'dart:typed_data';

import 'package:eqmonitor_map/src/flutter_scene/base_map_material_library.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_map_adapter.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_sprite_resource_owner.dart';
import 'package:eqmonitor_map/src/flutter_scene/map_gpu_probe.dart';
import 'package:eqmonitor_map/src/flutter_scene/map_shader_interface_manifest.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/overlay/map_sprite_atlas.dart';
import 'package:eqmonitor_map/src/renderer/base_map_overlay_frame_owner.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_resources.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scene/gpu.dart' as scene_gpu;
import 'package:flutter_scene/scene.dart' as scene;

typedef LoadEarthquakeAreaMaterial =
    Future<FlutterSceneMapMaterialBinding> Function();

const earthquakeObservationShaderBundleAssetKey =
    'packages/eqmonitor_map/flutter_gpu_shaders/shaderbundles/'
    'earthquake_overlay.shaderbundle';

const earthquakeOverlayShaderInterfaceAssetKey =
    'packages/eqmonitor_map/shaders/'
    'earthquake_overlay.shaderinterface.json';

sealed class EarthquakeOverlayMaterialPreparation {
  const EarthquakeOverlayMaterialPreparation();
}

final class EarthquakeOverlayMaterialPreparationReady
    extends EarthquakeOverlayMaterialPreparation {
  const EarthquakeOverlayMaterialPreparationReady({required this.stage});

  final EarthquakeOverlayMaterialStage stage;
}

final class EarthquakeOverlayMaterialPreparationFailed
    extends EarthquakeOverlayMaterialPreparation {
  const EarthquakeOverlayMaterialPreparationFailed({
    required this.error,
    required this.stackTrace,
  });

  final Object error;
  final StackTrace stackTrace;
}

final class EarthquakeOverlayMaterialPreparationSuperseded
    extends EarthquakeOverlayMaterialPreparation {
  const EarthquakeOverlayMaterialPreparationSuperseded();
}

/// Scene submit中だけ候補materialをresolverへ公開する一回限りのstage。
final class EarthquakeOverlayMaterialStage
    implements BaseMapOverlayFrameResourceStage {
  EarthquakeOverlayMaterialStage._({
    required this._owner,
    required this._generation,
    required this._materials,
  });

  final EarthquakeOverlayMaterialOwner _owner;
  final int _generation;
  final Map<_EarthquakeAreaMaterialKey, FlutterSceneMapMaterialBinding>
  _materials;

  @override
  void beginSubmission() => _owner._beginSubmission(this);

  @override
  void commit() => _owner._commit(this);

  @override
  void rollback() => _owner._rollback(this);
}

/// 現snapshotが使う震度色materialをparameter値ごとに所有する。
final class EarthquakeOverlayMaterialOwner {
  EarthquakeOverlayMaterialOwner({required this.loadMaterial});

  final LoadEarthquakeAreaMaterial loadMaterial;
  Map<_EarthquakeAreaMaterialKey, FlutterSceneMapMaterialBinding> _materials =
      const {};
  EarthquakeOverlayMaterialStage? _submissionStage;
  var _generation = 0;

  Future<EarthquakeOverlayMaterialPreparation> prepare({
    required List<EarthquakeAreaRenderStyleResources> resources,
  }) async {
    final generation = ++_generation;
    final keys = <_EarthquakeAreaMaterialKey>{
      for (final resource in resources)
        for (final entry in resource.entriesByCode.values)
          _EarthquakeAreaMaterialKey.from(entry.materialParameters),
    };
    late final List<
      MapEntry<_EarthquakeAreaMaterialKey, FlutterSceneMapMaterialBinding>
    >
    nextEntries;
    try {
      nextEntries = await Future.wait(
        keys.map((key) async {
          final material = _materials[key] ?? await loadMaterial();
          return MapEntry(key, material);
        }),
      );
    } on Object catch (error, stackTrace) {
      if (generation != _generation) {
        return const EarthquakeOverlayMaterialPreparationSuperseded();
      }
      return EarthquakeOverlayMaterialPreparationFailed(
        error: error,
        stackTrace: stackTrace,
      );
    }
    if (generation != _generation) {
      return const EarthquakeOverlayMaterialPreparationSuperseded();
    }
    return EarthquakeOverlayMaterialPreparationReady(
      stage: EarthquakeOverlayMaterialStage._(
        owner: this,
        generation: generation,
        materials: Map.unmodifiable(Map.fromEntries(nextEntries)),
      ),
    );
  }

  EarthquakeOverlayMaterialStage stageClear() {
    final generation = ++_generation;
    return EarthquakeOverlayMaterialStage._(
      owner: this,
      generation: generation,
      materials: const {},
    );
  }

  FlutterSceneMapMaterialBinding? materialFor(MapRenderBatch batch) {
    if (batch.compatibility.pipeline != earthquakeAreaFillPipelineKey) {
      return null;
    }
    final materials = _submissionStage?._materials ?? _materials;
    return materials[_EarthquakeAreaMaterialKey.from(
      batch.compatibility.materialParameters,
    )];
  }

  void _beginSubmission(EarthquakeOverlayMaterialStage stage) {
    if (stage._generation != _generation || _submissionStage != null) {
      throw StateError('Earthquake material stage is no longer current.');
    }
    _submissionStage = stage;
  }

  void _commit(EarthquakeOverlayMaterialStage stage) {
    if (!identical(_submissionStage, stage) ||
        stage._generation != _generation) {
      throw StateError('Earthquake material stage was not submitted.');
    }
    _materials = stage._materials;
    _submissionStage = null;
  }

  void _rollback(EarthquakeOverlayMaterialStage stage) {
    if (identical(_submissionStage, stage)) {
      _submissionStage = null;
    }
  }

  void clear() {
    _generation++;
    _submissionStage = null;
    _materials = const {};
  }
}

const mapSpriteVertexLayout = scene.VertexLayoutDescriptor(
  buffers: [
    scene.VertexBufferDescriptor(
      strideInBytes: mapSpriteQuadVertexStrideInBytes,
      attributes: [
        scene.VertexAttributeDescriptor(
          name: 'corner',
          format: scene_gpu.VertexFormat.float32x2,
        ),
      ],
    ),
    scene.VertexBufferDescriptor(
      strideInBytes: mapPointSpriteInstanceStrideInBytes,
      stepMode: scene_gpu.VertexStepMode.instance,
      attributes: [
        scene.VertexAttributeDescriptor(
          name: 'centerMercator',
          format: scene_gpu.VertexFormat.float32x2,
        ),
        scene.VertexAttributeDescriptor(
          name: 'uvRect',
          format: scene_gpu.VertexFormat.float32x4,
          offsetInBytes: 8,
        ),
        scene.VertexAttributeDescriptor(
          name: 'logicalSize',
          format: scene_gpu.VertexFormat.float32x2,
          offsetInBytes: 24,
        ),
        scene.VertexAttributeDescriptor(
          name: 'opacity',
          format: scene_gpu.VertexFormat.float32,
          offsetInBytes: 32,
        ),
        scene.VertexAttributeDescriptor(
          name: 'priority',
          format: scene_gpu.VertexFormat.float32,
          offsetInBytes: 36,
        ),
      ],
    ),
  ],
);

void validateMapPointSpriteBatchAbi({
  required MapPointSpriteInstanceBatch batch,
}) {
  if (batch.instanceCount <= 0 ||
      batch.instanceStrideInBytes != mapPointSpriteInstanceStrideInBytes ||
      batch.instanceData.lengthInBytes !=
          batch.instanceCount * mapPointSpriteInstanceStrideInBytes ||
      batch.frameUniform.lengthInBytes != mapSpriteFrameUniformByteLength) {
    throw ArgumentError.value(batch, 'batch', 'has an invalid sprite ABI');
  }
}

void validateMapSpriteShaderManifest({
  required MapShaderInterfaceManifest manifest,
}) {
  final vertex = manifest.shaderNamed(mapSpriteVertexShaderSymbol);
  final fragment = manifest.shaderNamed(mapSpriteFragmentShaderSymbol);
  final expectedInputs = <String, (int, int)>{
    'corner': (2, 0),
    'centerMercator': (2, 8),
    'uvRect': (4, 16),
    'logicalSize': (2, 32),
    'opacity': (1, 40),
    'priority': (1, 44),
  };
  final actualInputs = <String, (int, int)>{
    for (final input in vertex.inputs)
      if (input.type == MapShaderScalarType.float &&
          input.bitWidth == 32 &&
          input.columns == 1)
        input.name: (input.vecSize, input.offset),
  };
  final block = vertex.uniformBlocks.singleOrNull;
  final fields = block == null
      ? const <String, int>{}
      : {for (final field in block.fields) field.name: field.offsetInBytes};
  final sampledImage = fragment.sampledImages.singleOrNull;
  if (vertex.stage != MapShaderInterfaceStage.vertex ||
      fragment.stage != MapShaderInterfaceStage.fragment ||
      !mapEquals(actualInputs, expectedInputs) ||
      block?.name != mapSpriteFrameUniformBlockName ||
      block?.set != 0 ||
      block?.binding != 0 ||
      block?.sizeInBytes != mapSpriteFrameUniformByteLength ||
      !mapEquals(fields, const {
        'cameraWorld': 0,
        'viewportZoom': 16,
        'sizePolicy': 32,
        'opacityPolicy': 48,
      }) ||
      sampledImage?.name != mapSpriteAtlasUniformName ||
      sampledImage?.set != 0 ||
      sampledImage?.binding != 64) {
    throw const FormatException('Sprite shader interface ABI mismatch.');
  }
  mapSpriteVertexLayout.toGpuLayout();
}

final class FlutterSceneSpriteCandidateMaterialFactory<TMaterial> {
  const FlutterSceneSpriteCandidateMaterialFactory({
    required this.createMaterial,
  });

  final TMaterial Function() createMaterial;

  TMaterial create() => createMaterial();
}

final class FlutterSceneSpriteInstanceResource {
  const FlutterSceneSpriteInstanceResource({
    required this.geometry,
    required this.materialFactory,
  });

  final scene.StaticInstanceGeometry geometry;
  final FlutterSceneSpriteCandidateMaterialFactory<scene.ShaderMaterial>
  materialFactory;
}

final class FlutterSceneProductionSpriteResourceBackend
    implements
        FlutterSceneSpriteResourceBackend<
          scene.Texture2D,
          scene.StaticInstanceTopology,
          FlutterSceneSpriteInstanceResource
        > {
  factory FlutterSceneProductionSpriteResourceBackend({
    required scene_gpu.Shader vertexShader,
    required scene_gpu.Shader fragmentShader,
    required MapShaderInterfaceManifest manifest,
  }) => FlutterSceneProductionSpriteResourceBackend._(
    vertexShader,
    fragmentShader,
    manifest,
  );

  FlutterSceneProductionSpriteResourceBackend._(
    this._vertexShader,
    this._fragmentShader,
    this._manifest,
  );

  final scene_gpu.Shader _vertexShader;
  final scene_gpu.Shader _fragmentShader;
  final MapShaderInterfaceManifest _manifest;

  @override
  void preflightShaderInterface(MapPointSpriteInstanceBatch batch) {
    validateMapPointSpriteBatchAbi(batch: batch);
    validateMapSpriteShaderManifest(manifest: _manifest);
    final frameSlot = _vertexShader.getUniformSlot(
      mapSpriteFrameUniformBlockName,
    );
    if (frameSlot.sizeInBytes != mapSpriteFrameUniformByteLength ||
        frameSlot.getMemberOffsetInBytes('cameraWorld') != 0 ||
        frameSlot.getMemberOffsetInBytes('viewportZoom') != 16 ||
        frameSlot.getMemberOffsetInBytes('sizePolicy') != 32 ||
        frameSlot.getMemberOffsetInBytes('opacityPolicy') != 48) {
      throw StateError('Native SpriteFrame reflection does not match ABI v1.');
    }
  }

  @override
  scene.Texture2D uploadTexture(MapSpriteAtlas atlas) =>
      scene.Texture2D.fromPixels(
        atlas.rgbaBytes,
        atlas.width,
        atlas.height,
        sampling: const scene.TextureSampling(
          mipmaps: false,
          // Keep atlas filtering explicit even though Scene defaults match.
          // ignore: avoid_redundant_argument_values
          minFilter: scene_gpu.MinMagFilter.linear,
          // Preserve the atlas contract if Scene changes its default filter.
          // ignore: avoid_redundant_argument_values
          magFilter: scene_gpu.MinMagFilter.linear,
          maxAnisotropy: 1,
          addressMode: scene_gpu.SamplerAddressMode.clampToEdge,
        ),
      );

  @override
  scene.StaticInstanceTopology prepareTopology({
    required int spriteAbiVersion,
    required int materialVersion,
  }) {
    if (spriteAbiVersion != mapSpriteInstanceAbiVersion ||
        materialVersion != mapSpriteMaterialAbiVersion) {
      throw StateError('Unsupported sprite topology ABI.');
    }
    final topology = scene.StaticInstanceTopology(
      vertices: Float32List.fromList(const [-1, -1, 1, -1, 1, 1, -1, 1]),
      indices: Uint16List.fromList(const [0, 1, 2, 0, 2, 3]),
      layout: mapSpriteVertexLayout,
    );
    topology.prepare();
    return topology;
  }

  @override
  FlutterSceneSpriteInstanceResource prepareInstance({
    required scene.StaticInstanceTopology topology,
    required MapPointSpriteInstanceBatch batch,
  }) {
    final geometry = scene.StaticInstanceGeometry.withTopology(
      topology: topology,
      instanceData: batch.instanceData,
      instanceCount: batch.instanceCount,
      layout: mapSpriteVertexLayout,
    );
    geometry.prepare();
    return FlutterSceneSpriteInstanceResource(
      geometry: geometry,
      materialFactory: FlutterSceneSpriteCandidateMaterialFactory(
        createMaterial: () => scene.ShaderMaterial(
          vertexShader: _vertexShader,
          fragmentShader: _fragmentShader,
          cullingMode: scene_gpu.CullMode.none,
          isOpaqueOverride: false,
        ),
      ),
    );
  }

  @override
  void retireInstance(FlutterSceneSpriteInstanceResource instance) {
    instance.geometry.retire();
  }

  @override
  void retireTexture(scene.Texture2D texture) {
    // Texture2D has no explicit retire API. Dropping the owner reference lets
    // flutter_scene release the native texture after its in-flight pins end.
  }

  @override
  void retireTopology(scene.StaticInstanceTopology topology) {
    topology.retire();
  }
}

final class FlutterSceneSpriteSceneResources
    implements FlutterSceneSpriteFrameResources {
  FlutterSceneSpriteSceneResources({required this.owner});

  final FlutterSceneSpriteResourceOwner<
    scene.Texture2D,
    scene.StaticInstanceTopology,
    FlutterSceneSpriteInstanceResource
  >
  owner;

  MapGpuResourceCounterSnapshot get snapshot => owner.snapshot;

  @override
  FlutterSceneSpritePreparedSceneFrame prepareFrame({
    required MapFrameSnapshot frame,
    required List<MapPointSpriteInstanceBatch> batches,
  }) {
    final prepared = owner.prepareFrame(frame: frame, batches: batches);
    try {
      final nodes = [
        for (final entry in prepared.nodes)
          FlutterSceneSpritePreparedSceneNode(
            batch: entry.batch,
            node: scene.Node(
              mesh: scene.Mesh(
                entry.instance.geometry,
                entry.instance.materialFactory.create()
                  ..setUniformBlock(
                    mapSpriteFrameUniformBlockName,
                    entry.batch.frameUniform,
                    stage: scene.ShaderStage.vertex,
                  )
                  ..setTexture(mapSpriteAtlasUniformName, entry.texture),
              ),
            ),
          ),
      ];
      return _FlutterSceneSpritePreparedSceneFrame(
        prepared: prepared,
        nodes: List.unmodifiable(nodes),
      );
    } on Exception {
      prepared.rollback();
      rethrow;
      // Synchronous GPU allocation can report StateError during candidate prep.
      // ignore: avoid_catching_errors
    } on Error {
      prepared.rollback();
      rethrow;
    }
  }

  @override
  void retireAll() {
    owner.retireAll();
  }
}

final class _FlutterSceneSpritePreparedSceneFrame
    implements FlutterSceneSpritePreparedSceneFrame {
  const _FlutterSceneSpritePreparedSceneFrame({
    required this.prepared,
    required this.nodes,
  });

  final FlutterSceneSpritePreparedFrame<
    scene.Texture2D,
    scene.StaticInstanceTopology,
    FlutterSceneSpriteInstanceResource
  >
  prepared;

  @override
  final List<FlutterSceneSpritePreparedSceneNode> nodes;

  @override
  void commit() {
    prepared.commit();
  }

  @override
  void rollback() {
    prepared.rollback();
  }
}

@immutable
final class _EarthquakeAreaMaterialKey {
  _EarthquakeAreaMaterialKey.from(MapMaterialParameterBlock parameters)
    : this._(
        parameters.version,
        _words(parameters.bytes),
      );

  const _EarthquakeAreaMaterialKey._(this.version, this.words);

  final int version;
  final (int, int, int, int) words;

  static (int, int, int, int) _words(Uint8List bytes) {
    if (bytes.length != earthquakeAreaFillMaterialByteLength) {
      throw ArgumentError.value(bytes.length, 'bytes');
    }
    final data = ByteData.sublistView(bytes);
    return (
      data.getUint32(0, Endian.little),
      data.getUint32(4, Endian.little),
      data.getUint32(8, Endian.little),
      data.getUint32(12, Endian.little),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is _EarthquakeAreaMaterialKey &&
      other.version == version &&
      other.words == words;

  @override
  int get hashCode => Object.hash(version, words);
}

Future<FlutterSceneMapMaterialBinding>
loadEarthquakeAreaMaterialBinding() async =>
    FlutterScenePreprocessedMaterialBinding(
      await BaseMapMaterialLibrary.loadEarthquakeAreaFillMaterial(),
    );

Future<FlutterSceneObservationMaterialBinding>
loadEarthquakeObservationMaterialBinding() async {
  final shaderLibrary = await scene_gpu.loadShaderLibraryAsync(
    earthquakeObservationShaderBundleAssetKey,
  );
  if (shaderLibrary == null) {
    throw StateError(
      'No DataAssets observation shader bundle at '
      '$earthquakeObservationShaderBundleAssetKey.',
    );
  }
  return FlutterSceneShaderObservationMaterialBinding.fromShaderLibrary(
    shaderLibrary: shaderLibrary,
  );
}

final class FlutterSceneSpriteInitializationFailure implements Exception {
  const FlutterSceneSpriteInitializationFailure({
    required this.message,
    this.stackTrace,
  });

  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() => 'FlutterSceneSpriteInitializationFailure($message)';
}

Future<T?> loadOptionalFlutterSceneSpriteResources<T>({
  required Future<T> Function() load,
}) async {
  try {
    return await load();
  } on FlutterSceneSpriteInitializationFailure {
    return null;
  }
}

Future<FlutterSceneSpriteSceneResources> loadEarthquakeSpriteSceneResources({
  required MapSpriteRendererLimits limits,
  required int maxFramesInFlight,
  required MapSpriteGpuCompletionBarrier waitForGpuCompletion,
  MapGpuProbeRuntime? probeRuntime,
  ValueChanged<MapGpuResourceCounterSnapshot>? onCounterSnapshot,
}) async {
  final shaderInputs = await _loadEarthquakeSpriteShaderInputs();
  final backend = FlutterSceneProductionSpriteResourceBackend(
    vertexShader: shaderInputs.vertex,
    fragmentShader: shaderInputs.fragment,
    manifest: shaderInputs.manifest,
  );
  return FlutterSceneSpriteSceneResources(
    owner: FlutterSceneSpriteResourceOwner(
      limits: limits,
      maxFramesInFlight: maxFramesInFlight,
      backend: backend,
      waitForGpuCompletion: waitForGpuCompletion,
      probeRuntime: probeRuntime,
      onCounterSnapshot: onCounterSnapshot,
    ),
  );
}

Future<
  ({
    scene_gpu.Shader vertex,
    scene_gpu.Shader fragment,
    MapShaderInterfaceManifest manifest,
  })
>
_loadEarthquakeSpriteShaderInputs() async {
  try {
    final (shaderLibrary, manifestBytes) = await (
      scene_gpu.loadShaderLibraryAsync(
        earthquakeObservationShaderBundleAssetKey,
      ),
      rootBundle.load(earthquakeOverlayShaderInterfaceAssetKey),
    ).wait;
    if (shaderLibrary == null) {
      throw StateError(
        'No DataAssets sprite shader bundle at '
        '$earthquakeObservationShaderBundleAssetKey.',
      );
    }
    final vertex = shaderLibrary[mapSpriteVertexShaderSymbol];
    final fragment = shaderLibrary[mapSpriteFragmentShaderSymbol];
    if (vertex == null || fragment == null) {
      throw StateError(
        'Sprite shader bundle must provide $mapSpriteVertexShaderSymbol and '
        '$mapSpriteFragmentShaderSymbol.',
      );
    }
    return (
      vertex: vertex,
      fragment: fragment,
      manifest: MapShaderInterfaceManifest.parse(
        jsonBytes: manifestBytes.buffer.asUint8List(
          manifestBytes.offsetInBytes,
          manifestBytes.lengthInBytes,
        ),
      ),
    );
  } on Exception catch (error, stackTrace) {
    throw FlutterSceneSpriteInitializationFailure(
      message: error.toString(),
      stackTrace: stackTrace,
    );
    // rootBundle reports a missing declared asset as FlutterError.
    // ignore: avoid_catching_errors
  } on FlutterError catch (error, stackTrace) {
    throw FlutterSceneSpriteInitializationFailure(
      message: error.message,
      stackTrace: stackTrace,
    );
  }
}

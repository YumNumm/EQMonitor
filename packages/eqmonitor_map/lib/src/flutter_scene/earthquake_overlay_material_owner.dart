import 'package:eqmonitor_map/src/flutter_scene/base_map_material_library.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_map_adapter.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/renderer/base_map_overlay_frame_owner.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_resources.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_scene/gpu.dart' as scene_gpu;

typedef LoadEarthquakeAreaMaterial =
    Future<FlutterSceneMapMaterialBinding> Function();

const earthquakeObservationShaderBundleAssetKey =
    'packages/eqmonitor_map/flutter_gpu_shaders/shaderbundles/'
    'earthquake_overlay.shaderbundle';

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

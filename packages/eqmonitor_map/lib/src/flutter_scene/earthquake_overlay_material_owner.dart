import 'package:eqmonitor_map/src/flutter_scene/base_map_material_library.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_map_adapter.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_resources.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_scene/gpu.dart' as scene_gpu;

typedef LoadEarthquakeAreaMaterial =
    Future<FlutterSceneMapMaterialBinding> Function();

const earthquakeObservationShaderBundleAssetKey =
    'packages/eqmonitor_map/flutter_gpu_shaders/shaderbundles/'
    'earthquake_overlay.shaderbundle';

/// 現snapshotが使う震度色materialをparameter値ごとに所有する。
final class EarthquakeOverlayMaterialOwner {
  EarthquakeOverlayMaterialOwner({required this.loadMaterial});

  final LoadEarthquakeAreaMaterial loadMaterial;
  Map<_EarthquakeAreaMaterialKey, FlutterSceneMapMaterialBinding> _materials =
      const {};
  var _generation = 0;

  Future<bool> prepare({
    required List<EarthquakeAreaRenderStyleResources> resources,
  }) async {
    final generation = ++_generation;
    final keys = <_EarthquakeAreaMaterialKey>{
      for (final resource in resources)
        for (final entry in resource.entriesByCode.values)
          _EarthquakeAreaMaterialKey.from(entry.materialParameters),
    };
    final nextEntries = await Future.wait(
      keys.map((key) async {
        final material = _materials[key] ?? await loadMaterial();
        return MapEntry(key, material);
      }),
    );
    if (generation != _generation) {
      return false;
    }
    _materials = Map.unmodifiable(Map.fromEntries(nextEntries));
    return true;
  }

  FlutterSceneMapMaterialBinding? materialFor(MapRenderBatch batch) {
    if (batch.compatibility.pipeline != earthquakeAreaFillPipelineKey) {
      return null;
    }
    return _materials[_EarthquakeAreaMaterialKey.from(
      batch.compatibility.materialParameters,
    )];
  }

  void clear() {
    _generation++;
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

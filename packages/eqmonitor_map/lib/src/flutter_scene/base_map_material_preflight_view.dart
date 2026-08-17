import 'dart:async';

import 'package:eqmonitor_map/src/flutter_scene/scene_spike_camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math.dart' as scene_math;

/// consumer appのビルドで、Flutter Sceneのstatic resource初期化とこのpackageが
/// 同梱する`.fmat`のdata asset解決が成立することだけを確認する最小描画。
///
/// 実際のベースレイヤー描画は`docs/superpowers/plans/2026-08-05-eqmonitor-map-base-layer-pmtiles.md`
/// のTask 8とTask 10が持つ。ここでtile、camera操作、layer順を扱わない。
class BaseMapMaterialPreflightView extends HookWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final sceneGraph = useMemoized(scene.Scene.new);
    final camera = useMemoized(() => createSceneSpikeCameraSetup().camera);
    final failure = useState<Object?>(null);
    final isMaterialReady = useState(false);

    useEffect(() {
      var isDisposed = false;
      unawaited(
        _initialize(sceneGraph: sceneGraph)
            .then((_) {
              if (!isDisposed) {
                isMaterialReady.value = true;
              }
            })
            .onError<Object>((error, _) {
              if (!isDisposed) {
                failure.value = error;
              }
            }),
      );
      return () => isDisposed = true;
    }, [sceneGraph]);

    return Stack(
      children: [
        Positioned.fill(child: scene.SceneView(sceneGraph, camera: camera)),
        Positioned(
          left: 12,
          right: 12,
          bottom: 12,
          child: _PreflightStatusCard(
            failure: failure.value,
            isMaterialReady: isMaterialReady.value,
          ),
        ),
      ],
    );
  }
}

class _PreflightStatusCard extends StatelessWidget {
  const new({
    required this.failure,
    required this.isMaterialReady,
  });

  final Object? failure;
  final bool isMaterialReady;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (message, color) = switch ((failure, isMaterialReady)) {
      (final Object failure, _) => (
        'material読み込み失敗: $failure',
        theme.colorScheme.error,
      ),
      (_, true) => ('base_map_fill.fmat 読み込み済み', theme.colorScheme.primary),
      (_, false) => ('Flutter Scene初期化中', theme.colorScheme.onSurfaceVariant),
    };
    return Material(
      color: theme.colorScheme.surface.withValues(alpha: 0.94),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(color: color),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Object?>('failure', failure))
      ..add(DiagnosticsProperty<bool>('isMaterialReady', isMaterialReady));
  }
}

Future<void> _initialize({required scene.Scene sceneGraph}) async {
  await scene.Scene.initializeStaticResources();
  final material = await scene.loadFmatMaterial('assets/base_map_fill.fmat');
  material.parameters.setVec4(
    'fill_color',
    scene_math.Vector4(0.16, 0.55, 0.35, 1),
  );
  final geometry = scene.MeshGeometry.fromArrays(
    positions: Float32List.fromList(const [
      -0.8, -0.6, 0, //
      0.8, -0.6, 0, //
      0, 0.8, 0, //
    ]),
  );
  sceneGraph.add(scene.Node(mesh: scene.Mesh(geometry, material)));
}

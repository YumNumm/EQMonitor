import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_orthographic_projection.dart';
import 'package:eqmonitor_map/src/renderer/eqmonitor_orthographic_projection.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math.dart' as scene_math;

/// `FlutterSceneSpikeController.create`と`BaseMapMaterialPreflightView`が
/// 共通で必要とする、projectionとNodeCameraの組。
///
/// projectionは`projectionMatrixFor`にも使うため、cameraが持つ
/// [FlutterSceneOrthographicProjection]とは別に保持できる形にしている。
typedef SceneSpikeCameraSetup = ({
  EqmonitorOrthographicProjection projection,
  scene.NodeCamera camera,
});

const _worldHalfHeight = 1.2;

// cameraは描画面から離れて立つため、depth範囲がその距離を超えないと
// 三角形がラスタライズ前にクリップされる。
const _cameraStandoff = 2.0;

/// spikeのプレビュー描画すべてで共有する、cameraとprojectionの構築処理。
SceneSpikeCameraSetup createSceneSpikeCameraSetup() {
  final projection = EqmonitorOrthographicProjection(
    worldHalfHeight: _worldHalfHeight,
    depthHalfExtent: _cameraStandoff + _worldHalfHeight,
  );
  final cameraNode = scene.Node(
    localTransform: scene_math.Matrix4.translationValues(
      0,
      0,
      -_cameraStandoff,
    ),
  );
  return (
    projection: projection,
    camera: scene.NodeCamera(
      cameraNode,
      FlutterSceneOrthographicProjection(projection: projection),
    ),
  );
}

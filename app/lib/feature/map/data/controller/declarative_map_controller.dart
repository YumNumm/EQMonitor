import 'package:maplibre_gl/maplibre_gl.dart';

/// 宣言的な地図コントローラー
class DeclarativeMapController {
  MapLibreMapController? _controller;

  /// コントローラーを取得
  MapLibreMapController? get controller => _controller;

  /// コントローラーを設定
  void setController(MapLibreMapController controller) {
    _controller = controller;
  }

  /// カメラを移動
  Future<void> moveCamera(CameraUpdate update) async {
    final controller = _controller;
    if (controller == null) {
      return;
    }
    await controller.animateCamera(update);
  }

  /// カメラの位置を設定
  Future<void> moveCameraToPosition(CameraPosition position) async {
    await moveCamera(
      CameraUpdate.newCameraPosition(position),
    );
  }
}

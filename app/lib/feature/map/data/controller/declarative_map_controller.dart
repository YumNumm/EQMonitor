import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/map/ui/declarative_map.dart';
import 'package:flutter/services.dart';
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

  Future<void> addHypocenterImages() async {
    final controller = _controller;
    if (controller == null) {
      return;
    }

    await Future.wait([
      for (final asset in DeclarativeAssets.values)
        () async {
          final bytes = await _loadImageBytes(asset.path);
          if (bytes != null) {
            await controller.addImage(asset.name, bytes);
          } else {
            talker.error('Failed to load image: $asset');
          }
        }(),
    ]);
  }

  Future<Uint8List?> _loadImageBytes(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }
}

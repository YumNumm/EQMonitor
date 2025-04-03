import 'package:flutter/material.dart';
import 'package:jma_map/src/layers/layer_render_parameter.dart';
import 'package:jma_map/src/layers/map_layer.dart';

/// 複数のレイヤーを管理するクラス
/// C#の`MapLayerHost`に相当
class MapLayerHost {
  /// 再描画が要求されたときのコールバック
  VoidCallback? onRefreshRequested;

  /// レイヤーのリスト
  List<MapLayer> _layers = [];

  /// レイヤーのリストを取得
  List<MapLayer> get layers => _layers;

  /// レイヤーのリストを設定
  set layers(List<MapLayer> value) {
    // 古いレイヤーのコールバックを解除
    for (final layer in _layers) {
      layer.onRefreshRequested = null;
    }

    _layers = value;

    // 新しいレイヤーにコールバックを設定
    for (final layer in _layers) {
      layer.onRefreshRequested = _onLayerRefreshRequested;
      layer.refreshResourceCache();
    }

    // 再描画を要求
    onRefreshRequested?.call();
  }

  /// レイヤーから再描画要求があったときのコールバック
  void _onLayerRefreshRequested() {
    onRefreshRequested?.call();
  }

  /// レイヤーの描画を行う
  ///
  /// [canvas] 描画対象のキャンバス
  /// [param] 描画パラメータ
  /// [isAnimating] アニメーション中かどうか
  ///
  /// 戻り値: 次フレームの描画を即時行った方が良いか
  bool render(Canvas canvas, LayerRenderParameter param, bool isAnimating) {
    var needPersistentUpdate = false;

    for (final layer in _layers) {
      layer.render(canvas, param, isAnimating);
      if (layer.needPersistentUpdate) {
        needPersistentUpdate = true;
      }
    }

    return needPersistentUpdate;
  }
}

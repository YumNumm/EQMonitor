import 'package:flutter/material.dart';
import 'package:jma_map/src/layers/layer_render_parameter.dart';

/// すべてのレイヤーの基底クラス
/// C#の`MapLayer`に相当
abstract class MapLayer {
  /// 再描画が要求されたときのコールバック
  VoidCallback? onRefreshRequested;

  /// 連続した更新が必要かどうか
  /// 描画時にこのフラグが有効なレイヤーが存在している場合、次フレームの描画が予約される
  bool get needPersistentUpdate;

  /// 再描画を要求する
  void refreshRequest() {
    onRefreshRequested?.call();
  }

  /// リソースのキャッシュを更新する
  /// レイヤー変更時必ず1度は呼ばれる
  void refreshResourceCache();

  /// 描画を行う
  ///
  /// [canvas] 描画対象のキャンバス
  /// [param] 描画パラメータ
  /// [isAnimating] アニメーション中かどうか
  void render(Canvas canvas, LayerRenderParameter param, bool isAnimating);
}

import 'dart:ui';

import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math.dart' show Vector2;

/// `base_map_fill.fmat`/`base_map_line.fmat`から、layerごとに独立した
/// `scene.PreprocessedMaterial`を1つずつ作る静的factory。
///
/// # 設計変更の経緯
///
/// 以前は`load()`がfill/line用に1つずつしかmaterialを作らず、全fill layer・
/// 全line layerがその2つのinstanceを共有していた。`docs/map_spec_v3.md`が
/// layerごとに定義する色(`baseMapLayerSpecs`の`color`)は、共有materialの
/// 1色にしか反映できず、結果として全fill layerが同じ色・全line layerが
/// 同じ色で描かれ、`spec.color`は事実上使われていなかった
/// (実機確認でこれが判明した。team-lead指摘)。
///
/// `tile × layer × material`単位でbatchするという設計原則(Global
/// Constraints)は、「1つのmaterial instanceを複数のtileのnodeで使い回す」
/// ことを求めているのであって、「1つのmaterial instanceを複数のlayerでも
/// 使い回す」ことまでは求めていない。layerごとに1つのmaterial instanceを
/// 持たせても、tileの数やnodeの数には依存しないため原則には反しない。
///
/// このため、[loadFillMaterial]/[loadLineMaterial]は呼ばれるたびに新しい
/// `PreprocessedMaterial`を1つ読み込み、指定された色(と線幅)をその場で
/// 焼き込んで返す。呼び出し側(`_BaseMapController`)が
/// `baseMapLayerSpecs`の非background行ごとに1回ずつ呼び、
/// `styleLayerId`をkeyにして結果を保持する。
class BaseMapMaterialLibrary {
  const BaseMapMaterialLibrary._();

  /// `assets/base_map_fill.fmat`を新しく1つ読み込み、[color]を設定する。
  static Future<scene.PreprocessedMaterial> loadFillMaterial({
    required Color color,
  }) async {
    final material = await scene.loadFmatMaterial('assets/base_map_fill.fmat');
    material.parameters.setColor('fill_color', color);
    return material;
  }

  /// `assets/base_map_line.fmat`を新しく1つ読み込み、[color]を設定し、
  /// [setLineHalfWidth]で[halfWidthLogicalPixels]と[viewport]から求めた
  /// NDC単位の半線幅を焼き込む。[viewport]が変わったら[setLineHalfWidth]を
  /// 呼び直す必要がある(このメソッドは初期値を設定するだけ)。
  static Future<scene.PreprocessedMaterial> loadLineMaterial({
    required Color color,
    required double halfWidthLogicalPixels,
    required MapViewport viewport,
  }) async {
    final material = await scene.loadFmatMaterial('assets/base_map_line.fmat');
    material.parameters.setColor('line_color', color);
    setLineHalfWidth(
      material: material,
      halfWidthLogicalPixels: halfWidthLogicalPixels,
      viewport: viewport,
    );
    return material;
  }

  /// 既存の[material]の`half_width_ndc`パラメータを、[halfWidthLogicalPixels]
  /// と[viewport]から[halfLineWidthNdcFor]で求め直して上書きする。
  ///
  /// NDC単位の換算は[viewport]の`logicalSize`(width/height)に依存するため、
  /// viewportが変わる度(resize・画面回転)に呼び直す必要がある
  /// (`lib/src/widget/base_map_view.dart`の`updateViewport`参照)。
  static void setLineHalfWidth({
    required scene.PreprocessedMaterial material,
    required double halfWidthLogicalPixels,
    required MapViewport viewport,
  }) {
    material.parameters.setVec2(
      'half_width_ndc',
      halfLineWidthNdcFor(
        halfWidthLogicalPixels: halfWidthLogicalPixels,
        viewport: viewport,
      ),
    );
  }
}

/// logical pixel単位の半線幅を、`base_map_line.fmat`の`vertex{}`が
/// `vertex.world_position`(実質NDC相当。下記「訂正」節参照)へ加算する
/// NDC単位のvec2半線幅へ換算する。
///
/// # 換算式
///
/// ```dart
/// half_width_ndc = (
///   2 * halfWidthLogicalPixels / viewport.logicalSize.width,
///   2 * halfWidthLogicalPixels / viewport.logicalSize.height,
/// )
/// ```
///
/// NDCは`viewport.logicalSize`の`width × height`(logical px)に対して
/// `[-1, 1]`(全幅/全高2)を張る座標系なので、1 logical pxはNDCでx軸
/// `2/width`、y軸`2/height`に相当する。world空間では1 world px=1
/// logical pxで等方(x/yで同じ換算係数)だが、NDCは軸ごとに正規化されて
/// いるため、xとyで異なる係数を掛けて初めて画面上で等方な線幅になる
/// (`viewProjectionMatrixFor`が組み立てる正射影はY反転と平行移動を含む
/// affine変換だが回転を含まない対角scaleであるため、押し出しベクトルの
/// x/y成分をこの係数で独立に掛けるだけで正しいNDCオフセットが求まる)。
///
/// # 訂正: このdoc commentは以前「1 world単位=1 logical pixel」という
/// 誤った前提の恒等関数を導出していた
///
/// 以前のバージョンは、`extrude`が「tileMatrixFor適用後・camera/projection
/// 適用**前**のworld_positionへ加算される」という前提のもとで
/// `half_width_world == halfWidthLogicalPixels`という換算式(実質恒等関数)
/// を導出し、それをレビューで「world空間の縮尺だけを検証して正しい」と
/// 確認していた。**しかしこの確認はworld空間の縮尺だけを見ており、
/// 押し出しの加算がパイプラインの実際どの時点で起きるかを見落として
/// いた。**
///
/// 実際には`lib/src/widget/base_map_view.dart`の`_combinedTransformFor`が
/// 各tileのnodeへ`viewProjectionMatrixFor(camera, viewport) * tileMatrixFor`
/// を丸ごと`localTransform`(flutter_sceneのmodel transform)として焼き込み、
/// Scene側camera(`_IdentityCameraProjection`)は何も変換しない。flutter_scene
/// の生成頂点シェーダー(`flutter_scene_unskinned_body.glsl`)は
/// `vertex.world_position = model_transform * position`を`Vertex()`
/// 呼び出し**前**に計算し、`Vertex()`が`world_position`を書き換えた後で
/// `gl_Position = camera_transform * vec4(world_position, 1.0)`
/// (`camera_transform`はIdentity)を計算する。つまり`extrude`の加算は
/// tileMatrixForとviewProjectionForの**両方を通し終えた後**、実質NDCに
/// 近い空間に対して行われており、「camera/projection適用前」という
/// 旧doc commentの前提はこの camera 配線では成り立たない。
///
/// この結果、旧換算式の`half_width_world=1.0`はNDCで1.0(可視範囲±1の
/// 半分)もの押し出しとなり、画面全体を線色で塗り潰す不具合を生んで
/// いた(harness実験・実機確認で再現。詳細は
/// `.superpowers/sdd/2026-08-05-eqmonitor-map-base-layer-pmtiles/
/// extrude-fix-report.md`参照)。この事実に基づき、換算をworld単位の
/// 恒等関数からNDC単位のvec2へ変更した。
///
/// **shader内で`half_width_ndc`をzoomから再計算する実装(例:
/// `scaleForZoom(zoom)`を掛ける)は行わないこと。** `viewProjectionMatrixFor`
/// のY反転・平行移動はzoomに依存せず、`half_width_ndc`はviewportの
/// logical sizeだけに依存する(導出根拠は上記の換算式参照)。
Vector2 halfLineWidthNdcFor({
  required double halfWidthLogicalPixels,
  required MapViewport viewport,
}) {
  if (!halfWidthLogicalPixels.isFinite || halfWidthLogicalPixels < 0) {
    throw ArgumentError.value(
      halfWidthLogicalPixels,
      'halfWidthLogicalPixels',
      'must be finite and non-negative',
    );
  }
  return Vector2(
    2 * halfWidthLogicalPixels / viewport.logicalSize.width,
    2 * halfWidthLogicalPixels / viewport.logicalSize.height,
  );
}

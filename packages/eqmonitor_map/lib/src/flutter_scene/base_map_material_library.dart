import 'dart:ui';

import 'package:flutter_scene/scene.dart' as scene;

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

  /// `assets/base_map_line.fmat`を新しく1つ読み込み、[color]と
  /// [halfWidthLogicalPixels]を設定する。[halfWidthLogicalPixels]の単位・
  /// 換算方法は[halfLineWidthWorldFor]のdoc comment参照。
  static Future<scene.PreprocessedMaterial> loadLineMaterial({
    required Color color,
    required double halfWidthLogicalPixels,
  }) async {
    final material = await scene.loadFmatMaterial('assets/base_map_line.fmat');
    material.parameters
      ..setColor('line_color', color)
      ..setFloat(
        'half_width_world',
        halfLineWidthWorldFor(halfWidthLogicalPixels: halfWidthLogicalPixels),
      );
    return material;
  }
}

/// logical pixel単位の半線幅を、`base_map_line.fmat`の`vertex{}`が
/// `vertex.world_position`へ加算するworld単位の半線幅へ換算する。
///
/// # 換算式
///
/// 換算係数は1、つまり`half_width_world == halfWidthLogicalPixels`である。
/// zoomに依存する項は存在しない。
///
/// # 導出根拠
///
/// `assets/base_map_line.fmat`の`Vertex()`は`extrude`(方向のみを持つ
/// 単位ベクトル。tile-local座標のscaleを持たない。`lib/src/mesh/line_mesh.dart`
/// のdoc comment参照)を、tileMatrixFor適用後・camera/projection適用前の
/// `vertex.world_position`へ直接加算する。この`world_position`が使う
/// world座標系は、次の2つの理由から常に「1 world単位 == 1 logical pixel」
/// になるよう設計されている(zoomや`tileMatrixFor`のscaleは無関係)。
///
/// 1. `geo/tile_matrix.dart`の`viewProjectionMatrixFor`が組み立てる正射影
///    (`EqmonitorOrthographicProjection`)は、`worldHalfHeight`に
///    `viewport.logicalSize.height / 2`──画面のlogical pixel高さの半分
///    ──を渡す。zoomや`MapCamera.zoom`はここに一切現れない。
/// 2. `geo/tile_matrix.dart`の`tileMatrixFor`はtile-local座標を
///    `MapMercatorProjection.worldSizeForZoom(zoom)`基準のworld pixel座標へ
///    配置し、`geo/map_camera.dart`の`MapCamera.worldCenter`も同じ
///    `worldSizeForZoom(zoom)`でcamera中心をworld座標へ投影する。つまり
///    zoomが変わっても、tileとcamera中心は「同じzoom基準のworld pixel
///    座標系」の中で一貫して動くだけで、(1)の正射影のworldHalfHeightは
///    変化しない。
///
/// (1)(2)を合わせると、正射影が「world高さ`viewport.logicalSize.height`を
/// 画面いっぱい(`viewport.logicalSize.height` logical pixel)へ写す」写像
/// である以上、1 world単位は常に1 logical pixelに写る。zoomはtileや
/// cameraをworld座標系の中でどれだけ広げるか(=画面上でどれだけ大きく
/// 見えるか)だけを変え、world座標系そのものとscreen座標系の縮尺関係は
/// 変えない。
///
/// この設計は、`extrude`をtile-local座標(zoom依存のscaleを持つ座標系)へ
/// 加算してから変換するMapLibreの実装(`u_ratio`でzoom依存のtile座標scaleを
/// 補正する。
/// docs/knowledge/20260805_maplibre_native_renderer_reference.md
/// 「Line頂点生成」「Line shader」節参照)とは異なる。EQMonitorの`extrude`
/// はtile-local座標のscaleを最初から持たない方向ベクトルであり、
/// world座標(zoom非依存のscreen pixel scale)へ直接加算するため、
/// zoom依存の補正が要らない。**shader内で`half_width_world`をzoomから
/// 再計算する実装(例: `scaleForZoom(zoom)`を掛ける)は上記の等価性を壊す
/// ので行わないこと。**
double halfLineWidthWorldFor({required double halfWidthLogicalPixels}) {
  if (!halfWidthLogicalPixels.isFinite || halfWidthLogicalPixels < 0) {
    throw ArgumentError.value(
      halfWidthLogicalPixels,
      'halfWidthLogicalPixels',
      'must be finite and non-negative',
    );
  }
  return halfWidthLogicalPixels;
}

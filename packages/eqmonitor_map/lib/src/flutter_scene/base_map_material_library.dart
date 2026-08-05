import 'dart:ui';

import 'package:flutter_scene/scene.dart' as scene;

/// `base_map_fill.fmat`/`base_map_line.fmat`を読み込み、色と線幅を設定する
/// 公開methodを持つ。
///
/// [load]は2つのmaterialを1回だけ読み、以後は同じ`PreprocessedMaterial`
/// インスタンスを返す。ベースレイヤーの描画はtileごと・layerごとに新しい
/// meshを作るが、そのすべてが`fillMaterial`/`lineMaterial`という同じ2つの
/// materialインスタンスを共有する(`tile × layer × material`単位でbatchを
/// 分けるとしても、materialの実体は`tile`や`layer`の数によらず2つのまま)。
/// tileやlayerが増えるたびに`loadFmatMaterial`を呼び直さないこと。
class BaseMapMaterialLibrary {
  const BaseMapMaterialLibrary._({
    required this.fillMaterial,
    required this.lineMaterial,
  });

  /// `assets/base_map_fill.fmat`と`assets/base_map_line.fmat`を読み込む。
  static Future<BaseMapMaterialLibrary> load() async {
    final fillMaterial = await scene.loadFmatMaterial(
      'assets/base_map_fill.fmat',
    );
    final lineMaterial = await scene.loadFmatMaterial(
      'assets/base_map_line.fmat',
    );
    return BaseMapMaterialLibrary._(
      fillMaterial: fillMaterial,
      lineMaterial: lineMaterial,
    );
  }

  /// Fillレイヤーに使うmaterial。`fill_color`のみを持つ
  /// (`assets/base_map_fill.fmat`参照)。
  final scene.PreprocessedMaterial fillMaterial;

  /// Lineレイヤーに使うmaterial。`line_color`と`half_width_world`を持つ
  /// (`assets/base_map_line.fmat`参照)。
  final scene.PreprocessedMaterial lineMaterial;

  /// Fillレイヤーの色を設定する。
  void setFillColor(Color color) {
    fillMaterial.parameters.setColor('fill_color', color);
  }

  /// Lineレイヤーの色を設定する。
  void setLineColor(Color color) {
    lineMaterial.parameters.setColor('line_color', color);
  }

  /// Lineレイヤーの半線幅を設定する。[halfWidthLogicalPixels]はlogical pixel
  /// 単位の半線幅で、[halfLineWidthWorldFor]でworld単位へ換算してから
  /// materialへ渡す。呼び出し側(cameraやstyleが変わり得るdraw loop)が毎
  /// frame呼ぶことを想定しており、shader側では換算しない
  /// (`assets/base_map_line.fmat`のdoc comment、[halfLineWidthWorldFor]の
  /// doc comment参照)。
  void setLineHalfWidth({required double halfWidthLogicalPixels}) {
    lineMaterial.parameters.setFloat(
      'half_width_world',
      halfLineWidthWorldFor(halfWidthLogicalPixels: halfWidthLogicalPixels),
    );
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

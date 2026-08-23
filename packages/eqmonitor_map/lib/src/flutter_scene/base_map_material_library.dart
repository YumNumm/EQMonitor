import 'package:flutter_scene/scene.dart' as scene;

/// `base_map_fill.fmat`/`base_map_line.fmat`から、layerごとに独立した
/// `scene.PreprocessedMaterial`を1つずつ読み込む静的factory。
///
/// # なぜlayerごとに1つなのか
///
/// 以前は`load()`がfill/line用に1つずつしかmaterialを作らず、全fill layer・
/// 全line layerがその2つのinstanceを共有していた。`docs/map_spec_v3.md`が
/// layerごとに定義する色(`baseMapLayerSpecs`の`color`)は共有materialの1色に
/// しか反映できず、結果として全fill layerが同じ色で描かれていた(実機確認で
/// 判明。team-lead指摘)。
///
/// `tile × layer × material`単位でbatchするという設計原則は、「1つのmaterial
/// instanceを複数のtileのnodeで使い回す」ことを求めているのであって、
/// 「1つのmaterial instanceを複数のlayerでも使い回す」ことまでは求めて
/// いない。layerごとに1つ持たせてもtile数やnode数には依存しないため原則に
/// 反しない。
///
/// # uniformはここで焼き込まない(#1593)
///
/// 色と半線幅の設定はこのlibraryの責務から外れ、frameごとのuniform byte列
/// (`MapMaterialParameterBlock`)を`FlutterSceneMapAdapter`が適用する形に
/// なった。値の出所を「CPUで確定してuniformへ渡す」1本に絞るためであり、
/// 以前あった`setLineHalfWidth`とviewport未確定時の暫定値は不要になった。
/// 換算式とその根拠は
/// `lib/src/renderer/base_map_material_parameters.dart`の
/// `baseMapLineHalfWidthNdc`にある。
class BaseMapMaterialLibrary {
  const new _();

  /// `assets/base_map_fill.fmat`を新しく1つ読み込む。
  static Future<scene.PreprocessedMaterial> loadFillMaterial() =>
      scene.loadFmatMaterial('assets/base_map_fill.fmat');

  /// `assets/base_map_line.fmat`を新しく1つ読み込む。
  static Future<scene.PreprocessedMaterial> loadLineMaterial() =>
      scene.loadFmatMaterial('assets/base_map_line.fmat');
}

import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/renderer/eqmonitor_orthographic_projection.dart';
import 'package:vector_math/vector_math_64.dart';

/// tile-local座標(0..`extent`)をworld pixel座標へ配置する行列。
/// `docs/knowledge/20260805_maplibre_native_renderer_reference.md`が記録する
/// `TransformState::matrixFor`と同じ2段構成で、`translate`のあと`scale`を
/// 掛ける(vector_mathの`translateByDouble`/`scaleByDouble`は右から掛かる
/// ため、この呼び出し順で「scaleしてからtranslate」した結果になる)。
///
/// `extent`はMVT layerが宣言する値をそのまま渡す。定数化しない。
///
/// この行列単体はcamera位置を知らない、world原点基準の絶対座標を返す。
/// camera中心を原点とするorigin rebasingは[viewProjectionMatrixFor]側が
/// 担い、この行列とdouble精度のまま掛け合わせてから初めてfloat32へ丸める
/// こと。tile側だけを先にfloat32へ丸めると、world原点から遠いtileほど
/// 丸め誤差が大きくなり、rebasingの意味が失われる。
Matrix4 tileMatrixFor({
  required UnwrappedTileId tileId,
  required double zoom,
  required int extent,
  MapMercatorProjection projection = const MapMercatorProjection(),
}) {
  if (extent <= 0) {
    throw ArgumentError.value(extent, 'extent', 'must be positive');
  }
  final canonicalZ = tileId.canonical.z;
  final tileScale = 1 << canonicalZ;
  final worldSize = projection.worldSizeForZoom(zoom);
  final s = worldSize / tileScale;

  final translateX = (tileId.canonical.x + tileId.wrap * tileScale) * s;
  final translateY = tileId.canonical.y * s;

  return Matrix4.identity()
    ..translateByDouble(translateX, translateY, 0, 1)
    ..scaleByDouble(s / extent, s / extent, 1, 1);
}

/// viewportとcamera中心からworld→clipの行列を作る。orthographic
/// (bearing/pitch非対応)で、camera中心を原点とするorigin rebasingを行う。
///
/// 実装は`View * Projection`の標準的な合成で、`Ortho`は
/// [EqmonitorOrthographicProjection]をそのまま再利用する(spikeの正射影と
/// 重複させない)。worldHalfHeightはviewportのlogical pixel高さの半分
/// ── zoomのpixel基準を512に揃えているため、world pixelとlogical pixelは
/// 1:1で対応する。
///
/// [EqmonitorOrthographicProjection]はspikeの三角形(Y+が北/上)を前提に
/// 作られているのに対し、Mercatorのworld座標はY+が南(画像のように上が
/// 原点)。両者のY軸の向きが逆なため、camera中心へのtranslateの後、
/// Ortho適用の前にYを反転して北を上へ揃える。呼び出し順は
/// `translateByDouble`→`scaleByDouble`だが、vector_mathの`Matrix4`は
/// 呼び出し順に右から掛かるため、実際にvertexへ適用される順序は
/// 「translate(camera中心を引く)→Y反転→ortho」になる。
///
/// 戻り値の行列自体はcamera中心を原点へ寄せる`translate`を含むが、まだ
/// float32へは丸めていない。[tileMatrixFor]の結果とdouble精度のまま
/// 掛け合わせてから丸めることで、world原点から遠いcamera位置・tileでも
/// 画面近傍の相対座標として桁落ちなく解決できる。
Matrix4 viewProjectionMatrixFor({
  required MapCamera camera,
  required MapViewport viewport,
  MapMercatorProjection projection = const MapMercatorProjection(),
  double depthHalfExtent = 1,
}) {
  final center = camera.worldCenter(projection: projection);
  final ortho = EqmonitorOrthographicProjection(
    worldHalfHeight: viewport.logicalSize.height / 2,
    depthHalfExtent: depthHalfExtent,
  );
  return ortho.matrixFor(aspectRatio: viewport.aspectRatio)
    ..scaleByDouble(1, -1, 1, 1)
    ..translateByDouble(-center.x, -center.y, 0, 1);
}

/// ベースマップtile-local座標をclip座標へ変換する合成行列を作る。
///
/// MVT layerごとに宣言される[extent]を必須入力にして、tile-local頂点を
/// そのsource layerの座標系でworldへ配置する。
Matrix4 baseMapTileViewProjectionMatrixFor({
  required MapCamera camera,
  required MapViewport viewport,
  required UnwrappedTileId tileId,
  required double zoom,
  required int extent,
}) => viewProjectionMatrixFor(camera: camera, viewport: viewport).multiplied(
  tileMatrixFor(tileId: tileId, zoom: zoom, extent: extent),
);

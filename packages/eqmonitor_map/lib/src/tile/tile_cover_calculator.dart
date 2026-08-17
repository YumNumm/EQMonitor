import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';

/// camera/viewportから「1frameで要求するtile座標集合」を求める。
/// `docs/knowledge/20260805_maplibre_native_renderer_reference.md`の
/// 「tile cover」節が記録するMapLibre Nativeの現行実装は、world copyごとの
/// root AABBを四分木で分割し`Frustum`との交差判定で枝刈りする3D LOD実装
/// (`tileCover(TileCoverParameters, ...)`)だが、bearing/pitchを持たない
/// EQMonitorには過剰であり、同ファイルに併存する旧実装
/// (`scanTriangle`/`scanSpans`。画面4隅の投影点で覆う範囲を求め、中心からの
/// 距離でsortするscanline方式)相当の粒度で足りる。frustum cullingは
/// ここでは実装しない。
final class TileCoverCalculator {
  const new _();

  /// `camera`と`viewport`が画面に映す範囲を覆う[OverscaledTileId]の一覧を
  /// camera中心に近い順で返す。
  ///
  /// source zoomは`camera.zoom`(連続値)の`floor()`を基準にする。vector
  /// tileは1枚のtileを拡大して表示できるため、floorしたzoomよりも1段階
  /// 細かい、まだ存在しないtileを要求してしまうround/ceilは避ける。
  /// `minZoom`未満ならfloor後の値を`minZoom`まで引き上げる
  /// (`overscaleFactor`は1のまま、overscale扱いにはしない)。`maxZoom`を
  /// 超える場合は`overscaledZ`だけを上げたまま`canonical.z`を`maxZoom`に
  /// 留め、tileをoverscale表示させる。
  static List<OverscaledTileId> cover({
    required MapCamera camera,
    required MapViewport viewport,
    required int minZoom,
    required int maxZoom,
    MapMercatorProjection projection = const MapMercatorProjection(),
  }) {
    if (minZoom < 0) {
      throw ArgumentError.value(minZoom, 'minZoom', 'must be non-negative');
    }
    if (maxZoom < minZoom) {
      throw ArgumentError.value(maxZoom, 'maxZoom', 'must be >= minZoom');
    }

    final centerNormalized = projection.lngLatToNormalized(
      longitude: camera.centerLongitude,
      latitude: camera.centerLatitude,
    );
    // worldSizeForZoomがcamera.zoomのfinite検証を行うため、floor()は
    // この呼び出しの後で行う。NaNに対する`double.floor()`は例外を投げる
    // ため、検証済みの値に対してだけ呼ぶ。
    final worldSize = projection.worldSizeForZoom(camera.zoom);

    final integerZoom = camera.zoom.floor();
    final overscaledZ = integerZoom < minZoom ? minZoom : integerZoom;
    final canonicalZ = overscaledZ > maxZoom ? maxZoom : overscaledZ;
    final tileGridSize = 1 << canonicalZ;

    final halfWidthNormalized = (viewport.logicalSize.width / 2) / worldSize;
    final halfHeightNormalized = (viewport.logicalSize.height / 2) / worldSize;

    // 画面4隅(bearing/pitch非対応のため常に軸並行な矩形になる)を
    // normalized world座標へ投影する。wrapはまだ畳み込まず、date line
    // 跨ぎもそのまま連続値として保持する。
    final cornerXs = [
      centerNormalized.x - halfWidthNormalized,
      centerNormalized.x + halfWidthNormalized,
    ];
    final cornerYs = [
      centerNormalized.y - halfHeightNormalized,
      centerNormalized.y + halfHeightNormalized,
    ];
    final minX = cornerXs.reduce((a, b) => a < b ? a : b);
    final maxX = cornerXs.reduce((a, b) => a > b ? a : b);
    final minY = cornerYs.reduce((a, b) => a < b ? a : b);
    final maxY = cornerYs.reduce((a, b) => a > b ? a : b);

    // tile `i`はnormalized座標の半開区間`[i/n, (i+1)/n)`を占める。境界
    // ちょうど(`maxX*n`などが整数)をexclusiveに倒すと継ぎ目のtileを
    // 取りこぼす恐れがあるため、floorしたindexをそのまま含める
    // (1枚余分に含むことはあっても欠落はしない)。
    final rawXStart = (minX * tileGridSize).floor();
    final rawXEnd = (maxX * tileGridSize).floor();
    // 緯度方向はworldをwrapしないため、tile行の範囲へclampする。
    final rawYStart = _clampToTileRange(
      (minY * tileGridSize).floor(),
      tileGridSize,
    );
    final rawYEnd = _clampToTileRange(
      (maxY * tileGridSize).floor(),
      tileGridSize,
    );

    final tiles = <OverscaledTileId>[];
    for (var rawX = rawXStart; rawX <= rawXEnd; rawX++) {
      // Dartの`%`は除数が正の時に必ず非負を返す(Euclidean modulo)ため、
      // rawXが負でもcanonicalXは`[0, tileGridSize)`へ畳み込まれ、wrapは
      // その差分から求まる整数商になる。この`wrap*tileGridSize+x`の関係は
      // `tile_matrix.dart`の`tileMatrixFor`が使う`translateX`と同じもの。
      final canonicalX = rawX % tileGridSize;
      final wrap = (rawX - canonicalX) ~/ tileGridSize;
      for (var y = rawYStart; y <= rawYEnd; y++) {
        tiles.add(
          OverscaledTileId(
            overscaledZ: overscaledZ,
            wrap: wrap,
            canonical: CanonicalTileId(z: canonicalZ, x: canonicalX, y: y),
          ),
        );
      }
    }

    final cameraGridX = centerNormalized.x * tileGridSize;
    final cameraGridY = centerNormalized.y * tileGridSize;
    return _sortedByDistance(
      tiles,
      cameraGridX: cameraGridX,
      cameraGridY: cameraGridY,
      tileGridSize: tileGridSize,
    );
  }

  static int _clampToTileRange(int value, int tileGridSize) {
    if (value < 0) {
      return 0;
    }
    final maxIndex = tileGridSize - 1;
    if (value > maxIndex) {
      return maxIndex;
    }
    return value;
  }

  /// camera中心からの距離昇順、同距離は`wrap`→`canonical.x`→`canonical.y`の
  /// 昇順で安定させる。距離は2乗のまま比較する(sqrtを取っても単調増加で
  /// 順序は変わらないため)。tile中心の座標は`tile_matrix.dart`の
  /// `translateX`と同じ`wrap*tileGridSize+x`でunwrapし、world copyを
  /// またいでも連続な尺度で比較できるようにする。
  static List<OverscaledTileId> _sortedByDistance(
    List<OverscaledTileId> tiles, {
    required double cameraGridX,
    required double cameraGridY,
    required int tileGridSize,
  }) {
    final withDistance = [
      for (final tile in tiles)
        (
          tile: tile,
          distanceSquared: _distanceSquared(
            tile,
            cameraGridX: cameraGridX,
            cameraGridY: cameraGridY,
            tileGridSize: tileGridSize,
          ),
        ),
    ];
    withDistance.sort((a, b) {
      final distanceComparison = a.distanceSquared.compareTo(
        b.distanceSquared,
      );
      if (distanceComparison != 0) {
        return distanceComparison;
      }
      if (a.tile.wrap != b.tile.wrap) {
        return a.tile.wrap.compareTo(b.tile.wrap);
      }
      if (a.tile.canonical.x != b.tile.canonical.x) {
        return a.tile.canonical.x.compareTo(b.tile.canonical.x);
      }
      return a.tile.canonical.y.compareTo(b.tile.canonical.y);
    });
    return List.unmodifiable([
      for (final entry in withDistance) entry.tile,
    ]);
  }

  static double _distanceSquared(
    OverscaledTileId tile, {
    required double cameraGridX,
    required double cameraGridY,
    required int tileGridSize,
  }) {
    final tileCenterX = tile.wrap * tileGridSize + tile.canonical.x + 0.5;
    final tileCenterY = tile.canonical.y + 0.5;
    final dx = tileCenterX - cameraGridX;
    final dy = tileCenterY - cameraGridY;
    return dx * dx + dy * dy;
  }
}

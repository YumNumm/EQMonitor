import 'dart:ui';

import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/tile_cover_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

// このファイルのすべての期待値は、実装と同じループを書き写すのではなく、
// Web Mercatorの定義式(`x=(lng+180)/360`、`y=0.5-ln(tan(pi/4+lat/2))/(2pi)`)
// と`floor`/Euclidean moduloだけを使って手計算(Python script)で独立に導出
// した。各testのdoc commentに、その計算過程を残す。

void main() {
  group('TileCoverCalculator.cover', () {
    test('zoom整数のとき中心1枚のtileだけを返す', () {
      // 東京(139.767, 35.681)、zoom 4(整数)。
      // normalized center: x=(139.767+180)/360=0.8882416666...
      //   latRad=35.681度=0.622759...rad
      //   y=0.5-ln(tan(pi/4+latRad/2))/(2pi)=0.3937788146...
      // worldSize=2^4*512=8192。viewport 128x128 -> half=64px
      //   -> halfNormalized=64/8192=0.0078125
      // corner x範囲=[0.8804291666..., 0.8960541666...]
      // corner y範囲=[0.3859663146..., 0.4015913146...]
      // tileGridSize=2^4=16。x*16の範囲=[14.087..,14.336..] -> floorは
      //   両端とも14。y*16の範囲=[6.175..,6.425..] -> floorは両端とも6。
      // -> tile(z=4, x=14, y=6)の1枚だけ。
      const camera = MapCamera(
        centerLongitude: 139.767,
        centerLatitude: 35.681,
        zoom: 4,
      );
      final viewport = MapViewport(
        logicalSize: const Size(128, 128),
        devicePixelRatio: 1,
      );

      final tiles = TileCoverCalculator.cover(
        camera: camera,
        viewport: viewport,
        minZoom: 0,
        maxZoom: 10,
      );

      expect(tiles, hasLength(1));
      expect(
        tiles.single,
        _overscaledTileId(z: 4, overscaledZ: 4, wrap: 0, x: 14, y: 6),
      );
    });

    test('非整数zoomはfloorしたzoomのtileを返す(roundやceilではない)', () {
      // 前testと同じcamera位置・viewportで、zoomだけ4.9にする。
      // worldSizeは2^4.9*512に増えるためnormalized半径は前testより狭くなり
      // (0.8840550.., 0.8924282..) x (0.3895921.., 0.3979654..)、前testの
      // 範囲の部分集合になる。floor(4.9)=4なのでtileGridSize=16のままで、
      // x*16=[14.144..,14.278..]->floor 14、y*16=[6.233..,6.367..]->floor 6。
      // roundなら5、ceilなら5になり別のtileを指すため、floor採用の検証になる。
      const camera = MapCamera(
        centerLongitude: 139.767,
        centerLatitude: 35.681,
        zoom: 4.9,
      );
      final viewport = MapViewport(
        logicalSize: const Size(128, 128),
        devicePixelRatio: 1,
      );

      final tiles = TileCoverCalculator.cover(
        camera: camera,
        viewport: viewport,
        minZoom: 0,
        maxZoom: 10,
      );

      expect(tiles, hasLength(1));
      expect(
        tiles.single,
        _overscaledTileId(z: 4, overscaledZ: 4, wrap: 0, x: 14, y: 6),
      );
    });

    test('maxZoomを超えるとoverscaledZだけ上げcanonical.zはmaxZoomに留まる', () {
      // 同じcamera位置・viewportでzoom=8、maxZoom=5。
      // floor(8)=8 >= minZoom(0)なのでoverscaledZ=8。overscaledZ(8) >
      // maxZoom(5)なのでcanonicalZ=5、tileGridSize=32。
      // worldSize=2^8*512=131072、half=64/131072=0.00048828125。
      // corner x範囲=[0.88775338..,0.88872994..]、y範囲=
      // [0.39329053..,0.39426709..]。
      // x*32=[28.408..,28.439..]->floor 28、y*32=[12.585..,12.616..]->floor
      // 12。
      const camera = MapCamera(
        centerLongitude: 139.767,
        centerLatitude: 35.681,
        zoom: 8,
      );
      final viewport = MapViewport(
        logicalSize: const Size(128, 128),
        devicePixelRatio: 1,
      );

      final tiles = TileCoverCalculator.cover(
        camera: camera,
        viewport: viewport,
        minZoom: 0,
        maxZoom: 5,
      );

      expect(tiles, hasLength(1));
      final tile = tiles.single;
      expect(
        tile,
        _overscaledTileId(z: 5, overscaledZ: 8, wrap: 0, x: 28, y: 12),
      );
      expect(tile.overscaleFactor, 8);
    });

    test('camera.zoomがminZoom未満なら overscaledZ/canonical.z は minZoomへ '
        'clampされる(overscaleFactorは1のまま)', () {
      // 東京(139.767, 35.681)、camera.zoom=1、minZoom=3、maxZoom=10。
      // normalized center: x=0.8882416666..., y=0.3937788146...(前testと同じ)。
      // floor(1)=1 < minZoom(3)なので、overscaledZはminZoomの3へ引き上がる。
      // 3 <= maxZoom(10)なのでcanonicalZも3のまま(overscaleFactor=1、
      // overscale状態にはならない)。tileGridSize=8。
      // worldSize=2^1*512=1024。viewport 128x128 -> half=64px
      //   -> halfNormalized=64/1024=0.0625
      // corner x範囲=[0.8257416..,0.9507416..] -> x*8=[6.6059..,7.6059..]
      //   -> floor(x*8)は6,7の2列。
      // corner y範囲=[0.3312788..,0.4562788..] -> y*8=[2.6502..,3.6502..]
      //   -> floor(y*8)は2,3の2行。
      // -> (z=3, x∈{6,7}, y∈{2,3})の4枚、いずれもoverscaledZ=3。
      const camera = MapCamera(
        centerLongitude: 139.767,
        centerLatitude: 35.681,
        zoom: 1,
      );
      final viewport = MapViewport(
        logicalSize: const Size(128, 128),
        devicePixelRatio: 1,
      );

      final tiles = TileCoverCalculator.cover(
        camera: camera,
        viewport: viewport,
        minZoom: 3,
        maxZoom: 10,
      );

      expect(
        tiles.toSet(),
        {
          for (final x in [6, 7])
            for (final y in [2, 3])
              _overscaledTileId(z: 3, overscaledZ: 3, wrap: 0, x: x, y: y),
        },
      );
      // clampされた結果、overscaleは発生していないことを明示的に確認する。
      for (final tile in tiles) {
        expect(tile.overscaleFactor, 1);
      }
    });

    test('viewportのaspect比が違うと覆うtile矩形の向きも変わる', () {
      // camera: (lng=10, lat=5)、zoom=2(整数)。
      // normalized center: x=(10+180)/360=0.52777777..、
      //   latRad=5度=0.087266..rad、y=0.4860934491...
      // worldSize=2^2*512=2048。tileGridSize=4。
      //
      // 横長viewport 1400x300: half=(700,150)px
      //   -> halfNormalized=(0.341796875, 0.0732421875)
      //   x範囲=[0.185980..,0.869574..] -> x*4の範囲=[0.7439..,3.4782..]
      //     -> floor(x*4)は0..3の4列。
      //   y範囲=[0.412851..,0.559335..] -> y*4の範囲=[1.6514..,2.2373..]
      //     -> floor(y*4)は1..2の2行。
      //   -> x∈{0,1,2,3}, y∈{1,2}の8枚。
      const camera = MapCamera(
        centerLongitude: 10,
        centerLatitude: 5,
        zoom: 2,
      );
      final wideViewport = MapViewport(
        logicalSize: const Size(1400, 300),
        devicePixelRatio: 1,
      );

      final wideTiles = TileCoverCalculator.cover(
        camera: camera,
        viewport: wideViewport,
        minZoom: 0,
        maxZoom: 10,
      );

      expect(
        wideTiles.toSet(),
        {
          for (final x in [0, 1, 2, 3])
            for (final y in [1, 2])
              _overscaledTileId(z: 2, overscaledZ: 2, wrap: 0, x: x, y: y),
        },
      );

      // 縦長viewport 300x1400: half=(150,700)px
      //   -> halfNormalized=(0.0732421875, 0.341796875)
      //   x範囲=[0.454535..,0.601019..] -> x*4の範囲=[1.8181..,2.4040..]
      //     -> floor(x*4)は1..2の2列。
      //   y範囲=[0.144296..,0.827890..] -> y*4の範囲=[0.5771..,3.3115..]
      //     -> floor(y*4)は0..3の4行。
      //   -> x∈{1,2}, y∈{0,1,2,3}の8枚。
      final tallViewport = MapViewport(
        logicalSize: const Size(300, 1400),
        devicePixelRatio: 1,
      );

      final tallTiles = TileCoverCalculator.cover(
        camera: camera,
        viewport: tallViewport,
        minZoom: 0,
        maxZoom: 10,
      );

      expect(
        tallTiles.toSet(),
        {
          for (final x in [1, 2])
            for (final y in [0, 1, 2, 3])
              _overscaledTileId(z: 2, overscaledZ: 2, wrap: 0, x: x, y: y),
        },
      );
    });

    test('date lineを跨ぐ範囲は正しいwrapのtileを返す(wrap 0固定にしない)', () {
      // camera: (lng=179, lat=0)、zoom=2(整数)。
      // normalized center: x=(179+180)/360=0.99722222.., y=0.5(緯度0)。
      // worldSize=2048。tileGridSize=4。viewport 1024x200:
      //   half=(512,100)px -> halfNormalized=(0.25, 0.048828125)
      //   x範囲=[0.747222..,1.247222..] -> x*4の範囲=[2.9888..,4.9888..]
      //     -> floor(x*4): 2,3,4。rawX=4はtileGridSize(4)以上なので
      //     wrap=1, canonicalX=0へ畳み込まれる。
      //   y範囲=[0.451171..,0.548828..] -> y*4の範囲=[1.8046..,2.1953..]
      //     -> floor(y*4)は1..2の2行。
      //   -> (wrap=0,x=2..3,y=1..2)の4枚 + (wrap=1,x=0,y=1..2)の2枚。
      const camera = MapCamera(
        centerLongitude: 179,
        centerLatitude: 0,
        zoom: 2,
      );
      final viewport = MapViewport(
        logicalSize: const Size(1024, 200),
        devicePixelRatio: 1,
      );

      final tiles = TileCoverCalculator.cover(
        camera: camera,
        viewport: viewport,
        minZoom: 0,
        maxZoom: 10,
      );

      expect(
        tiles.toSet(),
        {
          for (final x in [2, 3])
            for (final y in [1, 2])
              _overscaledTileId(z: 2, overscaledZ: 2, wrap: 0, x: x, y: y),
          for (final y in [1, 2])
            _overscaledTileId(z: 2, overscaledZ: 2, wrap: 1, x: 0, y: y),
        },
      );
      // wrapを0で決め打ちしていないことを明示的に確認する。
      expect(tiles.any((tile) => tile.wrap == 1), isTrue);
    });

    test('date lineを西向きに跨ぐ場合はwrapが負になる(東向きtestと対称)', () {
      // 前testを東西反転したもの。camera: (lng=-179, lat=0)、zoom=2(整数)。
      // normalized center: x=(-179+180)/360=0.00277777.., y=0.5(緯度0)。
      // worldSize=2048。tileGridSize=4。viewport 1024x200:
      //   half=(512,100)px -> halfNormalized=(0.25, 0.048828125)
      //   x範囲=[-0.247222..,0.252777..] -> x*4の範囲=[-0.9888..,1.0111..]
      //     -> floor(x*4): -1,0,1。rawX=-1は負なので、Dartの`%`
      //     (Euclidean modulo)により canonicalX = -1 % 4 = 3、
      //     wrap = (-1 - 3) / 4 = -1へ畳み込まれる。
      //   y範囲=[0.451171..,0.548828..] -> y*4の範囲=[1.8046..,2.1953..]
      //     -> floor(y*4)は1..2の2行。
      //   -> (wrap=-1,x=3,y=1..2)の2枚 + (wrap=0,x∈{0,1},y=1..2)の4枚。
      const camera = MapCamera(
        centerLongitude: -179,
        centerLatitude: 0,
        zoom: 2,
      );
      final viewport = MapViewport(
        logicalSize: const Size(1024, 200),
        devicePixelRatio: 1,
      );

      final tiles = TileCoverCalculator.cover(
        camera: camera,
        viewport: viewport,
        minZoom: 0,
        maxZoom: 10,
      );

      expect(
        tiles.toSet(),
        {
          for (final y in [1, 2])
            _overscaledTileId(z: 2, overscaledZ: 2, wrap: -1, x: 3, y: y),
          for (final x in [0, 1])
            for (final y in [1, 2])
              _overscaledTileId(z: 2, overscaledZ: 2, wrap: 0, x: x, y: y),
        },
      );
      // wrapが負にもなり得ることを明示的に確認する
      // (`%`を`.remainder()`へ書き換える回帰を検知する)。
      expect(tiles.any((tile) => tile.wrap == -1), isTrue);
    });

    test('camera中心から距離の異なる複数tileを距離昇順で返す(タイブレークなし)', () {
      // camera: (lng=-40.5, lat=-17.71101441658224)、zoom=3(整数)。
      // このlat/lngは、normalized座標がちょうど(cx,cy)=(0.3875,0.55)になる
      // よう、Mercatorのy式を逆算(latRad=2*atan(exp(pi*(1-2y)))-pi/2)して
      // 求めたもの。
      // worldSize=2^3*512=4096。viewport 1024x1024(正方形) -> half=512px
      //   -> halfNormalized=512/4096=0.125
      // corner x範囲=[0.2625,0.5125]、corner y範囲=[0.425,0.675]。
      // tileGridSize=2^3=8。x*8=[2.1,4.1]->floor(x*8)は2,3,4。
      // y*8=[3.4,5.4]->floor(y*8)は3,4,5。-> 3x3=9枚。
      // cameraGrid=(cx*8,cy*8)=(3.1,4.4)。各tile中心(x+0.5,y+0.5)との
      // 距離の2乗を計算すると、9枚とも異なる値になる(tie無し)。近い順:
      //   (3,4):0.17 < (2,4):0.37 < (3,3):0.97 < (2,3):1.17 < (3,5):1.37
      //   < (2,5):1.57 < (4,4):1.97 < (4,3):2.77 < (4,5):3.17
      // (計算はPython scriptで独立に検証済み。実装のloop/sortを test側へ
      // 書き写したものではない)。
      const camera = MapCamera(
        centerLongitude: -40.5,
        centerLatitude: -17.71101441658224,
        zoom: 3,
      );
      final viewport = MapViewport(
        logicalSize: const Size(1024, 1024),
        devicePixelRatio: 1,
      );

      final tiles = TileCoverCalculator.cover(
        camera: camera,
        viewport: viewport,
        minZoom: 0,
        maxZoom: 10,
      );

      expect(tiles, [
        _overscaledTileId(z: 3, overscaledZ: 3, wrap: 0, x: 3, y: 4),
        _overscaledTileId(z: 3, overscaledZ: 3, wrap: 0, x: 2, y: 4),
        _overscaledTileId(z: 3, overscaledZ: 3, wrap: 0, x: 3, y: 3),
        _overscaledTileId(z: 3, overscaledZ: 3, wrap: 0, x: 2, y: 3),
        _overscaledTileId(z: 3, overscaledZ: 3, wrap: 0, x: 3, y: 5),
        _overscaledTileId(z: 3, overscaledZ: 3, wrap: 0, x: 2, y: 5),
        _overscaledTileId(z: 3, overscaledZ: 3, wrap: 0, x: 4, y: 4),
        _overscaledTileId(z: 3, overscaledZ: 3, wrap: 0, x: 4, y: 3),
        _overscaledTileId(z: 3, overscaledZ: 3, wrap: 0, x: 4, y: 5),
      ]);
    });

    test('camera中心からの距離昇順にsortし、同距離はwrap/x/yの昇順で安定させる', () {
      // camera: (lng=0, lat=0)、zoom=1(整数)。normalized center=(0.5,0.5)は
      // ちょうどtileGridSize=2の格子の中心(grid座標(1,1))に一致するため、
      // 隣接4tile(z=1)の中心は(0.5,0.5)/(1.5,0.5)/(0.5,1.5)/(1.5,1.5)で
      // camera中心からの距離はどれも sqrt(0.5^2+0.5^2) で完全に等しい。
      // viewportは1023x1023(ちょうど1024にすると境界がtileGridSize*1024を
      // 割り切り、余分な5枚目の列/行が出てしまうため、わずかに小さくする):
      //   half=511.5px -> halfNormalized=511.5/1024=0.4995117..
      //   x範囲もy範囲も[0.000488..,0.999512..] -> *2すると
      //   [0.000976..,1.999023..] -> floorは0と1の2列/2行 -> 4枚。
      // 距離が全tileで同じため、sort結果は純粋にwrap(すべて0)→x→yの昇順:
      //   (x=0,y=0) -> (x=0,y=1) -> (x=1,y=0) -> (x=1,y=1)。
      const camera = MapCamera(centerLongitude: 0, centerLatitude: 0, zoom: 1);
      final viewport = MapViewport(
        logicalSize: const Size(1023, 1023),
        devicePixelRatio: 1,
      );

      final tiles = TileCoverCalculator.cover(
        camera: camera,
        viewport: viewport,
        minZoom: 0,
        maxZoom: 10,
      );

      expect(tiles, [
        _overscaledTileId(z: 1, overscaledZ: 1, wrap: 0, x: 0, y: 0),
        _overscaledTileId(z: 1, overscaledZ: 1, wrap: 0, x: 0, y: 1),
        _overscaledTileId(z: 1, overscaledZ: 1, wrap: 0, x: 1, y: 0),
        _overscaledTileId(z: 1, overscaledZ: 1, wrap: 0, x: 1, y: 1),
      ]);
    });

    test('rejects a negative minZoom', () {
      const camera = MapCamera(
        centerLongitude: 0,
        centerLatitude: 0,
        zoom: 2,
      );
      final viewport = MapViewport(
        logicalSize: const Size(100, 100),
        devicePixelRatio: 1,
      );

      expect(
        () => TileCoverCalculator.cover(
          camera: camera,
          viewport: viewport,
          minZoom: -1,
          maxZoom: 10,
        ),
        throwsArgumentError,
      );
    });

    test('rejects a maxZoom smaller than minZoom', () {
      const camera = MapCamera(
        centerLongitude: 0,
        centerLatitude: 0,
        zoom: 2,
      );
      final viewport = MapViewport(
        logicalSize: const Size(100, 100),
        devicePixelRatio: 1,
      );

      expect(
        () => TileCoverCalculator.cover(
          camera: camera,
          viewport: viewport,
          minZoom: 5,
          maxZoom: 4,
        ),
        throwsArgumentError,
      );
    });
  });
}

OverscaledTileId _overscaledTileId({
  required int z,
  required int overscaledZ,
  required int wrap,
  required int x,
  required int y,
}) => OverscaledTileId(
  overscaledZ: overscaledZ,
  wrap: wrap,
  canonical: CanonicalTileId(z: z, x: x, y: y),
);

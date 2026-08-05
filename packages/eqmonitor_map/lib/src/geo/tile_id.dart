import 'package:flutter/foundation.dart';

/// `include/mbgl/tile/tile_id.hpp`が定義する3種のtile IDのうち、データとして
/// 一意な`z/x/y`。tile coverが1frameに数百～数千個生成し、cache keyとして
/// equality/hashCodeを引くhot pathの値型であるため、Freezedのcopyable生成
/// コードは持たせず、手書きの`==`/`hashCode`を持つ素のimmutable classにする。
@immutable
class CanonicalTileId {
  const CanonicalTileId({required this.z, required this.x, required this.y})
    : assert(z >= 0, 'z must be non-negative'),
      assert(x >= 0, 'x must be non-negative'),
      assert(y >= 0, 'y must be non-negative');

  final int z;
  final int x;
  final int y;

  /// `targetZ`における相当のtile座標へ変換する。`targetZ < z`なら祖先
  /// (`x >> (z - targetZ)`)、`targetZ > z`なら子孫相当の単一tile
  /// (`x << (targetZ - z)`)を返す。`targetZ == z`ならそのまま。
  CanonicalTileId scaledTo(int targetZ) {
    if (targetZ == z) {
      return this;
    }
    if (targetZ < z) {
      final shift = z - targetZ;
      return CanonicalTileId(z: targetZ, x: x >> shift, y: y >> shift);
    }
    final shift = targetZ - z;
    return CanonicalTileId(z: targetZ, x: x << shift, y: y << shift);
  }

  /// `z+1`における4枚の子tileを`(x*2,y*2)`を起点に列挙する。
  List<CanonicalTileId> children() {
    final childZ = z + 1;
    final childX = x * 2;
    final childY = y * 2;
    return [
      CanonicalTileId(z: childZ, x: childX, y: childY),
      CanonicalTileId(z: childZ, x: childX + 1, y: childY),
      CanonicalTileId(z: childZ, x: childX, y: childY + 1),
      CanonicalTileId(z: childZ, x: childX + 1, y: childY + 1),
    ];
  }

  @override
  bool operator ==(Object other) =>
      other is CanonicalTileId && other.z == z && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(z, x, y);

  @override
  String toString() => 'CanonicalTileId(z: $z, x: $x, y: $y)';
}

/// 「実際に取得・parseするzoom(`overscaledZ`)」と「データとして持つzoom
/// (`canonical.z`)」を分離するID。source max zoom超過時、`canonical`側は
/// max zoomのまま`overscaledZ`だけ上げ、tile内をoverscale factor倍に
/// 拡大表示する。
@immutable
class OverscaledTileId {
  // canonical.zとの関係を検証するassertがcanonicalという他の引数の
  // フィールドを読むため、const constructorのconstant evaluationでは
  // 扱えない(単純な自パラメータ同士の比較を超える)。CanonicalTileIdとは
  // 違いconstにはしない。
  OverscaledTileId({
    required this.overscaledZ,
    required this.wrap,
    required this.canonical,
  }) : assert(overscaledZ >= 0, 'overscaledZ must be non-negative'),
       assert(
         overscaledZ >= canonical.z,
         'overscaledZ must be at least canonical.z',
       );

  final int overscaledZ;
  final int wrap;
  final CanonicalTileId canonical;

  /// overscaledZがcanonical.zに対して何倍拡大表示されているか。
  /// `overscaledZ == canonical.z`なら1(overscaleなし)。
  int get overscaleFactor => 1 << (overscaledZ - canonical.z);

  /// world copy(`wrap`)を保ったまま描画位置IDへ変換する。
  UnwrappedTileId toUnwrapped() =>
      UnwrappedTileId(wrap: wrap, canonical: canonical);

  @override
  bool operator ==(Object other) =>
      other is OverscaledTileId &&
      other.overscaledZ == overscaledZ &&
      other.wrap == wrap &&
      other.canonical == canonical;

  @override
  int get hashCode => Object.hash(overscaledZ, wrap, canonical);

  @override
  String toString() =>
      'OverscaledTileId(overscaledZ: $overscaledZ, wrap: $wrap, '
      'canonical: $canonical)';
}

/// world copy(`wrap`)を含む描画位置のID。tile行列(`matrixFor`相当)への
/// 入力はこのIDになる。
@immutable
class UnwrappedTileId {
  const UnwrappedTileId({required this.wrap, required this.canonical});

  final int wrap;
  final CanonicalTileId canonical;

  @override
  bool operator ==(Object other) =>
      other is UnwrappedTileId &&
      other.wrap == wrap &&
      other.canonical == canonical;

  @override
  int get hashCode => Object.hash(wrap, canonical);

  @override
  String toString() => 'UnwrappedTileId(wrap: $wrap, canonical: $canonical)';
}

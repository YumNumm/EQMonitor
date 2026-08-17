import 'package:flutter/foundation.dart';

/// tile レイヤーの種別。fallback の許容度が根本的に異なる。
enum MapTileLayerKind {
  /// 背景地図。欠損時に同一 revision 内の親/子 tile で暫定描画してよい。
  basemap,

  /// 危険度・警報など生命に関わるレイヤー。欠損時に古い/別解像度の tile で
  /// ごまかさず fail closed する。
  hazard,
}

/// `BaseMapTileCache.lookupWithFallback` が欠損 tile をどこまで代替してよいかを
/// 決める policy。
///
/// - [basemap]: 同一 revision 内の親/子 fallback を許可する(`allowsSpatial
///   Fallback == true`)。
/// - [hazard]: いかなる spatial fallback も許可せず、exact hit 以外は miss と
///   して fail closed する(`allowsSpatialFallback == false`)。
///
/// revision 跨ぎの last-good は**どちらのレイヤーでも禁止**
/// ([allowsCrossRevisionLastGood]は常に`false`)。これは `BaseMapTileCache` の
/// cache key が `VerifiedTileSourceCacheIdentity.cacheIdentity`
/// (`sourceInstanceId` + 内容 digest)を含むことで担保される。中身が変われば
/// digest が変わるので、別 revision の entry は exact lookup でも一致しない。
@immutable
final class MapTileFallbackPolicy {
  const new _({
    required this.layerKind,
    required this.allowsSpatialFallback,
    required this.allowsCrossRevisionLastGood,
  });

  factory forLayer(MapTileLayerKind kind) =>
      switch (kind) {
        MapTileLayerKind.basemap => basemap,
        MapTileLayerKind.hazard => hazard,
      };

  static const basemap = MapTileFallbackPolicy._(
    layerKind: MapTileLayerKind.basemap,
    allowsSpatialFallback: true,
    allowsCrossRevisionLastGood: false,
  );

  static const hazard = MapTileFallbackPolicy._(
    layerKind: MapTileLayerKind.hazard,
    allowsSpatialFallback: false,
    allowsCrossRevisionLastGood: false,
  );

  final MapTileLayerKind layerKind;

  /// 欠損 tile を同一 revision 内の親/子 tile で代替してよいか。
  final bool allowsSpatialFallback;

  /// 別 revision の last-good tile を表示してよいか(常に`false`)。
  final bool allowsCrossRevisionLastGood;

  @override
  bool operator ==(Object other) =>
      other is MapTileFallbackPolicy && other.layerKind == layerKind;

  @override
  int get hashCode => layerKind.hashCode;
}

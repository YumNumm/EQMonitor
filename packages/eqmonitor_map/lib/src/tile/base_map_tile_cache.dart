import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_async_generation.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:flutter/foundation.dart';

/// decode済み[BaseMapTileGeometry]のcache。
///
/// # cache key
///
/// keyは`(sourceInstanceId, CanonicalTileId)`の組。`CanonicalTileId.z`は
/// tileが属するpyramid上の整数zoomであり、camera側の連続値`zoom`
/// (`MapCamera.zoom`)はkeyに一切含めない。camera zoomが小数だけ動いても
/// 要求する[CanonicalTileId]が変わらない限り(`TileCoverCalculator.cover`が
/// `camera.zoom.floor()`基準でtileを選ぶ、`tile_cover_calculator.dart`
/// 参照)同じkeyを引き続けるため、無効化は起きない
/// (Global Constraints「meshは整数zoom単位で構築し、非整数zoomはtile行列の
/// scaleで吸収する」)。
///
/// # eviction
///
/// [noteActiveZoom]で通知された「直近使用zoom」(`CanonicalTileId.z`と同じ
/// 整数)を基準に、`|entry.z - activeZoom| > 1`のentryを都度破棄する
/// (`docs/knowledge/20260802_kevi_map_renderer_reference.md`
/// 「ジオメトリcache戦略」節: 「直近使用zoom±1以外を破棄」)。件数上限
/// [maxEntries]は呼び出し側が渡す固定値(Global Constraints「上限値は
/// 呼び出し側が渡す`limits`引数で明示する」)で、この上限を超えた分は
/// **最も長く参照されていないentry(LRU)**から破棄する。ズーム窓とは独立な
/// 安全弁であり、ズーム窓を通過したentryが極端に多いarchiveでもメモリを
/// 無制限に使わないためのもの。
///
/// `_entries`は挿入順を保つ`Map`(Dartの既定`Map`は`LinkedHashMap`)であり、
/// [get]がhitするたびにそのentryを一度取り除いて入れ直すことで最新位置へ
/// 移動させる。これにより`_entries.keys.first`は常に「最も長く未参照の
/// entry」になり、そこから破棄すればLRUになる。zoomを変えないままの
/// pan操作では`noteActiveZoom`のzoom窓evictionが一切効かないため(`z`しか
/// 見ておらずx/y方向のpanには反応しない)、直近まで表示していたtileが
/// 単純なFIFOで先に捨てられてpan往復のたびに再decodeが起きる、という
/// 実測された不具合をLRU化で塞ぐ(fix round 1)。
///
/// # incarnation token
///
/// 進行中のdecodeをcamera変更でcancelできるよう、
/// `flutter_scene/flutter_scene_async_generation.dart`の
/// `SceneSpikeAsyncGenerationOwner`/`SceneSpikeAsyncGenerationToken`を
/// 再利用する(spike期に実装済みの汎用incarnation token機構であり、Scene
/// 固有の要素を持たないため、Task 1の逐語コピー差し戻しとは異なりこの
/// packageの別レイヤーから素直に再利用できる)。[beginDecode]で発行した
/// tokenを[put]へ渡すと、[cancelInFlight]が呼ばれた後のtokenでの[put]は
/// 黙って無視される(古い結果をcacheへ入れない)。cancelはエラーにしない
/// ([SceneSpikeAsyncGenerationOwner]自体が例外を投げない設計)。
///
/// # 子→親fallback
///
/// [lookupWithFallback]は、要求tileが未cacheの場合に
/// `docs/knowledge/20260805_maplibre_native_renderer_reference.md`
/// 「tileのライフサイクル」節と同じ順序で代替を探す: まず子4枚
/// (`CanonicalTileId.children()`)が**全て**cache済みならそれを使い、
/// 揃わなければ`overscaledZ`を1段ずつ下げるのと同じ意味で
/// `CanonicalTileId.scaledTo`によるancestorを1段ずつ遡り、最初に
/// 見つかった祖先で打ち切る。遡る段数の上限`maxParentSteps`は呼び出し側が
/// 渡す(Global Constraints)。
final class BaseMapTileCache {
  BaseMapTileCache({required this.maxEntries})
    : assert(maxEntries > 0, 'maxEntries must be positive');

  /// cacheへ保持できるentryの最大件数。
  final int maxEntries;

  final _generationOwner = SceneSpikeAsyncGenerationOwner();

  final Map<(String, CanonicalTileId), BaseMapTileGeometry> _entries = {};
  int? _activeZoom;

  /// 現在のentry件数(test用)。
  @visibleForTesting
  int get length => _entries.length;

  /// 新しいdecode試行のtokenを発行する。
  SceneSpikeAsyncGenerationToken beginDecode() => _generationOwner.begin();

  /// 進行中のdecodeを無効化する。camera変更時などに呼ぶ。
  void cancelInFlight() => _generationOwner.cancel();

  /// hitした場合、`_entries`内でのそのentryの位置を最新(最もLRUから遠い)
  /// へ移動させる副作用を持つ([_evictOverCapacity]のdoc comment参照)。
  BaseMapTileGeometry? get({
    required String sourceInstanceId,
    required CanonicalTileId tileId,
  }) {
    final key = (sourceInstanceId, tileId);
    final hit = _entries.remove(key);
    if (hit == null) {
      return null;
    }
    _entries[key] = hit;
    return hit;
  }

  /// [token]が[beginDecode]発行時点から見て最新のままなら[geometry]を
  /// cacheへ格納する。[cancelInFlight]により[token]が古くなっていた場合は
  /// 何もしない(古い結果をcacheへ入れない。エラーにもしない)。
  void put({
    required String sourceInstanceId,
    required CanonicalTileId tileId,
    required BaseMapTileGeometry geometry,
    required SceneSpikeAsyncGenerationToken token,
  }) {
    if (!token.isCurrent) {
      return;
    }
    _entries[(sourceInstanceId, tileId)] = geometry;
    _evictOutsideActiveZoomWindow();
    _evictOverCapacity();
  }

  /// 現在activeなzoom(整数、例えば`camera.zoom.floor()`)を通知する。
  /// 呼ぶたびに窓の外(`|z - zoom| > 1`)のentryを破棄する。
  void noteActiveZoom(int zoom) {
    _activeZoom = zoom;
    _evictOutsideActiveZoomWindow();
  }

  void _evictOutsideActiveZoomWindow() {
    final activeZoom = _activeZoom;
    if (activeZoom == null) {
      return;
    }
    _entries.removeWhere(
      (key, value) => (key.$2.z - activeZoom).abs() > 1,
    );
  }

  /// `_entries`の先頭(挿入順で最古、かつ[get]がhitするたびに末尾へ
  /// 移動させているため実質「最も長く未参照のentry」)から破棄する。
  void _evictOverCapacity() {
    while (_entries.length > maxEntries) {
      _entries.remove(_entries.keys.first);
    }
  }

  /// [tileId]を[sourceInstanceId]で探し、なければ子→親の順で代替を探す。
  BaseMapTileFallbackResult lookupWithFallback({
    required String sourceInstanceId,
    required CanonicalTileId tileId,
    required int maxParentSteps,
  }) {
    final exact = get(sourceInstanceId: sourceInstanceId, tileId: tileId);
    if (exact != null) {
      return BaseMapTileFallbackExact(exact);
    }

    final childIds = tileId.children();
    final childGeometries = [
      for (final childId in childIds)
        get(sourceInstanceId: sourceInstanceId, tileId: childId),
    ];
    if (childGeometries.every((geometry) => geometry != null)) {
      return BaseMapTileFallbackChildren(childGeometries.cast());
    }

    for (var step = 1; step <= maxParentSteps; step++) {
      final parentZ = tileId.z - step;
      if (parentZ < 0) {
        break;
      }
      final parentId = tileId.scaledTo(parentZ);
      final parentGeometry = get(
        sourceInstanceId: sourceInstanceId,
        tileId: parentId,
      );
      if (parentGeometry != null) {
        return BaseMapTileFallbackParent(
          parentGeometry,
          tileId: parentId,
          stepsUp: step,
        );
      }
    }

    return const BaseMapTileFallbackMiss();
  }

  /// 破棄予定のresourceを解放する。以後[beginDecode]で発行済みのtokenは
  /// すべて古いものとして扱われる。
  void dispose() {
    _generationOwner.dispose();
    _entries.clear();
  }
}

/// [BaseMapTileCache.lookupWithFallback]の結果。
@immutable
sealed class BaseMapTileFallbackResult {
  const BaseMapTileFallbackResult();
}

/// 要求どおりのtileがcache済みだった場合。
final class BaseMapTileFallbackExact extends BaseMapTileFallbackResult {
  const BaseMapTileFallbackExact(this.geometry);

  final BaseMapTileGeometry geometry;
}

/// 要求tileは未cacheだが、`z+1`の子4枚が全てcache済みだった場合。
final class BaseMapTileFallbackChildren extends BaseMapTileFallbackResult {
  const BaseMapTileFallbackChildren(this.children)
    : assert(children.length == 4, 'children must always contain 4 tiles');

  /// `CanonicalTileId.children()`と同じ並び順(4件、全て非null)。
  final List<BaseMapTileGeometry> children;
}

/// 要求tileも子4枚も未cacheで、`stepsUp`段上の祖先[tileId]がcache済み
/// だった場合。
final class BaseMapTileFallbackParent extends BaseMapTileFallbackResult {
  const BaseMapTileFallbackParent(
    this.geometry, {
    required this.tileId,
    required this.stepsUp,
  });

  final BaseMapTileGeometry geometry;
  final CanonicalTileId tileId;
  final int stepsUp;
}

/// 要求tile・子4枚・`maxParentSteps`段以内の祖先のいずれもcacheされていない
/// 場合。
final class BaseMapTileFallbackMiss extends BaseMapTileFallbackResult {
  const BaseMapTileFallbackMiss();
}

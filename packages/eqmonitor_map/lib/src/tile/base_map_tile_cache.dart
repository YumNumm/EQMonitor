import 'package:eqmonitor_map/src/foundation/async_generation_token.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:eqmonitor_map/src/tile/map_tile_fallback_policy.dart';
import 'package:eqmonitor_map/src/tile/map_tile_pipeline_budget.dart';
import 'package:flutter/foundation.dart';

/// decode済み[BaseMapTileGeometry]のcache。
///
/// # cache key
///
/// keyは`(sourceInstanceId, CanonicalTileId)`の組。この`sourceInstanceId`は
/// cacheにとっては不透明な識別子文字列であり、呼び出し側は
/// `VerifiedTileSourceCacheIdentity.cacheIdentity`(内容digestを含む)を渡す
/// 責務を負う。そうしないと、source が`sourceInstanceId`を据え置いたまま
/// 中身を差し替えたときにexact lookupが前revisionのgeometryを返す。
/// `CanonicalTileId.z`は
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
/// 整数)を基準にentryを破棄するが、**上方向(高zoom側)と下方向(低zoom側)で
/// 窓の深さが非対称**になっている(fix round 2)。
///
/// - 上方向: `entry.z > activeZoom + 1`を破棄する(元の
///   `docs/knowledge/20260802_kevi_map_renderer_reference.md`
///   「ジオメトリcache戦略」節の「直近使用zoom+1」をそのまま踏襲)。
/// - 下方向: `entry.z < activeZoom - maxParentFallbackSteps`を破棄する。
///
/// 対称な`±1`窓だったfix round 1の実装は、`lookupWithFallback`の祖先
/// fallback(下記「子→親fallback」節)と両立しなかった。zoomが2段以上一気に
/// 上がるpinch(例: z4→z6)では、要求tileの祖先(z4)がまだ子孫(z6)より
/// decodeが終わっているにもかかわらず、窓が`activeZoom(z6)±1`= `[5,7]`
/// しか許さないためz4は即座に破棄され、`maxParentFallbackSteps`を
/// どれだけ大きく設定しても遡る先が存在しなくなっていた(祖先を`±1`windowと
/// `maxParentSteps`引数の両方で保持しなければならないのに、片方(`±1`)しか
/// 実装していなかった)。低zoomのtileは1つのarchiveあたりの総数が
/// 指数的に少ない(zoom `z`の全世界tile数は`4^z`)ため、深く保持しても
/// メモリ増分は小さい。
///
/// 件数上限[maxEntries]は呼び出し側が渡す固定値(Global Constraints「上限値は
/// 呼び出し側が渡すlimits引数で明示する」)で、この上限を超えた分は
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
/// **LRU容量evictionと低zoom祖先の保持の相互作用**: 低zoomの祖先を
/// `lookupWithFallback`が実際にfallback先として使うたびに[get]を呼ぶため、
/// fallbackとして現役の間はLRUの「最近使った」扱いを受け続け、容量evictionの
/// 対象になりにくい。祖先を明示的にpinする機構は追加していない
/// (fallbackが不要になった祖先まで無条件に保持し続ける理由がなく、
/// 必要性を論証できない複雑化を避けるため)。祖先が実際にfallbackとして
/// 使われなくなった後は、通常のLRU順序に従って他のentryと同様に
/// 破棄され得る。
///
/// # incarnation token
///
/// 進行中のdecodeをcamera変更でcancelできるよう、
/// `foundation/async_generation_token.dart`の
/// [AsyncGenerationOwner]/[AsyncGenerationToken]を利用する(spike期に
/// `flutter_scene/`へ置いていた汎用incarnation token機構を、Scene 非依存の
/// foundation レイヤーへ昇格させたもの)。[beginDecode]で発行した
/// tokenを[put]へ渡すと、[cancelInFlight]が呼ばれた後のtokenでの[put]は
/// 黙って無視される(古い結果をcacheへ入れない)。cancelはエラーにしない
/// ([AsyncGenerationOwner]自体が例外を投げない設計)。
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
  BaseMapTileCache({
    required this.maxEntries,
    required this.maxParentFallbackSteps,
    this.fallbackPolicy = MapTileFallbackPolicy.basemap,
    this.budget,
  }) : assert(maxEntries > 0, 'maxEntries must be positive'),
       assert(
         maxParentFallbackSteps >= 0,
         'maxParentFallbackSteps must be non-negative',
       );

  /// cacheへ保持できるentryの最大件数。
  final int maxEntries;

  /// zoom窓の下方向(低zoom側)の深さ。[lookupWithFallback]へ渡す
  /// `maxParentSteps`と同じ値を呼び出し側が渡すことを想定している
  /// (呼び出し側=`BaseMapView`が`MapBaseLayerLimits.maxParentFallbackSteps`
  /// を両方へ渡す)。cache自身が`lookupWithFallback`の引数を検査して
  /// 一致を強制することはしない(cacheとlookupは疎結合なままにする)。
  final int maxParentFallbackSteps;

  /// 欠損 tile の代替可否を決める policy。既定は背景地図向けの
  /// [MapTileFallbackPolicy.basemap](親/子 fallback を許可)。hazard レイヤーの
  /// cache は[MapTileFallbackPolicy.hazard]を明示的に渡し、fail closed にする。
  final MapTileFallbackPolicy fallbackPolicy;

  /// pin 上限などの資源上限。[pin]を使う場合は必須(pin 数の上限を呼び出し側が
  /// 明示するため)。`null`のときは pinning 不可(Global Constraints「上限は
  /// 呼び出し側が渡す」に従い、暗黙の pin 上限を持たない)。
  final MapTilePipelineBudget? budget;

  final _generationOwner = AsyncGenerationOwner();

  final Map<(String, CanonicalTileId), BaseMapTileGeometry> _entries = {};

  /// LRU / zoom 窓 eviction から保護する entry の key 集合。上限は
  /// [budget]`.maxPinnedEntries`。
  final Set<(String, CanonicalTileId)> _pinned = {};
  int? _activeZoom;

  /// 現在のentry件数(test用)。
  @visibleForTesting
  int get length => _entries.length;

  /// 新しいdecode試行のtokenを発行する。
  AsyncGenerationToken beginDecode() => _generationOwner.begin();

  /// [tileId]の entry を eviction から保護する。既に put 済みでなければならず、
  /// pin 数は[budget]`.maxPinnedEntries`を超えられない。
  ///
  /// - [budget]未設定: [StateError](暗黙の pin 上限を持たないため)。
  /// - 未 cache の key: [ArgumentError]。
  /// - pin 上限超過: [StateError]。
  void pin({
    required String sourceInstanceId,
    required CanonicalTileId tileId,
  }) {
    final budget = this.budget;
    if (budget == null) {
      throw StateError('pinning requires a MapTilePipelineBudget.');
    }
    final key = (sourceInstanceId, tileId);
    if (!_entries.containsKey(key)) {
      throw ArgumentError.value(
        tileId,
        'tileId',
        'cannot pin a tile that is not cached',
      );
    }
    if (!_pinned.contains(key) && _pinned.length >= budget.maxPinnedEntries) {
      throw StateError(
        'pin budget exceeded (max ${budget.maxPinnedEntries}).',
      );
    }
    _pinned.add(key);
  }

  /// [tileId]の pin を解除する。以後、通常の LRU / zoom 窓 eviction の対象へ戻る。
  void unpin({
    required String sourceInstanceId,
    required CanonicalTileId tileId,
  }) {
    _pinned.remove((sourceInstanceId, tileId));
  }

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
    required AsyncGenerationToken token,
  }) {
    if (!token.isCurrent) {
      return;
    }
    _entries[(sourceInstanceId, tileId)] = geometry;
    _evictOutsideActiveZoomWindow();
    _evictOverCapacity();
  }

  /// 現在activeなzoom(整数、例えば`camera.zoom.floor()`)を通知する。
  /// 呼ぶたびに窓の外(`z > activeZoom + 1`または
  /// `z < activeZoom - maxParentFallbackSteps`)のentryを破棄する。
  void noteActiveZoom(int zoom) {
    _activeZoom = zoom;
    _evictOutsideActiveZoomWindow();
  }

  void _evictOutsideActiveZoomWindow() {
    final activeZoom = _activeZoom;
    if (activeZoom == null) {
      return;
    }
    _entries.removeWhere((key, value) {
      if (_pinned.contains(key)) {
        return false;
      }
      final z = key.$2.z;
      return z > activeZoom + 1 || z < activeZoom - maxParentFallbackSteps;
    });
  }

  /// `_entries`の先頭(挿入順で最古、かつ[get]がhitするたびに末尾へ
  /// 移動させているため実質「最も長く未参照のentry」)から破棄する。pin された
  /// entry は保護し、破棄しない(pin 数は[budget]で上限が課されているため、
  /// pin だけで無制限に膨らむことはない)。
  void _evictOverCapacity() {
    while (_entries.length > maxEntries) {
      final evictable = _entries.keys.where((key) => !_pinned.contains(key));
      if (evictable.isEmpty) {
        break;
      }
      _entries.remove(evictable.first);
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

    // hazard レイヤーは古い/別解像度の tile でごまかさず fail closed する。
    if (!fallbackPolicy.allowsSpatialFallback) {
      return const BaseMapTileFallbackMiss();
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
    _pinned.clear();
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

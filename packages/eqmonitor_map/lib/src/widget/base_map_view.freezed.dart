// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_map_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapBaseLayerLimits {

/// pan/pinch zoom gestureが許すcamera zoomの下限、および
/// [TileCoverCalculator.cover]へそのまま渡すtile zoomの下限。
///
/// 同じ値を2つの用途に使うのは、この2つが本来同じ「archiveが持つtile
/// zoom範囲」を指しているため([TileCoverCalculator.cover]のdoc
/// comment「`minZoom`未満ならfloor後の値を`minZoom`まで引き上げる」)。
/// gestureの下限だけを別に緩めると、archiveが持たないzoomのtileを
/// 要求して`PmTilesV3Exception`を招く。
 int get minZoom;/// [minZoom]と対になる上限。`maxZoom`を超えるcamera zoomは
/// [TileCoverCalculator.cover]がoverscale(`canonical.z`を`maxZoom`に
/// 留めたままtileを拡大表示)で吸収するが、[BaseMapView]はgesture自体を
/// この値で止めるため、[VerifiedPmTilesSource]が指すarchiveの実際の
/// `header.maxZoom`と一致させること(一致しない場合、`maxZoom`未満の
/// gesture操作だけでも実際のarchiveのzoom範囲を超えるtileを要求し得る)。
 int get maxZoom;/// [BaseMapTileRepository.open]へ渡すPMTiles archiveの走査上限。
 PmTilesV3Limits get pmTilesLimits;/// [BaseMapTileDecoder.decode]へ渡すMVT decode/mesh構築の上限。
 BaseMapTileDecodeLimits get decodeLimits;/// [BaseMapTileCache]が保持するdecode済みgeometryの件数上限。
///
/// [BaseMapView]がGPUへ載せるpacked meshのcache
/// ([BaseMapPackedMeshCache])も同じ値で件数を制限する。2つのcacheは同じ
/// 「一度にどれだけのtileを覚えておくか」という運用値を指しているため、
/// 別々の上限値を持たせる理由がない。
 int get maxCachedTileGeometries;/// [BaseMapTileCache.lookupWithFallback]が祖先を遡る最大段数。
///
/// [BaseMapTileCache]のzoom窓(低zoom側)の深さにも同じ値を渡す
/// (`base_map_tile_cache.dart`の「LRU容量evictionと低zoom祖先の保持の
/// 相互作用」節参照)。祖先を`lookupWithFallback`が実際に遡れる段数と、
/// その祖先がcacheの窓から破棄されずに残る段数を分けて設定できても
/// 意味がない(遡れる段数より深く保持しても使われず、遡れる段数より
/// 浅くしか保持しなければ遡っても見つからない)ため、1つの値を両方へ
/// 渡す。
 int get maxParentFallbackSteps;/// 同時に走らせる tile decode の上限([MapTileScheduler]へ渡す)。
///
/// 1 frame の cover に含まれる欠損 tile 全部へ無制限に `Isolate.run` decode を
/// 張ると、cover が大きく変わった瞬間に多数の isolate を同時 spawn して
/// resource を圧迫する。この値で同時 decode を頭打ちにし、decode 完了ごとに
/// 次の欠損 tile を中心近傍優先で開始する(backpressure)。
 int get maxInFlightDecodes;/// GPU resource を手放すまでに待つ frame 数
/// (`MapGpuResourceLedger` へ渡す)。
///
/// CPU frame の終了は GPU 完了を意味しない(設計正本「CPU frame終了は
/// GPU完了を意味しない」)。可視 tile から外れた geometry の参照を即座に
/// 落とすと、まだ in-flight の frame が参照している最中に GC 対象へ
/// してしまう。この frame 数ぶん未使用が続いた resource だけを手放す。
 int get maxFramesInFlight;/// Sprite atlas/topology/policy batchesのcaller-owned上限。
 MapSpriteRendererLimits get spriteRendererLimits;/// 一つのScene frameへ送るmesh packet / instance batch node総数の上限。
 int get maxSceneNodeCount;
/// Create a copy of MapBaseLayerLimits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapBaseLayerLimitsCopyWith<MapBaseLayerLimits> get copyWith => _$MapBaseLayerLimitsCopyWithImpl<MapBaseLayerLimits>(this as MapBaseLayerLimits, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapBaseLayerLimits&&(identical(other.minZoom, minZoom) || other.minZoom == minZoom)&&(identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom)&&(identical(other.pmTilesLimits, pmTilesLimits) || other.pmTilesLimits == pmTilesLimits)&&(identical(other.decodeLimits, decodeLimits) || other.decodeLimits == decodeLimits)&&(identical(other.maxCachedTileGeometries, maxCachedTileGeometries) || other.maxCachedTileGeometries == maxCachedTileGeometries)&&(identical(other.maxParentFallbackSteps, maxParentFallbackSteps) || other.maxParentFallbackSteps == maxParentFallbackSteps)&&(identical(other.maxInFlightDecodes, maxInFlightDecodes) || other.maxInFlightDecodes == maxInFlightDecodes)&&(identical(other.maxFramesInFlight, maxFramesInFlight) || other.maxFramesInFlight == maxFramesInFlight)&&(identical(other.spriteRendererLimits, spriteRendererLimits) || other.spriteRendererLimits == spriteRendererLimits)&&(identical(other.maxSceneNodeCount, maxSceneNodeCount) || other.maxSceneNodeCount == maxSceneNodeCount));
}


@override
int get hashCode => Object.hash(runtimeType,minZoom,maxZoom,pmTilesLimits,decodeLimits,maxCachedTileGeometries,maxParentFallbackSteps,maxInFlightDecodes,maxFramesInFlight,spriteRendererLimits,maxSceneNodeCount);

@override
String toString() {
  return 'MapBaseLayerLimits(minZoom: $minZoom, maxZoom: $maxZoom, pmTilesLimits: $pmTilesLimits, decodeLimits: $decodeLimits, maxCachedTileGeometries: $maxCachedTileGeometries, maxParentFallbackSteps: $maxParentFallbackSteps, maxInFlightDecodes: $maxInFlightDecodes, maxFramesInFlight: $maxFramesInFlight, spriteRendererLimits: $spriteRendererLimits, maxSceneNodeCount: $maxSceneNodeCount)';
}


}

/// @nodoc
abstract mixin class $MapBaseLayerLimitsCopyWith<$Res>  {
  factory $MapBaseLayerLimitsCopyWith(MapBaseLayerLimits value, $Res Function(MapBaseLayerLimits) _then) = _$MapBaseLayerLimitsCopyWithImpl;
@useResult
$Res call({
 int minZoom, int maxZoom, PmTilesV3Limits pmTilesLimits, BaseMapTileDecodeLimits decodeLimits, int maxCachedTileGeometries, int maxParentFallbackSteps, int maxInFlightDecodes, int maxFramesInFlight, MapSpriteRendererLimits spriteRendererLimits, int maxSceneNodeCount
});


$PmTilesV3LimitsCopyWith<$Res> get pmTilesLimits;$BaseMapTileDecodeLimitsCopyWith<$Res> get decodeLimits;

}
/// @nodoc
class _$MapBaseLayerLimitsCopyWithImpl<$Res>
    implements $MapBaseLayerLimitsCopyWith<$Res> {
  _$MapBaseLayerLimitsCopyWithImpl(this._self, this._then);

  final MapBaseLayerLimits _self;
  final $Res Function(MapBaseLayerLimits) _then;

/// Create a copy of MapBaseLayerLimits
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minZoom = null,Object? maxZoom = null,Object? pmTilesLimits = null,Object? decodeLimits = null,Object? maxCachedTileGeometries = null,Object? maxParentFallbackSteps = null,Object? maxInFlightDecodes = null,Object? maxFramesInFlight = null,Object? spriteRendererLimits = null,Object? maxSceneNodeCount = null,}) {
  return _then(MapBaseLayerLimits(
minZoom: null == minZoom ? _self.minZoom : minZoom // ignore: cast_nullable_to_non_nullable
as int,maxZoom: null == maxZoom ? _self.maxZoom : maxZoom // ignore: cast_nullable_to_non_nullable
as int,pmTilesLimits: null == pmTilesLimits ? _self.pmTilesLimits : pmTilesLimits // ignore: cast_nullable_to_non_nullable
as PmTilesV3Limits,decodeLimits: null == decodeLimits ? _self.decodeLimits : decodeLimits // ignore: cast_nullable_to_non_nullable
as BaseMapTileDecodeLimits,maxCachedTileGeometries: null == maxCachedTileGeometries ? _self.maxCachedTileGeometries : maxCachedTileGeometries // ignore: cast_nullable_to_non_nullable
as int,maxParentFallbackSteps: null == maxParentFallbackSteps ? _self.maxParentFallbackSteps : maxParentFallbackSteps // ignore: cast_nullable_to_non_nullable
as int,maxInFlightDecodes: null == maxInFlightDecodes ? _self.maxInFlightDecodes : maxInFlightDecodes // ignore: cast_nullable_to_non_nullable
as int,maxFramesInFlight: null == maxFramesInFlight ? _self.maxFramesInFlight : maxFramesInFlight // ignore: cast_nullable_to_non_nullable
as int,spriteRendererLimits: null == spriteRendererLimits ? _self.spriteRendererLimits : spriteRendererLimits // ignore: cast_nullable_to_non_nullable
as MapSpriteRendererLimits,maxSceneNodeCount: null == maxSceneNodeCount ? _self.maxSceneNodeCount : maxSceneNodeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of MapBaseLayerLimits
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PmTilesV3LimitsCopyWith<$Res> get pmTilesLimits {
  
  return $PmTilesV3LimitsCopyWith<$Res>(_self.pmTilesLimits, (value) {
    return _then(_self.copyWith(pmTilesLimits: value));
  });
}/// Create a copy of MapBaseLayerLimits
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BaseMapTileDecodeLimitsCopyWith<$Res> get decodeLimits {
  
  return $BaseMapTileDecodeLimitsCopyWith<$Res>(_self.decodeLimits, (value) {
    return _then(_self.copyWith(decodeLimits: value));
  });
}
}


/// Adds pattern-matching-related methods to [MapBaseLayerLimits].
extension MapBaseLayerLimitsPatterns on MapBaseLayerLimits {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapBaseLayerLimits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapBaseLayerLimits() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapBaseLayerLimits value)  $default,){
final _that = this;
switch (_that) {
case _MapBaseLayerLimits():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapBaseLayerLimits value)?  $default,){
final _that = this;
switch (_that) {
case _MapBaseLayerLimits() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int minZoom,  int maxZoom,  PmTilesV3Limits pmTilesLimits,  BaseMapTileDecodeLimits decodeLimits,  int maxCachedTileGeometries,  int maxParentFallbackSteps,  int maxInFlightDecodes,  int maxFramesInFlight,  MapSpriteRendererLimits spriteRendererLimits,  int maxSceneNodeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapBaseLayerLimits() when $default != null:
return $default(_that.minZoom,_that.maxZoom,_that.pmTilesLimits,_that.decodeLimits,_that.maxCachedTileGeometries,_that.maxParentFallbackSteps,_that.maxInFlightDecodes,_that.maxFramesInFlight,_that.spriteRendererLimits,_that.maxSceneNodeCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int minZoom,  int maxZoom,  PmTilesV3Limits pmTilesLimits,  BaseMapTileDecodeLimits decodeLimits,  int maxCachedTileGeometries,  int maxParentFallbackSteps,  int maxInFlightDecodes,  int maxFramesInFlight,  MapSpriteRendererLimits spriteRendererLimits,  int maxSceneNodeCount)  $default,) {final _that = this;
switch (_that) {
case _MapBaseLayerLimits():
return $default(_that.minZoom,_that.maxZoom,_that.pmTilesLimits,_that.decodeLimits,_that.maxCachedTileGeometries,_that.maxParentFallbackSteps,_that.maxInFlightDecodes,_that.maxFramesInFlight,_that.spriteRendererLimits,_that.maxSceneNodeCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int minZoom,  int maxZoom,  PmTilesV3Limits pmTilesLimits,  BaseMapTileDecodeLimits decodeLimits,  int maxCachedTileGeometries,  int maxParentFallbackSteps,  int maxInFlightDecodes,  int maxFramesInFlight,  MapSpriteRendererLimits spriteRendererLimits,  int maxSceneNodeCount)?  $default,) {final _that = this;
switch (_that) {
case _MapBaseLayerLimits() when $default != null:
return $default(_that.minZoom,_that.maxZoom,_that.pmTilesLimits,_that.decodeLimits,_that.maxCachedTileGeometries,_that.maxParentFallbackSteps,_that.maxInFlightDecodes,_that.maxFramesInFlight,_that.spriteRendererLimits,_that.maxSceneNodeCount);case _:
  return null;

}
}

}

/// @nodoc


class _MapBaseLayerLimits implements MapBaseLayerLimits {
  const _MapBaseLayerLimits({required this.minZoom, required this.maxZoom, required this.pmTilesLimits, required this.decodeLimits, required this.maxCachedTileGeometries, required this.maxParentFallbackSteps, required this.maxInFlightDecodes, required this.maxFramesInFlight, required this.spriteRendererLimits, required this.maxSceneNodeCount});
  

/// pan/pinch zoom gestureが許すcamera zoomの下限、および
/// [TileCoverCalculator.cover]へそのまま渡すtile zoomの下限。
///
/// 同じ値を2つの用途に使うのは、この2つが本来同じ「archiveが持つtile
/// zoom範囲」を指しているため([TileCoverCalculator.cover]のdoc
/// comment「`minZoom`未満ならfloor後の値を`minZoom`まで引き上げる」)。
/// gestureの下限だけを別に緩めると、archiveが持たないzoomのtileを
/// 要求して`PmTilesV3Exception`を招く。
@override final  int minZoom;
/// [minZoom]と対になる上限。`maxZoom`を超えるcamera zoomは
/// [TileCoverCalculator.cover]がoverscale(`canonical.z`を`maxZoom`に
/// 留めたままtileを拡大表示)で吸収するが、[BaseMapView]はgesture自体を
/// この値で止めるため、[VerifiedPmTilesSource]が指すarchiveの実際の
/// `header.maxZoom`と一致させること(一致しない場合、`maxZoom`未満の
/// gesture操作だけでも実際のarchiveのzoom範囲を超えるtileを要求し得る)。
@override final  int maxZoom;
/// [BaseMapTileRepository.open]へ渡すPMTiles archiveの走査上限。
@override final  PmTilesV3Limits pmTilesLimits;
/// [BaseMapTileDecoder.decode]へ渡すMVT decode/mesh構築の上限。
@override final  BaseMapTileDecodeLimits decodeLimits;
/// [BaseMapTileCache]が保持するdecode済みgeometryの件数上限。
///
/// [BaseMapView]がGPUへ載せるpacked meshのcache
/// ([BaseMapPackedMeshCache])も同じ値で件数を制限する。2つのcacheは同じ
/// 「一度にどれだけのtileを覚えておくか」という運用値を指しているため、
/// 別々の上限値を持たせる理由がない。
@override final  int maxCachedTileGeometries;
/// [BaseMapTileCache.lookupWithFallback]が祖先を遡る最大段数。
///
/// [BaseMapTileCache]のzoom窓(低zoom側)の深さにも同じ値を渡す
/// (`base_map_tile_cache.dart`の「LRU容量evictionと低zoom祖先の保持の
/// 相互作用」節参照)。祖先を`lookupWithFallback`が実際に遡れる段数と、
/// その祖先がcacheの窓から破棄されずに残る段数を分けて設定できても
/// 意味がない(遡れる段数より深く保持しても使われず、遡れる段数より
/// 浅くしか保持しなければ遡っても見つからない)ため、1つの値を両方へ
/// 渡す。
@override final  int maxParentFallbackSteps;
/// 同時に走らせる tile decode の上限([MapTileScheduler]へ渡す)。
///
/// 1 frame の cover に含まれる欠損 tile 全部へ無制限に `Isolate.run` decode を
/// 張ると、cover が大きく変わった瞬間に多数の isolate を同時 spawn して
/// resource を圧迫する。この値で同時 decode を頭打ちにし、decode 完了ごとに
/// 次の欠損 tile を中心近傍優先で開始する(backpressure)。
@override final  int maxInFlightDecodes;
/// GPU resource を手放すまでに待つ frame 数
/// (`MapGpuResourceLedger` へ渡す)。
///
/// CPU frame の終了は GPU 完了を意味しない(設計正本「CPU frame終了は
/// GPU完了を意味しない」)。可視 tile から外れた geometry の参照を即座に
/// 落とすと、まだ in-flight の frame が参照している最中に GC 対象へ
/// してしまう。この frame 数ぶん未使用が続いた resource だけを手放す。
@override final  int maxFramesInFlight;
/// Sprite atlas/topology/policy batchesのcaller-owned上限。
@override final  MapSpriteRendererLimits spriteRendererLimits;
/// 一つのScene frameへ送るmesh packet / instance batch node総数の上限。
@override final  int maxSceneNodeCount;

/// Create a copy of MapBaseLayerLimits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapBaseLayerLimitsCopyWith<_MapBaseLayerLimits> get copyWith => __$MapBaseLayerLimitsCopyWithImpl<_MapBaseLayerLimits>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapBaseLayerLimits&&(identical(other.minZoom, minZoom) || other.minZoom == minZoom)&&(identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom)&&(identical(other.pmTilesLimits, pmTilesLimits) || other.pmTilesLimits == pmTilesLimits)&&(identical(other.decodeLimits, decodeLimits) || other.decodeLimits == decodeLimits)&&(identical(other.maxCachedTileGeometries, maxCachedTileGeometries) || other.maxCachedTileGeometries == maxCachedTileGeometries)&&(identical(other.maxParentFallbackSteps, maxParentFallbackSteps) || other.maxParentFallbackSteps == maxParentFallbackSteps)&&(identical(other.maxInFlightDecodes, maxInFlightDecodes) || other.maxInFlightDecodes == maxInFlightDecodes)&&(identical(other.maxFramesInFlight, maxFramesInFlight) || other.maxFramesInFlight == maxFramesInFlight)&&(identical(other.spriteRendererLimits, spriteRendererLimits) || other.spriteRendererLimits == spriteRendererLimits)&&(identical(other.maxSceneNodeCount, maxSceneNodeCount) || other.maxSceneNodeCount == maxSceneNodeCount));
}


@override
int get hashCode => Object.hash(runtimeType,minZoom,maxZoom,pmTilesLimits,decodeLimits,maxCachedTileGeometries,maxParentFallbackSteps,maxInFlightDecodes,maxFramesInFlight,spriteRendererLimits,maxSceneNodeCount);

@override
String toString() {
  return 'MapBaseLayerLimits(minZoom: $minZoom, maxZoom: $maxZoom, pmTilesLimits: $pmTilesLimits, decodeLimits: $decodeLimits, maxCachedTileGeometries: $maxCachedTileGeometries, maxParentFallbackSteps: $maxParentFallbackSteps, maxInFlightDecodes: $maxInFlightDecodes, maxFramesInFlight: $maxFramesInFlight, spriteRendererLimits: $spriteRendererLimits, maxSceneNodeCount: $maxSceneNodeCount)';
}


}

/// @nodoc
abstract mixin class _$MapBaseLayerLimitsCopyWith<$Res> implements $MapBaseLayerLimitsCopyWith<$Res> {
  factory _$MapBaseLayerLimitsCopyWith(_MapBaseLayerLimits value, $Res Function(_MapBaseLayerLimits) _then) = __$MapBaseLayerLimitsCopyWithImpl;
@override @useResult
$Res call({
 int minZoom, int maxZoom, PmTilesV3Limits pmTilesLimits, BaseMapTileDecodeLimits decodeLimits, int maxCachedTileGeometries, int maxParentFallbackSteps, int maxInFlightDecodes, int maxFramesInFlight, MapSpriteRendererLimits spriteRendererLimits, int maxSceneNodeCount
});


@override $PmTilesV3LimitsCopyWith<$Res> get pmTilesLimits;@override $BaseMapTileDecodeLimitsCopyWith<$Res> get decodeLimits;

}
/// @nodoc
class __$MapBaseLayerLimitsCopyWithImpl<$Res>
    implements _$MapBaseLayerLimitsCopyWith<$Res> {
  __$MapBaseLayerLimitsCopyWithImpl(this._self, this._then);

  final _MapBaseLayerLimits _self;
  final $Res Function(_MapBaseLayerLimits) _then;

/// Create a copy of MapBaseLayerLimits
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minZoom = null,Object? maxZoom = null,Object? pmTilesLimits = null,Object? decodeLimits = null,Object? maxCachedTileGeometries = null,Object? maxParentFallbackSteps = null,Object? maxInFlightDecodes = null,Object? maxFramesInFlight = null,Object? spriteRendererLimits = null,Object? maxSceneNodeCount = null,}) {
  return _then(_MapBaseLayerLimits(
minZoom: null == minZoom ? _self.minZoom : minZoom // ignore: cast_nullable_to_non_nullable
as int,maxZoom: null == maxZoom ? _self.maxZoom : maxZoom // ignore: cast_nullable_to_non_nullable
as int,pmTilesLimits: null == pmTilesLimits ? _self.pmTilesLimits : pmTilesLimits // ignore: cast_nullable_to_non_nullable
as PmTilesV3Limits,decodeLimits: null == decodeLimits ? _self.decodeLimits : decodeLimits // ignore: cast_nullable_to_non_nullable
as BaseMapTileDecodeLimits,maxCachedTileGeometries: null == maxCachedTileGeometries ? _self.maxCachedTileGeometries : maxCachedTileGeometries // ignore: cast_nullable_to_non_nullable
as int,maxParentFallbackSteps: null == maxParentFallbackSteps ? _self.maxParentFallbackSteps : maxParentFallbackSteps // ignore: cast_nullable_to_non_nullable
as int,maxInFlightDecodes: null == maxInFlightDecodes ? _self.maxInFlightDecodes : maxInFlightDecodes // ignore: cast_nullable_to_non_nullable
as int,maxFramesInFlight: null == maxFramesInFlight ? _self.maxFramesInFlight : maxFramesInFlight // ignore: cast_nullable_to_non_nullable
as int,spriteRendererLimits: null == spriteRendererLimits ? _self.spriteRendererLimits : spriteRendererLimits // ignore: cast_nullable_to_non_nullable
as MapSpriteRendererLimits,maxSceneNodeCount: null == maxSceneNodeCount ? _self.maxSceneNodeCount : maxSceneNodeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of MapBaseLayerLimits
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PmTilesV3LimitsCopyWith<$Res> get pmTilesLimits {
  
  return $PmTilesV3LimitsCopyWith<$Res>(_self.pmTilesLimits, (value) {
    return _then(_self.copyWith(pmTilesLimits: value));
  });
}/// Create a copy of MapBaseLayerLimits
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BaseMapTileDecodeLimitsCopyWith<$Res> get decodeLimits {
  
  return $BaseMapTileDecodeLimitsCopyWith<$Res>(_self.decodeLimits, (value) {
    return _then(_self.copyWith(decodeLimits: value));
  });
}
}

// dart format on

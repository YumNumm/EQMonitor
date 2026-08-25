// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pmtiles_v3_limits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PmTilesV3Limits {

/// directory treeを辿る最大深さ。3を超えるarchiveは corrupt として拒否する。
 int get maxDirectoryDepth;/// root directoryが収まっているべき先頭からのwindow長（byte）。
 int get rootDirectoryWindowLength;/// root/leaf directoryの圧縮済みbyte列1件あたりの上限。
 int get maxDirectoryEncodedBytes;/// root/leaf directoryの展開済みbyte列1件あたりの上限。
 int get maxDirectoryDecodedBytes;/// 同時に保持するleaf directory cacheの最大件数。
///
/// 1件あたりの展開上限と組み合わせ、archiveを長時間読む場合や先行
/// validationで多数のleafを辿る場合もcacheの保持量を有限化する。
/// 0はcacheを無効化する。
 int get maxCachedLeafDirectories;/// tile payloadの圧縮済みbyte列1件あたりの上限。
 int get maxTileEncodedBytes;/// tile payloadの展開済みbyte列1件あたりの上限。
 int get maxTileDecodedBytes;/// `open`時にarchive全体のleaf directoryを先行走査し、clustered
/// ordering・件数などをarchive全体について再検証するかどうか。
///
/// 既定は`false`（何もscanしない）。安全な既定値である理由は、
/// 「先行検証を省いても安全だから」ではなく、設計正本
/// (`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`)
/// が「runtimeはheader/metadataの整合と各tile読み取り時のbounded検証を
/// 正とし、archive全体をscanしてglobal coverageや件数を再検証すること
/// はしない」と定めているためである。archive全体の整合性検証は
/// producer/release validatorの責務であり、runtimeが毎回開くたびに
/// 全leaf directoryを読む契約はここでは負わない。
///
/// `true`にすると、rootおよびすべてのleaf directoryを`open`時に走査し、
/// `clustered`ヘッダが`true`の場合は`PmTilesV3ClusteredOrdering`で
/// content配置の整合まで検証する。producer契約がclustered orderingと
/// tile件数の一致を保証しているarchive（例: `seismicity_pmtiles`が
/// 生成するarchive）でのみ有効化すること。
 bool get validateFullArchiveOnOpen;
/// Create a copy of PmTilesV3Limits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PmTilesV3LimitsCopyWith<PmTilesV3Limits> get copyWith => _$PmTilesV3LimitsCopyWithImpl<PmTilesV3Limits>(this as PmTilesV3Limits, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PmTilesV3Limits&&(identical(other.maxDirectoryDepth, maxDirectoryDepth) || other.maxDirectoryDepth == maxDirectoryDepth)&&(identical(other.rootDirectoryWindowLength, rootDirectoryWindowLength) || other.rootDirectoryWindowLength == rootDirectoryWindowLength)&&(identical(other.maxDirectoryEncodedBytes, maxDirectoryEncodedBytes) || other.maxDirectoryEncodedBytes == maxDirectoryEncodedBytes)&&(identical(other.maxDirectoryDecodedBytes, maxDirectoryDecodedBytes) || other.maxDirectoryDecodedBytes == maxDirectoryDecodedBytes)&&(identical(other.maxCachedLeafDirectories, maxCachedLeafDirectories) || other.maxCachedLeafDirectories == maxCachedLeafDirectories)&&(identical(other.maxTileEncodedBytes, maxTileEncodedBytes) || other.maxTileEncodedBytes == maxTileEncodedBytes)&&(identical(other.maxTileDecodedBytes, maxTileDecodedBytes) || other.maxTileDecodedBytes == maxTileDecodedBytes)&&(identical(other.validateFullArchiveOnOpen, validateFullArchiveOnOpen) || other.validateFullArchiveOnOpen == validateFullArchiveOnOpen));
}


@override
int get hashCode => Object.hash(runtimeType,maxDirectoryDepth,rootDirectoryWindowLength,maxDirectoryEncodedBytes,maxDirectoryDecodedBytes,maxCachedLeafDirectories,maxTileEncodedBytes,maxTileDecodedBytes,validateFullArchiveOnOpen);

@override
String toString() {
  return 'PmTilesV3Limits(maxDirectoryDepth: $maxDirectoryDepth, rootDirectoryWindowLength: $rootDirectoryWindowLength, maxDirectoryEncodedBytes: $maxDirectoryEncodedBytes, maxDirectoryDecodedBytes: $maxDirectoryDecodedBytes, maxCachedLeafDirectories: $maxCachedLeafDirectories, maxTileEncodedBytes: $maxTileEncodedBytes, maxTileDecodedBytes: $maxTileDecodedBytes, validateFullArchiveOnOpen: $validateFullArchiveOnOpen)';
}


}

/// @nodoc
abstract mixin class $PmTilesV3LimitsCopyWith<$Res>  {
  factory $PmTilesV3LimitsCopyWith(PmTilesV3Limits value, $Res Function(PmTilesV3Limits) _then) = _$PmTilesV3LimitsCopyWithImpl;
@useResult
$Res call({
 int maxDirectoryDepth, int rootDirectoryWindowLength, int maxDirectoryEncodedBytes, int maxDirectoryDecodedBytes, int maxCachedLeafDirectories, int maxTileEncodedBytes, int maxTileDecodedBytes, bool validateFullArchiveOnOpen
});




}
/// @nodoc
class _$PmTilesV3LimitsCopyWithImpl<$Res>
    implements $PmTilesV3LimitsCopyWith<$Res> {
  _$PmTilesV3LimitsCopyWithImpl(this._self, this._then);

  final PmTilesV3Limits _self;
  final $Res Function(PmTilesV3Limits) _then;

/// Create a copy of PmTilesV3Limits
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxDirectoryDepth = null,Object? rootDirectoryWindowLength = null,Object? maxDirectoryEncodedBytes = null,Object? maxDirectoryDecodedBytes = null,Object? maxCachedLeafDirectories = null,Object? maxTileEncodedBytes = null,Object? maxTileDecodedBytes = null,Object? validateFullArchiveOnOpen = null,}) {
  return _then(PmTilesV3Limits(
maxDirectoryDepth: null == maxDirectoryDepth ? _self.maxDirectoryDepth : maxDirectoryDepth // ignore: cast_nullable_to_non_nullable
as int,rootDirectoryWindowLength: null == rootDirectoryWindowLength ? _self.rootDirectoryWindowLength : rootDirectoryWindowLength // ignore: cast_nullable_to_non_nullable
as int,maxDirectoryEncodedBytes: null == maxDirectoryEncodedBytes ? _self.maxDirectoryEncodedBytes : maxDirectoryEncodedBytes // ignore: cast_nullable_to_non_nullable
as int,maxDirectoryDecodedBytes: null == maxDirectoryDecodedBytes ? _self.maxDirectoryDecodedBytes : maxDirectoryDecodedBytes // ignore: cast_nullable_to_non_nullable
as int,maxCachedLeafDirectories: null == maxCachedLeafDirectories ? _self.maxCachedLeafDirectories : maxCachedLeafDirectories // ignore: cast_nullable_to_non_nullable
as int,maxTileEncodedBytes: null == maxTileEncodedBytes ? _self.maxTileEncodedBytes : maxTileEncodedBytes // ignore: cast_nullable_to_non_nullable
as int,maxTileDecodedBytes: null == maxTileDecodedBytes ? _self.maxTileDecodedBytes : maxTileDecodedBytes // ignore: cast_nullable_to_non_nullable
as int,validateFullArchiveOnOpen: null == validateFullArchiveOnOpen ? _self.validateFullArchiveOnOpen : validateFullArchiveOnOpen // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PmTilesV3Limits].
extension PmTilesV3LimitsPatterns on PmTilesV3Limits {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PmTilesV3Limits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PmTilesV3Limits() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PmTilesV3Limits value)  $default,){
final _that = this;
switch (_that) {
case _PmTilesV3Limits():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PmTilesV3Limits value)?  $default,){
final _that = this;
switch (_that) {
case _PmTilesV3Limits() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxDirectoryDepth,  int rootDirectoryWindowLength,  int maxDirectoryEncodedBytes,  int maxDirectoryDecodedBytes,  int maxCachedLeafDirectories,  int maxTileEncodedBytes,  int maxTileDecodedBytes,  bool validateFullArchiveOnOpen)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PmTilesV3Limits() when $default != null:
return $default(_that.maxDirectoryDepth,_that.rootDirectoryWindowLength,_that.maxDirectoryEncodedBytes,_that.maxDirectoryDecodedBytes,_that.maxCachedLeafDirectories,_that.maxTileEncodedBytes,_that.maxTileDecodedBytes,_that.validateFullArchiveOnOpen);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxDirectoryDepth,  int rootDirectoryWindowLength,  int maxDirectoryEncodedBytes,  int maxDirectoryDecodedBytes,  int maxCachedLeafDirectories,  int maxTileEncodedBytes,  int maxTileDecodedBytes,  bool validateFullArchiveOnOpen)  $default,) {final _that = this;
switch (_that) {
case _PmTilesV3Limits():
return $default(_that.maxDirectoryDepth,_that.rootDirectoryWindowLength,_that.maxDirectoryEncodedBytes,_that.maxDirectoryDecodedBytes,_that.maxCachedLeafDirectories,_that.maxTileEncodedBytes,_that.maxTileDecodedBytes,_that.validateFullArchiveOnOpen);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxDirectoryDepth,  int rootDirectoryWindowLength,  int maxDirectoryEncodedBytes,  int maxDirectoryDecodedBytes,  int maxCachedLeafDirectories,  int maxTileEncodedBytes,  int maxTileDecodedBytes,  bool validateFullArchiveOnOpen)?  $default,) {final _that = this;
switch (_that) {
case _PmTilesV3Limits() when $default != null:
return $default(_that.maxDirectoryDepth,_that.rootDirectoryWindowLength,_that.maxDirectoryEncodedBytes,_that.maxDirectoryDecodedBytes,_that.maxCachedLeafDirectories,_that.maxTileEncodedBytes,_that.maxTileDecodedBytes,_that.validateFullArchiveOnOpen);case _:
  return null;

}
}

}

/// @nodoc


class _PmTilesV3Limits implements PmTilesV3Limits {
  const _PmTilesV3Limits({required this.maxDirectoryDepth, required this.rootDirectoryWindowLength, required this.maxDirectoryEncodedBytes, required this.maxDirectoryDecodedBytes, required this.maxCachedLeafDirectories, required this.maxTileEncodedBytes, required this.maxTileDecodedBytes, this.validateFullArchiveOnOpen = false});
  

/// directory treeを辿る最大深さ。3を超えるarchiveは corrupt として拒否する。
@override final  int maxDirectoryDepth;
/// root directoryが収まっているべき先頭からのwindow長（byte）。
@override final  int rootDirectoryWindowLength;
/// root/leaf directoryの圧縮済みbyte列1件あたりの上限。
@override final  int maxDirectoryEncodedBytes;
/// root/leaf directoryの展開済みbyte列1件あたりの上限。
@override final  int maxDirectoryDecodedBytes;
/// 同時に保持するleaf directory cacheの最大件数。
///
/// 1件あたりの展開上限と組み合わせ、archiveを長時間読む場合や先行
/// validationで多数のleafを辿る場合もcacheの保持量を有限化する。
/// 0はcacheを無効化する。
@override final  int maxCachedLeafDirectories;
/// tile payloadの圧縮済みbyte列1件あたりの上限。
@override final  int maxTileEncodedBytes;
/// tile payloadの展開済みbyte列1件あたりの上限。
@override final  int maxTileDecodedBytes;
/// `open`時にarchive全体のleaf directoryを先行走査し、clustered
/// ordering・件数などをarchive全体について再検証するかどうか。
///
/// 既定は`false`（何もscanしない）。安全な既定値である理由は、
/// 「先行検証を省いても安全だから」ではなく、設計正本
/// (`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`)
/// が「runtimeはheader/metadataの整合と各tile読み取り時のbounded検証を
/// 正とし、archive全体をscanしてglobal coverageや件数を再検証すること
/// はしない」と定めているためである。archive全体の整合性検証は
/// producer/release validatorの責務であり、runtimeが毎回開くたびに
/// 全leaf directoryを読む契約はここでは負わない。
///
/// `true`にすると、rootおよびすべてのleaf directoryを`open`時に走査し、
/// `clustered`ヘッダが`true`の場合は`PmTilesV3ClusteredOrdering`で
/// content配置の整合まで検証する。producer契約がclustered orderingと
/// tile件数の一致を保証しているarchive（例: `seismicity_pmtiles`が
/// 生成するarchive）でのみ有効化すること。
@override@JsonKey() final  bool validateFullArchiveOnOpen;

/// Create a copy of PmTilesV3Limits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PmTilesV3LimitsCopyWith<_PmTilesV3Limits> get copyWith => __$PmTilesV3LimitsCopyWithImpl<_PmTilesV3Limits>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PmTilesV3Limits&&(identical(other.maxDirectoryDepth, maxDirectoryDepth) || other.maxDirectoryDepth == maxDirectoryDepth)&&(identical(other.rootDirectoryWindowLength, rootDirectoryWindowLength) || other.rootDirectoryWindowLength == rootDirectoryWindowLength)&&(identical(other.maxDirectoryEncodedBytes, maxDirectoryEncodedBytes) || other.maxDirectoryEncodedBytes == maxDirectoryEncodedBytes)&&(identical(other.maxDirectoryDecodedBytes, maxDirectoryDecodedBytes) || other.maxDirectoryDecodedBytes == maxDirectoryDecodedBytes)&&(identical(other.maxCachedLeafDirectories, maxCachedLeafDirectories) || other.maxCachedLeafDirectories == maxCachedLeafDirectories)&&(identical(other.maxTileEncodedBytes, maxTileEncodedBytes) || other.maxTileEncodedBytes == maxTileEncodedBytes)&&(identical(other.maxTileDecodedBytes, maxTileDecodedBytes) || other.maxTileDecodedBytes == maxTileDecodedBytes)&&(identical(other.validateFullArchiveOnOpen, validateFullArchiveOnOpen) || other.validateFullArchiveOnOpen == validateFullArchiveOnOpen));
}


@override
int get hashCode => Object.hash(runtimeType,maxDirectoryDepth,rootDirectoryWindowLength,maxDirectoryEncodedBytes,maxDirectoryDecodedBytes,maxCachedLeafDirectories,maxTileEncodedBytes,maxTileDecodedBytes,validateFullArchiveOnOpen);

@override
String toString() {
  return 'PmTilesV3Limits(maxDirectoryDepth: $maxDirectoryDepth, rootDirectoryWindowLength: $rootDirectoryWindowLength, maxDirectoryEncodedBytes: $maxDirectoryEncodedBytes, maxDirectoryDecodedBytes: $maxDirectoryDecodedBytes, maxCachedLeafDirectories: $maxCachedLeafDirectories, maxTileEncodedBytes: $maxTileEncodedBytes, maxTileDecodedBytes: $maxTileDecodedBytes, validateFullArchiveOnOpen: $validateFullArchiveOnOpen)';
}


}

/// @nodoc
abstract mixin class _$PmTilesV3LimitsCopyWith<$Res> implements $PmTilesV3LimitsCopyWith<$Res> {
  factory _$PmTilesV3LimitsCopyWith(_PmTilesV3Limits value, $Res Function(_PmTilesV3Limits) _then) = __$PmTilesV3LimitsCopyWithImpl;
@override @useResult
$Res call({
 int maxDirectoryDepth, int rootDirectoryWindowLength, int maxDirectoryEncodedBytes, int maxDirectoryDecodedBytes, int maxCachedLeafDirectories, int maxTileEncodedBytes, int maxTileDecodedBytes, bool validateFullArchiveOnOpen
});




}
/// @nodoc
class __$PmTilesV3LimitsCopyWithImpl<$Res>
    implements _$PmTilesV3LimitsCopyWith<$Res> {
  __$PmTilesV3LimitsCopyWithImpl(this._self, this._then);

  final _PmTilesV3Limits _self;
  final $Res Function(_PmTilesV3Limits) _then;

/// Create a copy of PmTilesV3Limits
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxDirectoryDepth = null,Object? rootDirectoryWindowLength = null,Object? maxDirectoryEncodedBytes = null,Object? maxDirectoryDecodedBytes = null,Object? maxCachedLeafDirectories = null,Object? maxTileEncodedBytes = null,Object? maxTileDecodedBytes = null,Object? validateFullArchiveOnOpen = null,}) {
  return _then(_PmTilesV3Limits(
maxDirectoryDepth: null == maxDirectoryDepth ? _self.maxDirectoryDepth : maxDirectoryDepth // ignore: cast_nullable_to_non_nullable
as int,rootDirectoryWindowLength: null == rootDirectoryWindowLength ? _self.rootDirectoryWindowLength : rootDirectoryWindowLength // ignore: cast_nullable_to_non_nullable
as int,maxDirectoryEncodedBytes: null == maxDirectoryEncodedBytes ? _self.maxDirectoryEncodedBytes : maxDirectoryEncodedBytes // ignore: cast_nullable_to_non_nullable
as int,maxDirectoryDecodedBytes: null == maxDirectoryDecodedBytes ? _self.maxDirectoryDecodedBytes : maxDirectoryDecodedBytes // ignore: cast_nullable_to_non_nullable
as int,maxCachedLeafDirectories: null == maxCachedLeafDirectories ? _self.maxCachedLeafDirectories : maxCachedLeafDirectories // ignore: cast_nullable_to_non_nullable
as int,maxTileEncodedBytes: null == maxTileEncodedBytes ? _self.maxTileEncodedBytes : maxTileEncodedBytes // ignore: cast_nullable_to_non_nullable
as int,maxTileDecodedBytes: null == maxTileDecodedBytes ? _self.maxTileDecodedBytes : maxTileDecodedBytes // ignore: cast_nullable_to_non_nullable
as int,validateFullArchiveOnOpen: null == validateFullArchiveOnOpen ? _self.validateFullArchiveOnOpen : validateFullArchiveOnOpen // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

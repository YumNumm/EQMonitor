// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fill_mesh_builder_limits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FillMeshBuilderLimits {

/// 1つのpolygon(1つの外形とその穴の組)に含められる穴数の上限。
/// MapLibre Nativeの`fill_generator.cpp`が`limitHoles(polygon, 500)`で
/// 行っている制限と同じ位置付け。
 int get maxHolesPerPolygon;/// 1つのfeatureが持つ全ring(外形+穴、複数polygon分の合算)の頂点数の
/// 上限。三角形化前の頂点バッファ確保量を抑える早期チェックとして働く。
 int get maxVerticesPerFeature;/// 1つの`FillMesh` segmentに積める頂点数の上限。index bufferが
/// `Uint16List`であるため、呼び出し側がこの値を65536以下に設定しない
/// 場合`FillMeshBuilder`はArgumentErrorを投げる(index値がuint16の範囲を
/// 静かに超えて壊れたmeshを生成することを避けるための防御)。
 int get maxVerticesPerSegment;/// 1 tile用に生成した`FillMeshBuilder`の全`build`呼び出しを通じて、
/// 境界交差候補の辺ペア比較と包含判定の辺比較に使える回数の合計上限。
/// decoderはtileごとにbuilderを1つ生成して全fill layerで共有する。
 int get maxIntersectionChecks;
/// Create a copy of FillMeshBuilderLimits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FillMeshBuilderLimitsCopyWith<FillMeshBuilderLimits> get copyWith => _$FillMeshBuilderLimitsCopyWithImpl<FillMeshBuilderLimits>(this as FillMeshBuilderLimits, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FillMeshBuilderLimits&&(identical(other.maxHolesPerPolygon, maxHolesPerPolygon) || other.maxHolesPerPolygon == maxHolesPerPolygon)&&(identical(other.maxVerticesPerFeature, maxVerticesPerFeature) || other.maxVerticesPerFeature == maxVerticesPerFeature)&&(identical(other.maxVerticesPerSegment, maxVerticesPerSegment) || other.maxVerticesPerSegment == maxVerticesPerSegment)&&(identical(other.maxIntersectionChecks, maxIntersectionChecks) || other.maxIntersectionChecks == maxIntersectionChecks));
}


@override
int get hashCode => Object.hash(runtimeType,maxHolesPerPolygon,maxVerticesPerFeature,maxVerticesPerSegment,maxIntersectionChecks);

@override
String toString() {
  return 'FillMeshBuilderLimits(maxHolesPerPolygon: $maxHolesPerPolygon, maxVerticesPerFeature: $maxVerticesPerFeature, maxVerticesPerSegment: $maxVerticesPerSegment, maxIntersectionChecks: $maxIntersectionChecks)';
}


}

/// @nodoc
abstract mixin class $FillMeshBuilderLimitsCopyWith<$Res>  {
  factory $FillMeshBuilderLimitsCopyWith(FillMeshBuilderLimits value, $Res Function(FillMeshBuilderLimits) _then) = _$FillMeshBuilderLimitsCopyWithImpl;
@useResult
$Res call({
 int maxHolesPerPolygon, int maxVerticesPerFeature, int maxVerticesPerSegment, int maxIntersectionChecks
});




}
/// @nodoc
class _$FillMeshBuilderLimitsCopyWithImpl<$Res>
    implements $FillMeshBuilderLimitsCopyWith<$Res> {
  _$FillMeshBuilderLimitsCopyWithImpl(this._self, this._then);

  final FillMeshBuilderLimits _self;
  final $Res Function(FillMeshBuilderLimits) _then;

/// Create a copy of FillMeshBuilderLimits
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxHolesPerPolygon = null,Object? maxVerticesPerFeature = null,Object? maxVerticesPerSegment = null,Object? maxIntersectionChecks = null,}) {
  return _then(FillMeshBuilderLimits(
maxHolesPerPolygon: null == maxHolesPerPolygon ? _self.maxHolesPerPolygon : maxHolesPerPolygon // ignore: cast_nullable_to_non_nullable
as int,maxVerticesPerFeature: null == maxVerticesPerFeature ? _self.maxVerticesPerFeature : maxVerticesPerFeature // ignore: cast_nullable_to_non_nullable
as int,maxVerticesPerSegment: null == maxVerticesPerSegment ? _self.maxVerticesPerSegment : maxVerticesPerSegment // ignore: cast_nullable_to_non_nullable
as int,maxIntersectionChecks: null == maxIntersectionChecks ? _self.maxIntersectionChecks : maxIntersectionChecks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FillMeshBuilderLimits].
extension FillMeshBuilderLimitsPatterns on FillMeshBuilderLimits {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FillMeshBuilderLimits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FillMeshBuilderLimits() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FillMeshBuilderLimits value)  $default,){
final _that = this;
switch (_that) {
case _FillMeshBuilderLimits():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FillMeshBuilderLimits value)?  $default,){
final _that = this;
switch (_that) {
case _FillMeshBuilderLimits() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxHolesPerPolygon,  int maxVerticesPerFeature,  int maxVerticesPerSegment,  int maxIntersectionChecks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FillMeshBuilderLimits() when $default != null:
return $default(_that.maxHolesPerPolygon,_that.maxVerticesPerFeature,_that.maxVerticesPerSegment,_that.maxIntersectionChecks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxHolesPerPolygon,  int maxVerticesPerFeature,  int maxVerticesPerSegment,  int maxIntersectionChecks)  $default,) {final _that = this;
switch (_that) {
case _FillMeshBuilderLimits():
return $default(_that.maxHolesPerPolygon,_that.maxVerticesPerFeature,_that.maxVerticesPerSegment,_that.maxIntersectionChecks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxHolesPerPolygon,  int maxVerticesPerFeature,  int maxVerticesPerSegment,  int maxIntersectionChecks)?  $default,) {final _that = this;
switch (_that) {
case _FillMeshBuilderLimits() when $default != null:
return $default(_that.maxHolesPerPolygon,_that.maxVerticesPerFeature,_that.maxVerticesPerSegment,_that.maxIntersectionChecks);case _:
  return null;

}
}

}

/// @nodoc


class _FillMeshBuilderLimits implements FillMeshBuilderLimits {
  const _FillMeshBuilderLimits({required this.maxHolesPerPolygon, required this.maxVerticesPerFeature, required this.maxVerticesPerSegment, required this.maxIntersectionChecks});
  

/// 1つのpolygon(1つの外形とその穴の組)に含められる穴数の上限。
/// MapLibre Nativeの`fill_generator.cpp`が`limitHoles(polygon, 500)`で
/// 行っている制限と同じ位置付け。
@override final  int maxHolesPerPolygon;
/// 1つのfeatureが持つ全ring(外形+穴、複数polygon分の合算)の頂点数の
/// 上限。三角形化前の頂点バッファ確保量を抑える早期チェックとして働く。
@override final  int maxVerticesPerFeature;
/// 1つの`FillMesh` segmentに積める頂点数の上限。index bufferが
/// `Uint16List`であるため、呼び出し側がこの値を65536以下に設定しない
/// 場合`FillMeshBuilder`はArgumentErrorを投げる(index値がuint16の範囲を
/// 静かに超えて壊れたmeshを生成することを避けるための防御)。
@override final  int maxVerticesPerSegment;
/// 1 tile用に生成した`FillMeshBuilder`の全`build`呼び出しを通じて、
/// 境界交差候補の辺ペア比較と包含判定の辺比較に使える回数の合計上限。
/// decoderはtileごとにbuilderを1つ生成して全fill layerで共有する。
@override final  int maxIntersectionChecks;

/// Create a copy of FillMeshBuilderLimits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FillMeshBuilderLimitsCopyWith<_FillMeshBuilderLimits> get copyWith => __$FillMeshBuilderLimitsCopyWithImpl<_FillMeshBuilderLimits>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FillMeshBuilderLimits&&(identical(other.maxHolesPerPolygon, maxHolesPerPolygon) || other.maxHolesPerPolygon == maxHolesPerPolygon)&&(identical(other.maxVerticesPerFeature, maxVerticesPerFeature) || other.maxVerticesPerFeature == maxVerticesPerFeature)&&(identical(other.maxVerticesPerSegment, maxVerticesPerSegment) || other.maxVerticesPerSegment == maxVerticesPerSegment)&&(identical(other.maxIntersectionChecks, maxIntersectionChecks) || other.maxIntersectionChecks == maxIntersectionChecks));
}


@override
int get hashCode => Object.hash(runtimeType,maxHolesPerPolygon,maxVerticesPerFeature,maxVerticesPerSegment,maxIntersectionChecks);

@override
String toString() {
  return 'FillMeshBuilderLimits(maxHolesPerPolygon: $maxHolesPerPolygon, maxVerticesPerFeature: $maxVerticesPerFeature, maxVerticesPerSegment: $maxVerticesPerSegment, maxIntersectionChecks: $maxIntersectionChecks)';
}


}

/// @nodoc
abstract mixin class _$FillMeshBuilderLimitsCopyWith<$Res> implements $FillMeshBuilderLimitsCopyWith<$Res> {
  factory _$FillMeshBuilderLimitsCopyWith(_FillMeshBuilderLimits value, $Res Function(_FillMeshBuilderLimits) _then) = __$FillMeshBuilderLimitsCopyWithImpl;
@override @useResult
$Res call({
 int maxHolesPerPolygon, int maxVerticesPerFeature, int maxVerticesPerSegment, int maxIntersectionChecks
});




}
/// @nodoc
class __$FillMeshBuilderLimitsCopyWithImpl<$Res>
    implements _$FillMeshBuilderLimitsCopyWith<$Res> {
  __$FillMeshBuilderLimitsCopyWithImpl(this._self, this._then);

  final _FillMeshBuilderLimits _self;
  final $Res Function(_FillMeshBuilderLimits) _then;

/// Create a copy of FillMeshBuilderLimits
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxHolesPerPolygon = null,Object? maxVerticesPerFeature = null,Object? maxVerticesPerSegment = null,Object? maxIntersectionChecks = null,}) {
  return _then(_FillMeshBuilderLimits(
maxHolesPerPolygon: null == maxHolesPerPolygon ? _self.maxHolesPerPolygon : maxHolesPerPolygon // ignore: cast_nullable_to_non_nullable
as int,maxVerticesPerFeature: null == maxVerticesPerFeature ? _self.maxVerticesPerFeature : maxVerticesPerFeature // ignore: cast_nullable_to_non_nullable
as int,maxVerticesPerSegment: null == maxVerticesPerSegment ? _self.maxVerticesPerSegment : maxVerticesPerSegment // ignore: cast_nullable_to_non_nullable
as int,maxIntersectionChecks: null == maxIntersectionChecks ? _self.maxIntersectionChecks : maxIntersectionChecks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

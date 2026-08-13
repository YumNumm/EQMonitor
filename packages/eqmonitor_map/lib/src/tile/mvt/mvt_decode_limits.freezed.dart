// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mvt_decode_limits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MvtDecodeLimits {

/// 1つのtileに含められるlayer数の上限。
 int get maxLayers;/// 1つのlayerに含められるfeature数の上限。
 int get maxFeaturesPerLayer;/// 1つのfeatureに含められるring(パーツ)数の上限。
 int get maxRingsPerFeature;/// 1つのringに含められる頂点数の上限。
 int get maxVerticesPerRing;/// 1つのfeatureのgeometry commandが繰り返す操作回数の総和の上限。
/// ring/頂点の上限はバッファへ積んだ後に効くのに対し、この上限は
/// 単一のcommand headerが巨大なcountを宣言した時点で、頂点を読み出す
/// 前に打ち切るための早期チェックとして働く。
 int get maxCommandsPerFeature;/// layer名のUTF-8 byte長の上限。length-delimitedフィールドの長さを
/// 読んだ直後、文字列本体を読み出す前に検証する。
 int get maxLayerNameBytes;
/// Create a copy of MvtDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MvtDecodeLimitsCopyWith<MvtDecodeLimits> get copyWith => _$MvtDecodeLimitsCopyWithImpl<MvtDecodeLimits>(this as MvtDecodeLimits, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MvtDecodeLimits&&(identical(other.maxLayers, maxLayers) || other.maxLayers == maxLayers)&&(identical(other.maxFeaturesPerLayer, maxFeaturesPerLayer) || other.maxFeaturesPerLayer == maxFeaturesPerLayer)&&(identical(other.maxRingsPerFeature, maxRingsPerFeature) || other.maxRingsPerFeature == maxRingsPerFeature)&&(identical(other.maxVerticesPerRing, maxVerticesPerRing) || other.maxVerticesPerRing == maxVerticesPerRing)&&(identical(other.maxCommandsPerFeature, maxCommandsPerFeature) || other.maxCommandsPerFeature == maxCommandsPerFeature)&&(identical(other.maxLayerNameBytes, maxLayerNameBytes) || other.maxLayerNameBytes == maxLayerNameBytes));
}


@override
int get hashCode => Object.hash(runtimeType,maxLayers,maxFeaturesPerLayer,maxRingsPerFeature,maxVerticesPerRing,maxCommandsPerFeature,maxLayerNameBytes);

@override
String toString() {
  return 'MvtDecodeLimits(maxLayers: $maxLayers, maxFeaturesPerLayer: $maxFeaturesPerLayer, maxRingsPerFeature: $maxRingsPerFeature, maxVerticesPerRing: $maxVerticesPerRing, maxCommandsPerFeature: $maxCommandsPerFeature, maxLayerNameBytes: $maxLayerNameBytes)';
}


}

/// @nodoc
abstract mixin class $MvtDecodeLimitsCopyWith<$Res>  {
  factory $MvtDecodeLimitsCopyWith(MvtDecodeLimits value, $Res Function(MvtDecodeLimits) _then) = _$MvtDecodeLimitsCopyWithImpl;
@useResult
$Res call({
 int maxLayers, int maxFeaturesPerLayer, int maxRingsPerFeature, int maxVerticesPerRing, int maxCommandsPerFeature, int maxLayerNameBytes
});




}
/// @nodoc
class _$MvtDecodeLimitsCopyWithImpl<$Res>
    implements $MvtDecodeLimitsCopyWith<$Res> {
  _$MvtDecodeLimitsCopyWithImpl(this._self, this._then);

  final MvtDecodeLimits _self;
  final $Res Function(MvtDecodeLimits) _then;

/// Create a copy of MvtDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxLayers = null,Object? maxFeaturesPerLayer = null,Object? maxRingsPerFeature = null,Object? maxVerticesPerRing = null,Object? maxCommandsPerFeature = null,Object? maxLayerNameBytes = null,}) {
  return _then(MvtDecodeLimits(
maxLayers: null == maxLayers ? _self.maxLayers : maxLayers // ignore: cast_nullable_to_non_nullable
as int,maxFeaturesPerLayer: null == maxFeaturesPerLayer ? _self.maxFeaturesPerLayer : maxFeaturesPerLayer // ignore: cast_nullable_to_non_nullable
as int,maxRingsPerFeature: null == maxRingsPerFeature ? _self.maxRingsPerFeature : maxRingsPerFeature // ignore: cast_nullable_to_non_nullable
as int,maxVerticesPerRing: null == maxVerticesPerRing ? _self.maxVerticesPerRing : maxVerticesPerRing // ignore: cast_nullable_to_non_nullable
as int,maxCommandsPerFeature: null == maxCommandsPerFeature ? _self.maxCommandsPerFeature : maxCommandsPerFeature // ignore: cast_nullable_to_non_nullable
as int,maxLayerNameBytes: null == maxLayerNameBytes ? _self.maxLayerNameBytes : maxLayerNameBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MvtDecodeLimits].
extension MvtDecodeLimitsPatterns on MvtDecodeLimits {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MvtDecodeLimits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MvtDecodeLimits() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MvtDecodeLimits value)  $default,){
final _that = this;
switch (_that) {
case _MvtDecodeLimits():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MvtDecodeLimits value)?  $default,){
final _that = this;
switch (_that) {
case _MvtDecodeLimits() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxLayers,  int maxFeaturesPerLayer,  int maxRingsPerFeature,  int maxVerticesPerRing,  int maxCommandsPerFeature,  int maxLayerNameBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MvtDecodeLimits() when $default != null:
return $default(_that.maxLayers,_that.maxFeaturesPerLayer,_that.maxRingsPerFeature,_that.maxVerticesPerRing,_that.maxCommandsPerFeature,_that.maxLayerNameBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxLayers,  int maxFeaturesPerLayer,  int maxRingsPerFeature,  int maxVerticesPerRing,  int maxCommandsPerFeature,  int maxLayerNameBytes)  $default,) {final _that = this;
switch (_that) {
case _MvtDecodeLimits():
return $default(_that.maxLayers,_that.maxFeaturesPerLayer,_that.maxRingsPerFeature,_that.maxVerticesPerRing,_that.maxCommandsPerFeature,_that.maxLayerNameBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxLayers,  int maxFeaturesPerLayer,  int maxRingsPerFeature,  int maxVerticesPerRing,  int maxCommandsPerFeature,  int maxLayerNameBytes)?  $default,) {final _that = this;
switch (_that) {
case _MvtDecodeLimits() when $default != null:
return $default(_that.maxLayers,_that.maxFeaturesPerLayer,_that.maxRingsPerFeature,_that.maxVerticesPerRing,_that.maxCommandsPerFeature,_that.maxLayerNameBytes);case _:
  return null;

}
}

}

/// @nodoc


class _MvtDecodeLimits implements MvtDecodeLimits {
  const _MvtDecodeLimits({required this.maxLayers, required this.maxFeaturesPerLayer, required this.maxRingsPerFeature, required this.maxVerticesPerRing, required this.maxCommandsPerFeature, required this.maxLayerNameBytes});
  

/// 1つのtileに含められるlayer数の上限。
@override final  int maxLayers;
/// 1つのlayerに含められるfeature数の上限。
@override final  int maxFeaturesPerLayer;
/// 1つのfeatureに含められるring(パーツ)数の上限。
@override final  int maxRingsPerFeature;
/// 1つのringに含められる頂点数の上限。
@override final  int maxVerticesPerRing;
/// 1つのfeatureのgeometry commandが繰り返す操作回数の総和の上限。
/// ring/頂点の上限はバッファへ積んだ後に効くのに対し、この上限は
/// 単一のcommand headerが巨大なcountを宣言した時点で、頂点を読み出す
/// 前に打ち切るための早期チェックとして働く。
@override final  int maxCommandsPerFeature;
/// layer名のUTF-8 byte長の上限。length-delimitedフィールドの長さを
/// 読んだ直後、文字列本体を読み出す前に検証する。
@override final  int maxLayerNameBytes;

/// Create a copy of MvtDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MvtDecodeLimitsCopyWith<_MvtDecodeLimits> get copyWith => __$MvtDecodeLimitsCopyWithImpl<_MvtDecodeLimits>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MvtDecodeLimits&&(identical(other.maxLayers, maxLayers) || other.maxLayers == maxLayers)&&(identical(other.maxFeaturesPerLayer, maxFeaturesPerLayer) || other.maxFeaturesPerLayer == maxFeaturesPerLayer)&&(identical(other.maxRingsPerFeature, maxRingsPerFeature) || other.maxRingsPerFeature == maxRingsPerFeature)&&(identical(other.maxVerticesPerRing, maxVerticesPerRing) || other.maxVerticesPerRing == maxVerticesPerRing)&&(identical(other.maxCommandsPerFeature, maxCommandsPerFeature) || other.maxCommandsPerFeature == maxCommandsPerFeature)&&(identical(other.maxLayerNameBytes, maxLayerNameBytes) || other.maxLayerNameBytes == maxLayerNameBytes));
}


@override
int get hashCode => Object.hash(runtimeType,maxLayers,maxFeaturesPerLayer,maxRingsPerFeature,maxVerticesPerRing,maxCommandsPerFeature,maxLayerNameBytes);

@override
String toString() {
  return 'MvtDecodeLimits(maxLayers: $maxLayers, maxFeaturesPerLayer: $maxFeaturesPerLayer, maxRingsPerFeature: $maxRingsPerFeature, maxVerticesPerRing: $maxVerticesPerRing, maxCommandsPerFeature: $maxCommandsPerFeature, maxLayerNameBytes: $maxLayerNameBytes)';
}


}

/// @nodoc
abstract mixin class _$MvtDecodeLimitsCopyWith<$Res> implements $MvtDecodeLimitsCopyWith<$Res> {
  factory _$MvtDecodeLimitsCopyWith(_MvtDecodeLimits value, $Res Function(_MvtDecodeLimits) _then) = __$MvtDecodeLimitsCopyWithImpl;
@override @useResult
$Res call({
 int maxLayers, int maxFeaturesPerLayer, int maxRingsPerFeature, int maxVerticesPerRing, int maxCommandsPerFeature, int maxLayerNameBytes
});




}
/// @nodoc
class __$MvtDecodeLimitsCopyWithImpl<$Res>
    implements _$MvtDecodeLimitsCopyWith<$Res> {
  __$MvtDecodeLimitsCopyWithImpl(this._self, this._then);

  final _MvtDecodeLimits _self;
  final $Res Function(_MvtDecodeLimits) _then;

/// Create a copy of MvtDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxLayers = null,Object? maxFeaturesPerLayer = null,Object? maxRingsPerFeature = null,Object? maxVerticesPerRing = null,Object? maxCommandsPerFeature = null,Object? maxLayerNameBytes = null,}) {
  return _then(_MvtDecodeLimits(
maxLayers: null == maxLayers ? _self.maxLayers : maxLayers // ignore: cast_nullable_to_non_nullable
as int,maxFeaturesPerLayer: null == maxFeaturesPerLayer ? _self.maxFeaturesPerLayer : maxFeaturesPerLayer // ignore: cast_nullable_to_non_nullable
as int,maxRingsPerFeature: null == maxRingsPerFeature ? _self.maxRingsPerFeature : maxRingsPerFeature // ignore: cast_nullable_to_non_nullable
as int,maxVerticesPerRing: null == maxVerticesPerRing ? _self.maxVerticesPerRing : maxVerticesPerRing // ignore: cast_nullable_to_non_nullable
as int,maxCommandsPerFeature: null == maxCommandsPerFeature ? _self.maxCommandsPerFeature : maxCommandsPerFeature // ignore: cast_nullable_to_non_nullable
as int,maxLayerNameBytes: null == maxLayerNameBytes ? _self.maxLayerNameBytes : maxLayerNameBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

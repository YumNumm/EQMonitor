// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_pmtiles_decode_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeismicityPmTilesDecodeProgress {

 int get decodedTileCount; int get rawFeatureCount; int get uniqueFeatureCount;
/// Create a copy of SeismicityPmTilesDecodeProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityPmTilesDecodeProgressCopyWith<SeismicityPmTilesDecodeProgress> get copyWith => _$SeismicityPmTilesDecodeProgressCopyWithImpl<SeismicityPmTilesDecodeProgress>(this as SeismicityPmTilesDecodeProgress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesDecodeProgress&&(identical(other.decodedTileCount, decodedTileCount) || other.decodedTileCount == decodedTileCount)&&(identical(other.rawFeatureCount, rawFeatureCount) || other.rawFeatureCount == rawFeatureCount)&&(identical(other.uniqueFeatureCount, uniqueFeatureCount) || other.uniqueFeatureCount == uniqueFeatureCount));
}


@override
int get hashCode => Object.hash(runtimeType,decodedTileCount,rawFeatureCount,uniqueFeatureCount);

@override
String toString() {
  return 'SeismicityPmTilesDecodeProgress(decodedTileCount: $decodedTileCount, rawFeatureCount: $rawFeatureCount, uniqueFeatureCount: $uniqueFeatureCount)';
}


}

/// @nodoc
abstract mixin class $SeismicityPmTilesDecodeProgressCopyWith<$Res>  {
  factory $SeismicityPmTilesDecodeProgressCopyWith(SeismicityPmTilesDecodeProgress value, $Res Function(SeismicityPmTilesDecodeProgress) _then) = _$SeismicityPmTilesDecodeProgressCopyWithImpl;
@useResult
$Res call({
 int decodedTileCount, int rawFeatureCount, int uniqueFeatureCount
});




}
/// @nodoc
class _$SeismicityPmTilesDecodeProgressCopyWithImpl<$Res>
    implements $SeismicityPmTilesDecodeProgressCopyWith<$Res> {
  _$SeismicityPmTilesDecodeProgressCopyWithImpl(this._self, this._then);

  final SeismicityPmTilesDecodeProgress _self;
  final $Res Function(SeismicityPmTilesDecodeProgress) _then;

/// Create a copy of SeismicityPmTilesDecodeProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? decodedTileCount = null,Object? rawFeatureCount = null,Object? uniqueFeatureCount = null,}) {
  return _then(_self.copyWith(
decodedTileCount: null == decodedTileCount ? _self.decodedTileCount : decodedTileCount // ignore: cast_nullable_to_non_nullable
as int,rawFeatureCount: null == rawFeatureCount ? _self.rawFeatureCount : rawFeatureCount // ignore: cast_nullable_to_non_nullable
as int,uniqueFeatureCount: null == uniqueFeatureCount ? _self.uniqueFeatureCount : uniqueFeatureCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityPmTilesDecodeProgress].
extension SeismicityPmTilesDecodeProgressPatterns on SeismicityPmTilesDecodeProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityPmTilesDecodeProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityPmTilesDecodeProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityPmTilesDecodeProgress value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityPmTilesDecodeProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityPmTilesDecodeProgress value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityPmTilesDecodeProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int decodedTileCount,  int rawFeatureCount,  int uniqueFeatureCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityPmTilesDecodeProgress() when $default != null:
return $default(_that.decodedTileCount,_that.rawFeatureCount,_that.uniqueFeatureCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int decodedTileCount,  int rawFeatureCount,  int uniqueFeatureCount)  $default,) {final _that = this;
switch (_that) {
case _SeismicityPmTilesDecodeProgress():
return $default(_that.decodedTileCount,_that.rawFeatureCount,_that.uniqueFeatureCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int decodedTileCount,  int rawFeatureCount,  int uniqueFeatureCount)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityPmTilesDecodeProgress() when $default != null:
return $default(_that.decodedTileCount,_that.rawFeatureCount,_that.uniqueFeatureCount);case _:
  return null;

}
}

}

/// @nodoc


class _SeismicityPmTilesDecodeProgress implements SeismicityPmTilesDecodeProgress {
  const _SeismicityPmTilesDecodeProgress({required this.decodedTileCount, required this.rawFeatureCount, required this.uniqueFeatureCount});


@override final  int decodedTileCount;
@override final  int rawFeatureCount;
@override final  int uniqueFeatureCount;

/// Create a copy of SeismicityPmTilesDecodeProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityPmTilesDecodeProgressCopyWith<_SeismicityPmTilesDecodeProgress> get copyWith => __$SeismicityPmTilesDecodeProgressCopyWithImpl<_SeismicityPmTilesDecodeProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicityPmTilesDecodeProgress&&(identical(other.decodedTileCount, decodedTileCount) || other.decodedTileCount == decodedTileCount)&&(identical(other.rawFeatureCount, rawFeatureCount) || other.rawFeatureCount == rawFeatureCount)&&(identical(other.uniqueFeatureCount, uniqueFeatureCount) || other.uniqueFeatureCount == uniqueFeatureCount));
}


@override
int get hashCode => Object.hash(runtimeType,decodedTileCount,rawFeatureCount,uniqueFeatureCount);

@override
String toString() {
  return 'SeismicityPmTilesDecodeProgress(decodedTileCount: $decodedTileCount, rawFeatureCount: $rawFeatureCount, uniqueFeatureCount: $uniqueFeatureCount)';
}


}

/// @nodoc
abstract mixin class _$SeismicityPmTilesDecodeProgressCopyWith<$Res> implements $SeismicityPmTilesDecodeProgressCopyWith<$Res> {
  factory _$SeismicityPmTilesDecodeProgressCopyWith(_SeismicityPmTilesDecodeProgress value, $Res Function(_SeismicityPmTilesDecodeProgress) _then) = __$SeismicityPmTilesDecodeProgressCopyWithImpl;
@override @useResult
$Res call({
 int decodedTileCount, int rawFeatureCount, int uniqueFeatureCount
});




}
/// @nodoc
class __$SeismicityPmTilesDecodeProgressCopyWithImpl<$Res>
    implements _$SeismicityPmTilesDecodeProgressCopyWith<$Res> {
  __$SeismicityPmTilesDecodeProgressCopyWithImpl(this._self, this._then);

  final _SeismicityPmTilesDecodeProgress _self;
  final $Res Function(_SeismicityPmTilesDecodeProgress) _then;

/// Create a copy of SeismicityPmTilesDecodeProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? decodedTileCount = null,Object? rawFeatureCount = null,Object? uniqueFeatureCount = null,}) {
  return _then(_SeismicityPmTilesDecodeProgress(
decodedTileCount: null == decodedTileCount ? _self.decodedTileCount : decodedTileCount // ignore: cast_nullable_to_non_nullable
as int,rawFeatureCount: null == rawFeatureCount ? _self.rawFeatureCount : rawFeatureCount // ignore: cast_nullable_to_non_nullable
as int,uniqueFeatureCount: null == uniqueFeatureCount ? _self.uniqueFeatureCount : uniqueFeatureCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pmtiles_v3_limits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PmTilesV3Limits {

/// directory treeを辿る最大深さ。3を超えるarchiveは corrupt として拒否する。
 int get maxDirectoryDepth;/// root directoryが収まっているべき先頭からのwindow長（byte）。
 int get rootDirectoryWindowLength;
/// Create a copy of PmTilesV3Limits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PmTilesV3LimitsCopyWith<PmTilesV3Limits> get copyWith => _$PmTilesV3LimitsCopyWithImpl<PmTilesV3Limits>(this as PmTilesV3Limits, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PmTilesV3Limits&&(identical(other.maxDirectoryDepth, maxDirectoryDepth) || other.maxDirectoryDepth == maxDirectoryDepth)&&(identical(other.rootDirectoryWindowLength, rootDirectoryWindowLength) || other.rootDirectoryWindowLength == rootDirectoryWindowLength));
}


@override
int get hashCode => Object.hash(runtimeType,maxDirectoryDepth,rootDirectoryWindowLength);

@override
String toString() {
  return 'PmTilesV3Limits(maxDirectoryDepth: $maxDirectoryDepth, rootDirectoryWindowLength: $rootDirectoryWindowLength)';
}


}

/// @nodoc
abstract mixin class $PmTilesV3LimitsCopyWith<$Res>  {
  factory $PmTilesV3LimitsCopyWith(PmTilesV3Limits value, $Res Function(PmTilesV3Limits) _then) = _$PmTilesV3LimitsCopyWithImpl;
@useResult
$Res call({
 int maxDirectoryDepth, int rootDirectoryWindowLength
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
@pragma('vm:prefer-inline') @override $Res call({Object? maxDirectoryDepth = null,Object? rootDirectoryWindowLength = null,}) {
  return _then(_self.copyWith(
maxDirectoryDepth: null == maxDirectoryDepth ? _self.maxDirectoryDepth : maxDirectoryDepth // ignore: cast_nullable_to_non_nullable
as int,rootDirectoryWindowLength: null == rootDirectoryWindowLength ? _self.rootDirectoryWindowLength : rootDirectoryWindowLength // ignore: cast_nullable_to_non_nullable
as int,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxDirectoryDepth,  int rootDirectoryWindowLength)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PmTilesV3Limits() when $default != null:
return $default(_that.maxDirectoryDepth,_that.rootDirectoryWindowLength);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxDirectoryDepth,  int rootDirectoryWindowLength)  $default,) {final _that = this;
switch (_that) {
case _PmTilesV3Limits():
return $default(_that.maxDirectoryDepth,_that.rootDirectoryWindowLength);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxDirectoryDepth,  int rootDirectoryWindowLength)?  $default,) {final _that = this;
switch (_that) {
case _PmTilesV3Limits() when $default != null:
return $default(_that.maxDirectoryDepth,_that.rootDirectoryWindowLength);case _:
  return null;

}
}

}

/// @nodoc


class _PmTilesV3Limits implements PmTilesV3Limits {
  const _PmTilesV3Limits({required this.maxDirectoryDepth, required this.rootDirectoryWindowLength});
  

/// directory treeを辿る最大深さ。3を超えるarchiveは corrupt として拒否する。
@override final  int maxDirectoryDepth;
/// root directoryが収まっているべき先頭からのwindow長（byte）。
@override final  int rootDirectoryWindowLength;

/// Create a copy of PmTilesV3Limits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PmTilesV3LimitsCopyWith<_PmTilesV3Limits> get copyWith => __$PmTilesV3LimitsCopyWithImpl<_PmTilesV3Limits>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PmTilesV3Limits&&(identical(other.maxDirectoryDepth, maxDirectoryDepth) || other.maxDirectoryDepth == maxDirectoryDepth)&&(identical(other.rootDirectoryWindowLength, rootDirectoryWindowLength) || other.rootDirectoryWindowLength == rootDirectoryWindowLength));
}


@override
int get hashCode => Object.hash(runtimeType,maxDirectoryDepth,rootDirectoryWindowLength);

@override
String toString() {
  return 'PmTilesV3Limits(maxDirectoryDepth: $maxDirectoryDepth, rootDirectoryWindowLength: $rootDirectoryWindowLength)';
}


}

/// @nodoc
abstract mixin class _$PmTilesV3LimitsCopyWith<$Res> implements $PmTilesV3LimitsCopyWith<$Res> {
  factory _$PmTilesV3LimitsCopyWith(_PmTilesV3Limits value, $Res Function(_PmTilesV3Limits) _then) = __$PmTilesV3LimitsCopyWithImpl;
@override @useResult
$Res call({
 int maxDirectoryDepth, int rootDirectoryWindowLength
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
@override @pragma('vm:prefer-inline') $Res call({Object? maxDirectoryDepth = null,Object? rootDirectoryWindowLength = null,}) {
  return _then(_PmTilesV3Limits(
maxDirectoryDepth: null == maxDirectoryDepth ? _self.maxDirectoryDepth : maxDirectoryDepth // ignore: cast_nullable_to_non_nullable
as int,rootDirectoryWindowLength: null == rootDirectoryWindowLength ? _self.rootDirectoryWindowLength : rootDirectoryWindowLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

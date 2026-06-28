// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_earthquake_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NearbyEarthquakeParameter {

/// 緯度オフセット (度): ±この値の範囲を検索
 double get latitudeOffset;/// 経度オフセット (度): ±この値の範囲を検索
 double get longitudeOffset;/// 深さオフセット (km): ±この値の範囲を検索
 int get depthOffset;
/// Create a copy of NearbyEarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbyEarthquakeParameterCopyWith<NearbyEarthquakeParameter> get copyWith => _$NearbyEarthquakeParameterCopyWithImpl<NearbyEarthquakeParameter>(this as NearbyEarthquakeParameter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbyEarthquakeParameter&&(identical(other.latitudeOffset, latitudeOffset) || other.latitudeOffset == latitudeOffset)&&(identical(other.longitudeOffset, longitudeOffset) || other.longitudeOffset == longitudeOffset)&&(identical(other.depthOffset, depthOffset) || other.depthOffset == depthOffset));
}


@override
int get hashCode => Object.hash(runtimeType,latitudeOffset,longitudeOffset,depthOffset);

@override
String toString() {
  return 'NearbyEarthquakeParameter(latitudeOffset: $latitudeOffset, longitudeOffset: $longitudeOffset, depthOffset: $depthOffset)';
}


}

/// @nodoc
abstract mixin class $NearbyEarthquakeParameterCopyWith<$Res>  {
  factory $NearbyEarthquakeParameterCopyWith(NearbyEarthquakeParameter value, $Res Function(NearbyEarthquakeParameter) _then) = _$NearbyEarthquakeParameterCopyWithImpl;
@useResult
$Res call({
 double latitudeOffset, double longitudeOffset, int depthOffset
});




}
/// @nodoc
class _$NearbyEarthquakeParameterCopyWithImpl<$Res>
    implements $NearbyEarthquakeParameterCopyWith<$Res> {
  _$NearbyEarthquakeParameterCopyWithImpl(this._self, this._then);

  final NearbyEarthquakeParameter _self;
  final $Res Function(NearbyEarthquakeParameter) _then;

/// Create a copy of NearbyEarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitudeOffset = null,Object? longitudeOffset = null,Object? depthOffset = null,}) {
  return _then(_self.copyWith(
latitudeOffset: null == latitudeOffset ? _self.latitudeOffset : latitudeOffset // ignore: cast_nullable_to_non_nullable
as double,longitudeOffset: null == longitudeOffset ? _self.longitudeOffset : longitudeOffset // ignore: cast_nullable_to_non_nullable
as double,depthOffset: null == depthOffset ? _self.depthOffset : depthOffset // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NearbyEarthquakeParameter].
extension NearbyEarthquakeParameterPatterns on NearbyEarthquakeParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbyEarthquakeParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbyEarthquakeParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbyEarthquakeParameter value)  $default,){
final _that = this;
switch (_that) {
case _NearbyEarthquakeParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbyEarthquakeParameter value)?  $default,){
final _that = this;
switch (_that) {
case _NearbyEarthquakeParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitudeOffset,  double longitudeOffset,  int depthOffset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbyEarthquakeParameter() when $default != null:
return $default(_that.latitudeOffset,_that.longitudeOffset,_that.depthOffset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitudeOffset,  double longitudeOffset,  int depthOffset)  $default,) {final _that = this;
switch (_that) {
case _NearbyEarthquakeParameter():
return $default(_that.latitudeOffset,_that.longitudeOffset,_that.depthOffset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitudeOffset,  double longitudeOffset,  int depthOffset)?  $default,) {final _that = this;
switch (_that) {
case _NearbyEarthquakeParameter() when $default != null:
return $default(_that.latitudeOffset,_that.longitudeOffset,_that.depthOffset);case _:
  return null;

}
}

}

/// @nodoc


class _NearbyEarthquakeParameter implements NearbyEarthquakeParameter {
  const _NearbyEarthquakeParameter({this.latitudeOffset = 0.5, this.longitudeOffset = 0.5, this.depthOffset = 50});
  

/// 緯度オフセット (度): ±この値の範囲を検索
@override@JsonKey() final  double latitudeOffset;
/// 経度オフセット (度): ±この値の範囲を検索
@override@JsonKey() final  double longitudeOffset;
/// 深さオフセット (km): ±この値の範囲を検索
@override@JsonKey() final  int depthOffset;

/// Create a copy of NearbyEarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbyEarthquakeParameterCopyWith<_NearbyEarthquakeParameter> get copyWith => __$NearbyEarthquakeParameterCopyWithImpl<_NearbyEarthquakeParameter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbyEarthquakeParameter&&(identical(other.latitudeOffset, latitudeOffset) || other.latitudeOffset == latitudeOffset)&&(identical(other.longitudeOffset, longitudeOffset) || other.longitudeOffset == longitudeOffset)&&(identical(other.depthOffset, depthOffset) || other.depthOffset == depthOffset));
}


@override
int get hashCode => Object.hash(runtimeType,latitudeOffset,longitudeOffset,depthOffset);

@override
String toString() {
  return 'NearbyEarthquakeParameter(latitudeOffset: $latitudeOffset, longitudeOffset: $longitudeOffset, depthOffset: $depthOffset)';
}


}

/// @nodoc
abstract mixin class _$NearbyEarthquakeParameterCopyWith<$Res> implements $NearbyEarthquakeParameterCopyWith<$Res> {
  factory _$NearbyEarthquakeParameterCopyWith(_NearbyEarthquakeParameter value, $Res Function(_NearbyEarthquakeParameter) _then) = __$NearbyEarthquakeParameterCopyWithImpl;
@override @useResult
$Res call({
 double latitudeOffset, double longitudeOffset, int depthOffset
});




}
/// @nodoc
class __$NearbyEarthquakeParameterCopyWithImpl<$Res>
    implements _$NearbyEarthquakeParameterCopyWith<$Res> {
  __$NearbyEarthquakeParameterCopyWithImpl(this._self, this._then);

  final _NearbyEarthquakeParameter _self;
  final $Res Function(_NearbyEarthquakeParameter) _then;

/// Create a copy of NearbyEarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitudeOffset = null,Object? longitudeOffset = null,Object? depthOffset = null,}) {
  return _then(_NearbyEarthquakeParameter(
latitudeOffset: null == latitudeOffset ? _self.latitudeOffset : latitudeOffset // ignore: cast_nullable_to_non_nullable
as double,longitudeOffset: null == longitudeOffset ? _self.longitudeOffset : longitudeOffset // ignore: cast_nullable_to_non_nullable
as double,depthOffset: null == depthOffset ? _self.depthOffset : depthOffset // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

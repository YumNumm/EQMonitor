// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parameter_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParameterLocation {

 num get latitude; num get longitude;
/// Create a copy of ParameterLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParameterLocationCopyWith<ParameterLocation> get copyWith => _$ParameterLocationCopyWithImpl<ParameterLocation>(this as ParameterLocation, _$identity);

  /// Serializes this ParameterLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'ParameterLocation(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $ParameterLocationCopyWith<$Res>  {
  factory $ParameterLocationCopyWith(ParameterLocation value, $Res Function(ParameterLocation) _then) = _$ParameterLocationCopyWithImpl;
@useResult
$Res call({
 num latitude, num longitude
});




}
/// @nodoc
class _$ParameterLocationCopyWithImpl<$Res>
    implements $ParameterLocationCopyWith<$Res> {
  _$ParameterLocationCopyWithImpl(this._self, this._then);

  final ParameterLocation _self;
  final $Res Function(ParameterLocation) _then;

/// Create a copy of ParameterLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(ParameterLocation(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [ParameterLocation].
extension ParameterLocationPatterns on ParameterLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParameterLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParameterLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParameterLocation value)  $default,){
final _that = this;
switch (_that) {
case _ParameterLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParameterLocation value)?  $default,){
final _that = this;
switch (_that) {
case _ParameterLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num latitude,  num longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParameterLocation() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num latitude,  num longitude)  $default,) {final _that = this;
switch (_that) {
case _ParameterLocation():
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num latitude,  num longitude)?  $default,) {final _that = this;
switch (_that) {
case _ParameterLocation() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParameterLocation implements ParameterLocation {
  const _ParameterLocation({required this.latitude, required this.longitude});
  factory _ParameterLocation.fromJson(Map<String, dynamic> json) => _$ParameterLocationFromJson(json);

@override final  num latitude;
@override final  num longitude;

/// Create a copy of ParameterLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParameterLocationCopyWith<_ParameterLocation> get copyWith => __$ParameterLocationCopyWithImpl<_ParameterLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParameterLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParameterLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'ParameterLocation(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$ParameterLocationCopyWith<$Res> implements $ParameterLocationCopyWith<$Res> {
  factory _$ParameterLocationCopyWith(_ParameterLocation value, $Res Function(_ParameterLocation) _then) = __$ParameterLocationCopyWithImpl;
@override @useResult
$Res call({
 num latitude, num longitude
});




}
/// @nodoc
class __$ParameterLocationCopyWithImpl<$Res>
    implements _$ParameterLocationCopyWith<$Res> {
  __$ParameterLocationCopyWithImpl(this._self, this._then);

  final _ParameterLocation _self;
  final $Res Function(_ParameterLocation) _then;

/// Create a copy of ParameterLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_ParameterLocation(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on

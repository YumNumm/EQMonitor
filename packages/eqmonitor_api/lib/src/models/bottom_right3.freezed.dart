// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_right3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BottomRight3 {

 num get latitude; num get longitude;
/// Create a copy of BottomRight3
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BottomRight3CopyWith<BottomRight3> get copyWith => _$BottomRight3CopyWithImpl<BottomRight3>(this as BottomRight3, _$identity);

  /// Serializes this BottomRight3 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BottomRight3&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'BottomRight3(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $BottomRight3CopyWith<$Res>  {
  factory $BottomRight3CopyWith(BottomRight3 value, $Res Function(BottomRight3) _then) = _$BottomRight3CopyWithImpl;
@useResult
$Res call({
 num latitude, num longitude
});




}
/// @nodoc
class _$BottomRight3CopyWithImpl<$Res>
    implements $BottomRight3CopyWith<$Res> {
  _$BottomRight3CopyWithImpl(this._self, this._then);

  final BottomRight3 _self;
  final $Res Function(BottomRight3) _then;

/// Create a copy of BottomRight3
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [BottomRight3].
extension BottomRight3Patterns on BottomRight3 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BottomRight3 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BottomRight3() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BottomRight3 value)  $default,){
final _that = this;
switch (_that) {
case _BottomRight3():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BottomRight3 value)?  $default,){
final _that = this;
switch (_that) {
case _BottomRight3() when $default != null:
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
case _BottomRight3() when $default != null:
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
case _BottomRight3():
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
case _BottomRight3() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BottomRight3 implements BottomRight3 {
  const _BottomRight3({required this.latitude, required this.longitude});
  factory _BottomRight3.fromJson(Map<String, dynamic> json) => _$BottomRight3FromJson(json);

@override final  num latitude;
@override final  num longitude;

/// Create a copy of BottomRight3
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BottomRight3CopyWith<_BottomRight3> get copyWith => __$BottomRight3CopyWithImpl<_BottomRight3>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BottomRight3ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BottomRight3&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'BottomRight3(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$BottomRight3CopyWith<$Res> implements $BottomRight3CopyWith<$Res> {
  factory _$BottomRight3CopyWith(_BottomRight3 value, $Res Function(_BottomRight3) _then) = __$BottomRight3CopyWithImpl;
@override @useResult
$Res call({
 num latitude, num longitude
});




}
/// @nodoc
class __$BottomRight3CopyWithImpl<$Res>
    implements _$BottomRight3CopyWith<$Res> {
  __$BottomRight3CopyWithImpl(this._self, this._then);

  final _BottomRight3 _self;
  final $Res Function(_BottomRight3) _then;

/// Create a copy of BottomRight3
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_BottomRight3(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on

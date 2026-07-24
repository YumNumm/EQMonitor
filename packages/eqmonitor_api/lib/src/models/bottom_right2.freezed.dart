// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_right2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BottomRight2 {

 num get latitude; num get longitude;
/// Create a copy of BottomRight2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BottomRight2CopyWith<BottomRight2> get copyWith => _$BottomRight2CopyWithImpl<BottomRight2>(this as BottomRight2, _$identity);

  /// Serializes this BottomRight2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BottomRight2&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'BottomRight2(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $BottomRight2CopyWith<$Res>  {
  factory $BottomRight2CopyWith(BottomRight2 value, $Res Function(BottomRight2) _then) = _$BottomRight2CopyWithImpl;
@useResult
$Res call({
 num latitude, num longitude
});




}
/// @nodoc
class _$BottomRight2CopyWithImpl<$Res>
    implements $BottomRight2CopyWith<$Res> {
  _$BottomRight2CopyWithImpl(this._self, this._then);

  final BottomRight2 _self;
  final $Res Function(BottomRight2) _then;

/// Create a copy of BottomRight2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [BottomRight2].
extension BottomRight2Patterns on BottomRight2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BottomRight2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BottomRight2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BottomRight2 value)  $default,){
final _that = this;
switch (_that) {
case _BottomRight2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BottomRight2 value)?  $default,){
final _that = this;
switch (_that) {
case _BottomRight2() when $default != null:
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
case _BottomRight2() when $default != null:
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
case _BottomRight2():
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
case _BottomRight2() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BottomRight2 implements BottomRight2 {
  const _BottomRight2({required this.latitude, required this.longitude});
  factory _BottomRight2.fromJson(Map<String, dynamic> json) => _$BottomRight2FromJson(json);

@override final  num latitude;
@override final  num longitude;

/// Create a copy of BottomRight2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BottomRight2CopyWith<_BottomRight2> get copyWith => __$BottomRight2CopyWithImpl<_BottomRight2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BottomRight2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BottomRight2&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'BottomRight2(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$BottomRight2CopyWith<$Res> implements $BottomRight2CopyWith<$Res> {
  factory _$BottomRight2CopyWith(_BottomRight2 value, $Res Function(_BottomRight2) _then) = __$BottomRight2CopyWithImpl;
@override @useResult
$Res call({
 num latitude, num longitude
});




}
/// @nodoc
class __$BottomRight2CopyWithImpl<$Res>
    implements _$BottomRight2CopyWith<$Res> {
  __$BottomRight2CopyWithImpl(this._self, this._then);

  final _BottomRight2 _self;
  final $Res Function(_BottomRight2) _then;

/// Create a copy of BottomRight2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_BottomRight2(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on

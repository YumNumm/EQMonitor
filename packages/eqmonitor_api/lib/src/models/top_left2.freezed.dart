// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top_left2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TopLeft2 {

 num get latitude; num get longitude;
/// Create a copy of TopLeft2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopLeft2CopyWith<TopLeft2> get copyWith => _$TopLeft2CopyWithImpl<TopLeft2>(this as TopLeft2, _$identity);

  /// Serializes this TopLeft2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopLeft2&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'TopLeft2(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $TopLeft2CopyWith<$Res>  {
  factory $TopLeft2CopyWith(TopLeft2 value, $Res Function(TopLeft2) _then) = _$TopLeft2CopyWithImpl;
@useResult
$Res call({
 num latitude, num longitude
});




}
/// @nodoc
class _$TopLeft2CopyWithImpl<$Res>
    implements $TopLeft2CopyWith<$Res> {
  _$TopLeft2CopyWithImpl(this._self, this._then);

  final TopLeft2 _self;
  final $Res Function(TopLeft2) _then;

/// Create a copy of TopLeft2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [TopLeft2].
extension TopLeft2Patterns on TopLeft2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopLeft2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopLeft2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopLeft2 value)  $default,){
final _that = this;
switch (_that) {
case _TopLeft2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopLeft2 value)?  $default,){
final _that = this;
switch (_that) {
case _TopLeft2() when $default != null:
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
case _TopLeft2() when $default != null:
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
case _TopLeft2():
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
case _TopLeft2() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopLeft2 implements TopLeft2 {
  const _TopLeft2({required this.latitude, required this.longitude});
  factory _TopLeft2.fromJson(Map<String, dynamic> json) => _$TopLeft2FromJson(json);

@override final  num latitude;
@override final  num longitude;

/// Create a copy of TopLeft2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopLeft2CopyWith<_TopLeft2> get copyWith => __$TopLeft2CopyWithImpl<_TopLeft2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopLeft2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopLeft2&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'TopLeft2(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$TopLeft2CopyWith<$Res> implements $TopLeft2CopyWith<$Res> {
  factory _$TopLeft2CopyWith(_TopLeft2 value, $Res Function(_TopLeft2) _then) = __$TopLeft2CopyWithImpl;
@override @useResult
$Res call({
 num latitude, num longitude
});




}
/// @nodoc
class __$TopLeft2CopyWithImpl<$Res>
    implements _$TopLeft2CopyWith<$Res> {
  __$TopLeft2CopyWithImpl(this._self, this._then);

  final _TopLeft2 _self;
  final $Res Function(_TopLeft2) _then;

/// Create a copy of TopLeft2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_TopLeft2(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parameter_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParameterPoint {

 num get x; num get y;
/// Create a copy of ParameterPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParameterPointCopyWith<ParameterPoint> get copyWith => _$ParameterPointCopyWithImpl<ParameterPoint>(this as ParameterPoint, _$identity);

  /// Serializes this ParameterPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterPoint&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'ParameterPoint(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $ParameterPointCopyWith<$Res>  {
  factory $ParameterPointCopyWith(ParameterPoint value, $Res Function(ParameterPoint) _then) = _$ParameterPointCopyWithImpl;
@useResult
$Res call({
 num x, num y
});




}
/// @nodoc
class _$ParameterPointCopyWithImpl<$Res>
    implements $ParameterPointCopyWith<$Res> {
  _$ParameterPointCopyWithImpl(this._self, this._then);

  final ParameterPoint _self;
  final $Res Function(ParameterPoint) _then;

/// Create a copy of ParameterPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,}) {
  return _then(ParameterPoint(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as num,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [ParameterPoint].
extension ParameterPointPatterns on ParameterPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParameterPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParameterPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParameterPoint value)  $default,){
final _that = this;
switch (_that) {
case _ParameterPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParameterPoint value)?  $default,){
final _that = this;
switch (_that) {
case _ParameterPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num x,  num y)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParameterPoint() when $default != null:
return $default(_that.x,_that.y);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num x,  num y)  $default,) {final _that = this;
switch (_that) {
case _ParameterPoint():
return $default(_that.x,_that.y);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num x,  num y)?  $default,) {final _that = this;
switch (_that) {
case _ParameterPoint() when $default != null:
return $default(_that.x,_that.y);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParameterPoint implements ParameterPoint {
  const _ParameterPoint({required this.x, required this.y});
  factory _ParameterPoint.fromJson(Map<String, dynamic> json) => _$ParameterPointFromJson(json);

@override final  num x;
@override final  num y;

/// Create a copy of ParameterPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParameterPointCopyWith<_ParameterPoint> get copyWith => __$ParameterPointCopyWithImpl<_ParameterPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParameterPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParameterPoint&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'ParameterPoint(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class _$ParameterPointCopyWith<$Res> implements $ParameterPointCopyWith<$Res> {
  factory _$ParameterPointCopyWith(_ParameterPoint value, $Res Function(_ParameterPoint) _then) = __$ParameterPointCopyWithImpl;
@override @useResult
$Res call({
 num x, num y
});




}
/// @nodoc
class __$ParameterPointCopyWithImpl<$Res>
    implements _$ParameterPointCopyWith<$Res> {
  __$ParameterPointCopyWithImpl(this._self, this._then);

  final _ParameterPoint _self;
  final $Res Function(_ParameterPoint) _then;

/// Create a copy of ParameterPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,}) {
  return _then(_ParameterPoint(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as num,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Region3 {

 TopLeft3 get topLeft; BottomRight3 get bottomRight;
/// Create a copy of Region3
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Region3CopyWith<Region3> get copyWith => _$Region3CopyWithImpl<Region3>(this as Region3, _$identity);

  /// Serializes this Region3 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Region3&&(identical(other.topLeft, topLeft) || other.topLeft == topLeft)&&(identical(other.bottomRight, bottomRight) || other.bottomRight == bottomRight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topLeft,bottomRight);

@override
String toString() {
  return 'Region3(topLeft: $topLeft, bottomRight: $bottomRight)';
}


}

/// @nodoc
abstract mixin class $Region3CopyWith<$Res>  {
  factory $Region3CopyWith(Region3 value, $Res Function(Region3) _then) = _$Region3CopyWithImpl;
@useResult
$Res call({
 TopLeft3 topLeft, BottomRight3 bottomRight
});


$TopLeft3CopyWith<$Res> get topLeft;$BottomRight3CopyWith<$Res> get bottomRight;

}
/// @nodoc
class _$Region3CopyWithImpl<$Res>
    implements $Region3CopyWith<$Res> {
  _$Region3CopyWithImpl(this._self, this._then);

  final Region3 _self;
  final $Res Function(Region3) _then;

/// Create a copy of Region3
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topLeft = null,Object? bottomRight = null,}) {
  return _then(_self.copyWith(
topLeft: null == topLeft ? _self.topLeft : topLeft // ignore: cast_nullable_to_non_nullable
as TopLeft3,bottomRight: null == bottomRight ? _self.bottomRight : bottomRight // ignore: cast_nullable_to_non_nullable
as BottomRight3,
  ));
}
/// Create a copy of Region3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TopLeft3CopyWith<$Res> get topLeft {

  return $TopLeft3CopyWith<$Res>(_self.topLeft, (value) {
    return _then(_self.copyWith(topLeft: value));
  });
}/// Create a copy of Region3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BottomRight3CopyWith<$Res> get bottomRight {

  return $BottomRight3CopyWith<$Res>(_self.bottomRight, (value) {
    return _then(_self.copyWith(bottomRight: value));
  });
}
}


/// Adds pattern-matching-related methods to [Region3].
extension Region3Patterns on Region3 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Region3 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Region3() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Region3 value)  $default,){
final _that = this;
switch (_that) {
case _Region3():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Region3 value)?  $default,){
final _that = this;
switch (_that) {
case _Region3() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TopLeft3 topLeft,  BottomRight3 bottomRight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Region3() when $default != null:
return $default(_that.topLeft,_that.bottomRight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TopLeft3 topLeft,  BottomRight3 bottomRight)  $default,) {final _that = this;
switch (_that) {
case _Region3():
return $default(_that.topLeft,_that.bottomRight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TopLeft3 topLeft,  BottomRight3 bottomRight)?  $default,) {final _that = this;
switch (_that) {
case _Region3() when $default != null:
return $default(_that.topLeft,_that.bottomRight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Region3 implements Region3 {
  const _Region3({required this.topLeft, required this.bottomRight});
  factory _Region3.fromJson(Map<String, dynamic> json) => _$Region3FromJson(json);

@override final  TopLeft3 topLeft;
@override final  BottomRight3 bottomRight;

/// Create a copy of Region3
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Region3CopyWith<_Region3> get copyWith => __$Region3CopyWithImpl<_Region3>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Region3ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Region3&&(identical(other.topLeft, topLeft) || other.topLeft == topLeft)&&(identical(other.bottomRight, bottomRight) || other.bottomRight == bottomRight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topLeft,bottomRight);

@override
String toString() {
  return 'Region3(topLeft: $topLeft, bottomRight: $bottomRight)';
}


}

/// @nodoc
abstract mixin class _$Region3CopyWith<$Res> implements $Region3CopyWith<$Res> {
  factory _$Region3CopyWith(_Region3 value, $Res Function(_Region3) _then) = __$Region3CopyWithImpl;
@override @useResult
$Res call({
 TopLeft3 topLeft, BottomRight3 bottomRight
});


@override $TopLeft3CopyWith<$Res> get topLeft;@override $BottomRight3CopyWith<$Res> get bottomRight;

}
/// @nodoc
class __$Region3CopyWithImpl<$Res>
    implements _$Region3CopyWith<$Res> {
  __$Region3CopyWithImpl(this._self, this._then);

  final _Region3 _self;
  final $Res Function(_Region3) _then;

/// Create a copy of Region3
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topLeft = null,Object? bottomRight = null,}) {
  return _then(_Region3(
topLeft: null == topLeft ? _self.topLeft : topLeft // ignore: cast_nullable_to_non_nullable
as TopLeft3,bottomRight: null == bottomRight ? _self.bottomRight : bottomRight // ignore: cast_nullable_to_non_nullable
as BottomRight3,
  ));
}

/// Create a copy of Region3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TopLeft3CopyWith<$Res> get topLeft {

  return $TopLeft3CopyWith<$Res>(_self.topLeft, (value) {
    return _then(_self.copyWith(topLeft: value));
  });
}/// Create a copy of Region3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BottomRight3CopyWith<$Res> get bottomRight {

  return $BottomRight3CopyWith<$Res>(_self.bottomRight, (value) {
    return _then(_self.copyWith(bottomRight: value));
  });
}
}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Region2 {

 TopLeft2 get topLeft; BottomRight2 get bottomRight;
/// Create a copy of Region2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Region2CopyWith<Region2> get copyWith => _$Region2CopyWithImpl<Region2>(this as Region2, _$identity);

  /// Serializes this Region2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Region2&&(identical(other.topLeft, topLeft) || other.topLeft == topLeft)&&(identical(other.bottomRight, bottomRight) || other.bottomRight == bottomRight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topLeft,bottomRight);

@override
String toString() {
  return 'Region2(topLeft: $topLeft, bottomRight: $bottomRight)';
}


}

/// @nodoc
abstract mixin class $Region2CopyWith<$Res>  {
  factory $Region2CopyWith(Region2 value, $Res Function(Region2) _then) = _$Region2CopyWithImpl;
@useResult
$Res call({
 TopLeft2 topLeft, BottomRight2 bottomRight
});


$TopLeft2CopyWith<$Res> get topLeft;$BottomRight2CopyWith<$Res> get bottomRight;

}
/// @nodoc
class _$Region2CopyWithImpl<$Res>
    implements $Region2CopyWith<$Res> {
  _$Region2CopyWithImpl(this._self, this._then);

  final Region2 _self;
  final $Res Function(Region2) _then;

/// Create a copy of Region2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topLeft = null,Object? bottomRight = null,}) {
  return _then(_self.copyWith(
topLeft: null == topLeft ? _self.topLeft : topLeft // ignore: cast_nullable_to_non_nullable
as TopLeft2,bottomRight: null == bottomRight ? _self.bottomRight : bottomRight // ignore: cast_nullable_to_non_nullable
as BottomRight2,
  ));
}
/// Create a copy of Region2
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TopLeft2CopyWith<$Res> get topLeft {

  return $TopLeft2CopyWith<$Res>(_self.topLeft, (value) {
    return _then(_self.copyWith(topLeft: value));
  });
}/// Create a copy of Region2
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BottomRight2CopyWith<$Res> get bottomRight {

  return $BottomRight2CopyWith<$Res>(_self.bottomRight, (value) {
    return _then(_self.copyWith(bottomRight: value));
  });
}
}


/// Adds pattern-matching-related methods to [Region2].
extension Region2Patterns on Region2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Region2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Region2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Region2 value)  $default,){
final _that = this;
switch (_that) {
case _Region2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Region2 value)?  $default,){
final _that = this;
switch (_that) {
case _Region2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TopLeft2 topLeft,  BottomRight2 bottomRight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Region2() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TopLeft2 topLeft,  BottomRight2 bottomRight)  $default,) {final _that = this;
switch (_that) {
case _Region2():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TopLeft2 topLeft,  BottomRight2 bottomRight)?  $default,) {final _that = this;
switch (_that) {
case _Region2() when $default != null:
return $default(_that.topLeft,_that.bottomRight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Region2 implements Region2 {
  const _Region2({required this.topLeft, required this.bottomRight});
  factory _Region2.fromJson(Map<String, dynamic> json) => _$Region2FromJson(json);

@override final  TopLeft2 topLeft;
@override final  BottomRight2 bottomRight;

/// Create a copy of Region2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Region2CopyWith<_Region2> get copyWith => __$Region2CopyWithImpl<_Region2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Region2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Region2&&(identical(other.topLeft, topLeft) || other.topLeft == topLeft)&&(identical(other.bottomRight, bottomRight) || other.bottomRight == bottomRight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topLeft,bottomRight);

@override
String toString() {
  return 'Region2(topLeft: $topLeft, bottomRight: $bottomRight)';
}


}

/// @nodoc
abstract mixin class _$Region2CopyWith<$Res> implements $Region2CopyWith<$Res> {
  factory _$Region2CopyWith(_Region2 value, $Res Function(_Region2) _then) = __$Region2CopyWithImpl;
@override @useResult
$Res call({
 TopLeft2 topLeft, BottomRight2 bottomRight
});


@override $TopLeft2CopyWith<$Res> get topLeft;@override $BottomRight2CopyWith<$Res> get bottomRight;

}
/// @nodoc
class __$Region2CopyWithImpl<$Res>
    implements _$Region2CopyWith<$Res> {
  __$Region2CopyWithImpl(this._self, this._then);

  final _Region2 _self;
  final $Res Function(_Region2) _then;

/// Create a copy of Region2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topLeft = null,Object? bottomRight = null,}) {
  return _then(_Region2(
topLeft: null == topLeft ? _self.topLeft : topLeft // ignore: cast_nullable_to_non_nullable
as TopLeft2,bottomRight: null == bottomRight ? _self.bottomRight : bottomRight // ignore: cast_nullable_to_non_nullable
as BottomRight2,
  ));
}

/// Create a copy of Region2
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TopLeft2CopyWith<$Res> get topLeft {

  return $TopLeft2CopyWith<$Res>(_self.topLeft, (value) {
    return _then(_self.copyWith(topLeft: value));
  });
}/// Create a copy of Region2
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BottomRight2CopyWith<$Res> get bottomRight {

  return $BottomRight2CopyWith<$Res>(_self.bottomRight, (value) {
    return _then(_self.copyWith(bottomRight: value));
  });
}
}

// dart format on

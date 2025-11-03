// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'focal_mechanism.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FocalMechanism {

/// 傾斜角(δ)
///
/// 水平面から下向きに測る
 AnglePair get tiltAngle;/// すべり角(λ)
///
/// すべりの方向を水平面から半時計回りに測る
 AnglePair get slipAngle;/// 走向(θ)
///
/// 北から時計回りに測る
 AnglePair get strikeAngle;
/// Create a copy of FocalMechanism
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FocalMechanismCopyWith<FocalMechanism> get copyWith => _$FocalMechanismCopyWithImpl<FocalMechanism>(this as FocalMechanism, _$identity);

  /// Serializes this FocalMechanism to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FocalMechanism&&(identical(other.tiltAngle, tiltAngle) || other.tiltAngle == tiltAngle)&&(identical(other.slipAngle, slipAngle) || other.slipAngle == slipAngle)&&(identical(other.strikeAngle, strikeAngle) || other.strikeAngle == strikeAngle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tiltAngle,slipAngle,strikeAngle);

@override
String toString() {
  return 'FocalMechanism(tiltAngle: $tiltAngle, slipAngle: $slipAngle, strikeAngle: $strikeAngle)';
}


}

/// @nodoc
abstract mixin class $FocalMechanismCopyWith<$Res>  {
  factory $FocalMechanismCopyWith(FocalMechanism value, $Res Function(FocalMechanism) _then) = _$FocalMechanismCopyWithImpl;
@useResult
$Res call({
 AnglePair tiltAngle, AnglePair slipAngle, AnglePair strikeAngle
});


$AnglePairCopyWith<$Res> get tiltAngle;$AnglePairCopyWith<$Res> get slipAngle;$AnglePairCopyWith<$Res> get strikeAngle;

}
/// @nodoc
class _$FocalMechanismCopyWithImpl<$Res>
    implements $FocalMechanismCopyWith<$Res> {
  _$FocalMechanismCopyWithImpl(this._self, this._then);

  final FocalMechanism _self;
  final $Res Function(FocalMechanism) _then;

/// Create a copy of FocalMechanism
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tiltAngle = null,Object? slipAngle = null,Object? strikeAngle = null,}) {
  return _then(_self.copyWith(
tiltAngle: null == tiltAngle ? _self.tiltAngle : tiltAngle // ignore: cast_nullable_to_non_nullable
as AnglePair,slipAngle: null == slipAngle ? _self.slipAngle : slipAngle // ignore: cast_nullable_to_non_nullable
as AnglePair,strikeAngle: null == strikeAngle ? _self.strikeAngle : strikeAngle // ignore: cast_nullable_to_non_nullable
as AnglePair,
  ));
}
/// Create a copy of FocalMechanism
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnglePairCopyWith<$Res> get tiltAngle {
  
  return $AnglePairCopyWith<$Res>(_self.tiltAngle, (value) {
    return _then(_self.copyWith(tiltAngle: value));
  });
}/// Create a copy of FocalMechanism
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnglePairCopyWith<$Res> get slipAngle {
  
  return $AnglePairCopyWith<$Res>(_self.slipAngle, (value) {
    return _then(_self.copyWith(slipAngle: value));
  });
}/// Create a copy of FocalMechanism
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnglePairCopyWith<$Res> get strikeAngle {
  
  return $AnglePairCopyWith<$Res>(_self.strikeAngle, (value) {
    return _then(_self.copyWith(strikeAngle: value));
  });
}
}


/// Adds pattern-matching-related methods to [FocalMechanism].
extension FocalMechanismPatterns on FocalMechanism {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FocalMechanism value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FocalMechanism() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FocalMechanism value)  $default,){
final _that = this;
switch (_that) {
case _FocalMechanism():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FocalMechanism value)?  $default,){
final _that = this;
switch (_that) {
case _FocalMechanism() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AnglePair tiltAngle,  AnglePair slipAngle,  AnglePair strikeAngle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FocalMechanism() when $default != null:
return $default(_that.tiltAngle,_that.slipAngle,_that.strikeAngle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AnglePair tiltAngle,  AnglePair slipAngle,  AnglePair strikeAngle)  $default,) {final _that = this;
switch (_that) {
case _FocalMechanism():
return $default(_that.tiltAngle,_that.slipAngle,_that.strikeAngle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AnglePair tiltAngle,  AnglePair slipAngle,  AnglePair strikeAngle)?  $default,) {final _that = this;
switch (_that) {
case _FocalMechanism() when $default != null:
return $default(_that.tiltAngle,_that.slipAngle,_that.strikeAngle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FocalMechanism implements FocalMechanism {
  const _FocalMechanism({required this.tiltAngle, required this.slipAngle, required this.strikeAngle});
  factory _FocalMechanism.fromJson(Map<String, dynamic> json) => _$FocalMechanismFromJson(json);

/// 傾斜角(δ)
///
/// 水平面から下向きに測る
@override final  AnglePair tiltAngle;
/// すべり角(λ)
///
/// すべりの方向を水平面から半時計回りに測る
@override final  AnglePair slipAngle;
/// 走向(θ)
///
/// 北から時計回りに測る
@override final  AnglePair strikeAngle;

/// Create a copy of FocalMechanism
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FocalMechanismCopyWith<_FocalMechanism> get copyWith => __$FocalMechanismCopyWithImpl<_FocalMechanism>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FocalMechanismToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FocalMechanism&&(identical(other.tiltAngle, tiltAngle) || other.tiltAngle == tiltAngle)&&(identical(other.slipAngle, slipAngle) || other.slipAngle == slipAngle)&&(identical(other.strikeAngle, strikeAngle) || other.strikeAngle == strikeAngle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tiltAngle,slipAngle,strikeAngle);

@override
String toString() {
  return 'FocalMechanism(tiltAngle: $tiltAngle, slipAngle: $slipAngle, strikeAngle: $strikeAngle)';
}


}

/// @nodoc
abstract mixin class _$FocalMechanismCopyWith<$Res> implements $FocalMechanismCopyWith<$Res> {
  factory _$FocalMechanismCopyWith(_FocalMechanism value, $Res Function(_FocalMechanism) _then) = __$FocalMechanismCopyWithImpl;
@override @useResult
$Res call({
 AnglePair tiltAngle, AnglePair slipAngle, AnglePair strikeAngle
});


@override $AnglePairCopyWith<$Res> get tiltAngle;@override $AnglePairCopyWith<$Res> get slipAngle;@override $AnglePairCopyWith<$Res> get strikeAngle;

}
/// @nodoc
class __$FocalMechanismCopyWithImpl<$Res>
    implements _$FocalMechanismCopyWith<$Res> {
  __$FocalMechanismCopyWithImpl(this._self, this._then);

  final _FocalMechanism _self;
  final $Res Function(_FocalMechanism) _then;

/// Create a copy of FocalMechanism
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tiltAngle = null,Object? slipAngle = null,Object? strikeAngle = null,}) {
  return _then(_FocalMechanism(
tiltAngle: null == tiltAngle ? _self.tiltAngle : tiltAngle // ignore: cast_nullable_to_non_nullable
as AnglePair,slipAngle: null == slipAngle ? _self.slipAngle : slipAngle // ignore: cast_nullable_to_non_nullable
as AnglePair,strikeAngle: null == strikeAngle ? _self.strikeAngle : strikeAngle // ignore: cast_nullable_to_non_nullable
as AnglePair,
  ));
}

/// Create a copy of FocalMechanism
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnglePairCopyWith<$Res> get tiltAngle {
  
  return $AnglePairCopyWith<$Res>(_self.tiltAngle, (value) {
    return _then(_self.copyWith(tiltAngle: value));
  });
}/// Create a copy of FocalMechanism
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnglePairCopyWith<$Res> get slipAngle {
  
  return $AnglePairCopyWith<$Res>(_self.slipAngle, (value) {
    return _then(_self.copyWith(slipAngle: value));
  });
}/// Create a copy of FocalMechanism
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnglePairCopyWith<$Res> get strikeAngle {
  
  return $AnglePairCopyWith<$Res>(_self.strikeAngle, (value) {
    return _then(_self.copyWith(strikeAngle: value));
  });
}
}

// dart format on

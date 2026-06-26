// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_estimation_first_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiEstimationFirstHeight {

 DateTime? get arrivalTime; bool? get isAlreadyArrived; Revise? get revise;
/// Create a copy of TsunamiEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiEstimationFirstHeightCopyWith<TsunamiEstimationFirstHeight> get copyWith => _$TsunamiEstimationFirstHeightCopyWithImpl<TsunamiEstimationFirstHeight>(this as TsunamiEstimationFirstHeight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiEstimationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.isAlreadyArrived, isAlreadyArrived) || other.isAlreadyArrived == isAlreadyArrived)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,isAlreadyArrived,revise);

@override
String toString() {
  return 'TsunamiEstimationFirstHeight(arrivalTime: $arrivalTime, isAlreadyArrived: $isAlreadyArrived, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiEstimationFirstHeightCopyWith<$Res>  {
  factory $TsunamiEstimationFirstHeightCopyWith(TsunamiEstimationFirstHeight value, $Res Function(TsunamiEstimationFirstHeight) _then) = _$TsunamiEstimationFirstHeightCopyWithImpl;
@useResult
$Res call({
 DateTime? arrivalTime, bool? isAlreadyArrived, Revise? revise
});




}
/// @nodoc
class _$TsunamiEstimationFirstHeightCopyWithImpl<$Res>
    implements $TsunamiEstimationFirstHeightCopyWith<$Res> {
  _$TsunamiEstimationFirstHeightCopyWithImpl(this._self, this._then);

  final TsunamiEstimationFirstHeight _self;
  final $Res Function(TsunamiEstimationFirstHeight) _then;

/// Create a copy of TsunamiEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? isAlreadyArrived = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isAlreadyArrived: freezed == isAlreadyArrived ? _self.isAlreadyArrived : isAlreadyArrived // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiEstimationFirstHeight].
extension TsunamiEstimationFirstHeightPatterns on TsunamiEstimationFirstHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiEstimationFirstHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiEstimationFirstHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiEstimationFirstHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? arrivalTime,  bool? isAlreadyArrived,  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? arrivalTime,  bool? isAlreadyArrived,  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight():
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? arrivalTime,  bool? isAlreadyArrived,  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiEstimationFirstHeight implements TsunamiEstimationFirstHeight {
  const _TsunamiEstimationFirstHeight({required this.arrivalTime, required this.isAlreadyArrived, required this.revise});
  

@override final  DateTime? arrivalTime;
@override final  bool? isAlreadyArrived;
@override final  Revise? revise;

/// Create a copy of TsunamiEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiEstimationFirstHeightCopyWith<_TsunamiEstimationFirstHeight> get copyWith => __$TsunamiEstimationFirstHeightCopyWithImpl<_TsunamiEstimationFirstHeight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiEstimationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.isAlreadyArrived, isAlreadyArrived) || other.isAlreadyArrived == isAlreadyArrived)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,isAlreadyArrived,revise);

@override
String toString() {
  return 'TsunamiEstimationFirstHeight(arrivalTime: $arrivalTime, isAlreadyArrived: $isAlreadyArrived, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiEstimationFirstHeightCopyWith<$Res> implements $TsunamiEstimationFirstHeightCopyWith<$Res> {
  factory _$TsunamiEstimationFirstHeightCopyWith(_TsunamiEstimationFirstHeight value, $Res Function(_TsunamiEstimationFirstHeight) _then) = __$TsunamiEstimationFirstHeightCopyWithImpl;
@override @useResult
$Res call({
 DateTime? arrivalTime, bool? isAlreadyArrived, Revise? revise
});




}
/// @nodoc
class __$TsunamiEstimationFirstHeightCopyWithImpl<$Res>
    implements _$TsunamiEstimationFirstHeightCopyWith<$Res> {
  __$TsunamiEstimationFirstHeightCopyWithImpl(this._self, this._then);

  final _TsunamiEstimationFirstHeight _self;
  final $Res Function(_TsunamiEstimationFirstHeight) _then;

/// Create a copy of TsunamiEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? isAlreadyArrived = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiEstimationFirstHeight(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isAlreadyArrived: freezed == isAlreadyArrived ? _self.isAlreadyArrived : isAlreadyArrived // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_observation_first_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiObservationFirstHeight {

 DateTime? get arrivalTime; WaveInitial? get initial; bool? get isUnidentifiable; bool? get isMissing; Revise? get revise;
/// Create a copy of TsunamiObservationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiObservationFirstHeightCopyWith<TsunamiObservationFirstHeight> get copyWith => _$TsunamiObservationFirstHeightCopyWithImpl<TsunamiObservationFirstHeight>(this as TsunamiObservationFirstHeight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiObservationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.isUnidentifiable, isUnidentifiable) || other.isUnidentifiable == isUnidentifiable)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,initial,isUnidentifiable,isMissing,revise);

@override
String toString() {
  return 'TsunamiObservationFirstHeight(arrivalTime: $arrivalTime, initial: $initial, isUnidentifiable: $isUnidentifiable, isMissing: $isMissing, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiObservationFirstHeightCopyWith<$Res>  {
  factory $TsunamiObservationFirstHeightCopyWith(TsunamiObservationFirstHeight value, $Res Function(TsunamiObservationFirstHeight) _then) = _$TsunamiObservationFirstHeightCopyWithImpl;
@useResult
$Res call({
 DateTime? arrivalTime, WaveInitial? initial, bool? isUnidentifiable, bool? isMissing, Revise? revise
});




}
/// @nodoc
class _$TsunamiObservationFirstHeightCopyWithImpl<$Res>
    implements $TsunamiObservationFirstHeightCopyWith<$Res> {
  _$TsunamiObservationFirstHeightCopyWithImpl(this._self, this._then);

  final TsunamiObservationFirstHeight _self;
  final $Res Function(TsunamiObservationFirstHeight) _then;

/// Create a copy of TsunamiObservationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? initial = freezed,Object? isUnidentifiable = freezed,Object? isMissing = freezed,Object? revise = freezed,}) {
  return _then(TsunamiObservationFirstHeight(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,initial: freezed == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as WaveInitial?,isUnidentifiable: freezed == isUnidentifiable ? _self.isUnidentifiable : isUnidentifiable // ignore: cast_nullable_to_non_nullable
as bool?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiObservationFirstHeight].
extension TsunamiObservationFirstHeightPatterns on TsunamiObservationFirstHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiObservationFirstHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiObservationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiObservationFirstHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiObservationFirstHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiObservationFirstHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiObservationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? arrivalTime,  WaveInitial? initial,  bool? isUnidentifiable,  bool? isMissing,  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiObservationFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? arrivalTime,  WaveInitial? initial,  bool? isUnidentifiable,  bool? isMissing,  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _TsunamiObservationFirstHeight():
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? arrivalTime,  WaveInitial? initial,  bool? isUnidentifiable,  bool? isMissing,  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiObservationFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing,_that.revise);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiObservationFirstHeight implements TsunamiObservationFirstHeight {
  const _TsunamiObservationFirstHeight({required this.arrivalTime, required this.initial, required this.isUnidentifiable, required this.isMissing, required this.revise});
  

@override final  DateTime? arrivalTime;
@override final  WaveInitial? initial;
@override final  bool? isUnidentifiable;
@override final  bool? isMissing;
@override final  Revise? revise;

/// Create a copy of TsunamiObservationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiObservationFirstHeightCopyWith<_TsunamiObservationFirstHeight> get copyWith => __$TsunamiObservationFirstHeightCopyWithImpl<_TsunamiObservationFirstHeight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiObservationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.isUnidentifiable, isUnidentifiable) || other.isUnidentifiable == isUnidentifiable)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,arrivalTime,initial,isUnidentifiable,isMissing,revise);

@override
String toString() {
  return 'TsunamiObservationFirstHeight(arrivalTime: $arrivalTime, initial: $initial, isUnidentifiable: $isUnidentifiable, isMissing: $isMissing, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiObservationFirstHeightCopyWith<$Res> implements $TsunamiObservationFirstHeightCopyWith<$Res> {
  factory _$TsunamiObservationFirstHeightCopyWith(_TsunamiObservationFirstHeight value, $Res Function(_TsunamiObservationFirstHeight) _then) = __$TsunamiObservationFirstHeightCopyWithImpl;
@override @useResult
$Res call({
 DateTime? arrivalTime, WaveInitial? initial, bool? isUnidentifiable, bool? isMissing, Revise? revise
});




}
/// @nodoc
class __$TsunamiObservationFirstHeightCopyWithImpl<$Res>
    implements _$TsunamiObservationFirstHeightCopyWith<$Res> {
  __$TsunamiObservationFirstHeightCopyWithImpl(this._self, this._then);

  final _TsunamiObservationFirstHeight _self;
  final $Res Function(_TsunamiObservationFirstHeight) _then;

/// Create a copy of TsunamiObservationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? initial = freezed,Object? isUnidentifiable = freezed,Object? isMissing = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiObservationFirstHeight(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,initial: freezed == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as WaveInitial?,isUnidentifiable: freezed == isUnidentifiable ? _self.isUnidentifiable : isUnidentifiable // ignore: cast_nullable_to_non_nullable
as bool?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}


}

// dart format on

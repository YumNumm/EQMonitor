// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_observation_max_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiObservationMaxHeight {

 DateTime? get dateTime; double? get value; bool? get isOver; bool? get isRising; ObservationMaxHeightCondition? get condition; bool? get isMissing; Revise? get revise;
/// Create a copy of TsunamiObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiObservationMaxHeightCopyWith<TsunamiObservationMaxHeight> get copyWith => _$TsunamiObservationMaxHeightCopyWithImpl<TsunamiObservationMaxHeight>(this as TsunamiObservationMaxHeight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiObservationMaxHeight&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.isRising, isRising) || other.isRising == isRising)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,value,isOver,isRising,condition,isMissing,revise);

@override
String toString() {
  return 'TsunamiObservationMaxHeight(dateTime: $dateTime, value: $value, isOver: $isOver, isRising: $isRising, condition: $condition, isMissing: $isMissing, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiObservationMaxHeightCopyWith<$Res>  {
  factory $TsunamiObservationMaxHeightCopyWith(TsunamiObservationMaxHeight value, $Res Function(TsunamiObservationMaxHeight) _then) = _$TsunamiObservationMaxHeightCopyWithImpl;
@useResult
$Res call({
 DateTime? dateTime, double? value, bool? isOver, bool? isRising, ObservationMaxHeightCondition? condition, bool? isMissing, Revise? revise
});




}
/// @nodoc
class _$TsunamiObservationMaxHeightCopyWithImpl<$Res>
    implements $TsunamiObservationMaxHeightCopyWith<$Res> {
  _$TsunamiObservationMaxHeightCopyWithImpl(this._self, this._then);

  final TsunamiObservationMaxHeight _self;
  final $Res Function(TsunamiObservationMaxHeight) _then;

/// Create a copy of TsunamiObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateTime = freezed,Object? value = freezed,Object? isOver = freezed,Object? isRising = freezed,Object? condition = freezed,Object? isMissing = freezed,Object? revise = freezed,}) {
  return _then(TsunamiObservationMaxHeight(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,isRising: freezed == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiObservationMaxHeight].
extension TsunamiObservationMaxHeightPatterns on TsunamiObservationMaxHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiObservationMaxHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiObservationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiObservationMaxHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiObservationMaxHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiObservationMaxHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiObservationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? dateTime,  double? value,  bool? isOver,  bool? isRising,  ObservationMaxHeightCondition? condition,  bool? isMissing,  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiObservationMaxHeight() when $default != null:
return $default(_that.dateTime,_that.value,_that.isOver,_that.isRising,_that.condition,_that.isMissing,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? dateTime,  double? value,  bool? isOver,  bool? isRising,  ObservationMaxHeightCondition? condition,  bool? isMissing,  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _TsunamiObservationMaxHeight():
return $default(_that.dateTime,_that.value,_that.isOver,_that.isRising,_that.condition,_that.isMissing,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? dateTime,  double? value,  bool? isOver,  bool? isRising,  ObservationMaxHeightCondition? condition,  bool? isMissing,  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiObservationMaxHeight() when $default != null:
return $default(_that.dateTime,_that.value,_that.isOver,_that.isRising,_that.condition,_that.isMissing,_that.revise);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiObservationMaxHeight implements TsunamiObservationMaxHeight {
  const _TsunamiObservationMaxHeight({required this.dateTime, required this.value, required this.isOver, required this.isRising, required this.condition, required this.isMissing, required this.revise});
  

@override final  DateTime? dateTime;
@override final  double? value;
@override final  bool? isOver;
@override final  bool? isRising;
@override final  ObservationMaxHeightCondition? condition;
@override final  bool? isMissing;
@override final  Revise? revise;

/// Create a copy of TsunamiObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiObservationMaxHeightCopyWith<_TsunamiObservationMaxHeight> get copyWith => __$TsunamiObservationMaxHeightCopyWithImpl<_TsunamiObservationMaxHeight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiObservationMaxHeight&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.isRising, isRising) || other.isRising == isRising)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,value,isOver,isRising,condition,isMissing,revise);

@override
String toString() {
  return 'TsunamiObservationMaxHeight(dateTime: $dateTime, value: $value, isOver: $isOver, isRising: $isRising, condition: $condition, isMissing: $isMissing, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiObservationMaxHeightCopyWith<$Res> implements $TsunamiObservationMaxHeightCopyWith<$Res> {
  factory _$TsunamiObservationMaxHeightCopyWith(_TsunamiObservationMaxHeight value, $Res Function(_TsunamiObservationMaxHeight) _then) = __$TsunamiObservationMaxHeightCopyWithImpl;
@override @useResult
$Res call({
 DateTime? dateTime, double? value, bool? isOver, bool? isRising, ObservationMaxHeightCondition? condition, bool? isMissing, Revise? revise
});




}
/// @nodoc
class __$TsunamiObservationMaxHeightCopyWithImpl<$Res>
    implements _$TsunamiObservationMaxHeightCopyWith<$Res> {
  __$TsunamiObservationMaxHeightCopyWithImpl(this._self, this._then);

  final _TsunamiObservationMaxHeight _self;
  final $Res Function(_TsunamiObservationMaxHeight) _then;

/// Create a copy of TsunamiObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateTime = freezed,Object? value = freezed,Object? isOver = freezed,Object? isRising = freezed,Object? condition = freezed,Object? isMissing = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiObservationMaxHeight(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,isRising: freezed == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}


}

// dart format on

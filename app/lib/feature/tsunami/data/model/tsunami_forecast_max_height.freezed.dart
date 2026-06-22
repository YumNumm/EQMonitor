// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_forecast_max_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiForecastMaxHeight {

 double? get value; bool? get isOver; QualitativeHeight? get qualitative; bool? get isImportant; Revise? get revise;
/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiForecastMaxHeightCopyWith<TsunamiForecastMaxHeight> get copyWith => _$TsunamiForecastMaxHeightCopyWithImpl<TsunamiForecastMaxHeight>(this as TsunamiForecastMaxHeight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiForecastMaxHeight&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,value,isOver,qualitative,isImportant,revise);

@override
String toString() {
  return 'TsunamiForecastMaxHeight(value: $value, isOver: $isOver, qualitative: $qualitative, isImportant: $isImportant, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiForecastMaxHeightCopyWith<$Res>  {
  factory $TsunamiForecastMaxHeightCopyWith(TsunamiForecastMaxHeight value, $Res Function(TsunamiForecastMaxHeight) _then) = _$TsunamiForecastMaxHeightCopyWithImpl;
@useResult
$Res call({
 double? value, bool? isOver, QualitativeHeight? qualitative, bool? isImportant, Revise? revise
});




}
/// @nodoc
class _$TsunamiForecastMaxHeightCopyWithImpl<$Res>
    implements $TsunamiForecastMaxHeightCopyWith<$Res> {
  _$TsunamiForecastMaxHeightCopyWithImpl(this._self, this._then);

  final TsunamiForecastMaxHeight _self;
  final $Res Function(TsunamiForecastMaxHeight) _then;

/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? isOver = freezed,Object? qualitative = freezed,Object? isImportant = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,isImportant: freezed == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiForecastMaxHeight].
extension TsunamiForecastMaxHeightPatterns on TsunamiForecastMaxHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiForecastMaxHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiForecastMaxHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiForecastMaxHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? value,  bool? isOver,  QualitativeHeight? qualitative,  bool? isImportant,  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight() when $default != null:
return $default(_that.value,_that.isOver,_that.qualitative,_that.isImportant,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? value,  bool? isOver,  QualitativeHeight? qualitative,  bool? isImportant,  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight():
return $default(_that.value,_that.isOver,_that.qualitative,_that.isImportant,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? value,  bool? isOver,  QualitativeHeight? qualitative,  bool? isImportant,  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight() when $default != null:
return $default(_that.value,_that.isOver,_that.qualitative,_that.isImportant,_that.revise);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiForecastMaxHeight implements TsunamiForecastMaxHeight {
  const _TsunamiForecastMaxHeight({required this.value, required this.isOver, required this.qualitative, required this.isImportant, required this.revise});
  

@override final  double? value;
@override final  bool? isOver;
@override final  QualitativeHeight? qualitative;
@override final  bool? isImportant;
@override final  Revise? revise;

/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiForecastMaxHeightCopyWith<_TsunamiForecastMaxHeight> get copyWith => __$TsunamiForecastMaxHeightCopyWithImpl<_TsunamiForecastMaxHeight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiForecastMaxHeight&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.revise, revise) || other.revise == revise));
}


@override
int get hashCode => Object.hash(runtimeType,value,isOver,qualitative,isImportant,revise);

@override
String toString() {
  return 'TsunamiForecastMaxHeight(value: $value, isOver: $isOver, qualitative: $qualitative, isImportant: $isImportant, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiForecastMaxHeightCopyWith<$Res> implements $TsunamiForecastMaxHeightCopyWith<$Res> {
  factory _$TsunamiForecastMaxHeightCopyWith(_TsunamiForecastMaxHeight value, $Res Function(_TsunamiForecastMaxHeight) _then) = __$TsunamiForecastMaxHeightCopyWithImpl;
@override @useResult
$Res call({
 double? value, bool? isOver, QualitativeHeight? qualitative, bool? isImportant, Revise? revise
});




}
/// @nodoc
class __$TsunamiForecastMaxHeightCopyWithImpl<$Res>
    implements _$TsunamiForecastMaxHeightCopyWith<$Res> {
  __$TsunamiForecastMaxHeightCopyWithImpl(this._self, this._then);

  final _TsunamiForecastMaxHeight _self;
  final $Res Function(_TsunamiForecastMaxHeight) _then;

/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? isOver = freezed,Object? qualitative = freezed,Object? isImportant = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiForecastMaxHeight(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,isImportant: freezed == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}


}

// dart format on

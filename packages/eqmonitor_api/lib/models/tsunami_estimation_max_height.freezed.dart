// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_estimation_max_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiEstimationMaxHeight {

@JsonKey(name: 'date_time') DateTime get dateTime; num get value; bool get over; QualitativeHeight get qualitative;@JsonKey(name: 'is_observing') bool get isObserving;
/// Create a copy of TsunamiEstimationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiEstimationMaxHeightCopyWith<TsunamiEstimationMaxHeight> get copyWith => _$TsunamiEstimationMaxHeightCopyWithImpl<TsunamiEstimationMaxHeight>(this as TsunamiEstimationMaxHeight, _$identity);

  /// Serializes this TsunamiEstimationMaxHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiEstimationMaxHeight&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.over, over) || other.over == over)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isObserving, isObserving) || other.isObserving == isObserving));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateTime,value,over,qualitative,isObserving);

@override
String toString() {
  return 'TsunamiEstimationMaxHeight(dateTime: $dateTime, value: $value, over: $over, qualitative: $qualitative, isObserving: $isObserving)';
}


}

/// @nodoc
abstract mixin class $TsunamiEstimationMaxHeightCopyWith<$Res>  {
  factory $TsunamiEstimationMaxHeightCopyWith(TsunamiEstimationMaxHeight value, $Res Function(TsunamiEstimationMaxHeight) _then) = _$TsunamiEstimationMaxHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'date_time') DateTime dateTime, num value, bool over, QualitativeHeight qualitative,@JsonKey(name: 'is_observing') bool isObserving
});




}
/// @nodoc
class _$TsunamiEstimationMaxHeightCopyWithImpl<$Res>
    implements $TsunamiEstimationMaxHeightCopyWith<$Res> {
  _$TsunamiEstimationMaxHeightCopyWithImpl(this._self, this._then);

  final TsunamiEstimationMaxHeight _self;
  final $Res Function(TsunamiEstimationMaxHeight) _then;

/// Create a copy of TsunamiEstimationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateTime = null,Object? value = null,Object? over = null,Object? qualitative = null,Object? isObserving = null,}) {
  return _then(_self.copyWith(
dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,over: null == over ? _self.over : over // ignore: cast_nullable_to_non_nullable
as bool,qualitative: null == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight,isObserving: null == isObserving ? _self.isObserving : isObserving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiEstimationMaxHeight].
extension TsunamiEstimationMaxHeightPatterns on TsunamiEstimationMaxHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiEstimationMaxHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiEstimationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiEstimationMaxHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiEstimationMaxHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiEstimationMaxHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiEstimationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_time')  DateTime dateTime,  num value,  bool over,  QualitativeHeight qualitative, @JsonKey(name: 'is_observing')  bool isObserving)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiEstimationMaxHeight() when $default != null:
return $default(_that.dateTime,_that.value,_that.over,_that.qualitative,_that.isObserving);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_time')  DateTime dateTime,  num value,  bool over,  QualitativeHeight qualitative, @JsonKey(name: 'is_observing')  bool isObserving)  $default,) {final _that = this;
switch (_that) {
case _TsunamiEstimationMaxHeight():
return $default(_that.dateTime,_that.value,_that.over,_that.qualitative,_that.isObserving);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'date_time')  DateTime dateTime,  num value,  bool over,  QualitativeHeight qualitative, @JsonKey(name: 'is_observing')  bool isObserving)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiEstimationMaxHeight() when $default != null:
return $default(_that.dateTime,_that.value,_that.over,_that.qualitative,_that.isObserving);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiEstimationMaxHeight implements TsunamiEstimationMaxHeight {
  const _TsunamiEstimationMaxHeight({@JsonKey(name: 'date_time') required this.dateTime, required this.value, required this.over, required this.qualitative, @JsonKey(name: 'is_observing') required this.isObserving});
  factory _TsunamiEstimationMaxHeight.fromJson(Map<String, dynamic> json) => _$TsunamiEstimationMaxHeightFromJson(json);

@override@JsonKey(name: 'date_time') final  DateTime dateTime;
@override final  num value;
@override final  bool over;
@override final  QualitativeHeight qualitative;
@override@JsonKey(name: 'is_observing') final  bool isObserving;

/// Create a copy of TsunamiEstimationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiEstimationMaxHeightCopyWith<_TsunamiEstimationMaxHeight> get copyWith => __$TsunamiEstimationMaxHeightCopyWithImpl<_TsunamiEstimationMaxHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiEstimationMaxHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiEstimationMaxHeight&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.over, over) || other.over == over)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isObserving, isObserving) || other.isObserving == isObserving));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateTime,value,over,qualitative,isObserving);

@override
String toString() {
  return 'TsunamiEstimationMaxHeight(dateTime: $dateTime, value: $value, over: $over, qualitative: $qualitative, isObserving: $isObserving)';
}


}

/// @nodoc
abstract mixin class _$TsunamiEstimationMaxHeightCopyWith<$Res> implements $TsunamiEstimationMaxHeightCopyWith<$Res> {
  factory _$TsunamiEstimationMaxHeightCopyWith(_TsunamiEstimationMaxHeight value, $Res Function(_TsunamiEstimationMaxHeight) _then) = __$TsunamiEstimationMaxHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'date_time') DateTime dateTime, num value, bool over, QualitativeHeight qualitative,@JsonKey(name: 'is_observing') bool isObserving
});




}
/// @nodoc
class __$TsunamiEstimationMaxHeightCopyWithImpl<$Res>
    implements _$TsunamiEstimationMaxHeightCopyWith<$Res> {
  __$TsunamiEstimationMaxHeightCopyWithImpl(this._self, this._then);

  final _TsunamiEstimationMaxHeight _self;
  final $Res Function(_TsunamiEstimationMaxHeight) _then;

/// Create a copy of TsunamiEstimationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateTime = null,Object? value = null,Object? over = null,Object? qualitative = null,Object? isObserving = null,}) {
  return _then(_TsunamiEstimationMaxHeight(
dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,over: null == over ? _self.over : over // ignore: cast_nullable_to_non_nullable
as bool,qualitative: null == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight,isObserving: null == isObserving ? _self.isObserving : isObserving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_observation_station_max_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiObservationStationMaxHeight {

@JsonKey(name: 'date_time') DateTime get dateTime; num get value; bool get over;@JsonKey(name: 'is_rising') bool get isRising; ObservationMaxHeightCondition get condition;@JsonKey(name: 'is_missing') bool get isMissing;
/// Create a copy of TsunamiObservationStationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiObservationStationMaxHeightCopyWith<TsunamiObservationStationMaxHeight> get copyWith => _$TsunamiObservationStationMaxHeightCopyWithImpl<TsunamiObservationStationMaxHeight>(this as TsunamiObservationStationMaxHeight, _$identity);

  /// Serializes this TsunamiObservationStationMaxHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiObservationStationMaxHeight&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.over, over) || other.over == over)&&(identical(other.isRising, isRising) || other.isRising == isRising)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateTime,value,over,isRising,condition,isMissing);

@override
String toString() {
  return 'TsunamiObservationStationMaxHeight(dateTime: $dateTime, value: $value, over: $over, isRising: $isRising, condition: $condition, isMissing: $isMissing)';
}


}

/// @nodoc
abstract mixin class $TsunamiObservationStationMaxHeightCopyWith<$Res>  {
  factory $TsunamiObservationStationMaxHeightCopyWith(TsunamiObservationStationMaxHeight value, $Res Function(TsunamiObservationStationMaxHeight) _then) = _$TsunamiObservationStationMaxHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'date_time') DateTime dateTime, num value, bool over,@JsonKey(name: 'is_rising') bool isRising, ObservationMaxHeightCondition condition,@JsonKey(name: 'is_missing') bool isMissing
});




}
/// @nodoc
class _$TsunamiObservationStationMaxHeightCopyWithImpl<$Res>
    implements $TsunamiObservationStationMaxHeightCopyWith<$Res> {
  _$TsunamiObservationStationMaxHeightCopyWithImpl(this._self, this._then);

  final TsunamiObservationStationMaxHeight _self;
  final $Res Function(TsunamiObservationStationMaxHeight) _then;

/// Create a copy of TsunamiObservationStationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateTime = null,Object? value = null,Object? over = null,Object? isRising = null,Object? condition = null,Object? isMissing = null,}) {
  return _then(_self.copyWith(
dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,over: null == over ? _self.over : over // ignore: cast_nullable_to_non_nullable
as bool,isRising: null == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as bool,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition,isMissing: null == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiObservationStationMaxHeight].
extension TsunamiObservationStationMaxHeightPatterns on TsunamiObservationStationMaxHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiObservationStationMaxHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiObservationStationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiObservationStationMaxHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiObservationStationMaxHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiObservationStationMaxHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiObservationStationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_time')  DateTime dateTime,  num value,  bool over, @JsonKey(name: 'is_rising')  bool isRising,  ObservationMaxHeightCondition condition, @JsonKey(name: 'is_missing')  bool isMissing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiObservationStationMaxHeight() when $default != null:
return $default(_that.dateTime,_that.value,_that.over,_that.isRising,_that.condition,_that.isMissing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_time')  DateTime dateTime,  num value,  bool over, @JsonKey(name: 'is_rising')  bool isRising,  ObservationMaxHeightCondition condition, @JsonKey(name: 'is_missing')  bool isMissing)  $default,) {final _that = this;
switch (_that) {
case _TsunamiObservationStationMaxHeight():
return $default(_that.dateTime,_that.value,_that.over,_that.isRising,_that.condition,_that.isMissing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'date_time')  DateTime dateTime,  num value,  bool over, @JsonKey(name: 'is_rising')  bool isRising,  ObservationMaxHeightCondition condition, @JsonKey(name: 'is_missing')  bool isMissing)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiObservationStationMaxHeight() when $default != null:
return $default(_that.dateTime,_that.value,_that.over,_that.isRising,_that.condition,_that.isMissing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiObservationStationMaxHeight implements TsunamiObservationStationMaxHeight {
  const _TsunamiObservationStationMaxHeight({@JsonKey(name: 'date_time') required this.dateTime, required this.value, required this.over, @JsonKey(name: 'is_rising') required this.isRising, required this.condition, @JsonKey(name: 'is_missing') required this.isMissing});
  factory _TsunamiObservationStationMaxHeight.fromJson(Map<String, dynamic> json) => _$TsunamiObservationStationMaxHeightFromJson(json);

@override@JsonKey(name: 'date_time') final  DateTime dateTime;
@override final  num value;
@override final  bool over;
@override@JsonKey(name: 'is_rising') final  bool isRising;
@override final  ObservationMaxHeightCondition condition;
@override@JsonKey(name: 'is_missing') final  bool isMissing;

/// Create a copy of TsunamiObservationStationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiObservationStationMaxHeightCopyWith<_TsunamiObservationStationMaxHeight> get copyWith => __$TsunamiObservationStationMaxHeightCopyWithImpl<_TsunamiObservationStationMaxHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiObservationStationMaxHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiObservationStationMaxHeight&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&(identical(other.over, over) || other.over == over)&&(identical(other.isRising, isRising) || other.isRising == isRising)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateTime,value,over,isRising,condition,isMissing);

@override
String toString() {
  return 'TsunamiObservationStationMaxHeight(dateTime: $dateTime, value: $value, over: $over, isRising: $isRising, condition: $condition, isMissing: $isMissing)';
}


}

/// @nodoc
abstract mixin class _$TsunamiObservationStationMaxHeightCopyWith<$Res> implements $TsunamiObservationStationMaxHeightCopyWith<$Res> {
  factory _$TsunamiObservationStationMaxHeightCopyWith(_TsunamiObservationStationMaxHeight value, $Res Function(_TsunamiObservationStationMaxHeight) _then) = __$TsunamiObservationStationMaxHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'date_time') DateTime dateTime, num value, bool over,@JsonKey(name: 'is_rising') bool isRising, ObservationMaxHeightCondition condition,@JsonKey(name: 'is_missing') bool isMissing
});




}
/// @nodoc
class __$TsunamiObservationStationMaxHeightCopyWithImpl<$Res>
    implements _$TsunamiObservationStationMaxHeightCopyWith<$Res> {
  __$TsunamiObservationStationMaxHeightCopyWithImpl(this._self, this._then);

  final _TsunamiObservationStationMaxHeight _self;
  final $Res Function(_TsunamiObservationStationMaxHeight) _then;

/// Create a copy of TsunamiObservationStationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateTime = null,Object? value = null,Object? over = null,Object? isRising = null,Object? condition = null,Object? isMissing = null,}) {
  return _then(_TsunamiObservationStationMaxHeight(
dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,over: null == over ? _self.over : over // ignore: cast_nullable_to_non_nullable
as bool,isRising: null == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as bool,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition,isMissing: null == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_forecast_first_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiForecastFirstHeight {

@JsonKey(name: 'arrival_time') DateTime get arrivalTime; FirstHeightCondition get condition;
/// Create a copy of TsunamiForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<TsunamiForecastFirstHeight> get copyWith => _$TsunamiForecastFirstHeightCopyWithImpl<TsunamiForecastFirstHeight>(this as TsunamiForecastFirstHeight, _$identity);

  /// Serializes this TsunamiForecastFirstHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiForecastFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,condition);

@override
String toString() {
  return 'TsunamiForecastFirstHeight(arrivalTime: $arrivalTime, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $TsunamiForecastFirstHeightCopyWith<$Res>  {
  factory $TsunamiForecastFirstHeightCopyWith(TsunamiForecastFirstHeight value, $Res Function(TsunamiForecastFirstHeight) _then) = _$TsunamiForecastFirstHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'arrival_time') DateTime arrivalTime, FirstHeightCondition condition
});




}
/// @nodoc
class _$TsunamiForecastFirstHeightCopyWithImpl<$Res>
    implements $TsunamiForecastFirstHeightCopyWith<$Res> {
  _$TsunamiForecastFirstHeightCopyWithImpl(this._self, this._then);

  final TsunamiForecastFirstHeight _self;
  final $Res Function(TsunamiForecastFirstHeight) _then;

/// Create a copy of TsunamiForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = null,Object? condition = null,}) {
  return _then(_self.copyWith(
arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as FirstHeightCondition,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiForecastFirstHeight].
extension TsunamiForecastFirstHeightPatterns on TsunamiForecastFirstHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiForecastFirstHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiForecastFirstHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiForecastFirstHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiForecastFirstHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiForecastFirstHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiForecastFirstHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'arrival_time')  DateTime arrivalTime,  FirstHeightCondition condition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiForecastFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.condition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'arrival_time')  DateTime arrivalTime,  FirstHeightCondition condition)  $default,) {final _that = this;
switch (_that) {
case _TsunamiForecastFirstHeight():
return $default(_that.arrivalTime,_that.condition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'arrival_time')  DateTime arrivalTime,  FirstHeightCondition condition)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiForecastFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.condition);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiForecastFirstHeight implements TsunamiForecastFirstHeight {
  const _TsunamiForecastFirstHeight({@JsonKey(name: 'arrival_time') required this.arrivalTime, required this.condition});
  factory _TsunamiForecastFirstHeight.fromJson(Map<String, dynamic> json) => _$TsunamiForecastFirstHeightFromJson(json);

@override@JsonKey(name: 'arrival_time') final  DateTime arrivalTime;
@override final  FirstHeightCondition condition;

/// Create a copy of TsunamiForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiForecastFirstHeightCopyWith<_TsunamiForecastFirstHeight> get copyWith => __$TsunamiForecastFirstHeightCopyWithImpl<_TsunamiForecastFirstHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiForecastFirstHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiForecastFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,condition);

@override
String toString() {
  return 'TsunamiForecastFirstHeight(arrivalTime: $arrivalTime, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$TsunamiForecastFirstHeightCopyWith<$Res> implements $TsunamiForecastFirstHeightCopyWith<$Res> {
  factory _$TsunamiForecastFirstHeightCopyWith(_TsunamiForecastFirstHeight value, $Res Function(_TsunamiForecastFirstHeight) _then) = __$TsunamiForecastFirstHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'arrival_time') DateTime arrivalTime, FirstHeightCondition condition
});




}
/// @nodoc
class __$TsunamiForecastFirstHeightCopyWithImpl<$Res>
    implements _$TsunamiForecastFirstHeightCopyWith<$Res> {
  __$TsunamiForecastFirstHeightCopyWithImpl(this._self, this._then);

  final _TsunamiForecastFirstHeight _self;
  final $Res Function(_TsunamiForecastFirstHeight) _then;

/// Create a copy of TsunamiForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = null,Object? condition = null,}) {
  return _then(_TsunamiForecastFirstHeight(
arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as FirstHeightCondition,
  ));
}


}

// dart format on

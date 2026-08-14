// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_station_forecast_first_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStationForecastFirstHeight {

/// まだ津波が到達していない場合、到達していないと推測される場合に出現する
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? get arrivalTime;@JsonKey(includeIfNull: false) FirstHeightCondition? get condition;@JsonKey(includeIfNull: false) Revise? get revise;
/// Create a copy of TsunamiStationForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationForecastFirstHeightCopyWith<TsunamiStationForecastFirstHeight> get copyWith => _$TsunamiStationForecastFirstHeightCopyWithImpl<TsunamiStationForecastFirstHeight>(this as TsunamiStationForecastFirstHeight, _$identity);

  /// Serializes this TsunamiStationForecastFirstHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationForecastFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,condition,revise);

@override
String toString() {
  return 'TsunamiStationForecastFirstHeight(arrivalTime: $arrivalTime, condition: $condition, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationForecastFirstHeightCopyWith<$Res>  {
  factory $TsunamiStationForecastFirstHeightCopyWith(TsunamiStationForecastFirstHeight value, $Res Function(TsunamiStationForecastFirstHeight) _then) = _$TsunamiStationForecastFirstHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) FirstHeightCondition? condition,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class _$TsunamiStationForecastFirstHeightCopyWithImpl<$Res>
    implements $TsunamiStationForecastFirstHeightCopyWith<$Res> {
  _$TsunamiStationForecastFirstHeightCopyWithImpl(this._self, this._then);

  final TsunamiStationForecastFirstHeight _self;
  final $Res Function(TsunamiStationForecastFirstHeight) _then;

/// Create a copy of TsunamiStationForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? condition = freezed,Object? revise = freezed,}) {
  return _then(TsunamiStationForecastFirstHeight(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as FirstHeightCondition?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiStationForecastFirstHeight].
extension TsunamiStationForecastFirstHeightPatterns on TsunamiStationForecastFirstHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStationForecastFirstHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStationForecastFirstHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStationForecastFirstHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationForecastFirstHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStationForecastFirstHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationForecastFirstHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  FirstHeightCondition? condition, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStationForecastFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.condition,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  FirstHeightCondition? condition, @JsonKey(includeIfNull: false)  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationForecastFirstHeight():
return $default(_that.arrivalTime,_that.condition,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  FirstHeightCondition? condition, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationForecastFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.condition,_that.revise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStationForecastFirstHeight implements TsunamiStationForecastFirstHeight {
  const _TsunamiStationForecastFirstHeight({@JsonKey(includeIfNull: false, name: 'arrival_time') this.arrivalTime, @JsonKey(includeIfNull: false) this.condition, @JsonKey(includeIfNull: false) this.revise});
  factory _TsunamiStationForecastFirstHeight.fromJson(Map<String, dynamic> json) => _$TsunamiStationForecastFirstHeightFromJson(json);

/// まだ津波が到達していない場合、到達していないと推測される場合に出現する
@override@JsonKey(includeIfNull: false, name: 'arrival_time') final  DateTime? arrivalTime;
@override@JsonKey(includeIfNull: false) final  FirstHeightCondition? condition;
@override@JsonKey(includeIfNull: false) final  Revise? revise;

/// Create a copy of TsunamiStationForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationForecastFirstHeightCopyWith<_TsunamiStationForecastFirstHeight> get copyWith => __$TsunamiStationForecastFirstHeightCopyWithImpl<_TsunamiStationForecastFirstHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStationForecastFirstHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationForecastFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,condition,revise);

@override
String toString() {
  return 'TsunamiStationForecastFirstHeight(arrivalTime: $arrivalTime, condition: $condition, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationForecastFirstHeightCopyWith<$Res> implements $TsunamiStationForecastFirstHeightCopyWith<$Res> {
  factory _$TsunamiStationForecastFirstHeightCopyWith(_TsunamiStationForecastFirstHeight value, $Res Function(_TsunamiStationForecastFirstHeight) _then) = __$TsunamiStationForecastFirstHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) FirstHeightCondition? condition,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class __$TsunamiStationForecastFirstHeightCopyWithImpl<$Res>
    implements _$TsunamiStationForecastFirstHeightCopyWith<$Res> {
  __$TsunamiStationForecastFirstHeightCopyWithImpl(this._self, this._then);

  final _TsunamiStationForecastFirstHeight _self;
  final $Res Function(_TsunamiStationForecastFirstHeight) _then;

/// Create a copy of TsunamiStationForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? condition = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiStationForecastFirstHeight(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as FirstHeightCondition?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}


}

// dart format on

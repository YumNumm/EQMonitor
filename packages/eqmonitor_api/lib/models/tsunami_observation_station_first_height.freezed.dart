// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_observation_station_first_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiObservationStationFirstHeight {

@JsonKey(name: 'arrival_time') DateTime get arrivalTime; WaveInitial get initial;@JsonKey(name: 'is_unidentifiable') bool get isUnidentifiable;@JsonKey(name: 'is_missing') bool get isMissing;
/// Create a copy of TsunamiObservationStationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiObservationStationFirstHeightCopyWith<TsunamiObservationStationFirstHeight> get copyWith => _$TsunamiObservationStationFirstHeightCopyWithImpl<TsunamiObservationStationFirstHeight>(this as TsunamiObservationStationFirstHeight, _$identity);

  /// Serializes this TsunamiObservationStationFirstHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiObservationStationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.isUnidentifiable, isUnidentifiable) || other.isUnidentifiable == isUnidentifiable)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,initial,isUnidentifiable,isMissing);

@override
String toString() {
  return 'TsunamiObservationStationFirstHeight(arrivalTime: $arrivalTime, initial: $initial, isUnidentifiable: $isUnidentifiable, isMissing: $isMissing)';
}


}

/// @nodoc
abstract mixin class $TsunamiObservationStationFirstHeightCopyWith<$Res>  {
  factory $TsunamiObservationStationFirstHeightCopyWith(TsunamiObservationStationFirstHeight value, $Res Function(TsunamiObservationStationFirstHeight) _then) = _$TsunamiObservationStationFirstHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'arrival_time') DateTime arrivalTime, WaveInitial initial,@JsonKey(name: 'is_unidentifiable') bool isUnidentifiable,@JsonKey(name: 'is_missing') bool isMissing
});




}
/// @nodoc
class _$TsunamiObservationStationFirstHeightCopyWithImpl<$Res>
    implements $TsunamiObservationStationFirstHeightCopyWith<$Res> {
  _$TsunamiObservationStationFirstHeightCopyWithImpl(this._self, this._then);

  final TsunamiObservationStationFirstHeight _self;
  final $Res Function(TsunamiObservationStationFirstHeight) _then;

/// Create a copy of TsunamiObservationStationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = null,Object? initial = null,Object? isUnidentifiable = null,Object? isMissing = null,}) {
  return _then(_self.copyWith(
arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as WaveInitial,isUnidentifiable: null == isUnidentifiable ? _self.isUnidentifiable : isUnidentifiable // ignore: cast_nullable_to_non_nullable
as bool,isMissing: null == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiObservationStationFirstHeight].
extension TsunamiObservationStationFirstHeightPatterns on TsunamiObservationStationFirstHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiObservationStationFirstHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiObservationStationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiObservationStationFirstHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiObservationStationFirstHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiObservationStationFirstHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiObservationStationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'arrival_time')  DateTime arrivalTime,  WaveInitial initial, @JsonKey(name: 'is_unidentifiable')  bool isUnidentifiable, @JsonKey(name: 'is_missing')  bool isMissing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiObservationStationFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'arrival_time')  DateTime arrivalTime,  WaveInitial initial, @JsonKey(name: 'is_unidentifiable')  bool isUnidentifiable, @JsonKey(name: 'is_missing')  bool isMissing)  $default,) {final _that = this;
switch (_that) {
case _TsunamiObservationStationFirstHeight():
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'arrival_time')  DateTime arrivalTime,  WaveInitial initial, @JsonKey(name: 'is_unidentifiable')  bool isUnidentifiable, @JsonKey(name: 'is_missing')  bool isMissing)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiObservationStationFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiObservationStationFirstHeight implements TsunamiObservationStationFirstHeight {
  const _TsunamiObservationStationFirstHeight({@JsonKey(name: 'arrival_time') required this.arrivalTime, required this.initial, @JsonKey(name: 'is_unidentifiable') required this.isUnidentifiable, @JsonKey(name: 'is_missing') required this.isMissing});
  factory _TsunamiObservationStationFirstHeight.fromJson(Map<String, dynamic> json) => _$TsunamiObservationStationFirstHeightFromJson(json);

@override@JsonKey(name: 'arrival_time') final  DateTime arrivalTime;
@override final  WaveInitial initial;
@override@JsonKey(name: 'is_unidentifiable') final  bool isUnidentifiable;
@override@JsonKey(name: 'is_missing') final  bool isMissing;

/// Create a copy of TsunamiObservationStationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiObservationStationFirstHeightCopyWith<_TsunamiObservationStationFirstHeight> get copyWith => __$TsunamiObservationStationFirstHeightCopyWithImpl<_TsunamiObservationStationFirstHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiObservationStationFirstHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiObservationStationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.isUnidentifiable, isUnidentifiable) || other.isUnidentifiable == isUnidentifiable)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,initial,isUnidentifiable,isMissing);

@override
String toString() {
  return 'TsunamiObservationStationFirstHeight(arrivalTime: $arrivalTime, initial: $initial, isUnidentifiable: $isUnidentifiable, isMissing: $isMissing)';
}


}

/// @nodoc
abstract mixin class _$TsunamiObservationStationFirstHeightCopyWith<$Res> implements $TsunamiObservationStationFirstHeightCopyWith<$Res> {
  factory _$TsunamiObservationStationFirstHeightCopyWith(_TsunamiObservationStationFirstHeight value, $Res Function(_TsunamiObservationStationFirstHeight) _then) = __$TsunamiObservationStationFirstHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'arrival_time') DateTime arrivalTime, WaveInitial initial,@JsonKey(name: 'is_unidentifiable') bool isUnidentifiable,@JsonKey(name: 'is_missing') bool isMissing
});




}
/// @nodoc
class __$TsunamiObservationStationFirstHeightCopyWithImpl<$Res>
    implements _$TsunamiObservationStationFirstHeightCopyWith<$Res> {
  __$TsunamiObservationStationFirstHeightCopyWithImpl(this._self, this._then);

  final _TsunamiObservationStationFirstHeight _self;
  final $Res Function(_TsunamiObservationStationFirstHeight) _then;

/// Create a copy of TsunamiObservationStationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = null,Object? initial = null,Object? isUnidentifiable = null,Object? isMissing = null,}) {
  return _then(_TsunamiObservationStationFirstHeight(
arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as WaveInitial,isUnidentifiable: null == isUnidentifiable ? _self.isUnidentifiable : isUnidentifiable // ignore: cast_nullable_to_non_nullable
as bool,isMissing: null == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

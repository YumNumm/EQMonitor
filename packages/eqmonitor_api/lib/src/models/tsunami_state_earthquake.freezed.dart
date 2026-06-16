// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_state_earthquake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStateEarthquake {

@JsonKey(name: 'origin_time') DateTime get originTime; TsunamiStateHypocenter get hypocenter;@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? get arrivalTime;
/// Create a copy of TsunamiStateEarthquake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStateEarthquakeCopyWith<TsunamiStateEarthquake> get copyWith => _$TsunamiStateEarthquakeCopyWithImpl<TsunamiStateEarthquake>(this as TsunamiStateEarthquake, _$identity);

  /// Serializes this TsunamiStateEarthquake to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStateEarthquake&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originTime,hypocenter,arrivalTime);

@override
String toString() {
  return 'TsunamiStateEarthquake(originTime: $originTime, hypocenter: $hypocenter, arrivalTime: $arrivalTime)';
}


}

/// @nodoc
abstract mixin class $TsunamiStateEarthquakeCopyWith<$Res>  {
  factory $TsunamiStateEarthquakeCopyWith(TsunamiStateEarthquake value, $Res Function(TsunamiStateEarthquake) _then) = _$TsunamiStateEarthquakeCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'origin_time') DateTime originTime, TsunamiStateHypocenter hypocenter,@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime
});


$TsunamiStateHypocenterCopyWith<$Res> get hypocenter;

}
/// @nodoc
class _$TsunamiStateEarthquakeCopyWithImpl<$Res>
    implements $TsunamiStateEarthquakeCopyWith<$Res> {
  _$TsunamiStateEarthquakeCopyWithImpl(this._self, this._then);

  final TsunamiStateEarthquake _self;
  final $Res Function(TsunamiStateEarthquake) _then;

/// Create a copy of TsunamiStateEarthquake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originTime = null,Object? hypocenter = null,Object? arrivalTime = freezed,}) {
  return _then(_self.copyWith(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as TsunamiStateHypocenter,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of TsunamiStateEarthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStateHypocenterCopyWith<$Res> get hypocenter {
  
  return $TsunamiStateHypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiStateEarthquake].
extension TsunamiStateEarthquakePatterns on TsunamiStateEarthquake {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStateEarthquake value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStateEarthquake() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStateEarthquake value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStateEarthquake():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStateEarthquake value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStateEarthquake() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'origin_time')  DateTime originTime,  TsunamiStateHypocenter hypocenter, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStateEarthquake() when $default != null:
return $default(_that.originTime,_that.hypocenter,_that.arrivalTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'origin_time')  DateTime originTime,  TsunamiStateHypocenter hypocenter, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStateEarthquake():
return $default(_that.originTime,_that.hypocenter,_that.arrivalTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'origin_time')  DateTime originTime,  TsunamiStateHypocenter hypocenter, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStateEarthquake() when $default != null:
return $default(_that.originTime,_that.hypocenter,_that.arrivalTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStateEarthquake implements TsunamiStateEarthquake {
  const _TsunamiStateEarthquake({@JsonKey(name: 'origin_time') required this.originTime, required this.hypocenter, @JsonKey(includeIfNull: false, name: 'arrival_time') this.arrivalTime});
  factory _TsunamiStateEarthquake.fromJson(Map<String, dynamic> json) => _$TsunamiStateEarthquakeFromJson(json);

@override@JsonKey(name: 'origin_time') final  DateTime originTime;
@override final  TsunamiStateHypocenter hypocenter;
@override@JsonKey(includeIfNull: false, name: 'arrival_time') final  DateTime? arrivalTime;

/// Create a copy of TsunamiStateEarthquake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStateEarthquakeCopyWith<_TsunamiStateEarthquake> get copyWith => __$TsunamiStateEarthquakeCopyWithImpl<_TsunamiStateEarthquake>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStateEarthquakeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStateEarthquake&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originTime,hypocenter,arrivalTime);

@override
String toString() {
  return 'TsunamiStateEarthquake(originTime: $originTime, hypocenter: $hypocenter, arrivalTime: $arrivalTime)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStateEarthquakeCopyWith<$Res> implements $TsunamiStateEarthquakeCopyWith<$Res> {
  factory _$TsunamiStateEarthquakeCopyWith(_TsunamiStateEarthquake value, $Res Function(_TsunamiStateEarthquake) _then) = __$TsunamiStateEarthquakeCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'origin_time') DateTime originTime, TsunamiStateHypocenter hypocenter,@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime
});


@override $TsunamiStateHypocenterCopyWith<$Res> get hypocenter;

}
/// @nodoc
class __$TsunamiStateEarthquakeCopyWithImpl<$Res>
    implements _$TsunamiStateEarthquakeCopyWith<$Res> {
  __$TsunamiStateEarthquakeCopyWithImpl(this._self, this._then);

  final _TsunamiStateEarthquake _self;
  final $Res Function(_TsunamiStateEarthquake) _then;

/// Create a copy of TsunamiStateEarthquake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originTime = null,Object? hypocenter = null,Object? arrivalTime = freezed,}) {
  return _then(_TsunamiStateEarthquake(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as TsunamiStateHypocenter,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of TsunamiStateEarthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStateHypocenterCopyWith<$Res> get hypocenter {
  
  return $TsunamiStateHypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_state_earthquake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiStateEarthquake {

 DateTime get originTime; TsunamiEarthquakeHypocenter get hypocenter; DateTime? get arrivalTime;
/// Create a copy of TsunamiStateEarthquake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStateEarthquakeCopyWith<TsunamiStateEarthquake> get copyWith => _$TsunamiStateEarthquakeCopyWithImpl<TsunamiStateEarthquake>(this as TsunamiStateEarthquake, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStateEarthquake&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}


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
 DateTime originTime, TsunamiEarthquakeHypocenter hypocenter, DateTime? arrivalTime
});


$TsunamiEarthquakeHypocenterCopyWith<$Res> get hypocenter;

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
  return _then(TsunamiStateEarthquake(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as TsunamiEarthquakeHypocenter,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of TsunamiStateEarthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEarthquakeHypocenterCopyWith<$Res> get hypocenter {
  
  return $TsunamiEarthquakeHypocenterCopyWith<$Res>(_self.hypocenter, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime originTime,  TsunamiEarthquakeHypocenter hypocenter,  DateTime? arrivalTime)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime originTime,  TsunamiEarthquakeHypocenter hypocenter,  DateTime? arrivalTime)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime originTime,  TsunamiEarthquakeHypocenter hypocenter,  DateTime? arrivalTime)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStateEarthquake() when $default != null:
return $default(_that.originTime,_that.hypocenter,_that.arrivalTime);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiStateEarthquake implements TsunamiStateEarthquake {
  const _TsunamiStateEarthquake({required this.originTime, required this.hypocenter, this.arrivalTime});
  

@override final  DateTime originTime;
@override final  TsunamiEarthquakeHypocenter hypocenter;
@override final  DateTime? arrivalTime;

/// Create a copy of TsunamiStateEarthquake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStateEarthquakeCopyWith<_TsunamiStateEarthquake> get copyWith => __$TsunamiStateEarthquakeCopyWithImpl<_TsunamiStateEarthquake>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStateEarthquake&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}


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
 DateTime originTime, TsunamiEarthquakeHypocenter hypocenter, DateTime? arrivalTime
});


@override $TsunamiEarthquakeHypocenterCopyWith<$Res> get hypocenter;

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
as TsunamiEarthquakeHypocenter,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of TsunamiStateEarthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEarthquakeHypocenterCopyWith<$Res> get hypocenter {
  
  return $TsunamiEarthquakeHypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}

// dart format on

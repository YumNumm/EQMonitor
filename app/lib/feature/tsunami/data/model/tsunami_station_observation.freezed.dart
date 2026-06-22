// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_station_observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiStationObservation {

 String? get sensor; TsunamiObservationFirstHeight get firstHeight; TsunamiObservationMaxHeight? get maxHeight;
/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationObservationCopyWith<TsunamiStationObservation> get copyWith => _$TsunamiStationObservationCopyWithImpl<TsunamiStationObservation>(this as TsunamiStationObservation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationObservation&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}


@override
int get hashCode => Object.hash(runtimeType,sensor,firstHeight,maxHeight);

@override
String toString() {
  return 'TsunamiStationObservation(sensor: $sensor, firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationObservationCopyWith<$Res>  {
  factory $TsunamiStationObservationCopyWith(TsunamiStationObservation value, $Res Function(TsunamiStationObservation) _then) = _$TsunamiStationObservationCopyWithImpl;
@useResult
$Res call({
 String? sensor, TsunamiObservationFirstHeight firstHeight, TsunamiObservationMaxHeight? maxHeight
});


$TsunamiObservationFirstHeightCopyWith<$Res> get firstHeight;$TsunamiObservationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class _$TsunamiStationObservationCopyWithImpl<$Res>
    implements $TsunamiStationObservationCopyWith<$Res> {
  _$TsunamiStationObservationCopyWithImpl(this._self, this._then);

  final TsunamiStationObservation _self;
  final $Res Function(TsunamiStationObservation) _then;

/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sensor = freezed,Object? firstHeight = null,Object? maxHeight = freezed,}) {
  return _then(_self.copyWith(
sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as String?,firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiObservationFirstHeight,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiObservationMaxHeight?,
  ));
}
/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiObservationFirstHeightCopyWith<$Res> get firstHeight {
  
  return $TsunamiObservationFirstHeightCopyWith<$Res>(_self.firstHeight, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiObservationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiObservationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiStationObservation].
extension TsunamiStationObservationPatterns on TsunamiStationObservation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStationObservation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStationObservation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStationObservation value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationObservation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStationObservation value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationObservation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? sensor,  TsunamiObservationFirstHeight firstHeight,  TsunamiObservationMaxHeight? maxHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStationObservation() when $default != null:
return $default(_that.sensor,_that.firstHeight,_that.maxHeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? sensor,  TsunamiObservationFirstHeight firstHeight,  TsunamiObservationMaxHeight? maxHeight)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationObservation():
return $default(_that.sensor,_that.firstHeight,_that.maxHeight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? sensor,  TsunamiObservationFirstHeight firstHeight,  TsunamiObservationMaxHeight? maxHeight)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationObservation() when $default != null:
return $default(_that.sensor,_that.firstHeight,_that.maxHeight);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiStationObservation implements TsunamiStationObservation {
  const _TsunamiStationObservation({required this.sensor, required this.firstHeight, required this.maxHeight});
  

@override final  String? sensor;
@override final  TsunamiObservationFirstHeight firstHeight;
@override final  TsunamiObservationMaxHeight? maxHeight;

/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationObservationCopyWith<_TsunamiStationObservation> get copyWith => __$TsunamiStationObservationCopyWithImpl<_TsunamiStationObservation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationObservation&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}


@override
int get hashCode => Object.hash(runtimeType,sensor,firstHeight,maxHeight);

@override
String toString() {
  return 'TsunamiStationObservation(sensor: $sensor, firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationObservationCopyWith<$Res> implements $TsunamiStationObservationCopyWith<$Res> {
  factory _$TsunamiStationObservationCopyWith(_TsunamiStationObservation value, $Res Function(_TsunamiStationObservation) _then) = __$TsunamiStationObservationCopyWithImpl;
@override @useResult
$Res call({
 String? sensor, TsunamiObservationFirstHeight firstHeight, TsunamiObservationMaxHeight? maxHeight
});


@override $TsunamiObservationFirstHeightCopyWith<$Res> get firstHeight;@override $TsunamiObservationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class __$TsunamiStationObservationCopyWithImpl<$Res>
    implements _$TsunamiStationObservationCopyWith<$Res> {
  __$TsunamiStationObservationCopyWithImpl(this._self, this._then);

  final _TsunamiStationObservation _self;
  final $Res Function(_TsunamiStationObservation) _then;

/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sensor = freezed,Object? firstHeight = null,Object? maxHeight = freezed,}) {
  return _then(_TsunamiStationObservation(
sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as String?,firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiObservationFirstHeight,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiObservationMaxHeight?,
  ));
}

/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiObservationFirstHeightCopyWith<$Res> get firstHeight {
  
  return $TsunamiObservationFirstHeightCopyWith<$Res>(_self.firstHeight, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiObservationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiObservationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

// dart format on

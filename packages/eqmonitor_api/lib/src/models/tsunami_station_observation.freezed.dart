// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_station_observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStationObservation {

@JsonKey(name: 'first_height') TsunamiStationObservationFirstHeight get firstHeight;/// 特殊な観測機器の場合に出現
@JsonKey(includeIfNull: false) String? get sensor;@JsonKey(includeIfNull: false, name: 'max_height') TsunamiStationObservationMaxHeight? get maxHeight;
/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationObservationCopyWith<TsunamiStationObservation> get copyWith => _$TsunamiStationObservationCopyWithImpl<TsunamiStationObservation>(this as TsunamiStationObservation, _$identity);

  /// Serializes this TsunamiStationObservation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationObservation&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstHeight,sensor,maxHeight);

@override
String toString() {
  return 'TsunamiStationObservation(firstHeight: $firstHeight, sensor: $sensor, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationObservationCopyWith<$Res>  {
  factory $TsunamiStationObservationCopyWith(TsunamiStationObservation value, $Res Function(TsunamiStationObservation) _then) = _$TsunamiStationObservationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'first_height') TsunamiStationObservationFirstHeight firstHeight,@JsonKey(includeIfNull: false) String? sensor,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiStationObservationMaxHeight? maxHeight
});


$TsunamiStationObservationFirstHeightCopyWith<$Res> get firstHeight;$TsunamiStationObservationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class _$TsunamiStationObservationCopyWithImpl<$Res>
    implements $TsunamiStationObservationCopyWith<$Res> {
  _$TsunamiStationObservationCopyWithImpl(this._self, this._then);

  final TsunamiStationObservation _self;
  final $Res Function(TsunamiStationObservation) _then;

/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstHeight = null,Object? sensor = freezed,Object? maxHeight = freezed,}) {
  return _then(TsunamiStationObservation(
firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationObservationFirstHeight,sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as String?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationObservationMaxHeight?,
  ));
}
/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationObservationFirstHeightCopyWith<$Res> get firstHeight {

  return $TsunamiStationObservationFirstHeightCopyWith<$Res>(_self.firstHeight, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationObservationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiStationObservationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_height')  TsunamiStationObservationFirstHeight firstHeight, @JsonKey(includeIfNull: false)  String? sensor, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiStationObservationMaxHeight? maxHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStationObservation() when $default != null:
return $default(_that.firstHeight,_that.sensor,_that.maxHeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_height')  TsunamiStationObservationFirstHeight firstHeight, @JsonKey(includeIfNull: false)  String? sensor, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiStationObservationMaxHeight? maxHeight)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationObservation():
return $default(_that.firstHeight,_that.sensor,_that.maxHeight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'first_height')  TsunamiStationObservationFirstHeight firstHeight, @JsonKey(includeIfNull: false)  String? sensor, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiStationObservationMaxHeight? maxHeight)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationObservation() when $default != null:
return $default(_that.firstHeight,_that.sensor,_that.maxHeight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStationObservation implements TsunamiStationObservation {
  const _TsunamiStationObservation({@JsonKey(name: 'first_height') required this.firstHeight, @JsonKey(includeIfNull: false) this.sensor, @JsonKey(includeIfNull: false, name: 'max_height') this.maxHeight});
  factory _TsunamiStationObservation.fromJson(Map<String, dynamic> json) => _$TsunamiStationObservationFromJson(json);

@override@JsonKey(name: 'first_height') final  TsunamiStationObservationFirstHeight firstHeight;
/// 特殊な観測機器の場合に出現
@override@JsonKey(includeIfNull: false) final  String? sensor;
@override@JsonKey(includeIfNull: false, name: 'max_height') final  TsunamiStationObservationMaxHeight? maxHeight;

/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationObservationCopyWith<_TsunamiStationObservation> get copyWith => __$TsunamiStationObservationCopyWithImpl<_TsunamiStationObservation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStationObservationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationObservation&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstHeight,sensor,maxHeight);

@override
String toString() {
  return 'TsunamiStationObservation(firstHeight: $firstHeight, sensor: $sensor, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationObservationCopyWith<$Res> implements $TsunamiStationObservationCopyWith<$Res> {
  factory _$TsunamiStationObservationCopyWith(_TsunamiStationObservation value, $Res Function(_TsunamiStationObservation) _then) = __$TsunamiStationObservationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'first_height') TsunamiStationObservationFirstHeight firstHeight,@JsonKey(includeIfNull: false) String? sensor,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiStationObservationMaxHeight? maxHeight
});


@override $TsunamiStationObservationFirstHeightCopyWith<$Res> get firstHeight;@override $TsunamiStationObservationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class __$TsunamiStationObservationCopyWithImpl<$Res>
    implements _$TsunamiStationObservationCopyWith<$Res> {
  __$TsunamiStationObservationCopyWithImpl(this._self, this._then);

  final _TsunamiStationObservation _self;
  final $Res Function(_TsunamiStationObservation) _then;

/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstHeight = null,Object? sensor = freezed,Object? maxHeight = freezed,}) {
  return _then(_TsunamiStationObservation(
firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationObservationFirstHeight,sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as String?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationObservationMaxHeight?,
  ));
}

/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationObservationFirstHeightCopyWith<$Res> get firstHeight {

  return $TsunamiStationObservationFirstHeightCopyWith<$Res>(_self.firstHeight, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiStationObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationObservationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiStationObservationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

// dart format on

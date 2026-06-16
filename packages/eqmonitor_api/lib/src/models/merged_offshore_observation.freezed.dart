// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merged_offshore_observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MergedOffshoreObservation {

@JsonKey(name: 'station_code') String get stationCode;@JsonKey(name: 'station_name') String get stationName;@JsonKey(includeIfNull: false) String? get sensor;@JsonKey(includeIfNull: false, name: 'first_height') TsunamiObservationStationFirstHeight? get firstHeight;@JsonKey(includeIfNull: false, name: 'max_height') TsunamiObservationStationMaxHeight? get maxHeight;
/// Create a copy of MergedOffshoreObservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MergedOffshoreObservationCopyWith<MergedOffshoreObservation> get copyWith => _$MergedOffshoreObservationCopyWithImpl<MergedOffshoreObservation>(this as MergedOffshoreObservation, _$identity);

  /// Serializes this MergedOffshoreObservation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MergedOffshoreObservation&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stationCode,stationName,sensor,firstHeight,maxHeight);

@override
String toString() {
  return 'MergedOffshoreObservation(stationCode: $stationCode, stationName: $stationName, sensor: $sensor, firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class $MergedOffshoreObservationCopyWith<$Res>  {
  factory $MergedOffshoreObservationCopyWith(MergedOffshoreObservation value, $Res Function(MergedOffshoreObservation) _then) = _$MergedOffshoreObservationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'station_code') String stationCode,@JsonKey(name: 'station_name') String stationName,@JsonKey(includeIfNull: false) String? sensor,@JsonKey(includeIfNull: false, name: 'first_height') TsunamiObservationStationFirstHeight? firstHeight,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiObservationStationMaxHeight? maxHeight
});


$TsunamiObservationStationFirstHeightCopyWith<$Res>? get firstHeight;$TsunamiObservationStationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class _$MergedOffshoreObservationCopyWithImpl<$Res>
    implements $MergedOffshoreObservationCopyWith<$Res> {
  _$MergedOffshoreObservationCopyWithImpl(this._self, this._then);

  final MergedOffshoreObservation _self;
  final $Res Function(MergedOffshoreObservation) _then;

/// Create a copy of MergedOffshoreObservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stationCode = null,Object? stationName = null,Object? sensor = freezed,Object? firstHeight = freezed,Object? maxHeight = freezed,}) {
  return _then(_self.copyWith(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,stationName: null == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String,sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as String?,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiObservationStationFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiObservationStationMaxHeight?,
  ));
}
/// Create a copy of MergedOffshoreObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiObservationStationFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiObservationStationFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of MergedOffshoreObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiObservationStationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiObservationStationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [MergedOffshoreObservation].
extension MergedOffshoreObservationPatterns on MergedOffshoreObservation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MergedOffshoreObservation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MergedOffshoreObservation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MergedOffshoreObservation value)  $default,){
final _that = this;
switch (_that) {
case _MergedOffshoreObservation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MergedOffshoreObservation value)?  $default,){
final _that = this;
switch (_that) {
case _MergedOffshoreObservation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'station_code')  String stationCode, @JsonKey(name: 'station_name')  String stationName, @JsonKey(includeIfNull: false)  String? sensor, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiObservationStationFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiObservationStationMaxHeight? maxHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MergedOffshoreObservation() when $default != null:
return $default(_that.stationCode,_that.stationName,_that.sensor,_that.firstHeight,_that.maxHeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'station_code')  String stationCode, @JsonKey(name: 'station_name')  String stationName, @JsonKey(includeIfNull: false)  String? sensor, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiObservationStationFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiObservationStationMaxHeight? maxHeight)  $default,) {final _that = this;
switch (_that) {
case _MergedOffshoreObservation():
return $default(_that.stationCode,_that.stationName,_that.sensor,_that.firstHeight,_that.maxHeight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'station_code')  String stationCode, @JsonKey(name: 'station_name')  String stationName, @JsonKey(includeIfNull: false)  String? sensor, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiObservationStationFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiObservationStationMaxHeight? maxHeight)?  $default,) {final _that = this;
switch (_that) {
case _MergedOffshoreObservation() when $default != null:
return $default(_that.stationCode,_that.stationName,_that.sensor,_that.firstHeight,_that.maxHeight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MergedOffshoreObservation implements MergedOffshoreObservation {
  const _MergedOffshoreObservation({@JsonKey(name: 'station_code') required this.stationCode, @JsonKey(name: 'station_name') required this.stationName, @JsonKey(includeIfNull: false) this.sensor, @JsonKey(includeIfNull: false, name: 'first_height') this.firstHeight, @JsonKey(includeIfNull: false, name: 'max_height') this.maxHeight});
  factory _MergedOffshoreObservation.fromJson(Map<String, dynamic> json) => _$MergedOffshoreObservationFromJson(json);

@override@JsonKey(name: 'station_code') final  String stationCode;
@override@JsonKey(name: 'station_name') final  String stationName;
@override@JsonKey(includeIfNull: false) final  String? sensor;
@override@JsonKey(includeIfNull: false, name: 'first_height') final  TsunamiObservationStationFirstHeight? firstHeight;
@override@JsonKey(includeIfNull: false, name: 'max_height') final  TsunamiObservationStationMaxHeight? maxHeight;

/// Create a copy of MergedOffshoreObservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MergedOffshoreObservationCopyWith<_MergedOffshoreObservation> get copyWith => __$MergedOffshoreObservationCopyWithImpl<_MergedOffshoreObservation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MergedOffshoreObservationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MergedOffshoreObservation&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stationCode,stationName,sensor,firstHeight,maxHeight);

@override
String toString() {
  return 'MergedOffshoreObservation(stationCode: $stationCode, stationName: $stationName, sensor: $sensor, firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class _$MergedOffshoreObservationCopyWith<$Res> implements $MergedOffshoreObservationCopyWith<$Res> {
  factory _$MergedOffshoreObservationCopyWith(_MergedOffshoreObservation value, $Res Function(_MergedOffshoreObservation) _then) = __$MergedOffshoreObservationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'station_code') String stationCode,@JsonKey(name: 'station_name') String stationName,@JsonKey(includeIfNull: false) String? sensor,@JsonKey(includeIfNull: false, name: 'first_height') TsunamiObservationStationFirstHeight? firstHeight,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiObservationStationMaxHeight? maxHeight
});


@override $TsunamiObservationStationFirstHeightCopyWith<$Res>? get firstHeight;@override $TsunamiObservationStationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class __$MergedOffshoreObservationCopyWithImpl<$Res>
    implements _$MergedOffshoreObservationCopyWith<$Res> {
  __$MergedOffshoreObservationCopyWithImpl(this._self, this._then);

  final _MergedOffshoreObservation _self;
  final $Res Function(_MergedOffshoreObservation) _then;

/// Create a copy of MergedOffshoreObservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stationCode = null,Object? stationName = null,Object? sensor = freezed,Object? firstHeight = freezed,Object? maxHeight = freezed,}) {
  return _then(_MergedOffshoreObservation(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,stationName: null == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String,sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as String?,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiObservationStationFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiObservationStationMaxHeight?,
  ));
}

/// Create a copy of MergedOffshoreObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiObservationStationFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiObservationStationFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of MergedOffshoreObservation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiObservationStationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiObservationStationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

// dart format on

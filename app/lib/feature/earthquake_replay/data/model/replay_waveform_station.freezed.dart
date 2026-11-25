// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_waveform_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReplayWaveformStation {

 String get stationCode; double get latitude; double get longitude; RealtimeIntensitySeries get intensities;
/// Create a copy of ReplayWaveformStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayWaveformStationCopyWith<ReplayWaveformStation> get copyWith => _$ReplayWaveformStationCopyWithImpl<ReplayWaveformStation>(this as ReplayWaveformStation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayWaveformStation&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.intensities, intensities) || other.intensities == intensities));
}


@override
int get hashCode => Object.hash(runtimeType,stationCode,latitude,longitude,intensities);

@override
String toString() {
  return 'ReplayWaveformStation(stationCode: $stationCode, latitude: $latitude, longitude: $longitude, intensities: $intensities)';
}


}

/// @nodoc
abstract mixin class $ReplayWaveformStationCopyWith<$Res>  {
  factory $ReplayWaveformStationCopyWith(ReplayWaveformStation value, $Res Function(ReplayWaveformStation) _then) = _$ReplayWaveformStationCopyWithImpl;
@useResult
$Res call({
 String stationCode, double latitude, double longitude, RealtimeIntensitySeries intensities
});




}
/// @nodoc
class _$ReplayWaveformStationCopyWithImpl<$Res>
    implements $ReplayWaveformStationCopyWith<$Res> {
  _$ReplayWaveformStationCopyWithImpl(this._self, this._then);

  final ReplayWaveformStation _self;
  final $Res Function(ReplayWaveformStation) _then;

/// Create a copy of ReplayWaveformStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stationCode = null,Object? latitude = null,Object? longitude = null,Object? intensities = null,}) {
  return _then(ReplayWaveformStation(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,intensities: null == intensities ? _self.intensities : intensities // ignore: cast_nullable_to_non_nullable
as RealtimeIntensitySeries,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplayWaveformStation].
extension ReplayWaveformStationPatterns on ReplayWaveformStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayWaveformStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayWaveformStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayWaveformStation value)  $default,){
final _that = this;
switch (_that) {
case _ReplayWaveformStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayWaveformStation value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayWaveformStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stationCode,  double latitude,  double longitude,  RealtimeIntensitySeries intensities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplayWaveformStation() when $default != null:
return $default(_that.stationCode,_that.latitude,_that.longitude,_that.intensities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stationCode,  double latitude,  double longitude,  RealtimeIntensitySeries intensities)  $default,) {final _that = this;
switch (_that) {
case _ReplayWaveformStation():
return $default(_that.stationCode,_that.latitude,_that.longitude,_that.intensities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stationCode,  double latitude,  double longitude,  RealtimeIntensitySeries intensities)?  $default,) {final _that = this;
switch (_that) {
case _ReplayWaveformStation() when $default != null:
return $default(_that.stationCode,_that.latitude,_that.longitude,_that.intensities);case _:
  return null;

}
}

}

/// @nodoc


class _ReplayWaveformStation implements ReplayWaveformStation {
  const _ReplayWaveformStation({required this.stationCode, required this.latitude, required this.longitude, required this.intensities});
  

@override final  String stationCode;
@override final  double latitude;
@override final  double longitude;
@override final  RealtimeIntensitySeries intensities;

/// Create a copy of ReplayWaveformStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayWaveformStationCopyWith<_ReplayWaveformStation> get copyWith => __$ReplayWaveformStationCopyWithImpl<_ReplayWaveformStation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayWaveformStation&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.intensities, intensities) || other.intensities == intensities));
}


@override
int get hashCode => Object.hash(runtimeType,stationCode,latitude,longitude,intensities);

@override
String toString() {
  return 'ReplayWaveformStation(stationCode: $stationCode, latitude: $latitude, longitude: $longitude, intensities: $intensities)';
}


}

/// @nodoc
abstract mixin class _$ReplayWaveformStationCopyWith<$Res> implements $ReplayWaveformStationCopyWith<$Res> {
  factory _$ReplayWaveformStationCopyWith(_ReplayWaveformStation value, $Res Function(_ReplayWaveformStation) _then) = __$ReplayWaveformStationCopyWithImpl;
@override @useResult
$Res call({
 String stationCode, double latitude, double longitude, RealtimeIntensitySeries intensities
});




}
/// @nodoc
class __$ReplayWaveformStationCopyWithImpl<$Res>
    implements _$ReplayWaveformStationCopyWith<$Res> {
  __$ReplayWaveformStationCopyWithImpl(this._self, this._then);

  final _ReplayWaveformStation _self;
  final $Res Function(_ReplayWaveformStation) _then;

/// Create a copy of ReplayWaveformStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stationCode = null,Object? latitude = null,Object? longitude = null,Object? intensities = null,}) {
  return _then(_ReplayWaveformStation(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,intensities: null == intensities ? _self.intensities : intensities // ignore: cast_nullable_to_non_nullable
as RealtimeIntensitySeries,
  ));
}


}

// dart format on

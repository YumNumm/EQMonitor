// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_waveform_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinWaveformMetadata {

 String get network; String get component; String get stationCode; double get stationLatitude; double get stationLongitude; double get stationHeightMeters; DateTime get recordTime; DateTime get startTime; int get samplingHz; String get direction; double get scaleNumeratorGal; double get scaleDenominator; double get maxAccelerationGal;
/// Create a copy of KyoshinWaveformMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinWaveformMetadataCopyWith<KyoshinWaveformMetadata> get copyWith => _$KyoshinWaveformMetadataCopyWithImpl<KyoshinWaveformMetadata>(this as KyoshinWaveformMetadata, _$identity);

  /// Serializes this KyoshinWaveformMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinWaveformMetadata&&(identical(other.network, network) || other.network == network)&&(identical(other.component, component) || other.component == component)&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.stationLatitude, stationLatitude) || other.stationLatitude == stationLatitude)&&(identical(other.stationLongitude, stationLongitude) || other.stationLongitude == stationLongitude)&&(identical(other.stationHeightMeters, stationHeightMeters) || other.stationHeightMeters == stationHeightMeters)&&(identical(other.recordTime, recordTime) || other.recordTime == recordTime)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.samplingHz, samplingHz) || other.samplingHz == samplingHz)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.scaleNumeratorGal, scaleNumeratorGal) || other.scaleNumeratorGal == scaleNumeratorGal)&&(identical(other.scaleDenominator, scaleDenominator) || other.scaleDenominator == scaleDenominator)&&(identical(other.maxAccelerationGal, maxAccelerationGal) || other.maxAccelerationGal == maxAccelerationGal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,component,stationCode,stationLatitude,stationLongitude,stationHeightMeters,recordTime,startTime,samplingHz,direction,scaleNumeratorGal,scaleDenominator,maxAccelerationGal);

@override
String toString() {
  return 'KyoshinWaveformMetadata(network: $network, component: $component, stationCode: $stationCode, stationLatitude: $stationLatitude, stationLongitude: $stationLongitude, stationHeightMeters: $stationHeightMeters, recordTime: $recordTime, startTime: $startTime, samplingHz: $samplingHz, direction: $direction, scaleNumeratorGal: $scaleNumeratorGal, scaleDenominator: $scaleDenominator, maxAccelerationGal: $maxAccelerationGal)';
}


}

/// @nodoc
abstract mixin class $KyoshinWaveformMetadataCopyWith<$Res>  {
  factory $KyoshinWaveformMetadataCopyWith(KyoshinWaveformMetadata value, $Res Function(KyoshinWaveformMetadata) _then) = _$KyoshinWaveformMetadataCopyWithImpl;
@useResult
$Res call({
 String network, String component, String stationCode, double stationLatitude, double stationLongitude, double stationHeightMeters, DateTime recordTime, DateTime startTime, int samplingHz, String direction, double scaleNumeratorGal, double scaleDenominator, double maxAccelerationGal
});




}
/// @nodoc
class _$KyoshinWaveformMetadataCopyWithImpl<$Res>
    implements $KyoshinWaveformMetadataCopyWith<$Res> {
  _$KyoshinWaveformMetadataCopyWithImpl(this._self, this._then);

  final KyoshinWaveformMetadata _self;
  final $Res Function(KyoshinWaveformMetadata) _then;

/// Create a copy of KyoshinWaveformMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? network = null,Object? component = null,Object? stationCode = null,Object? stationLatitude = null,Object? stationLongitude = null,Object? stationHeightMeters = null,Object? recordTime = null,Object? startTime = null,Object? samplingHz = null,Object? direction = null,Object? scaleNumeratorGal = null,Object? scaleDenominator = null,Object? maxAccelerationGal = null,}) {
  return _then(KyoshinWaveformMetadata(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,component: null == component ? _self.component : component // ignore: cast_nullable_to_non_nullable
as String,stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,stationLatitude: null == stationLatitude ? _self.stationLatitude : stationLatitude // ignore: cast_nullable_to_non_nullable
as double,stationLongitude: null == stationLongitude ? _self.stationLongitude : stationLongitude // ignore: cast_nullable_to_non_nullable
as double,stationHeightMeters: null == stationHeightMeters ? _self.stationHeightMeters : stationHeightMeters // ignore: cast_nullable_to_non_nullable
as double,recordTime: null == recordTime ? _self.recordTime : recordTime // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,samplingHz: null == samplingHz ? _self.samplingHz : samplingHz // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,scaleNumeratorGal: null == scaleNumeratorGal ? _self.scaleNumeratorGal : scaleNumeratorGal // ignore: cast_nullable_to_non_nullable
as double,scaleDenominator: null == scaleDenominator ? _self.scaleDenominator : scaleDenominator // ignore: cast_nullable_to_non_nullable
as double,maxAccelerationGal: null == maxAccelerationGal ? _self.maxAccelerationGal : maxAccelerationGal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [KyoshinWaveformMetadata].
extension KyoshinWaveformMetadataPatterns on KyoshinWaveformMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinWaveformMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinWaveformMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinWaveformMetadata value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinWaveformMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinWaveformMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinWaveformMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String network,  String component,  String stationCode,  double stationLatitude,  double stationLongitude,  double stationHeightMeters,  DateTime recordTime,  DateTime startTime,  int samplingHz,  String direction,  double scaleNumeratorGal,  double scaleDenominator,  double maxAccelerationGal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinWaveformMetadata() when $default != null:
return $default(_that.network,_that.component,_that.stationCode,_that.stationLatitude,_that.stationLongitude,_that.stationHeightMeters,_that.recordTime,_that.startTime,_that.samplingHz,_that.direction,_that.scaleNumeratorGal,_that.scaleDenominator,_that.maxAccelerationGal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String network,  String component,  String stationCode,  double stationLatitude,  double stationLongitude,  double stationHeightMeters,  DateTime recordTime,  DateTime startTime,  int samplingHz,  String direction,  double scaleNumeratorGal,  double scaleDenominator,  double maxAccelerationGal)  $default,) {final _that = this;
switch (_that) {
case _KyoshinWaveformMetadata():
return $default(_that.network,_that.component,_that.stationCode,_that.stationLatitude,_that.stationLongitude,_that.stationHeightMeters,_that.recordTime,_that.startTime,_that.samplingHz,_that.direction,_that.scaleNumeratorGal,_that.scaleDenominator,_that.maxAccelerationGal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String network,  String component,  String stationCode,  double stationLatitude,  double stationLongitude,  double stationHeightMeters,  DateTime recordTime,  DateTime startTime,  int samplingHz,  String direction,  double scaleNumeratorGal,  double scaleDenominator,  double maxAccelerationGal)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinWaveformMetadata() when $default != null:
return $default(_that.network,_that.component,_that.stationCode,_that.stationLatitude,_that.stationLongitude,_that.stationHeightMeters,_that.recordTime,_that.startTime,_that.samplingHz,_that.direction,_that.scaleNumeratorGal,_that.scaleDenominator,_that.maxAccelerationGal);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _KyoshinWaveformMetadata implements KyoshinWaveformMetadata {
  const _KyoshinWaveformMetadata({required this.network, required this.component, required this.stationCode, required this.stationLatitude, required this.stationLongitude, required this.stationHeightMeters, required this.recordTime, required this.startTime, required this.samplingHz, required this.direction, required this.scaleNumeratorGal, required this.scaleDenominator, required this.maxAccelerationGal});
  factory _KyoshinWaveformMetadata.fromJson(Map<String, dynamic> json) => _$KyoshinWaveformMetadataFromJson(json);

@override final  String network;
@override final  String component;
@override final  String stationCode;
@override final  double stationLatitude;
@override final  double stationLongitude;
@override final  double stationHeightMeters;
@override final  DateTime recordTime;
@override final  DateTime startTime;
@override final  int samplingHz;
@override final  String direction;
@override final  double scaleNumeratorGal;
@override final  double scaleDenominator;
@override final  double maxAccelerationGal;

/// Create a copy of KyoshinWaveformMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinWaveformMetadataCopyWith<_KyoshinWaveformMetadata> get copyWith => __$KyoshinWaveformMetadataCopyWithImpl<_KyoshinWaveformMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinWaveformMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinWaveformMetadata&&(identical(other.network, network) || other.network == network)&&(identical(other.component, component) || other.component == component)&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.stationLatitude, stationLatitude) || other.stationLatitude == stationLatitude)&&(identical(other.stationLongitude, stationLongitude) || other.stationLongitude == stationLongitude)&&(identical(other.stationHeightMeters, stationHeightMeters) || other.stationHeightMeters == stationHeightMeters)&&(identical(other.recordTime, recordTime) || other.recordTime == recordTime)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.samplingHz, samplingHz) || other.samplingHz == samplingHz)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.scaleNumeratorGal, scaleNumeratorGal) || other.scaleNumeratorGal == scaleNumeratorGal)&&(identical(other.scaleDenominator, scaleDenominator) || other.scaleDenominator == scaleDenominator)&&(identical(other.maxAccelerationGal, maxAccelerationGal) || other.maxAccelerationGal == maxAccelerationGal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,component,stationCode,stationLatitude,stationLongitude,stationHeightMeters,recordTime,startTime,samplingHz,direction,scaleNumeratorGal,scaleDenominator,maxAccelerationGal);

@override
String toString() {
  return 'KyoshinWaveformMetadata(network: $network, component: $component, stationCode: $stationCode, stationLatitude: $stationLatitude, stationLongitude: $stationLongitude, stationHeightMeters: $stationHeightMeters, recordTime: $recordTime, startTime: $startTime, samplingHz: $samplingHz, direction: $direction, scaleNumeratorGal: $scaleNumeratorGal, scaleDenominator: $scaleDenominator, maxAccelerationGal: $maxAccelerationGal)';
}


}

/// @nodoc
abstract mixin class _$KyoshinWaveformMetadataCopyWith<$Res> implements $KyoshinWaveformMetadataCopyWith<$Res> {
  factory _$KyoshinWaveformMetadataCopyWith(_KyoshinWaveformMetadata value, $Res Function(_KyoshinWaveformMetadata) _then) = __$KyoshinWaveformMetadataCopyWithImpl;
@override @useResult
$Res call({
 String network, String component, String stationCode, double stationLatitude, double stationLongitude, double stationHeightMeters, DateTime recordTime, DateTime startTime, int samplingHz, String direction, double scaleNumeratorGal, double scaleDenominator, double maxAccelerationGal
});




}
/// @nodoc
class __$KyoshinWaveformMetadataCopyWithImpl<$Res>
    implements _$KyoshinWaveformMetadataCopyWith<$Res> {
  __$KyoshinWaveformMetadataCopyWithImpl(this._self, this._then);

  final _KyoshinWaveformMetadata _self;
  final $Res Function(_KyoshinWaveformMetadata) _then;

/// Create a copy of KyoshinWaveformMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? network = null,Object? component = null,Object? stationCode = null,Object? stationLatitude = null,Object? stationLongitude = null,Object? stationHeightMeters = null,Object? recordTime = null,Object? startTime = null,Object? samplingHz = null,Object? direction = null,Object? scaleNumeratorGal = null,Object? scaleDenominator = null,Object? maxAccelerationGal = null,}) {
  return _then(_KyoshinWaveformMetadata(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,component: null == component ? _self.component : component // ignore: cast_nullable_to_non_nullable
as String,stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,stationLatitude: null == stationLatitude ? _self.stationLatitude : stationLatitude // ignore: cast_nullable_to_non_nullable
as double,stationLongitude: null == stationLongitude ? _self.stationLongitude : stationLongitude // ignore: cast_nullable_to_non_nullable
as double,stationHeightMeters: null == stationHeightMeters ? _self.stationHeightMeters : stationHeightMeters // ignore: cast_nullable_to_non_nullable
as double,recordTime: null == recordTime ? _self.recordTime : recordTime // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,samplingHz: null == samplingHz ? _self.samplingHz : samplingHz // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,scaleNumeratorGal: null == scaleNumeratorGal ? _self.scaleNumeratorGal : scaleNumeratorGal // ignore: cast_nullable_to_non_nullable
as double,scaleDenominator: null == scaleDenominator ? _self.scaleDenominator : scaleDenominator // ignore: cast_nullable_to_non_nullable
as double,maxAccelerationGal: null == maxAccelerationGal ? _self.maxAccelerationGal : maxAccelerationGal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

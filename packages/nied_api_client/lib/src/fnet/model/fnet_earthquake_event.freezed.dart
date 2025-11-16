// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fnet_earthquake_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FnetEarthquakeEvent {

/// 発生時刻 (UTC)
 DateTime get originTime;/// 緯度 (度)
 double get latitude;/// 経度 (度)
 double get longitude;/// JMA震源の深さ (km)
 double get jmaDepth;/// JMAマグニチュード (Mj)
 double get jmaMagnitude;/// 地域名
 String get regionName;/// 断層面の走向 (度) - 2つの可能な値
 FaultParameterPair get strike;/// 断層面の傾斜角 (度) - 2つの可能な値
 FaultParameterPair get dip;/// 断層面のすべり角 (度) - 2つの可能な値
 FaultParameterPair get rake;/// 地震モーメント (Nm)
 double get seismicMoment;/// モーメントテンソル解の震源深さ (km)
 double get mtDepth;/// モーメントマグニチュード (Mw)
 double get mtMagnitude;/// バリアンス・リダクション (%)
 double get varianceReduction;/// モーメントテンソル成分
 MomentTensor get momentTensor;/// モーメントテンソルの単位 (Nm)
 double get unit;/// 使用観測点数
 int get numberOfStations;
/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnetEarthquakeEventCopyWith<FnetEarthquakeEvent> get copyWith => _$FnetEarthquakeEventCopyWithImpl<FnetEarthquakeEvent>(this as FnetEarthquakeEvent, _$identity);

  /// Serializes this FnetEarthquakeEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnetEarthquakeEvent&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.jmaDepth, jmaDepth) || other.jmaDepth == jmaDepth)&&(identical(other.jmaMagnitude, jmaMagnitude) || other.jmaMagnitude == jmaMagnitude)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.strike, strike) || other.strike == strike)&&(identical(other.dip, dip) || other.dip == dip)&&(identical(other.rake, rake) || other.rake == rake)&&(identical(other.seismicMoment, seismicMoment) || other.seismicMoment == seismicMoment)&&(identical(other.mtDepth, mtDepth) || other.mtDepth == mtDepth)&&(identical(other.mtMagnitude, mtMagnitude) || other.mtMagnitude == mtMagnitude)&&(identical(other.varianceReduction, varianceReduction) || other.varianceReduction == varianceReduction)&&(identical(other.momentTensor, momentTensor) || other.momentTensor == momentTensor)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.numberOfStations, numberOfStations) || other.numberOfStations == numberOfStations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originTime,latitude,longitude,jmaDepth,jmaMagnitude,regionName,strike,dip,rake,seismicMoment,mtDepth,mtMagnitude,varianceReduction,momentTensor,unit,numberOfStations);

@override
String toString() {
  return 'FnetEarthquakeEvent(originTime: $originTime, latitude: $latitude, longitude: $longitude, jmaDepth: $jmaDepth, jmaMagnitude: $jmaMagnitude, regionName: $regionName, strike: $strike, dip: $dip, rake: $rake, seismicMoment: $seismicMoment, mtDepth: $mtDepth, mtMagnitude: $mtMagnitude, varianceReduction: $varianceReduction, momentTensor: $momentTensor, unit: $unit, numberOfStations: $numberOfStations)';
}


}

/// @nodoc
abstract mixin class $FnetEarthquakeEventCopyWith<$Res>  {
  factory $FnetEarthquakeEventCopyWith(FnetEarthquakeEvent value, $Res Function(FnetEarthquakeEvent) _then) = _$FnetEarthquakeEventCopyWithImpl;
@useResult
$Res call({
 DateTime originTime, double latitude, double longitude, double jmaDepth, double jmaMagnitude, String regionName, FaultParameterPair strike, FaultParameterPair dip, FaultParameterPair rake, double seismicMoment, double mtDepth, double mtMagnitude, double varianceReduction, MomentTensor momentTensor, double unit, int numberOfStations
});


$FaultParameterPairCopyWith<$Res> get strike;$FaultParameterPairCopyWith<$Res> get dip;$FaultParameterPairCopyWith<$Res> get rake;$MomentTensorCopyWith<$Res> get momentTensor;

}
/// @nodoc
class _$FnetEarthquakeEventCopyWithImpl<$Res>
    implements $FnetEarthquakeEventCopyWith<$Res> {
  _$FnetEarthquakeEventCopyWithImpl(this._self, this._then);

  final FnetEarthquakeEvent _self;
  final $Res Function(FnetEarthquakeEvent) _then;

/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originTime = null,Object? latitude = null,Object? longitude = null,Object? jmaDepth = null,Object? jmaMagnitude = null,Object? regionName = null,Object? strike = null,Object? dip = null,Object? rake = null,Object? seismicMoment = null,Object? mtDepth = null,Object? mtMagnitude = null,Object? varianceReduction = null,Object? momentTensor = null,Object? unit = null,Object? numberOfStations = null,}) {
  return _then(_self.copyWith(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,jmaDepth: null == jmaDepth ? _self.jmaDepth : jmaDepth // ignore: cast_nullable_to_non_nullable
as double,jmaMagnitude: null == jmaMagnitude ? _self.jmaMagnitude : jmaMagnitude // ignore: cast_nullable_to_non_nullable
as double,regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,strike: null == strike ? _self.strike : strike // ignore: cast_nullable_to_non_nullable
as FaultParameterPair,dip: null == dip ? _self.dip : dip // ignore: cast_nullable_to_non_nullable
as FaultParameterPair,rake: null == rake ? _self.rake : rake // ignore: cast_nullable_to_non_nullable
as FaultParameterPair,seismicMoment: null == seismicMoment ? _self.seismicMoment : seismicMoment // ignore: cast_nullable_to_non_nullable
as double,mtDepth: null == mtDepth ? _self.mtDepth : mtDepth // ignore: cast_nullable_to_non_nullable
as double,mtMagnitude: null == mtMagnitude ? _self.mtMagnitude : mtMagnitude // ignore: cast_nullable_to_non_nullable
as double,varianceReduction: null == varianceReduction ? _self.varianceReduction : varianceReduction // ignore: cast_nullable_to_non_nullable
as double,momentTensor: null == momentTensor ? _self.momentTensor : momentTensor // ignore: cast_nullable_to_non_nullable
as MomentTensor,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as double,numberOfStations: null == numberOfStations ? _self.numberOfStations : numberOfStations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FaultParameterPairCopyWith<$Res> get strike {
  
  return $FaultParameterPairCopyWith<$Res>(_self.strike, (value) {
    return _then(_self.copyWith(strike: value));
  });
}/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FaultParameterPairCopyWith<$Res> get dip {
  
  return $FaultParameterPairCopyWith<$Res>(_self.dip, (value) {
    return _then(_self.copyWith(dip: value));
  });
}/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FaultParameterPairCopyWith<$Res> get rake {
  
  return $FaultParameterPairCopyWith<$Res>(_self.rake, (value) {
    return _then(_self.copyWith(rake: value));
  });
}/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MomentTensorCopyWith<$Res> get momentTensor {
  
  return $MomentTensorCopyWith<$Res>(_self.momentTensor, (value) {
    return _then(_self.copyWith(momentTensor: value));
  });
}
}


/// Adds pattern-matching-related methods to [FnetEarthquakeEvent].
extension FnetEarthquakeEventPatterns on FnetEarthquakeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FnetEarthquakeEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FnetEarthquakeEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FnetEarthquakeEvent value)  $default,){
final _that = this;
switch (_that) {
case _FnetEarthquakeEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FnetEarthquakeEvent value)?  $default,){
final _that = this;
switch (_that) {
case _FnetEarthquakeEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime originTime,  double latitude,  double longitude,  double jmaDepth,  double jmaMagnitude,  String regionName,  FaultParameterPair strike,  FaultParameterPair dip,  FaultParameterPair rake,  double seismicMoment,  double mtDepth,  double mtMagnitude,  double varianceReduction,  MomentTensor momentTensor,  double unit,  int numberOfStations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FnetEarthquakeEvent() when $default != null:
return $default(_that.originTime,_that.latitude,_that.longitude,_that.jmaDepth,_that.jmaMagnitude,_that.regionName,_that.strike,_that.dip,_that.rake,_that.seismicMoment,_that.mtDepth,_that.mtMagnitude,_that.varianceReduction,_that.momentTensor,_that.unit,_that.numberOfStations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime originTime,  double latitude,  double longitude,  double jmaDepth,  double jmaMagnitude,  String regionName,  FaultParameterPair strike,  FaultParameterPair dip,  FaultParameterPair rake,  double seismicMoment,  double mtDepth,  double mtMagnitude,  double varianceReduction,  MomentTensor momentTensor,  double unit,  int numberOfStations)  $default,) {final _that = this;
switch (_that) {
case _FnetEarthquakeEvent():
return $default(_that.originTime,_that.latitude,_that.longitude,_that.jmaDepth,_that.jmaMagnitude,_that.regionName,_that.strike,_that.dip,_that.rake,_that.seismicMoment,_that.mtDepth,_that.mtMagnitude,_that.varianceReduction,_that.momentTensor,_that.unit,_that.numberOfStations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime originTime,  double latitude,  double longitude,  double jmaDepth,  double jmaMagnitude,  String regionName,  FaultParameterPair strike,  FaultParameterPair dip,  FaultParameterPair rake,  double seismicMoment,  double mtDepth,  double mtMagnitude,  double varianceReduction,  MomentTensor momentTensor,  double unit,  int numberOfStations)?  $default,) {final _that = this;
switch (_that) {
case _FnetEarthquakeEvent() when $default != null:
return $default(_that.originTime,_that.latitude,_that.longitude,_that.jmaDepth,_that.jmaMagnitude,_that.regionName,_that.strike,_that.dip,_that.rake,_that.seismicMoment,_that.mtDepth,_that.mtMagnitude,_that.varianceReduction,_that.momentTensor,_that.unit,_that.numberOfStations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FnetEarthquakeEvent implements FnetEarthquakeEvent {
  const _FnetEarthquakeEvent({required this.originTime, required this.latitude, required this.longitude, required this.jmaDepth, required this.jmaMagnitude, required this.regionName, required this.strike, required this.dip, required this.rake, required this.seismicMoment, required this.mtDepth, required this.mtMagnitude, required this.varianceReduction, required this.momentTensor, required this.unit, required this.numberOfStations});
  factory _FnetEarthquakeEvent.fromJson(Map<String, dynamic> json) => _$FnetEarthquakeEventFromJson(json);

/// 発生時刻 (UTC)
@override final  DateTime originTime;
/// 緯度 (度)
@override final  double latitude;
/// 経度 (度)
@override final  double longitude;
/// JMA震源の深さ (km)
@override final  double jmaDepth;
/// JMAマグニチュード (Mj)
@override final  double jmaMagnitude;
/// 地域名
@override final  String regionName;
/// 断層面の走向 (度) - 2つの可能な値
@override final  FaultParameterPair strike;
/// 断層面の傾斜角 (度) - 2つの可能な値
@override final  FaultParameterPair dip;
/// 断層面のすべり角 (度) - 2つの可能な値
@override final  FaultParameterPair rake;
/// 地震モーメント (Nm)
@override final  double seismicMoment;
/// モーメントテンソル解の震源深さ (km)
@override final  double mtDepth;
/// モーメントマグニチュード (Mw)
@override final  double mtMagnitude;
/// バリアンス・リダクション (%)
@override final  double varianceReduction;
/// モーメントテンソル成分
@override final  MomentTensor momentTensor;
/// モーメントテンソルの単位 (Nm)
@override final  double unit;
/// 使用観測点数
@override final  int numberOfStations;

/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FnetEarthquakeEventCopyWith<_FnetEarthquakeEvent> get copyWith => __$FnetEarthquakeEventCopyWithImpl<_FnetEarthquakeEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FnetEarthquakeEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FnetEarthquakeEvent&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.jmaDepth, jmaDepth) || other.jmaDepth == jmaDepth)&&(identical(other.jmaMagnitude, jmaMagnitude) || other.jmaMagnitude == jmaMagnitude)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.strike, strike) || other.strike == strike)&&(identical(other.dip, dip) || other.dip == dip)&&(identical(other.rake, rake) || other.rake == rake)&&(identical(other.seismicMoment, seismicMoment) || other.seismicMoment == seismicMoment)&&(identical(other.mtDepth, mtDepth) || other.mtDepth == mtDepth)&&(identical(other.mtMagnitude, mtMagnitude) || other.mtMagnitude == mtMagnitude)&&(identical(other.varianceReduction, varianceReduction) || other.varianceReduction == varianceReduction)&&(identical(other.momentTensor, momentTensor) || other.momentTensor == momentTensor)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.numberOfStations, numberOfStations) || other.numberOfStations == numberOfStations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originTime,latitude,longitude,jmaDepth,jmaMagnitude,regionName,strike,dip,rake,seismicMoment,mtDepth,mtMagnitude,varianceReduction,momentTensor,unit,numberOfStations);

@override
String toString() {
  return 'FnetEarthquakeEvent(originTime: $originTime, latitude: $latitude, longitude: $longitude, jmaDepth: $jmaDepth, jmaMagnitude: $jmaMagnitude, regionName: $regionName, strike: $strike, dip: $dip, rake: $rake, seismicMoment: $seismicMoment, mtDepth: $mtDepth, mtMagnitude: $mtMagnitude, varianceReduction: $varianceReduction, momentTensor: $momentTensor, unit: $unit, numberOfStations: $numberOfStations)';
}


}

/// @nodoc
abstract mixin class _$FnetEarthquakeEventCopyWith<$Res> implements $FnetEarthquakeEventCopyWith<$Res> {
  factory _$FnetEarthquakeEventCopyWith(_FnetEarthquakeEvent value, $Res Function(_FnetEarthquakeEvent) _then) = __$FnetEarthquakeEventCopyWithImpl;
@override @useResult
$Res call({
 DateTime originTime, double latitude, double longitude, double jmaDepth, double jmaMagnitude, String regionName, FaultParameterPair strike, FaultParameterPair dip, FaultParameterPair rake, double seismicMoment, double mtDepth, double mtMagnitude, double varianceReduction, MomentTensor momentTensor, double unit, int numberOfStations
});


@override $FaultParameterPairCopyWith<$Res> get strike;@override $FaultParameterPairCopyWith<$Res> get dip;@override $FaultParameterPairCopyWith<$Res> get rake;@override $MomentTensorCopyWith<$Res> get momentTensor;

}
/// @nodoc
class __$FnetEarthquakeEventCopyWithImpl<$Res>
    implements _$FnetEarthquakeEventCopyWith<$Res> {
  __$FnetEarthquakeEventCopyWithImpl(this._self, this._then);

  final _FnetEarthquakeEvent _self;
  final $Res Function(_FnetEarthquakeEvent) _then;

/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originTime = null,Object? latitude = null,Object? longitude = null,Object? jmaDepth = null,Object? jmaMagnitude = null,Object? regionName = null,Object? strike = null,Object? dip = null,Object? rake = null,Object? seismicMoment = null,Object? mtDepth = null,Object? mtMagnitude = null,Object? varianceReduction = null,Object? momentTensor = null,Object? unit = null,Object? numberOfStations = null,}) {
  return _then(_FnetEarthquakeEvent(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,jmaDepth: null == jmaDepth ? _self.jmaDepth : jmaDepth // ignore: cast_nullable_to_non_nullable
as double,jmaMagnitude: null == jmaMagnitude ? _self.jmaMagnitude : jmaMagnitude // ignore: cast_nullable_to_non_nullable
as double,regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,strike: null == strike ? _self.strike : strike // ignore: cast_nullable_to_non_nullable
as FaultParameterPair,dip: null == dip ? _self.dip : dip // ignore: cast_nullable_to_non_nullable
as FaultParameterPair,rake: null == rake ? _self.rake : rake // ignore: cast_nullable_to_non_nullable
as FaultParameterPair,seismicMoment: null == seismicMoment ? _self.seismicMoment : seismicMoment // ignore: cast_nullable_to_non_nullable
as double,mtDepth: null == mtDepth ? _self.mtDepth : mtDepth // ignore: cast_nullable_to_non_nullable
as double,mtMagnitude: null == mtMagnitude ? _self.mtMagnitude : mtMagnitude // ignore: cast_nullable_to_non_nullable
as double,varianceReduction: null == varianceReduction ? _self.varianceReduction : varianceReduction // ignore: cast_nullable_to_non_nullable
as double,momentTensor: null == momentTensor ? _self.momentTensor : momentTensor // ignore: cast_nullable_to_non_nullable
as MomentTensor,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as double,numberOfStations: null == numberOfStations ? _self.numberOfStations : numberOfStations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FaultParameterPairCopyWith<$Res> get strike {
  
  return $FaultParameterPairCopyWith<$Res>(_self.strike, (value) {
    return _then(_self.copyWith(strike: value));
  });
}/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FaultParameterPairCopyWith<$Res> get dip {
  
  return $FaultParameterPairCopyWith<$Res>(_self.dip, (value) {
    return _then(_self.copyWith(dip: value));
  });
}/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FaultParameterPairCopyWith<$Res> get rake {
  
  return $FaultParameterPairCopyWith<$Res>(_self.rake, (value) {
    return _then(_self.copyWith(rake: value));
  });
}/// Create a copy of FnetEarthquakeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MomentTensorCopyWith<$Res> get momentTensor {
  
  return $MomentTensorCopyWith<$Res>(_self.momentTensor, (value) {
    return _then(_self.copyWith(momentTensor: value));
  });
}
}


/// @nodoc
mixin _$FaultParameterPair {

 double get plane1; double get plane2;
/// Create a copy of FaultParameterPair
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaultParameterPairCopyWith<FaultParameterPair> get copyWith => _$FaultParameterPairCopyWithImpl<FaultParameterPair>(this as FaultParameterPair, _$identity);

  /// Serializes this FaultParameterPair to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaultParameterPair&&(identical(other.plane1, plane1) || other.plane1 == plane1)&&(identical(other.plane2, plane2) || other.plane2 == plane2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plane1,plane2);

@override
String toString() {
  return 'FaultParameterPair(plane1: $plane1, plane2: $plane2)';
}


}

/// @nodoc
abstract mixin class $FaultParameterPairCopyWith<$Res>  {
  factory $FaultParameterPairCopyWith(FaultParameterPair value, $Res Function(FaultParameterPair) _then) = _$FaultParameterPairCopyWithImpl;
@useResult
$Res call({
 double plane1, double plane2
});




}
/// @nodoc
class _$FaultParameterPairCopyWithImpl<$Res>
    implements $FaultParameterPairCopyWith<$Res> {
  _$FaultParameterPairCopyWithImpl(this._self, this._then);

  final FaultParameterPair _self;
  final $Res Function(FaultParameterPair) _then;

/// Create a copy of FaultParameterPair
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plane1 = null,Object? plane2 = null,}) {
  return _then(_self.copyWith(
plane1: null == plane1 ? _self.plane1 : plane1 // ignore: cast_nullable_to_non_nullable
as double,plane2: null == plane2 ? _self.plane2 : plane2 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FaultParameterPair].
extension FaultParameterPairPatterns on FaultParameterPair {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaultParameterPair value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaultParameterPair() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaultParameterPair value)  $default,){
final _that = this;
switch (_that) {
case _FaultParameterPair():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaultParameterPair value)?  $default,){
final _that = this;
switch (_that) {
case _FaultParameterPair() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double plane1,  double plane2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaultParameterPair() when $default != null:
return $default(_that.plane1,_that.plane2);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double plane1,  double plane2)  $default,) {final _that = this;
switch (_that) {
case _FaultParameterPair():
return $default(_that.plane1,_that.plane2);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double plane1,  double plane2)?  $default,) {final _that = this;
switch (_that) {
case _FaultParameterPair() when $default != null:
return $default(_that.plane1,_that.plane2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FaultParameterPair implements FaultParameterPair {
  const _FaultParameterPair({required this.plane1, required this.plane2});
  factory _FaultParameterPair.fromJson(Map<String, dynamic> json) => _$FaultParameterPairFromJson(json);

@override final  double plane1;
@override final  double plane2;

/// Create a copy of FaultParameterPair
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaultParameterPairCopyWith<_FaultParameterPair> get copyWith => __$FaultParameterPairCopyWithImpl<_FaultParameterPair>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FaultParameterPairToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaultParameterPair&&(identical(other.plane1, plane1) || other.plane1 == plane1)&&(identical(other.plane2, plane2) || other.plane2 == plane2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plane1,plane2);

@override
String toString() {
  return 'FaultParameterPair(plane1: $plane1, plane2: $plane2)';
}


}

/// @nodoc
abstract mixin class _$FaultParameterPairCopyWith<$Res> implements $FaultParameterPairCopyWith<$Res> {
  factory _$FaultParameterPairCopyWith(_FaultParameterPair value, $Res Function(_FaultParameterPair) _then) = __$FaultParameterPairCopyWithImpl;
@override @useResult
$Res call({
 double plane1, double plane2
});




}
/// @nodoc
class __$FaultParameterPairCopyWithImpl<$Res>
    implements _$FaultParameterPairCopyWith<$Res> {
  __$FaultParameterPairCopyWithImpl(this._self, this._then);

  final _FaultParameterPair _self;
  final $Res Function(_FaultParameterPair) _then;

/// Create a copy of FaultParameterPair
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plane1 = null,Object? plane2 = null,}) {
  return _then(_FaultParameterPair(
plane1: null == plane1 ? _self.plane1 : plane1 // ignore: cast_nullable_to_non_nullable
as double,plane2: null == plane2 ? _self.plane2 : plane2 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MomentTensor {

 double get mxx; double get mxy; double get mxz; double get myy; double get myz; double get mzz;
/// Create a copy of MomentTensor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MomentTensorCopyWith<MomentTensor> get copyWith => _$MomentTensorCopyWithImpl<MomentTensor>(this as MomentTensor, _$identity);

  /// Serializes this MomentTensor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MomentTensor&&(identical(other.mxx, mxx) || other.mxx == mxx)&&(identical(other.mxy, mxy) || other.mxy == mxy)&&(identical(other.mxz, mxz) || other.mxz == mxz)&&(identical(other.myy, myy) || other.myy == myy)&&(identical(other.myz, myz) || other.myz == myz)&&(identical(other.mzz, mzz) || other.mzz == mzz));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mxx,mxy,mxz,myy,myz,mzz);

@override
String toString() {
  return 'MomentTensor(mxx: $mxx, mxy: $mxy, mxz: $mxz, myy: $myy, myz: $myz, mzz: $mzz)';
}


}

/// @nodoc
abstract mixin class $MomentTensorCopyWith<$Res>  {
  factory $MomentTensorCopyWith(MomentTensor value, $Res Function(MomentTensor) _then) = _$MomentTensorCopyWithImpl;
@useResult
$Res call({
 double mxx, double mxy, double mxz, double myy, double myz, double mzz
});




}
/// @nodoc
class _$MomentTensorCopyWithImpl<$Res>
    implements $MomentTensorCopyWith<$Res> {
  _$MomentTensorCopyWithImpl(this._self, this._then);

  final MomentTensor _self;
  final $Res Function(MomentTensor) _then;

/// Create a copy of MomentTensor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mxx = null,Object? mxy = null,Object? mxz = null,Object? myy = null,Object? myz = null,Object? mzz = null,}) {
  return _then(_self.copyWith(
mxx: null == mxx ? _self.mxx : mxx // ignore: cast_nullable_to_non_nullable
as double,mxy: null == mxy ? _self.mxy : mxy // ignore: cast_nullable_to_non_nullable
as double,mxz: null == mxz ? _self.mxz : mxz // ignore: cast_nullable_to_non_nullable
as double,myy: null == myy ? _self.myy : myy // ignore: cast_nullable_to_non_nullable
as double,myz: null == myz ? _self.myz : myz // ignore: cast_nullable_to_non_nullable
as double,mzz: null == mzz ? _self.mzz : mzz // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MomentTensor].
extension MomentTensorPatterns on MomentTensor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MomentTensor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MomentTensor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MomentTensor value)  $default,){
final _that = this;
switch (_that) {
case _MomentTensor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MomentTensor value)?  $default,){
final _that = this;
switch (_that) {
case _MomentTensor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double mxx,  double mxy,  double mxz,  double myy,  double myz,  double mzz)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MomentTensor() when $default != null:
return $default(_that.mxx,_that.mxy,_that.mxz,_that.myy,_that.myz,_that.mzz);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double mxx,  double mxy,  double mxz,  double myy,  double myz,  double mzz)  $default,) {final _that = this;
switch (_that) {
case _MomentTensor():
return $default(_that.mxx,_that.mxy,_that.mxz,_that.myy,_that.myz,_that.mzz);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double mxx,  double mxy,  double mxz,  double myy,  double myz,  double mzz)?  $default,) {final _that = this;
switch (_that) {
case _MomentTensor() when $default != null:
return $default(_that.mxx,_that.mxy,_that.mxz,_that.myy,_that.myz,_that.mzz);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MomentTensor implements MomentTensor {
  const _MomentTensor({required this.mxx, required this.mxy, required this.mxz, required this.myy, required this.myz, required this.mzz});
  factory _MomentTensor.fromJson(Map<String, dynamic> json) => _$MomentTensorFromJson(json);

@override final  double mxx;
@override final  double mxy;
@override final  double mxz;
@override final  double myy;
@override final  double myz;
@override final  double mzz;

/// Create a copy of MomentTensor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MomentTensorCopyWith<_MomentTensor> get copyWith => __$MomentTensorCopyWithImpl<_MomentTensor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MomentTensorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MomentTensor&&(identical(other.mxx, mxx) || other.mxx == mxx)&&(identical(other.mxy, mxy) || other.mxy == mxy)&&(identical(other.mxz, mxz) || other.mxz == mxz)&&(identical(other.myy, myy) || other.myy == myy)&&(identical(other.myz, myz) || other.myz == myz)&&(identical(other.mzz, mzz) || other.mzz == mzz));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mxx,mxy,mxz,myy,myz,mzz);

@override
String toString() {
  return 'MomentTensor(mxx: $mxx, mxy: $mxy, mxz: $mxz, myy: $myy, myz: $myz, mzz: $mzz)';
}


}

/// @nodoc
abstract mixin class _$MomentTensorCopyWith<$Res> implements $MomentTensorCopyWith<$Res> {
  factory _$MomentTensorCopyWith(_MomentTensor value, $Res Function(_MomentTensor) _then) = __$MomentTensorCopyWithImpl;
@override @useResult
$Res call({
 double mxx, double mxy, double mxz, double myy, double myz, double mzz
});




}
/// @nodoc
class __$MomentTensorCopyWithImpl<$Res>
    implements _$MomentTensorCopyWith<$Res> {
  __$MomentTensorCopyWithImpl(this._self, this._then);

  final _MomentTensor _self;
  final $Res Function(_MomentTensor) _then;

/// Create a copy of MomentTensor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mxx = null,Object? mxy = null,Object? mxz = null,Object? myy = null,Object? myz = null,Object? mzz = null,}) {
  return _then(_MomentTensor(
mxx: null == mxx ? _self.mxx : mxx // ignore: cast_nullable_to_non_nullable
as double,mxy: null == mxy ? _self.mxy : mxy // ignore: cast_nullable_to_non_nullable
as double,mxz: null == mxz ? _self.mxz : mxz // ignore: cast_nullable_to_non_nullable
as double,myy: null == myy ? _self.myy : myy // ignore: cast_nullable_to_non_nullable
as double,myz: null == myz ? _self.myz : myz // ignore: cast_nullable_to_non_nullable
as double,mzz: null == mzz ? _self.mzz : mzz // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

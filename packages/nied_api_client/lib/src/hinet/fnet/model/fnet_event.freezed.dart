// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fnet_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FnetEvent {

/// 発生時刻(UT)
 DateTime get originTime;/// 緯度（度）
 double get latitude;/// 経度（度）
 double get longitude;/// JMA深さ（km）
 double get jmaDepth;/// JMAマグニチュード（Mj）
 double get jmaMagnitude;/// 地域名
 String get regionName;/// 走向（Strike）- 2つの値
 FnetAnglePair get strike;/// 傾斜（Dip）- 2つの値
 FnetAnglePair get dip;/// すべり角（Rake）- 2つの値
 FnetAnglePair get rake;/// 地震モーメント（Nm）
 double get seismicMoment;/// モーメントテンソル深さ（km）
 double get mtDepth;/// モーメントマグニチュード（Mw）
 double get momentMagnitude;/// 分散低減率（%）
 double get varianceReduction;/// モーメントテンソル成分
 FnetMomentTensor get momentTensor;/// 単位（Nm）
 double get unit;/// 観測点数
 int get numberOfStations;
/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnetEventCopyWith<FnetEvent> get copyWith => _$FnetEventCopyWithImpl<FnetEvent>(this as FnetEvent, _$identity);

  /// Serializes this FnetEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnetEvent&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.jmaDepth, jmaDepth) || other.jmaDepth == jmaDepth)&&(identical(other.jmaMagnitude, jmaMagnitude) || other.jmaMagnitude == jmaMagnitude)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.strike, strike) || other.strike == strike)&&(identical(other.dip, dip) || other.dip == dip)&&(identical(other.rake, rake) || other.rake == rake)&&(identical(other.seismicMoment, seismicMoment) || other.seismicMoment == seismicMoment)&&(identical(other.mtDepth, mtDepth) || other.mtDepth == mtDepth)&&(identical(other.momentMagnitude, momentMagnitude) || other.momentMagnitude == momentMagnitude)&&(identical(other.varianceReduction, varianceReduction) || other.varianceReduction == varianceReduction)&&(identical(other.momentTensor, momentTensor) || other.momentTensor == momentTensor)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.numberOfStations, numberOfStations) || other.numberOfStations == numberOfStations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originTime,latitude,longitude,jmaDepth,jmaMagnitude,regionName,strike,dip,rake,seismicMoment,mtDepth,momentMagnitude,varianceReduction,momentTensor,unit,numberOfStations);

@override
String toString() {
  return 'FnetEvent(originTime: $originTime, latitude: $latitude, longitude: $longitude, jmaDepth: $jmaDepth, jmaMagnitude: $jmaMagnitude, regionName: $regionName, strike: $strike, dip: $dip, rake: $rake, seismicMoment: $seismicMoment, mtDepth: $mtDepth, momentMagnitude: $momentMagnitude, varianceReduction: $varianceReduction, momentTensor: $momentTensor, unit: $unit, numberOfStations: $numberOfStations)';
}


}

/// @nodoc
abstract mixin class $FnetEventCopyWith<$Res>  {
  factory $FnetEventCopyWith(FnetEvent value, $Res Function(FnetEvent) _then) = _$FnetEventCopyWithImpl;
@useResult
$Res call({
 DateTime originTime, double latitude, double longitude, double jmaDepth, double jmaMagnitude, String regionName, FnetAnglePair strike, FnetAnglePair dip, FnetAnglePair rake, double seismicMoment, double mtDepth, double momentMagnitude, double varianceReduction, FnetMomentTensor momentTensor, double unit, int numberOfStations
});


$FnetAnglePairCopyWith<$Res> get strike;$FnetAnglePairCopyWith<$Res> get dip;$FnetAnglePairCopyWith<$Res> get rake;$FnetMomentTensorCopyWith<$Res> get momentTensor;

}
/// @nodoc
class _$FnetEventCopyWithImpl<$Res>
    implements $FnetEventCopyWith<$Res> {
  _$FnetEventCopyWithImpl(this._self, this._then);

  final FnetEvent _self;
  final $Res Function(FnetEvent) _then;

/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originTime = null,Object? latitude = null,Object? longitude = null,Object? jmaDepth = null,Object? jmaMagnitude = null,Object? regionName = null,Object? strike = null,Object? dip = null,Object? rake = null,Object? seismicMoment = null,Object? mtDepth = null,Object? momentMagnitude = null,Object? varianceReduction = null,Object? momentTensor = null,Object? unit = null,Object? numberOfStations = null,}) {
  return _then(FnetEvent(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,jmaDepth: null == jmaDepth ? _self.jmaDepth : jmaDepth // ignore: cast_nullable_to_non_nullable
as double,jmaMagnitude: null == jmaMagnitude ? _self.jmaMagnitude : jmaMagnitude // ignore: cast_nullable_to_non_nullable
as double,regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,strike: null == strike ? _self.strike : strike // ignore: cast_nullable_to_non_nullable
as FnetAnglePair,dip: null == dip ? _self.dip : dip // ignore: cast_nullable_to_non_nullable
as FnetAnglePair,rake: null == rake ? _self.rake : rake // ignore: cast_nullable_to_non_nullable
as FnetAnglePair,seismicMoment: null == seismicMoment ? _self.seismicMoment : seismicMoment // ignore: cast_nullable_to_non_nullable
as double,mtDepth: null == mtDepth ? _self.mtDepth : mtDepth // ignore: cast_nullable_to_non_nullable
as double,momentMagnitude: null == momentMagnitude ? _self.momentMagnitude : momentMagnitude // ignore: cast_nullable_to_non_nullable
as double,varianceReduction: null == varianceReduction ? _self.varianceReduction : varianceReduction // ignore: cast_nullable_to_non_nullable
as double,momentTensor: null == momentTensor ? _self.momentTensor : momentTensor // ignore: cast_nullable_to_non_nullable
as FnetMomentTensor,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as double,numberOfStations: null == numberOfStations ? _self.numberOfStations : numberOfStations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FnetAnglePairCopyWith<$Res> get strike {
  
  return $FnetAnglePairCopyWith<$Res>(_self.strike, (value) {
    return _then(_self.copyWith(strike: value));
  });
}/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FnetAnglePairCopyWith<$Res> get dip {
  
  return $FnetAnglePairCopyWith<$Res>(_self.dip, (value) {
    return _then(_self.copyWith(dip: value));
  });
}/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FnetAnglePairCopyWith<$Res> get rake {
  
  return $FnetAnglePairCopyWith<$Res>(_self.rake, (value) {
    return _then(_self.copyWith(rake: value));
  });
}/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FnetMomentTensorCopyWith<$Res> get momentTensor {
  
  return $FnetMomentTensorCopyWith<$Res>(_self.momentTensor, (value) {
    return _then(_self.copyWith(momentTensor: value));
  });
}
}


/// Adds pattern-matching-related methods to [FnetEvent].
extension FnetEventPatterns on FnetEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FnetEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FnetEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FnetEvent value)  $default,){
final _that = this;
switch (_that) {
case _FnetEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FnetEvent value)?  $default,){
final _that = this;
switch (_that) {
case _FnetEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime originTime,  double latitude,  double longitude,  double jmaDepth,  double jmaMagnitude,  String regionName,  FnetAnglePair strike,  FnetAnglePair dip,  FnetAnglePair rake,  double seismicMoment,  double mtDepth,  double momentMagnitude,  double varianceReduction,  FnetMomentTensor momentTensor,  double unit,  int numberOfStations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FnetEvent() when $default != null:
return $default(_that.originTime,_that.latitude,_that.longitude,_that.jmaDepth,_that.jmaMagnitude,_that.regionName,_that.strike,_that.dip,_that.rake,_that.seismicMoment,_that.mtDepth,_that.momentMagnitude,_that.varianceReduction,_that.momentTensor,_that.unit,_that.numberOfStations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime originTime,  double latitude,  double longitude,  double jmaDepth,  double jmaMagnitude,  String regionName,  FnetAnglePair strike,  FnetAnglePair dip,  FnetAnglePair rake,  double seismicMoment,  double mtDepth,  double momentMagnitude,  double varianceReduction,  FnetMomentTensor momentTensor,  double unit,  int numberOfStations)  $default,) {final _that = this;
switch (_that) {
case _FnetEvent():
return $default(_that.originTime,_that.latitude,_that.longitude,_that.jmaDepth,_that.jmaMagnitude,_that.regionName,_that.strike,_that.dip,_that.rake,_that.seismicMoment,_that.mtDepth,_that.momentMagnitude,_that.varianceReduction,_that.momentTensor,_that.unit,_that.numberOfStations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime originTime,  double latitude,  double longitude,  double jmaDepth,  double jmaMagnitude,  String regionName,  FnetAnglePair strike,  FnetAnglePair dip,  FnetAnglePair rake,  double seismicMoment,  double mtDepth,  double momentMagnitude,  double varianceReduction,  FnetMomentTensor momentTensor,  double unit,  int numberOfStations)?  $default,) {final _that = this;
switch (_that) {
case _FnetEvent() when $default != null:
return $default(_that.originTime,_that.latitude,_that.longitude,_that.jmaDepth,_that.jmaMagnitude,_that.regionName,_that.strike,_that.dip,_that.rake,_that.seismicMoment,_that.mtDepth,_that.momentMagnitude,_that.varianceReduction,_that.momentTensor,_that.unit,_that.numberOfStations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FnetEvent implements FnetEvent {
  const _FnetEvent({required this.originTime, required this.latitude, required this.longitude, required this.jmaDepth, required this.jmaMagnitude, required this.regionName, required this.strike, required this.dip, required this.rake, required this.seismicMoment, required this.mtDepth, required this.momentMagnitude, required this.varianceReduction, required this.momentTensor, required this.unit, required this.numberOfStations});
  factory _FnetEvent.fromJson(Map<String, dynamic> json) => _$FnetEventFromJson(json);

/// 発生時刻(UT)
@override final  DateTime originTime;
/// 緯度（度）
@override final  double latitude;
/// 経度（度）
@override final  double longitude;
/// JMA深さ（km）
@override final  double jmaDepth;
/// JMAマグニチュード（Mj）
@override final  double jmaMagnitude;
/// 地域名
@override final  String regionName;
/// 走向（Strike）- 2つの値
@override final  FnetAnglePair strike;
/// 傾斜（Dip）- 2つの値
@override final  FnetAnglePair dip;
/// すべり角（Rake）- 2つの値
@override final  FnetAnglePair rake;
/// 地震モーメント（Nm）
@override final  double seismicMoment;
/// モーメントテンソル深さ（km）
@override final  double mtDepth;
/// モーメントマグニチュード（Mw）
@override final  double momentMagnitude;
/// 分散低減率（%）
@override final  double varianceReduction;
/// モーメントテンソル成分
@override final  FnetMomentTensor momentTensor;
/// 単位（Nm）
@override final  double unit;
/// 観測点数
@override final  int numberOfStations;

/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FnetEventCopyWith<_FnetEvent> get copyWith => __$FnetEventCopyWithImpl<_FnetEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FnetEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FnetEvent&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.jmaDepth, jmaDepth) || other.jmaDepth == jmaDepth)&&(identical(other.jmaMagnitude, jmaMagnitude) || other.jmaMagnitude == jmaMagnitude)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.strike, strike) || other.strike == strike)&&(identical(other.dip, dip) || other.dip == dip)&&(identical(other.rake, rake) || other.rake == rake)&&(identical(other.seismicMoment, seismicMoment) || other.seismicMoment == seismicMoment)&&(identical(other.mtDepth, mtDepth) || other.mtDepth == mtDepth)&&(identical(other.momentMagnitude, momentMagnitude) || other.momentMagnitude == momentMagnitude)&&(identical(other.varianceReduction, varianceReduction) || other.varianceReduction == varianceReduction)&&(identical(other.momentTensor, momentTensor) || other.momentTensor == momentTensor)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.numberOfStations, numberOfStations) || other.numberOfStations == numberOfStations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originTime,latitude,longitude,jmaDepth,jmaMagnitude,regionName,strike,dip,rake,seismicMoment,mtDepth,momentMagnitude,varianceReduction,momentTensor,unit,numberOfStations);

@override
String toString() {
  return 'FnetEvent(originTime: $originTime, latitude: $latitude, longitude: $longitude, jmaDepth: $jmaDepth, jmaMagnitude: $jmaMagnitude, regionName: $regionName, strike: $strike, dip: $dip, rake: $rake, seismicMoment: $seismicMoment, mtDepth: $mtDepth, momentMagnitude: $momentMagnitude, varianceReduction: $varianceReduction, momentTensor: $momentTensor, unit: $unit, numberOfStations: $numberOfStations)';
}


}

/// @nodoc
abstract mixin class _$FnetEventCopyWith<$Res> implements $FnetEventCopyWith<$Res> {
  factory _$FnetEventCopyWith(_FnetEvent value, $Res Function(_FnetEvent) _then) = __$FnetEventCopyWithImpl;
@override @useResult
$Res call({
 DateTime originTime, double latitude, double longitude, double jmaDepth, double jmaMagnitude, String regionName, FnetAnglePair strike, FnetAnglePair dip, FnetAnglePair rake, double seismicMoment, double mtDepth, double momentMagnitude, double varianceReduction, FnetMomentTensor momentTensor, double unit, int numberOfStations
});


@override $FnetAnglePairCopyWith<$Res> get strike;@override $FnetAnglePairCopyWith<$Res> get dip;@override $FnetAnglePairCopyWith<$Res> get rake;@override $FnetMomentTensorCopyWith<$Res> get momentTensor;

}
/// @nodoc
class __$FnetEventCopyWithImpl<$Res>
    implements _$FnetEventCopyWith<$Res> {
  __$FnetEventCopyWithImpl(this._self, this._then);

  final _FnetEvent _self;
  final $Res Function(_FnetEvent) _then;

/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originTime = null,Object? latitude = null,Object? longitude = null,Object? jmaDepth = null,Object? jmaMagnitude = null,Object? regionName = null,Object? strike = null,Object? dip = null,Object? rake = null,Object? seismicMoment = null,Object? mtDepth = null,Object? momentMagnitude = null,Object? varianceReduction = null,Object? momentTensor = null,Object? unit = null,Object? numberOfStations = null,}) {
  return _then(_FnetEvent(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,jmaDepth: null == jmaDepth ? _self.jmaDepth : jmaDepth // ignore: cast_nullable_to_non_nullable
as double,jmaMagnitude: null == jmaMagnitude ? _self.jmaMagnitude : jmaMagnitude // ignore: cast_nullable_to_non_nullable
as double,regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,strike: null == strike ? _self.strike : strike // ignore: cast_nullable_to_non_nullable
as FnetAnglePair,dip: null == dip ? _self.dip : dip // ignore: cast_nullable_to_non_nullable
as FnetAnglePair,rake: null == rake ? _self.rake : rake // ignore: cast_nullable_to_non_nullable
as FnetAnglePair,seismicMoment: null == seismicMoment ? _self.seismicMoment : seismicMoment // ignore: cast_nullable_to_non_nullable
as double,mtDepth: null == mtDepth ? _self.mtDepth : mtDepth // ignore: cast_nullable_to_non_nullable
as double,momentMagnitude: null == momentMagnitude ? _self.momentMagnitude : momentMagnitude // ignore: cast_nullable_to_non_nullable
as double,varianceReduction: null == varianceReduction ? _self.varianceReduction : varianceReduction // ignore: cast_nullable_to_non_nullable
as double,momentTensor: null == momentTensor ? _self.momentTensor : momentTensor // ignore: cast_nullable_to_non_nullable
as FnetMomentTensor,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as double,numberOfStations: null == numberOfStations ? _self.numberOfStations : numberOfStations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FnetAnglePairCopyWith<$Res> get strike {
  
  return $FnetAnglePairCopyWith<$Res>(_self.strike, (value) {
    return _then(_self.copyWith(strike: value));
  });
}/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FnetAnglePairCopyWith<$Res> get dip {
  
  return $FnetAnglePairCopyWith<$Res>(_self.dip, (value) {
    return _then(_self.copyWith(dip: value));
  });
}/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FnetAnglePairCopyWith<$Res> get rake {
  
  return $FnetAnglePairCopyWith<$Res>(_self.rake, (value) {
    return _then(_self.copyWith(rake: value));
  });
}/// Create a copy of FnetEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FnetMomentTensorCopyWith<$Res> get momentTensor {
  
  return $FnetMomentTensorCopyWith<$Res>(_self.momentTensor, (value) {
    return _then(_self.copyWith(momentTensor: value));
  });
}
}


/// @nodoc
mixin _$FnetAnglePair {

 double get plane1; double get plane2;
/// Create a copy of FnetAnglePair
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnetAnglePairCopyWith<FnetAnglePair> get copyWith => _$FnetAnglePairCopyWithImpl<FnetAnglePair>(this as FnetAnglePair, _$identity);

  /// Serializes this FnetAnglePair to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnetAnglePair&&(identical(other.plane1, plane1) || other.plane1 == plane1)&&(identical(other.plane2, plane2) || other.plane2 == plane2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plane1,plane2);

@override
String toString() {
  return 'FnetAnglePair(plane1: $plane1, plane2: $plane2)';
}


}

/// @nodoc
abstract mixin class $FnetAnglePairCopyWith<$Res>  {
  factory $FnetAnglePairCopyWith(FnetAnglePair value, $Res Function(FnetAnglePair) _then) = _$FnetAnglePairCopyWithImpl;
@useResult
$Res call({
 double plane1, double plane2
});




}
/// @nodoc
class _$FnetAnglePairCopyWithImpl<$Res>
    implements $FnetAnglePairCopyWith<$Res> {
  _$FnetAnglePairCopyWithImpl(this._self, this._then);

  final FnetAnglePair _self;
  final $Res Function(FnetAnglePair) _then;

/// Create a copy of FnetAnglePair
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plane1 = null,Object? plane2 = null,}) {
  return _then(FnetAnglePair(
plane1: null == plane1 ? _self.plane1 : plane1 // ignore: cast_nullable_to_non_nullable
as double,plane2: null == plane2 ? _self.plane2 : plane2 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FnetAnglePair].
extension FnetAnglePairPatterns on FnetAnglePair {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FnetAnglePair value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FnetAnglePair() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FnetAnglePair value)  $default,){
final _that = this;
switch (_that) {
case _FnetAnglePair():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FnetAnglePair value)?  $default,){
final _that = this;
switch (_that) {
case _FnetAnglePair() when $default != null:
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
case _FnetAnglePair() when $default != null:
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
case _FnetAnglePair():
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
case _FnetAnglePair() when $default != null:
return $default(_that.plane1,_that.plane2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FnetAnglePair implements FnetAnglePair {
  const _FnetAnglePair({required this.plane1, required this.plane2});
  factory _FnetAnglePair.fromJson(Map<String, dynamic> json) => _$FnetAnglePairFromJson(json);

@override final  double plane1;
@override final  double plane2;

/// Create a copy of FnetAnglePair
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FnetAnglePairCopyWith<_FnetAnglePair> get copyWith => __$FnetAnglePairCopyWithImpl<_FnetAnglePair>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FnetAnglePairToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FnetAnglePair&&(identical(other.plane1, plane1) || other.plane1 == plane1)&&(identical(other.plane2, plane2) || other.plane2 == plane2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plane1,plane2);

@override
String toString() {
  return 'FnetAnglePair(plane1: $plane1, plane2: $plane2)';
}


}

/// @nodoc
abstract mixin class _$FnetAnglePairCopyWith<$Res> implements $FnetAnglePairCopyWith<$Res> {
  factory _$FnetAnglePairCopyWith(_FnetAnglePair value, $Res Function(_FnetAnglePair) _then) = __$FnetAnglePairCopyWithImpl;
@override @useResult
$Res call({
 double plane1, double plane2
});




}
/// @nodoc
class __$FnetAnglePairCopyWithImpl<$Res>
    implements _$FnetAnglePairCopyWith<$Res> {
  __$FnetAnglePairCopyWithImpl(this._self, this._then);

  final _FnetAnglePair _self;
  final $Res Function(_FnetAnglePair) _then;

/// Create a copy of FnetAnglePair
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plane1 = null,Object? plane2 = null,}) {
  return _then(_FnetAnglePair(
plane1: null == plane1 ? _self.plane1 : plane1 // ignore: cast_nullable_to_non_nullable
as double,plane2: null == plane2 ? _self.plane2 : plane2 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$FnetMomentTensor {

 double get mxx; double get mxy; double get mxz; double get myy; double get myz; double get mzz;
/// Create a copy of FnetMomentTensor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnetMomentTensorCopyWith<FnetMomentTensor> get copyWith => _$FnetMomentTensorCopyWithImpl<FnetMomentTensor>(this as FnetMomentTensor, _$identity);

  /// Serializes this FnetMomentTensor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnetMomentTensor&&(identical(other.mxx, mxx) || other.mxx == mxx)&&(identical(other.mxy, mxy) || other.mxy == mxy)&&(identical(other.mxz, mxz) || other.mxz == mxz)&&(identical(other.myy, myy) || other.myy == myy)&&(identical(other.myz, myz) || other.myz == myz)&&(identical(other.mzz, mzz) || other.mzz == mzz));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mxx,mxy,mxz,myy,myz,mzz);

@override
String toString() {
  return 'FnetMomentTensor(mxx: $mxx, mxy: $mxy, mxz: $mxz, myy: $myy, myz: $myz, mzz: $mzz)';
}


}

/// @nodoc
abstract mixin class $FnetMomentTensorCopyWith<$Res>  {
  factory $FnetMomentTensorCopyWith(FnetMomentTensor value, $Res Function(FnetMomentTensor) _then) = _$FnetMomentTensorCopyWithImpl;
@useResult
$Res call({
 double mxx, double mxy, double mxz, double myy, double myz, double mzz
});




}
/// @nodoc
class _$FnetMomentTensorCopyWithImpl<$Res>
    implements $FnetMomentTensorCopyWith<$Res> {
  _$FnetMomentTensorCopyWithImpl(this._self, this._then);

  final FnetMomentTensor _self;
  final $Res Function(FnetMomentTensor) _then;

/// Create a copy of FnetMomentTensor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mxx = null,Object? mxy = null,Object? mxz = null,Object? myy = null,Object? myz = null,Object? mzz = null,}) {
  return _then(FnetMomentTensor(
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


/// Adds pattern-matching-related methods to [FnetMomentTensor].
extension FnetMomentTensorPatterns on FnetMomentTensor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FnetMomentTensor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FnetMomentTensor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FnetMomentTensor value)  $default,){
final _that = this;
switch (_that) {
case _FnetMomentTensor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FnetMomentTensor value)?  $default,){
final _that = this;
switch (_that) {
case _FnetMomentTensor() when $default != null:
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
case _FnetMomentTensor() when $default != null:
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
case _FnetMomentTensor():
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
case _FnetMomentTensor() when $default != null:
return $default(_that.mxx,_that.mxy,_that.mxz,_that.myy,_that.myz,_that.mzz);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FnetMomentTensor implements FnetMomentTensor {
  const _FnetMomentTensor({required this.mxx, required this.mxy, required this.mxz, required this.myy, required this.myz, required this.mzz});
  factory _FnetMomentTensor.fromJson(Map<String, dynamic> json) => _$FnetMomentTensorFromJson(json);

@override final  double mxx;
@override final  double mxy;
@override final  double mxz;
@override final  double myy;
@override final  double myz;
@override final  double mzz;

/// Create a copy of FnetMomentTensor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FnetMomentTensorCopyWith<_FnetMomentTensor> get copyWith => __$FnetMomentTensorCopyWithImpl<_FnetMomentTensor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FnetMomentTensorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FnetMomentTensor&&(identical(other.mxx, mxx) || other.mxx == mxx)&&(identical(other.mxy, mxy) || other.mxy == mxy)&&(identical(other.mxz, mxz) || other.mxz == mxz)&&(identical(other.myy, myy) || other.myy == myy)&&(identical(other.myz, myz) || other.myz == myz)&&(identical(other.mzz, mzz) || other.mzz == mzz));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mxx,mxy,mxz,myy,myz,mzz);

@override
String toString() {
  return 'FnetMomentTensor(mxx: $mxx, mxy: $mxy, mxz: $mxz, myy: $myy, myz: $myz, mzz: $mzz)';
}


}

/// @nodoc
abstract mixin class _$FnetMomentTensorCopyWith<$Res> implements $FnetMomentTensorCopyWith<$Res> {
  factory _$FnetMomentTensorCopyWith(_FnetMomentTensor value, $Res Function(_FnetMomentTensor) _then) = __$FnetMomentTensorCopyWithImpl;
@override @useResult
$Res call({
 double mxx, double mxy, double mxz, double myy, double myz, double mzz
});




}
/// @nodoc
class __$FnetMomentTensorCopyWithImpl<$Res>
    implements _$FnetMomentTensorCopyWith<$Res> {
  __$FnetMomentTensorCopyWithImpl(this._self, this._then);

  final _FnetMomentTensor _self;
  final $Res Function(_FnetMomentTensor) _then;

/// Create a copy of FnetMomentTensor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mxx = null,Object? mxy = null,Object? mxz = null,Object? myy = null,Object? myz = null,Object? mzz = null,}) {
  return _then(_FnetMomentTensor(
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

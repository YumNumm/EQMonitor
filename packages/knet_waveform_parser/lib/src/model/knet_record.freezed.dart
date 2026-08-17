// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'knet_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KnetRecord {

/// 地震情報（即時公開データでは null）
 KnetEarthquakeInfo? get earthquakeInfo;/// 観測点情報
 KnetStationInfo get stationInfo;/// 記録開始時刻（JST）
 DateTime get recordTime;/// サンプリング周波数 (Hz)
 double get samplingFrequencyHz;/// 計測時間 (秒)
 double get durationTimeSec;/// チャンネル方向
 KnetChannelDirection get direction;/// スケール係数の分子
 double get scaleFactorNumerator;/// スケール係数の分母
 double get scaleFactorDenominator;/// 最大加速度 (gal)
 double get maxAccelerationGal;/// 最終補正時刻
 DateTime? get lastCorrection;/// メモ
 String get memo;/// 波形データ（生デジタル値）
 List<int> get rawData;/// ネットワーク種別
 KnetNetworkType get networkType;
/// Create a copy of KnetRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KnetRecordCopyWith<KnetRecord> get copyWith => _$KnetRecordCopyWithImpl<KnetRecord>(this as KnetRecord, _$identity);

  /// Serializes this KnetRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KnetRecord&&(identical(other.earthquakeInfo, earthquakeInfo) || other.earthquakeInfo == earthquakeInfo)&&(identical(other.stationInfo, stationInfo) || other.stationInfo == stationInfo)&&(identical(other.recordTime, recordTime) || other.recordTime == recordTime)&&(identical(other.samplingFrequencyHz, samplingFrequencyHz) || other.samplingFrequencyHz == samplingFrequencyHz)&&(identical(other.durationTimeSec, durationTimeSec) || other.durationTimeSec == durationTimeSec)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.scaleFactorNumerator, scaleFactorNumerator) || other.scaleFactorNumerator == scaleFactorNumerator)&&(identical(other.scaleFactorDenominator, scaleFactorDenominator) || other.scaleFactorDenominator == scaleFactorDenominator)&&(identical(other.maxAccelerationGal, maxAccelerationGal) || other.maxAccelerationGal == maxAccelerationGal)&&(identical(other.lastCorrection, lastCorrection) || other.lastCorrection == lastCorrection)&&(identical(other.memo, memo) || other.memo == memo)&&const DeepCollectionEquality().equals(other.rawData, rawData)&&(identical(other.networkType, networkType) || other.networkType == networkType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,earthquakeInfo,stationInfo,recordTime,samplingFrequencyHz,durationTimeSec,direction,scaleFactorNumerator,scaleFactorDenominator,maxAccelerationGal,lastCorrection,memo,const DeepCollectionEquality().hash(rawData),networkType);

@override
String toString() {
  return 'KnetRecord(earthquakeInfo: $earthquakeInfo, stationInfo: $stationInfo, recordTime: $recordTime, samplingFrequencyHz: $samplingFrequencyHz, durationTimeSec: $durationTimeSec, direction: $direction, scaleFactorNumerator: $scaleFactorNumerator, scaleFactorDenominator: $scaleFactorDenominator, maxAccelerationGal: $maxAccelerationGal, lastCorrection: $lastCorrection, memo: $memo, rawData: $rawData, networkType: $networkType)';
}


}

/// @nodoc
abstract mixin class $KnetRecordCopyWith<$Res>  {
  factory $KnetRecordCopyWith(KnetRecord value, $Res Function(KnetRecord) _then) = _$KnetRecordCopyWithImpl;
@useResult
$Res call({
 KnetEarthquakeInfo? earthquakeInfo, KnetStationInfo stationInfo, DateTime recordTime, double samplingFrequencyHz, double durationTimeSec, KnetChannelDirection direction, double scaleFactorNumerator, double scaleFactorDenominator, double maxAccelerationGal, DateTime? lastCorrection, String memo, List<int> rawData, KnetNetworkType networkType
});


$KnetEarthquakeInfoCopyWith<$Res>? get earthquakeInfo;$KnetStationInfoCopyWith<$Res> get stationInfo;

}
/// @nodoc
class _$KnetRecordCopyWithImpl<$Res>
    implements $KnetRecordCopyWith<$Res> {
  _$KnetRecordCopyWithImpl(this._self, this._then);

  final KnetRecord _self;
  final $Res Function(KnetRecord) _then;

/// Create a copy of KnetRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? earthquakeInfo = freezed,Object? stationInfo = null,Object? recordTime = null,Object? samplingFrequencyHz = null,Object? durationTimeSec = null,Object? direction = null,Object? scaleFactorNumerator = null,Object? scaleFactorDenominator = null,Object? maxAccelerationGal = null,Object? lastCorrection = freezed,Object? memo = null,Object? rawData = null,Object? networkType = null,}) {
  return _then(KnetRecord(
earthquakeInfo: freezed == earthquakeInfo ? _self.earthquakeInfo : earthquakeInfo // ignore: cast_nullable_to_non_nullable
as KnetEarthquakeInfo?,stationInfo: null == stationInfo ? _self.stationInfo : stationInfo // ignore: cast_nullable_to_non_nullable
as KnetStationInfo,recordTime: null == recordTime ? _self.recordTime : recordTime // ignore: cast_nullable_to_non_nullable
as DateTime,samplingFrequencyHz: null == samplingFrequencyHz ? _self.samplingFrequencyHz : samplingFrequencyHz // ignore: cast_nullable_to_non_nullable
as double,durationTimeSec: null == durationTimeSec ? _self.durationTimeSec : durationTimeSec // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as KnetChannelDirection,scaleFactorNumerator: null == scaleFactorNumerator ? _self.scaleFactorNumerator : scaleFactorNumerator // ignore: cast_nullable_to_non_nullable
as double,scaleFactorDenominator: null == scaleFactorDenominator ? _self.scaleFactorDenominator : scaleFactorDenominator // ignore: cast_nullable_to_non_nullable
as double,maxAccelerationGal: null == maxAccelerationGal ? _self.maxAccelerationGal : maxAccelerationGal // ignore: cast_nullable_to_non_nullable
as double,lastCorrection: freezed == lastCorrection ? _self.lastCorrection : lastCorrection // ignore: cast_nullable_to_non_nullable
as DateTime?,memo: null == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String,rawData: null == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as List<int>,networkType: null == networkType ? _self.networkType : networkType // ignore: cast_nullable_to_non_nullable
as KnetNetworkType,
  ));
}
/// Create a copy of KnetRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KnetEarthquakeInfoCopyWith<$Res>? get earthquakeInfo {
    if (_self.earthquakeInfo == null) {
    return null;
  }

  return $KnetEarthquakeInfoCopyWith<$Res>(_self.earthquakeInfo!, (value) {
    return _then(_self.copyWith(earthquakeInfo: value));
  });
}/// Create a copy of KnetRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KnetStationInfoCopyWith<$Res> get stationInfo {
  
  return $KnetStationInfoCopyWith<$Res>(_self.stationInfo, (value) {
    return _then(_self.copyWith(stationInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [KnetRecord].
extension KnetRecordPatterns on KnetRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KnetRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KnetRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KnetRecord value)  $default,){
final _that = this;
switch (_that) {
case _KnetRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KnetRecord value)?  $default,){
final _that = this;
switch (_that) {
case _KnetRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KnetEarthquakeInfo? earthquakeInfo,  KnetStationInfo stationInfo,  DateTime recordTime,  double samplingFrequencyHz,  double durationTimeSec,  KnetChannelDirection direction,  double scaleFactorNumerator,  double scaleFactorDenominator,  double maxAccelerationGal,  DateTime? lastCorrection,  String memo,  List<int> rawData,  KnetNetworkType networkType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KnetRecord() when $default != null:
return $default(_that.earthquakeInfo,_that.stationInfo,_that.recordTime,_that.samplingFrequencyHz,_that.durationTimeSec,_that.direction,_that.scaleFactorNumerator,_that.scaleFactorDenominator,_that.maxAccelerationGal,_that.lastCorrection,_that.memo,_that.rawData,_that.networkType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KnetEarthquakeInfo? earthquakeInfo,  KnetStationInfo stationInfo,  DateTime recordTime,  double samplingFrequencyHz,  double durationTimeSec,  KnetChannelDirection direction,  double scaleFactorNumerator,  double scaleFactorDenominator,  double maxAccelerationGal,  DateTime? lastCorrection,  String memo,  List<int> rawData,  KnetNetworkType networkType)  $default,) {final _that = this;
switch (_that) {
case _KnetRecord():
return $default(_that.earthquakeInfo,_that.stationInfo,_that.recordTime,_that.samplingFrequencyHz,_that.durationTimeSec,_that.direction,_that.scaleFactorNumerator,_that.scaleFactorDenominator,_that.maxAccelerationGal,_that.lastCorrection,_that.memo,_that.rawData,_that.networkType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KnetEarthquakeInfo? earthquakeInfo,  KnetStationInfo stationInfo,  DateTime recordTime,  double samplingFrequencyHz,  double durationTimeSec,  KnetChannelDirection direction,  double scaleFactorNumerator,  double scaleFactorDenominator,  double maxAccelerationGal,  DateTime? lastCorrection,  String memo,  List<int> rawData,  KnetNetworkType networkType)?  $default,) {final _that = this;
switch (_that) {
case _KnetRecord() when $default != null:
return $default(_that.earthquakeInfo,_that.stationInfo,_that.recordTime,_that.samplingFrequencyHz,_that.durationTimeSec,_that.direction,_that.scaleFactorNumerator,_that.scaleFactorDenominator,_that.maxAccelerationGal,_that.lastCorrection,_that.memo,_that.rawData,_that.networkType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KnetRecord extends KnetRecord {
  const _KnetRecord({required this.earthquakeInfo, required this.stationInfo, required this.recordTime, required this.samplingFrequencyHz, required this.durationTimeSec, required this.direction, required this.scaleFactorNumerator, required this.scaleFactorDenominator, required this.maxAccelerationGal, required this.lastCorrection, required this.memo, required  List<int> rawData, required this.networkType}): _rawData = rawData,super._();
  factory _KnetRecord.fromJson(Map<String, dynamic> json) => _$KnetRecordFromJson(json);

/// 地震情報（即時公開データでは null）
@override final  KnetEarthquakeInfo? earthquakeInfo;
/// 観測点情報
@override final  KnetStationInfo stationInfo;
/// 記録開始時刻（JST）
@override final  DateTime recordTime;
/// サンプリング周波数 (Hz)
@override final  double samplingFrequencyHz;
/// 計測時間 (秒)
@override final  double durationTimeSec;
/// チャンネル方向
@override final  KnetChannelDirection direction;
/// スケール係数の分子
@override final  double scaleFactorNumerator;
/// スケール係数の分母
@override final  double scaleFactorDenominator;
/// 最大加速度 (gal)
@override final  double maxAccelerationGal;
/// 最終補正時刻
@override final  DateTime? lastCorrection;
/// メモ
@override final  String memo;
/// 波形データ（生デジタル値）
 final  List<int> _rawData;
/// 波形データ（生デジタル値）
@override List<int> get rawData {
  if (_rawData is EqualUnmodifiableListView) return _rawData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rawData);
}

/// ネットワーク種別
@override final  KnetNetworkType networkType;

/// Create a copy of KnetRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KnetRecordCopyWith<_KnetRecord> get copyWith => __$KnetRecordCopyWithImpl<_KnetRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KnetRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KnetRecord&&(identical(other.earthquakeInfo, earthquakeInfo) || other.earthquakeInfo == earthquakeInfo)&&(identical(other.stationInfo, stationInfo) || other.stationInfo == stationInfo)&&(identical(other.recordTime, recordTime) || other.recordTime == recordTime)&&(identical(other.samplingFrequencyHz, samplingFrequencyHz) || other.samplingFrequencyHz == samplingFrequencyHz)&&(identical(other.durationTimeSec, durationTimeSec) || other.durationTimeSec == durationTimeSec)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.scaleFactorNumerator, scaleFactorNumerator) || other.scaleFactorNumerator == scaleFactorNumerator)&&(identical(other.scaleFactorDenominator, scaleFactorDenominator) || other.scaleFactorDenominator == scaleFactorDenominator)&&(identical(other.maxAccelerationGal, maxAccelerationGal) || other.maxAccelerationGal == maxAccelerationGal)&&(identical(other.lastCorrection, lastCorrection) || other.lastCorrection == lastCorrection)&&(identical(other.memo, memo) || other.memo == memo)&&const DeepCollectionEquality().equals(other._rawData, _rawData)&&(identical(other.networkType, networkType) || other.networkType == networkType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,earthquakeInfo,stationInfo,recordTime,samplingFrequencyHz,durationTimeSec,direction,scaleFactorNumerator,scaleFactorDenominator,maxAccelerationGal,lastCorrection,memo,const DeepCollectionEquality().hash(_rawData),networkType);

@override
String toString() {
  return 'KnetRecord(earthquakeInfo: $earthquakeInfo, stationInfo: $stationInfo, recordTime: $recordTime, samplingFrequencyHz: $samplingFrequencyHz, durationTimeSec: $durationTimeSec, direction: $direction, scaleFactorNumerator: $scaleFactorNumerator, scaleFactorDenominator: $scaleFactorDenominator, maxAccelerationGal: $maxAccelerationGal, lastCorrection: $lastCorrection, memo: $memo, rawData: $rawData, networkType: $networkType)';
}


}

/// @nodoc
abstract mixin class _$KnetRecordCopyWith<$Res> implements $KnetRecordCopyWith<$Res> {
  factory _$KnetRecordCopyWith(_KnetRecord value, $Res Function(_KnetRecord) _then) = __$KnetRecordCopyWithImpl;
@override @useResult
$Res call({
 KnetEarthquakeInfo? earthquakeInfo, KnetStationInfo stationInfo, DateTime recordTime, double samplingFrequencyHz, double durationTimeSec, KnetChannelDirection direction, double scaleFactorNumerator, double scaleFactorDenominator, double maxAccelerationGal, DateTime? lastCorrection, String memo, List<int> rawData, KnetNetworkType networkType
});


@override $KnetEarthquakeInfoCopyWith<$Res>? get earthquakeInfo;@override $KnetStationInfoCopyWith<$Res> get stationInfo;

}
/// @nodoc
class __$KnetRecordCopyWithImpl<$Res>
    implements _$KnetRecordCopyWith<$Res> {
  __$KnetRecordCopyWithImpl(this._self, this._then);

  final _KnetRecord _self;
  final $Res Function(_KnetRecord) _then;

/// Create a copy of KnetRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? earthquakeInfo = freezed,Object? stationInfo = null,Object? recordTime = null,Object? samplingFrequencyHz = null,Object? durationTimeSec = null,Object? direction = null,Object? scaleFactorNumerator = null,Object? scaleFactorDenominator = null,Object? maxAccelerationGal = null,Object? lastCorrection = freezed,Object? memo = null,Object? rawData = null,Object? networkType = null,}) {
  return _then(_KnetRecord(
earthquakeInfo: freezed == earthquakeInfo ? _self.earthquakeInfo : earthquakeInfo // ignore: cast_nullable_to_non_nullable
as KnetEarthquakeInfo?,stationInfo: null == stationInfo ? _self.stationInfo : stationInfo // ignore: cast_nullable_to_non_nullable
as KnetStationInfo,recordTime: null == recordTime ? _self.recordTime : recordTime // ignore: cast_nullable_to_non_nullable
as DateTime,samplingFrequencyHz: null == samplingFrequencyHz ? _self.samplingFrequencyHz : samplingFrequencyHz // ignore: cast_nullable_to_non_nullable
as double,durationTimeSec: null == durationTimeSec ? _self.durationTimeSec : durationTimeSec // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as KnetChannelDirection,scaleFactorNumerator: null == scaleFactorNumerator ? _self.scaleFactorNumerator : scaleFactorNumerator // ignore: cast_nullable_to_non_nullable
as double,scaleFactorDenominator: null == scaleFactorDenominator ? _self.scaleFactorDenominator : scaleFactorDenominator // ignore: cast_nullable_to_non_nullable
as double,maxAccelerationGal: null == maxAccelerationGal ? _self.maxAccelerationGal : maxAccelerationGal // ignore: cast_nullable_to_non_nullable
as double,lastCorrection: freezed == lastCorrection ? _self.lastCorrection : lastCorrection // ignore: cast_nullable_to_non_nullable
as DateTime?,memo: null == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String,rawData: null == rawData ? _self._rawData : rawData // ignore: cast_nullable_to_non_nullable
as List<int>,networkType: null == networkType ? _self.networkType : networkType // ignore: cast_nullable_to_non_nullable
as KnetNetworkType,
  ));
}

/// Create a copy of KnetRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KnetEarthquakeInfoCopyWith<$Res>? get earthquakeInfo {
    if (_self.earthquakeInfo == null) {
    return null;
  }

  return $KnetEarthquakeInfoCopyWith<$Res>(_self.earthquakeInfo!, (value) {
    return _then(_self.copyWith(earthquakeInfo: value));
  });
}/// Create a copy of KnetRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KnetStationInfoCopyWith<$Res> get stationInfo {
  
  return $KnetStationInfoCopyWith<$Res>(_self.stationInfo, (value) {
    return _then(_self.copyWith(stationInfo: value));
  });
}
}


/// @nodoc
mixin _$KnetEarthquakeInfo {

/// 地震発生時刻
 DateTime get originTime;/// 震源緯度 (度)
 double get latitude;/// 震源経度 (度)
 double get longitude;/// 震源深さ (km)
 double get depthKm;/// マグニチュード
 double get magnitude;
/// Create a copy of KnetEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KnetEarthquakeInfoCopyWith<KnetEarthquakeInfo> get copyWith => _$KnetEarthquakeInfoCopyWithImpl<KnetEarthquakeInfo>(this as KnetEarthquakeInfo, _$identity);

  /// Serializes this KnetEarthquakeInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KnetEarthquakeInfo&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originTime,latitude,longitude,depthKm,magnitude);

@override
String toString() {
  return 'KnetEarthquakeInfo(originTime: $originTime, latitude: $latitude, longitude: $longitude, depthKm: $depthKm, magnitude: $magnitude)';
}


}

/// @nodoc
abstract mixin class $KnetEarthquakeInfoCopyWith<$Res>  {
  factory $KnetEarthquakeInfoCopyWith(KnetEarthquakeInfo value, $Res Function(KnetEarthquakeInfo) _then) = _$KnetEarthquakeInfoCopyWithImpl;
@useResult
$Res call({
 DateTime originTime, double latitude, double longitude, double depthKm, double magnitude
});




}
/// @nodoc
class _$KnetEarthquakeInfoCopyWithImpl<$Res>
    implements $KnetEarthquakeInfoCopyWith<$Res> {
  _$KnetEarthquakeInfoCopyWithImpl(this._self, this._then);

  final KnetEarthquakeInfo _self;
  final $Res Function(KnetEarthquakeInfo) _then;

/// Create a copy of KnetEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originTime = null,Object? latitude = null,Object? longitude = null,Object? depthKm = null,Object? magnitude = null,}) {
  return _then(KnetEarthquakeInfo(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depthKm: null == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [KnetEarthquakeInfo].
extension KnetEarthquakeInfoPatterns on KnetEarthquakeInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KnetEarthquakeInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KnetEarthquakeInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KnetEarthquakeInfo value)  $default,){
final _that = this;
switch (_that) {
case _KnetEarthquakeInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KnetEarthquakeInfo value)?  $default,){
final _that = this;
switch (_that) {
case _KnetEarthquakeInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime originTime,  double latitude,  double longitude,  double depthKm,  double magnitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KnetEarthquakeInfo() when $default != null:
return $default(_that.originTime,_that.latitude,_that.longitude,_that.depthKm,_that.magnitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime originTime,  double latitude,  double longitude,  double depthKm,  double magnitude)  $default,) {final _that = this;
switch (_that) {
case _KnetEarthquakeInfo():
return $default(_that.originTime,_that.latitude,_that.longitude,_that.depthKm,_that.magnitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime originTime,  double latitude,  double longitude,  double depthKm,  double magnitude)?  $default,) {final _that = this;
switch (_that) {
case _KnetEarthquakeInfo() when $default != null:
return $default(_that.originTime,_that.latitude,_that.longitude,_that.depthKm,_that.magnitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KnetEarthquakeInfo implements KnetEarthquakeInfo {
  const _KnetEarthquakeInfo({required this.originTime, required this.latitude, required this.longitude, required this.depthKm, required this.magnitude});
  factory _KnetEarthquakeInfo.fromJson(Map<String, dynamic> json) => _$KnetEarthquakeInfoFromJson(json);

/// 地震発生時刻
@override final  DateTime originTime;
/// 震源緯度 (度)
@override final  double latitude;
/// 震源経度 (度)
@override final  double longitude;
/// 震源深さ (km)
@override final  double depthKm;
/// マグニチュード
@override final  double magnitude;

/// Create a copy of KnetEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KnetEarthquakeInfoCopyWith<_KnetEarthquakeInfo> get copyWith => __$KnetEarthquakeInfoCopyWithImpl<_KnetEarthquakeInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KnetEarthquakeInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KnetEarthquakeInfo&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originTime,latitude,longitude,depthKm,magnitude);

@override
String toString() {
  return 'KnetEarthquakeInfo(originTime: $originTime, latitude: $latitude, longitude: $longitude, depthKm: $depthKm, magnitude: $magnitude)';
}


}

/// @nodoc
abstract mixin class _$KnetEarthquakeInfoCopyWith<$Res> implements $KnetEarthquakeInfoCopyWith<$Res> {
  factory _$KnetEarthquakeInfoCopyWith(_KnetEarthquakeInfo value, $Res Function(_KnetEarthquakeInfo) _then) = __$KnetEarthquakeInfoCopyWithImpl;
@override @useResult
$Res call({
 DateTime originTime, double latitude, double longitude, double depthKm, double magnitude
});




}
/// @nodoc
class __$KnetEarthquakeInfoCopyWithImpl<$Res>
    implements _$KnetEarthquakeInfoCopyWith<$Res> {
  __$KnetEarthquakeInfoCopyWithImpl(this._self, this._then);

  final _KnetEarthquakeInfo _self;
  final $Res Function(_KnetEarthquakeInfo) _then;

/// Create a copy of KnetEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originTime = null,Object? latitude = null,Object? longitude = null,Object? depthKm = null,Object? magnitude = null,}) {
  return _then(_KnetEarthquakeInfo(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depthKm: null == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$KnetStationInfo {

/// 観測点コード
 String get stationCode;/// 観測点緯度 (度)
 double get latitude;/// 観測点経度 (度)
 double get longitude;/// 観測点標高 (m)
 double get heightM;
/// Create a copy of KnetStationInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KnetStationInfoCopyWith<KnetStationInfo> get copyWith => _$KnetStationInfoCopyWithImpl<KnetStationInfo>(this as KnetStationInfo, _$identity);

  /// Serializes this KnetStationInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KnetStationInfo&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.heightM, heightM) || other.heightM == heightM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stationCode,latitude,longitude,heightM);

@override
String toString() {
  return 'KnetStationInfo(stationCode: $stationCode, latitude: $latitude, longitude: $longitude, heightM: $heightM)';
}


}

/// @nodoc
abstract mixin class $KnetStationInfoCopyWith<$Res>  {
  factory $KnetStationInfoCopyWith(KnetStationInfo value, $Res Function(KnetStationInfo) _then) = _$KnetStationInfoCopyWithImpl;
@useResult
$Res call({
 String stationCode, double latitude, double longitude, double heightM
});




}
/// @nodoc
class _$KnetStationInfoCopyWithImpl<$Res>
    implements $KnetStationInfoCopyWith<$Res> {
  _$KnetStationInfoCopyWithImpl(this._self, this._then);

  final KnetStationInfo _self;
  final $Res Function(KnetStationInfo) _then;

/// Create a copy of KnetStationInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stationCode = null,Object? latitude = null,Object? longitude = null,Object? heightM = null,}) {
  return _then(KnetStationInfo(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,heightM: null == heightM ? _self.heightM : heightM // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [KnetStationInfo].
extension KnetStationInfoPatterns on KnetStationInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KnetStationInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KnetStationInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KnetStationInfo value)  $default,){
final _that = this;
switch (_that) {
case _KnetStationInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KnetStationInfo value)?  $default,){
final _that = this;
switch (_that) {
case _KnetStationInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stationCode,  double latitude,  double longitude,  double heightM)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KnetStationInfo() when $default != null:
return $default(_that.stationCode,_that.latitude,_that.longitude,_that.heightM);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stationCode,  double latitude,  double longitude,  double heightM)  $default,) {final _that = this;
switch (_that) {
case _KnetStationInfo():
return $default(_that.stationCode,_that.latitude,_that.longitude,_that.heightM);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stationCode,  double latitude,  double longitude,  double heightM)?  $default,) {final _that = this;
switch (_that) {
case _KnetStationInfo() when $default != null:
return $default(_that.stationCode,_that.latitude,_that.longitude,_that.heightM);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KnetStationInfo implements KnetStationInfo {
  const _KnetStationInfo({required this.stationCode, required this.latitude, required this.longitude, required this.heightM});
  factory _KnetStationInfo.fromJson(Map<String, dynamic> json) => _$KnetStationInfoFromJson(json);

/// 観測点コード
@override final  String stationCode;
/// 観測点緯度 (度)
@override final  double latitude;
/// 観測点経度 (度)
@override final  double longitude;
/// 観測点標高 (m)
@override final  double heightM;

/// Create a copy of KnetStationInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KnetStationInfoCopyWith<_KnetStationInfo> get copyWith => __$KnetStationInfoCopyWithImpl<_KnetStationInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KnetStationInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KnetStationInfo&&(identical(other.stationCode, stationCode) || other.stationCode == stationCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.heightM, heightM) || other.heightM == heightM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stationCode,latitude,longitude,heightM);

@override
String toString() {
  return 'KnetStationInfo(stationCode: $stationCode, latitude: $latitude, longitude: $longitude, heightM: $heightM)';
}


}

/// @nodoc
abstract mixin class _$KnetStationInfoCopyWith<$Res> implements $KnetStationInfoCopyWith<$Res> {
  factory _$KnetStationInfoCopyWith(_KnetStationInfo value, $Res Function(_KnetStationInfo) _then) = __$KnetStationInfoCopyWithImpl;
@override @useResult
$Res call({
 String stationCode, double latitude, double longitude, double heightM
});




}
/// @nodoc
class __$KnetStationInfoCopyWithImpl<$Res>
    implements _$KnetStationInfoCopyWith<$Res> {
  __$KnetStationInfoCopyWithImpl(this._self, this._then);

  final _KnetStationInfo _self;
  final $Res Function(_KnetStationInfo) _then;

/// Create a copy of KnetStationInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stationCode = null,Object? latitude = null,Object? longitude = null,Object? heightM = null,}) {
  return _then(_KnetStationInfo(
stationCode: null == stationCode ? _self.stationCode : stationCode // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,heightM: null == heightM ? _self.heightM : heightM // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

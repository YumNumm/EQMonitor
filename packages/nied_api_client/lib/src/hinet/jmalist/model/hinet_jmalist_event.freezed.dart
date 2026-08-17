// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hinet_jmalist_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HinetJmalistEvent {

/// 発生時刻(UTC)
///
/// jmalist.php の出力は JST のため、パーサ側で UTC(-9h)へ変換して
/// 格納する。
 DateTime get originTime;/// 時刻誤差(秒)
 double get timeError; double get latitude;/// 緯度誤差(度)
 double get latitudeError; double get longitude;/// 経度誤差(度)
 double get longitudeError;/// 深さ(km)
 double get depthKm;/// マグニチュード(1つ目)
 double get magnitude1;/// マグニチュード(2つ目、欠測時 null)
 double? get magnitude2;/// マグニチュード種別フラグ(例: 'V'、欠測時 null)
 String? get magnitudeFlag;/// 震央地名(英語)
 String get regionNameEn;/// 品質コード
 String get qualityCode;
/// Create a copy of HinetJmalistEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HinetJmalistEventCopyWith<HinetJmalistEvent> get copyWith => _$HinetJmalistEventCopyWithImpl<HinetJmalistEvent>(this as HinetJmalistEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HinetJmalistEvent&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.timeError, timeError) || other.timeError == timeError)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.latitudeError, latitudeError) || other.latitudeError == latitudeError)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.longitudeError, longitudeError) || other.longitudeError == longitudeError)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.magnitude1, magnitude1) || other.magnitude1 == magnitude1)&&(identical(other.magnitude2, magnitude2) || other.magnitude2 == magnitude2)&&(identical(other.magnitudeFlag, magnitudeFlag) || other.magnitudeFlag == magnitudeFlag)&&(identical(other.regionNameEn, regionNameEn) || other.regionNameEn == regionNameEn)&&(identical(other.qualityCode, qualityCode) || other.qualityCode == qualityCode));
}


@override
int get hashCode => Object.hash(runtimeType,originTime,timeError,latitude,latitudeError,longitude,longitudeError,depthKm,magnitude1,magnitude2,magnitudeFlag,regionNameEn,qualityCode);

@override
String toString() {
  return 'HinetJmalistEvent(originTime: $originTime, timeError: $timeError, latitude: $latitude, latitudeError: $latitudeError, longitude: $longitude, longitudeError: $longitudeError, depthKm: $depthKm, magnitude1: $magnitude1, magnitude2: $magnitude2, magnitudeFlag: $magnitudeFlag, regionNameEn: $regionNameEn, qualityCode: $qualityCode)';
}


}

/// @nodoc
abstract mixin class $HinetJmalistEventCopyWith<$Res>  {
  factory $HinetJmalistEventCopyWith(HinetJmalistEvent value, $Res Function(HinetJmalistEvent) _then) = _$HinetJmalistEventCopyWithImpl;
@useResult
$Res call({
 DateTime originTime, double timeError, double latitude, double latitudeError, double longitude, double longitudeError, double depthKm, double magnitude1, double? magnitude2, String? magnitudeFlag, String regionNameEn, String qualityCode
});




}
/// @nodoc
class _$HinetJmalistEventCopyWithImpl<$Res>
    implements $HinetJmalistEventCopyWith<$Res> {
  _$HinetJmalistEventCopyWithImpl(this._self, this._then);

  final HinetJmalistEvent _self;
  final $Res Function(HinetJmalistEvent) _then;

/// Create a copy of HinetJmalistEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originTime = null,Object? timeError = null,Object? latitude = null,Object? latitudeError = null,Object? longitude = null,Object? longitudeError = null,Object? depthKm = null,Object? magnitude1 = null,Object? magnitude2 = freezed,Object? magnitudeFlag = freezed,Object? regionNameEn = null,Object? qualityCode = null,}) {
  return _then(HinetJmalistEvent(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,timeError: null == timeError ? _self.timeError : timeError // ignore: cast_nullable_to_non_nullable
as double,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,latitudeError: null == latitudeError ? _self.latitudeError : latitudeError // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,longitudeError: null == longitudeError ? _self.longitudeError : longitudeError // ignore: cast_nullable_to_non_nullable
as double,depthKm: null == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double,magnitude1: null == magnitude1 ? _self.magnitude1 : magnitude1 // ignore: cast_nullable_to_non_nullable
as double,magnitude2: freezed == magnitude2 ? _self.magnitude2 : magnitude2 // ignore: cast_nullable_to_non_nullable
as double?,magnitudeFlag: freezed == magnitudeFlag ? _self.magnitudeFlag : magnitudeFlag // ignore: cast_nullable_to_non_nullable
as String?,regionNameEn: null == regionNameEn ? _self.regionNameEn : regionNameEn // ignore: cast_nullable_to_non_nullable
as String,qualityCode: null == qualityCode ? _self.qualityCode : qualityCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HinetJmalistEvent].
extension HinetJmalistEventPatterns on HinetJmalistEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HinetJmalistEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HinetJmalistEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HinetJmalistEvent value)  $default,){
final _that = this;
switch (_that) {
case _HinetJmalistEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HinetJmalistEvent value)?  $default,){
final _that = this;
switch (_that) {
case _HinetJmalistEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime originTime,  double timeError,  double latitude,  double latitudeError,  double longitude,  double longitudeError,  double depthKm,  double magnitude1,  double? magnitude2,  String? magnitudeFlag,  String regionNameEn,  String qualityCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HinetJmalistEvent() when $default != null:
return $default(_that.originTime,_that.timeError,_that.latitude,_that.latitudeError,_that.longitude,_that.longitudeError,_that.depthKm,_that.magnitude1,_that.magnitude2,_that.magnitudeFlag,_that.regionNameEn,_that.qualityCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime originTime,  double timeError,  double latitude,  double latitudeError,  double longitude,  double longitudeError,  double depthKm,  double magnitude1,  double? magnitude2,  String? magnitudeFlag,  String regionNameEn,  String qualityCode)  $default,) {final _that = this;
switch (_that) {
case _HinetJmalistEvent():
return $default(_that.originTime,_that.timeError,_that.latitude,_that.latitudeError,_that.longitude,_that.longitudeError,_that.depthKm,_that.magnitude1,_that.magnitude2,_that.magnitudeFlag,_that.regionNameEn,_that.qualityCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime originTime,  double timeError,  double latitude,  double latitudeError,  double longitude,  double longitudeError,  double depthKm,  double magnitude1,  double? magnitude2,  String? magnitudeFlag,  String regionNameEn,  String qualityCode)?  $default,) {final _that = this;
switch (_that) {
case _HinetJmalistEvent() when $default != null:
return $default(_that.originTime,_that.timeError,_that.latitude,_that.latitudeError,_that.longitude,_that.longitudeError,_that.depthKm,_that.magnitude1,_that.magnitude2,_that.magnitudeFlag,_that.regionNameEn,_that.qualityCode);case _:
  return null;

}
}

}

/// @nodoc


class _HinetJmalistEvent implements HinetJmalistEvent {
  const _HinetJmalistEvent({required this.originTime, required this.timeError, required this.latitude, required this.latitudeError, required this.longitude, required this.longitudeError, required this.depthKm, required this.magnitude1, required this.magnitude2, required this.magnitudeFlag, required this.regionNameEn, required this.qualityCode});
  

/// 発生時刻(UTC)
///
/// jmalist.php の出力は JST のため、パーサ側で UTC(-9h)へ変換して
/// 格納する。
@override final  DateTime originTime;
/// 時刻誤差(秒)
@override final  double timeError;
@override final  double latitude;
/// 緯度誤差(度)
@override final  double latitudeError;
@override final  double longitude;
/// 経度誤差(度)
@override final  double longitudeError;
/// 深さ(km)
@override final  double depthKm;
/// マグニチュード(1つ目)
@override final  double magnitude1;
/// マグニチュード(2つ目、欠測時 null)
@override final  double? magnitude2;
/// マグニチュード種別フラグ(例: 'V'、欠測時 null)
@override final  String? magnitudeFlag;
/// 震央地名(英語)
@override final  String regionNameEn;
/// 品質コード
@override final  String qualityCode;

/// Create a copy of HinetJmalistEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HinetJmalistEventCopyWith<_HinetJmalistEvent> get copyWith => __$HinetJmalistEventCopyWithImpl<_HinetJmalistEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HinetJmalistEvent&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.timeError, timeError) || other.timeError == timeError)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.latitudeError, latitudeError) || other.latitudeError == latitudeError)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.longitudeError, longitudeError) || other.longitudeError == longitudeError)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.magnitude1, magnitude1) || other.magnitude1 == magnitude1)&&(identical(other.magnitude2, magnitude2) || other.magnitude2 == magnitude2)&&(identical(other.magnitudeFlag, magnitudeFlag) || other.magnitudeFlag == magnitudeFlag)&&(identical(other.regionNameEn, regionNameEn) || other.regionNameEn == regionNameEn)&&(identical(other.qualityCode, qualityCode) || other.qualityCode == qualityCode));
}


@override
int get hashCode => Object.hash(runtimeType,originTime,timeError,latitude,latitudeError,longitude,longitudeError,depthKm,magnitude1,magnitude2,magnitudeFlag,regionNameEn,qualityCode);

@override
String toString() {
  return 'HinetJmalistEvent(originTime: $originTime, timeError: $timeError, latitude: $latitude, latitudeError: $latitudeError, longitude: $longitude, longitudeError: $longitudeError, depthKm: $depthKm, magnitude1: $magnitude1, magnitude2: $magnitude2, magnitudeFlag: $magnitudeFlag, regionNameEn: $regionNameEn, qualityCode: $qualityCode)';
}


}

/// @nodoc
abstract mixin class _$HinetJmalistEventCopyWith<$Res> implements $HinetJmalistEventCopyWith<$Res> {
  factory _$HinetJmalistEventCopyWith(_HinetJmalistEvent value, $Res Function(_HinetJmalistEvent) _then) = __$HinetJmalistEventCopyWithImpl;
@override @useResult
$Res call({
 DateTime originTime, double timeError, double latitude, double latitudeError, double longitude, double longitudeError, double depthKm, double magnitude1, double? magnitude2, String? magnitudeFlag, String regionNameEn, String qualityCode
});




}
/// @nodoc
class __$HinetJmalistEventCopyWithImpl<$Res>
    implements _$HinetJmalistEventCopyWith<$Res> {
  __$HinetJmalistEventCopyWithImpl(this._self, this._then);

  final _HinetJmalistEvent _self;
  final $Res Function(_HinetJmalistEvent) _then;

/// Create a copy of HinetJmalistEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originTime = null,Object? timeError = null,Object? latitude = null,Object? latitudeError = null,Object? longitude = null,Object? longitudeError = null,Object? depthKm = null,Object? magnitude1 = null,Object? magnitude2 = freezed,Object? magnitudeFlag = freezed,Object? regionNameEn = null,Object? qualityCode = null,}) {
  return _then(_HinetJmalistEvent(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,timeError: null == timeError ? _self.timeError : timeError // ignore: cast_nullable_to_non_nullable
as double,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,latitudeError: null == latitudeError ? _self.latitudeError : latitudeError // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,longitudeError: null == longitudeError ? _self.longitudeError : longitudeError // ignore: cast_nullable_to_non_nullable
as double,depthKm: null == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as double,magnitude1: null == magnitude1 ? _self.magnitude1 : magnitude1 // ignore: cast_nullable_to_non_nullable
as double,magnitude2: freezed == magnitude2 ? _self.magnitude2 : magnitude2 // ignore: cast_nullable_to_non_nullable
as double?,magnitudeFlag: freezed == magnitudeFlag ? _self.magnitudeFlag : magnitudeFlag // ignore: cast_nullable_to_non_nullable
as String?,regionNameEn: null == regionNameEn ? _self.regionNameEn : regionNameEn // ignore: cast_nullable_to_non_nullable
as String,qualityCode: null == qualityCode ? _self.qualityCode : qualityCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'aqua_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AquaEvent {

/// イベントID (yyyyMMddHHmmss形式)
///
/// 地震発生日時を表す14桁の数字
/// 例: 20251103000018 = 2025年11月3日 00時00分18秒
 String get id;/// 発生日時
///
/// 地震の発生時刻（震源時）
/// JST時刻
/// ただし、typeがCMTの場合は、セントロイドの時刻を表す
@TZDateTimeJstJsonConverter() TZDateTime get originTime;/// 震央地名
///
/// 震源の位置を表す地名
/// 例: "福島県沖", "Off Fukushima Prefecture"
 String get region;/// 緯度 (度)
///
/// 震源の緯度（北緯が正）
/// ただし、typeがCMTの場合は、セントロイドの緯度を表す
 double get latitude;/// 経度 (度)
///
/// 震源の経度（東経が正）
/// ただし、typeがCMTの場合は、セントロイドの経度を表す
 double get longitude;/// 深さ (km)
///
/// 震源の深さ（地表面からの距離）
/// ただし、typeがCMTの場合は、セントロイドの深さを表す
 double get depth;/// モーメントマグニチュード (Mw)
///
/// 地震のエネルギー規模を表すマグニチュード
 double get magnitude;/// 発震機構解
///
/// 地震のメカニズム解
/// nullの場合、発震機構解が求められなかったことを示します
 FocalMechanism? get focalMechanism;/// Variance Reduction (%)
///
/// 観測波形と計算波形の二乗残渣を観測波形振幅で正規化し、その値を1から引いた値
/// 80%以上だとかなり良く、50%程度であれば妥当な解と言える。20%以下の解は信用できない
 double? get varianceReduction;/// 使用観測点数
///
/// 解析に使用された観測点の数
 int get stationCount;/// 解析タイプ
///
/// AQUA-CMT（セントロイドモーメントテンソル）または
/// AQUA-MT（モーメントテンソル）
 AquaEventType get type;
/// Create a copy of AquaEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AquaEventCopyWith<AquaEvent> get copyWith => _$AquaEventCopyWithImpl<AquaEvent>(this as AquaEvent, _$identity);

  /// Serializes this AquaEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AquaEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.region, region) || other.region == region)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.focalMechanism, focalMechanism) || other.focalMechanism == focalMechanism)&&(identical(other.varianceReduction, varianceReduction) || other.varianceReduction == varianceReduction)&&(identical(other.stationCount, stationCount) || other.stationCount == stationCount)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,originTime,region,latitude,longitude,depth,magnitude,focalMechanism,varianceReduction,stationCount,type);

@override
String toString() {
  return 'AquaEvent(id: $id, originTime: $originTime, region: $region, latitude: $latitude, longitude: $longitude, depth: $depth, magnitude: $magnitude, focalMechanism: $focalMechanism, varianceReduction: $varianceReduction, stationCount: $stationCount, type: $type)';
}


}

/// @nodoc
abstract mixin class $AquaEventCopyWith<$Res>  {
  factory $AquaEventCopyWith(AquaEvent value, $Res Function(AquaEvent) _then) = _$AquaEventCopyWithImpl;
@useResult
$Res call({
 String id,@TZDateTimeJstJsonConverter() TZDateTime originTime, String region, double latitude, double longitude, double depth, double magnitude, FocalMechanism? focalMechanism, double? varianceReduction, int stationCount, AquaEventType type
});


$FocalMechanismCopyWith<$Res>? get focalMechanism;

}
/// @nodoc
class _$AquaEventCopyWithImpl<$Res>
    implements $AquaEventCopyWith<$Res> {
  _$AquaEventCopyWithImpl(this._self, this._then);

  final AquaEvent _self;
  final $Res Function(AquaEvent) _then;

/// Create a copy of AquaEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? originTime = null,Object? region = null,Object? latitude = null,Object? longitude = null,Object? depth = null,Object? magnitude = null,Object? focalMechanism = freezed,Object? varianceReduction = freezed,Object? stationCount = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as TZDateTime,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double,focalMechanism: freezed == focalMechanism ? _self.focalMechanism : focalMechanism // ignore: cast_nullable_to_non_nullable
as FocalMechanism?,varianceReduction: freezed == varianceReduction ? _self.varianceReduction : varianceReduction // ignore: cast_nullable_to_non_nullable
as double?,stationCount: null == stationCount ? _self.stationCount : stationCount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AquaEventType,
  ));
}
/// Create a copy of AquaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FocalMechanismCopyWith<$Res>? get focalMechanism {
    if (_self.focalMechanism == null) {
    return null;
  }

  return $FocalMechanismCopyWith<$Res>(_self.focalMechanism!, (value) {
    return _then(_self.copyWith(focalMechanism: value));
  });
}
}


/// Adds pattern-matching-related methods to [AquaEvent].
extension AquaEventPatterns on AquaEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AquaEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AquaEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AquaEvent value)  $default,){
final _that = this;
switch (_that) {
case _AquaEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AquaEvent value)?  $default,){
final _that = this;
switch (_that) {
case _AquaEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @TZDateTimeJstJsonConverter()  TZDateTime originTime,  String region,  double latitude,  double longitude,  double depth,  double magnitude,  FocalMechanism? focalMechanism,  double? varianceReduction,  int stationCount,  AquaEventType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AquaEvent() when $default != null:
return $default(_that.id,_that.originTime,_that.region,_that.latitude,_that.longitude,_that.depth,_that.magnitude,_that.focalMechanism,_that.varianceReduction,_that.stationCount,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @TZDateTimeJstJsonConverter()  TZDateTime originTime,  String region,  double latitude,  double longitude,  double depth,  double magnitude,  FocalMechanism? focalMechanism,  double? varianceReduction,  int stationCount,  AquaEventType type)  $default,) {final _that = this;
switch (_that) {
case _AquaEvent():
return $default(_that.id,_that.originTime,_that.region,_that.latitude,_that.longitude,_that.depth,_that.magnitude,_that.focalMechanism,_that.varianceReduction,_that.stationCount,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @TZDateTimeJstJsonConverter()  TZDateTime originTime,  String region,  double latitude,  double longitude,  double depth,  double magnitude,  FocalMechanism? focalMechanism,  double? varianceReduction,  int stationCount,  AquaEventType type)?  $default,) {final _that = this;
switch (_that) {
case _AquaEvent() when $default != null:
return $default(_that.id,_that.originTime,_that.region,_that.latitude,_that.longitude,_that.depth,_that.magnitude,_that.focalMechanism,_that.varianceReduction,_that.stationCount,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AquaEvent implements AquaEvent {
  const _AquaEvent({required this.id, @TZDateTimeJstJsonConverter() required this.originTime, required this.region, required this.latitude, required this.longitude, required this.depth, required this.magnitude, required this.focalMechanism, required this.varianceReduction, required this.stationCount, required this.type});
  factory _AquaEvent.fromJson(Map<String, dynamic> json) => _$AquaEventFromJson(json);

/// イベントID (yyyyMMddHHmmss形式)
///
/// 地震発生日時を表す14桁の数字
/// 例: 20251103000018 = 2025年11月3日 00時00分18秒
@override final  String id;
/// 発生日時
///
/// 地震の発生時刻（震源時）
/// JST時刻
/// ただし、typeがCMTの場合は、セントロイドの時刻を表す
@override@TZDateTimeJstJsonConverter() final  TZDateTime originTime;
/// 震央地名
///
/// 震源の位置を表す地名
/// 例: "福島県沖", "Off Fukushima Prefecture"
@override final  String region;
/// 緯度 (度)
///
/// 震源の緯度（北緯が正）
/// ただし、typeがCMTの場合は、セントロイドの緯度を表す
@override final  double latitude;
/// 経度 (度)
///
/// 震源の経度（東経が正）
/// ただし、typeがCMTの場合は、セントロイドの経度を表す
@override final  double longitude;
/// 深さ (km)
///
/// 震源の深さ（地表面からの距離）
/// ただし、typeがCMTの場合は、セントロイドの深さを表す
@override final  double depth;
/// モーメントマグニチュード (Mw)
///
/// 地震のエネルギー規模を表すマグニチュード
@override final  double magnitude;
/// 発震機構解
///
/// 地震のメカニズム解
/// nullの場合、発震機構解が求められなかったことを示します
@override final  FocalMechanism? focalMechanism;
/// Variance Reduction (%)
///
/// 観測波形と計算波形の二乗残渣を観測波形振幅で正規化し、その値を1から引いた値
/// 80%以上だとかなり良く、50%程度であれば妥当な解と言える。20%以下の解は信用できない
@override final  double? varianceReduction;
/// 使用観測点数
///
/// 解析に使用された観測点の数
@override final  int stationCount;
/// 解析タイプ
///
/// AQUA-CMT（セントロイドモーメントテンソル）または
/// AQUA-MT（モーメントテンソル）
@override final  AquaEventType type;

/// Create a copy of AquaEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AquaEventCopyWith<_AquaEvent> get copyWith => __$AquaEventCopyWithImpl<_AquaEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AquaEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AquaEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.region, region) || other.region == region)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.focalMechanism, focalMechanism) || other.focalMechanism == focalMechanism)&&(identical(other.varianceReduction, varianceReduction) || other.varianceReduction == varianceReduction)&&(identical(other.stationCount, stationCount) || other.stationCount == stationCount)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,originTime,region,latitude,longitude,depth,magnitude,focalMechanism,varianceReduction,stationCount,type);

@override
String toString() {
  return 'AquaEvent(id: $id, originTime: $originTime, region: $region, latitude: $latitude, longitude: $longitude, depth: $depth, magnitude: $magnitude, focalMechanism: $focalMechanism, varianceReduction: $varianceReduction, stationCount: $stationCount, type: $type)';
}


}

/// @nodoc
abstract mixin class _$AquaEventCopyWith<$Res> implements $AquaEventCopyWith<$Res> {
  factory _$AquaEventCopyWith(_AquaEvent value, $Res Function(_AquaEvent) _then) = __$AquaEventCopyWithImpl;
@override @useResult
$Res call({
 String id,@TZDateTimeJstJsonConverter() TZDateTime originTime, String region, double latitude, double longitude, double depth, double magnitude, FocalMechanism? focalMechanism, double? varianceReduction, int stationCount, AquaEventType type
});


@override $FocalMechanismCopyWith<$Res>? get focalMechanism;

}
/// @nodoc
class __$AquaEventCopyWithImpl<$Res>
    implements _$AquaEventCopyWith<$Res> {
  __$AquaEventCopyWithImpl(this._self, this._then);

  final _AquaEvent _self;
  final $Res Function(_AquaEvent) _then;

/// Create a copy of AquaEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? originTime = null,Object? region = null,Object? latitude = null,Object? longitude = null,Object? depth = null,Object? magnitude = null,Object? focalMechanism = freezed,Object? varianceReduction = freezed,Object? stationCount = null,Object? type = null,}) {
  return _then(_AquaEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as TZDateTime,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double,focalMechanism: freezed == focalMechanism ? _self.focalMechanism : focalMechanism // ignore: cast_nullable_to_non_nullable
as FocalMechanism?,varianceReduction: freezed == varianceReduction ? _self.varianceReduction : varianceReduction // ignore: cast_nullable_to_non_nullable
as double?,stationCount: null == stationCount ? _self.stationCount : stationCount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AquaEventType,
  ));
}

/// Create a copy of AquaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FocalMechanismCopyWith<$Res>? get focalMechanism {
    if (_self.focalMechanism == null) {
    return null;
  }

  return $FocalMechanismCopyWith<$Res>(_self.focalMechanism!, (value) {
    return _then(_self.copyWith(focalMechanism: value));
  });
}
}

// dart format on

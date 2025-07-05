// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Eew {

/// リザルト
 Result? get result;/// 発報時間
@JsonKey(fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString) DateTime? get reportTime;/// 地域コード
 String? get regionCode;/// リクエスト時間
 String? get requestTime;/// 地域名
 String? get regionName;/// 経度
@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) double? get longitude;/// キャンセル報か
@JsonKey(name: 'is_cancel', fromJson: boolFromDynamic) bool? get isCancel;/// 震源の深さ
@JsonKey(fromJson: depthFromString, toJson: depthToString) int? get depth;/// 予想最大震度
@JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString) JmaIntensity? get intensity;/// 最終報か
@JsonKey(name: 'is_final', fromJson: boolFromDynamic) bool? get isFinal;/// 訓練報か
@JsonKey(name: 'isTraining', fromJson: boolFromDynamic) bool? get isTraining;/// 緯度
@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) double? get latitude;/// 発生時間
@JsonKey(name: 'origin_time', fromJson: originTimeFromString) DateTime? get originTime;/// セキュリティ情報
 Security? get security;/// マグニチュード
@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) double? get magnitude;/// 発報番号
@JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString) int? get reportNum;/// なにこれ?
 String? get requestHypoType;/// 地震ID
 String? get reportId;/// 警報 or 予報
@JsonKey(name: 'alertflg') String? get alertFlag;
/// Create a copy of Eew
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewCopyWith<Eew> get copyWith => _$EewCopyWithImpl<Eew>(this as Eew, _$identity);

  /// Serializes this Eew to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Eew&&(identical(other.result, result) || other.result == result)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.requestTime, requestTime) || other.requestTime == requestTime)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isCancel, isCancel) || other.isCancel == isCancel)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal)&&(identical(other.isTraining, isTraining) || other.isTraining == isTraining)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.security, security) || other.security == security)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.reportNum, reportNum) || other.reportNum == reportNum)&&(identical(other.requestHypoType, requestHypoType) || other.requestHypoType == requestHypoType)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.alertFlag, alertFlag) || other.alertFlag == alertFlag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,result,reportTime,regionCode,requestTime,regionName,longitude,isCancel,depth,intensity,isFinal,isTraining,latitude,originTime,security,magnitude,reportNum,requestHypoType,reportId,alertFlag]);

@override
String toString() {
  return 'Eew(result: $result, reportTime: $reportTime, regionCode: $regionCode, requestTime: $requestTime, regionName: $regionName, longitude: $longitude, isCancel: $isCancel, depth: $depth, intensity: $intensity, isFinal: $isFinal, isTraining: $isTraining, latitude: $latitude, originTime: $originTime, security: $security, magnitude: $magnitude, reportNum: $reportNum, requestHypoType: $requestHypoType, reportId: $reportId, alertFlag: $alertFlag)';
}


}

/// @nodoc
abstract mixin class $EewCopyWith<$Res>  {
  factory $EewCopyWith(Eew value, $Res Function(Eew) _then) = _$EewCopyWithImpl;
@useResult
$Res call({
 Result? result,@JsonKey(fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString) DateTime? reportTime, String? regionCode, String? requestTime, String? regionName,@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) double? longitude,@JsonKey(name: 'is_cancel', fromJson: boolFromDynamic) bool? isCancel,@JsonKey(fromJson: depthFromString, toJson: depthToString) int? depth,@JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString) JmaIntensity? intensity,@JsonKey(name: 'is_final', fromJson: boolFromDynamic) bool? isFinal,@JsonKey(name: 'isTraining', fromJson: boolFromDynamic) bool? isTraining,@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) double? latitude,@JsonKey(name: 'origin_time', fromJson: originTimeFromString) DateTime? originTime, Security? security,@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) double? magnitude,@JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString) int? reportNum, String? requestHypoType, String? reportId,@JsonKey(name: 'alertflg') String? alertFlag
});


$ResultCopyWith<$Res>? get result;$SecurityCopyWith<$Res>? get security;

}
/// @nodoc
class _$EewCopyWithImpl<$Res>
    implements $EewCopyWith<$Res> {
  _$EewCopyWithImpl(this._self, this._then);

  final Eew _self;
  final $Res Function(Eew) _then;

/// Create a copy of Eew
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = freezed,Object? reportTime = freezed,Object? regionCode = freezed,Object? requestTime = freezed,Object? regionName = freezed,Object? longitude = freezed,Object? isCancel = freezed,Object? depth = freezed,Object? intensity = freezed,Object? isFinal = freezed,Object? isTraining = freezed,Object? latitude = freezed,Object? originTime = freezed,Object? security = freezed,Object? magnitude = freezed,Object? reportNum = freezed,Object? requestHypoType = freezed,Object? reportId = freezed,Object? alertFlag = freezed,}) {
  return _then(_self.copyWith(
result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,reportTime: freezed == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,requestTime: freezed == requestTime ? _self.requestTime : requestTime // ignore: cast_nullable_to_non_nullable
as String?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isCancel: freezed == isCancel ? _self.isCancel : isCancel // ignore: cast_nullable_to_non_nullable
as bool?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,isFinal: freezed == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool?,isTraining: freezed == isTraining ? _self.isTraining : isTraining // ignore: cast_nullable_to_non_nullable
as bool?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as Security?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,reportNum: freezed == reportNum ? _self.reportNum : reportNum // ignore: cast_nullable_to_non_nullable
as int?,requestHypoType: freezed == requestHypoType ? _self.requestHypoType : requestHypoType // ignore: cast_nullable_to_non_nullable
as String?,reportId: freezed == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String?,alertFlag: freezed == alertFlag ? _self.alertFlag : alertFlag // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Eew
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of Eew
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _Eew extends Eew {
  const _Eew({this.result, @JsonKey(fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString) this.reportTime, this.regionCode, this.requestTime, this.regionName, @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) this.longitude, @JsonKey(name: 'is_cancel', fromJson: boolFromDynamic) this.isCancel, @JsonKey(fromJson: depthFromString, toJson: depthToString) this.depth, @JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString) this.intensity, @JsonKey(name: 'is_final', fromJson: boolFromDynamic) this.isFinal, @JsonKey(name: 'isTraining', fromJson: boolFromDynamic) this.isTraining, @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) this.latitude, @JsonKey(name: 'origin_time', fromJson: originTimeFromString) this.originTime, this.security, @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) this.magnitude, @JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString) this.reportNum, this.requestHypoType, this.reportId, @JsonKey(name: 'alertflg') this.alertFlag}): super._();
  factory _Eew.fromJson(Map<String, dynamic> json) => _$EewFromJson(json);

/// リザルト
@override final  Result? result;
/// 発報時間
@override@JsonKey(fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString) final  DateTime? reportTime;
/// 地域コード
@override final  String? regionCode;
/// リクエスト時間
@override final  String? requestTime;
/// 地域名
@override final  String? regionName;
/// 経度
@override@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) final  double? longitude;
/// キャンセル報か
@override@JsonKey(name: 'is_cancel', fromJson: boolFromDynamic) final  bool? isCancel;
/// 震源の深さ
@override@JsonKey(fromJson: depthFromString, toJson: depthToString) final  int? depth;
/// 予想最大震度
@override@JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString) final  JmaIntensity? intensity;
/// 最終報か
@override@JsonKey(name: 'is_final', fromJson: boolFromDynamic) final  bool? isFinal;
/// 訓練報か
@override@JsonKey(name: 'isTraining', fromJson: boolFromDynamic) final  bool? isTraining;
/// 緯度
@override@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) final  double? latitude;
/// 発生時間
@override@JsonKey(name: 'origin_time', fromJson: originTimeFromString) final  DateTime? originTime;
/// セキュリティ情報
@override final  Security? security;
/// マグニチュード
@override@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) final  double? magnitude;
/// 発報番号
@override@JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString) final  int? reportNum;
/// なにこれ?
@override final  String? requestHypoType;
/// 地震ID
@override final  String? reportId;
/// 警報 or 予報
@override@JsonKey(name: 'alertflg') final  String? alertFlag;

/// Create a copy of Eew
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewCopyWith<_Eew> get copyWith => __$EewCopyWithImpl<_Eew>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Eew&&(identical(other.result, result) || other.result == result)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.requestTime, requestTime) || other.requestTime == requestTime)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isCancel, isCancel) || other.isCancel == isCancel)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal)&&(identical(other.isTraining, isTraining) || other.isTraining == isTraining)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.security, security) || other.security == security)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.reportNum, reportNum) || other.reportNum == reportNum)&&(identical(other.requestHypoType, requestHypoType) || other.requestHypoType == requestHypoType)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.alertFlag, alertFlag) || other.alertFlag == alertFlag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,result,reportTime,regionCode,requestTime,regionName,longitude,isCancel,depth,intensity,isFinal,isTraining,latitude,originTime,security,magnitude,reportNum,requestHypoType,reportId,alertFlag]);

@override
String toString() {
  return 'Eew(result: $result, reportTime: $reportTime, regionCode: $regionCode, requestTime: $requestTime, regionName: $regionName, longitude: $longitude, isCancel: $isCancel, depth: $depth, intensity: $intensity, isFinal: $isFinal, isTraining: $isTraining, latitude: $latitude, originTime: $originTime, security: $security, magnitude: $magnitude, reportNum: $reportNum, requestHypoType: $requestHypoType, reportId: $reportId, alertFlag: $alertFlag)';
}


}

/// @nodoc
abstract mixin class _$EewCopyWith<$Res> implements $EewCopyWith<$Res> {
  factory _$EewCopyWith(_Eew value, $Res Function(_Eew) _then) = __$EewCopyWithImpl;
@override @useResult
$Res call({
 Result? result,@JsonKey(fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString) DateTime? reportTime, String? regionCode, String? requestTime, String? regionName,@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) double? longitude,@JsonKey(name: 'is_cancel', fromJson: boolFromDynamic) bool? isCancel,@JsonKey(fromJson: depthFromString, toJson: depthToString) int? depth,@JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString) JmaIntensity? intensity,@JsonKey(name: 'is_final', fromJson: boolFromDynamic) bool? isFinal,@JsonKey(name: 'isTraining', fromJson: boolFromDynamic) bool? isTraining,@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) double? latitude,@JsonKey(name: 'origin_time', fromJson: originTimeFromString) DateTime? originTime, Security? security,@JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString) double? magnitude,@JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString) int? reportNum, String? requestHypoType, String? reportId,@JsonKey(name: 'alertflg') String? alertFlag
});


@override $ResultCopyWith<$Res>? get result;@override $SecurityCopyWith<$Res>? get security;

}
/// @nodoc
class __$EewCopyWithImpl<$Res>
    implements _$EewCopyWith<$Res> {
  __$EewCopyWithImpl(this._self, this._then);

  final _Eew _self;
  final $Res Function(_Eew) _then;

/// Create a copy of Eew
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = freezed,Object? reportTime = freezed,Object? regionCode = freezed,Object? requestTime = freezed,Object? regionName = freezed,Object? longitude = freezed,Object? isCancel = freezed,Object? depth = freezed,Object? intensity = freezed,Object? isFinal = freezed,Object? isTraining = freezed,Object? latitude = freezed,Object? originTime = freezed,Object? security = freezed,Object? magnitude = freezed,Object? reportNum = freezed,Object? requestHypoType = freezed,Object? reportId = freezed,Object? alertFlag = freezed,}) {
  return _then(_Eew(
result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,reportTime: freezed == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,requestTime: freezed == requestTime ? _self.requestTime : requestTime // ignore: cast_nullable_to_non_nullable
as String?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isCancel: freezed == isCancel ? _self.isCancel : isCancel // ignore: cast_nullable_to_non_nullable
as bool?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,isFinal: freezed == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool?,isTraining: freezed == isTraining ? _self.isTraining : isTraining // ignore: cast_nullable_to_non_nullable
as bool?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as Security?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,reportNum: freezed == reportNum ? _self.reportNum : reportNum // ignore: cast_nullable_to_non_nullable
as int?,requestHypoType: freezed == requestHypoType ? _self.requestHypoType : requestHypoType // ignore: cast_nullable_to_non_nullable
as String?,reportId: freezed == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String?,alertFlag: freezed == alertFlag ? _self.alertFlag : alertFlag // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Eew
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of Eew
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}
}

// dart format on

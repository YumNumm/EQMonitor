// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Eew _$EewFromJson(Map<String, dynamic> json) {
  return _Eew.fromJson(json);
}

/// @nodoc
mixin _$Eew {
  /// リザルト
  Result? get result => throw _privateConstructorUsedError;

  /// 発報時間
  @JsonKey(fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString)
  DateTime? get reportTime => throw _privateConstructorUsedError;

  /// 地域コード
  String? get regionCode => throw _privateConstructorUsedError;

  /// リクエスト時間
  String? get requestTime => throw _privateConstructorUsedError;

  /// 地域名
  String? get regionName => throw _privateConstructorUsedError;

  /// 経度
  @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
  double? get longitude => throw _privateConstructorUsedError;

  /// キャンセル報か
  @JsonKey(name: 'is_cancel', fromJson: boolFromDynamic)
  bool? get isCancel => throw _privateConstructorUsedError;

  /// 震源の深さ
  @JsonKey(fromJson: depthFromString, toJson: depthToString)
  int? get depth => throw _privateConstructorUsedError;

  /// 予想最大震度
  @JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString)
  JmaIntensity? get intensity => throw _privateConstructorUsedError;

  /// 最終報か
  @JsonKey(name: 'is_final', fromJson: boolFromDynamic)
  bool? get isFinal => throw _privateConstructorUsedError;

  /// 訓練報か
  @JsonKey(name: 'isTraining', fromJson: boolFromDynamic)
  bool? get isTraining => throw _privateConstructorUsedError;

  /// 緯度
  @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
  double? get latitude => throw _privateConstructorUsedError;

  /// 発生時間
  @JsonKey(name: 'origin_time', fromJson: originTimeFromString)
  DateTime? get originTime => throw _privateConstructorUsedError;

  /// セキュリティ情報
  Security? get security => throw _privateConstructorUsedError;

  /// マグニチュード
  @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
  double? get magnitude => throw _privateConstructorUsedError;

  /// 発報番号
  @JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString)
  int? get reportNum => throw _privateConstructorUsedError;

  /// なにこれ?
  String? get requestHypoType => throw _privateConstructorUsedError;

  /// 地震ID
  String? get reportId => throw _privateConstructorUsedError;

  /// 警報 or 予報
  @JsonKey(name: 'alertflg')
  String? get alertFlag => throw _privateConstructorUsedError;

  /// Serializes this Eew to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Eew
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EewCopyWith<Eew> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EewCopyWith<$Res> {
  factory $EewCopyWith(Eew value, $Res Function(Eew) then) =
      _$EewCopyWithImpl<$Res, Eew>;
  @useResult
  $Res call(
      {Result? result,
      @JsonKey(
          fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString)
      DateTime? reportTime,
      String? regionCode,
      String? requestTime,
      String? regionName,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      double? longitude,
      @JsonKey(name: 'is_cancel', fromJson: boolFromDynamic) bool? isCancel,
      @JsonKey(fromJson: depthFromString, toJson: depthToString) int? depth,
      @JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString)
      JmaIntensity? intensity,
      @JsonKey(name: 'is_final', fromJson: boolFromDynamic) bool? isFinal,
      @JsonKey(name: 'isTraining', fromJson: boolFromDynamic) bool? isTraining,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      double? latitude,
      @JsonKey(name: 'origin_time', fromJson: originTimeFromString)
      DateTime? originTime,
      Security? security,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      double? magnitude,
      @JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString)
      int? reportNum,
      String? requestHypoType,
      String? reportId,
      @JsonKey(name: 'alertflg') String? alertFlag});

  $ResultCopyWith<$Res>? get result;
  $SecurityCopyWith<$Res>? get security;
}

/// @nodoc
class _$EewCopyWithImpl<$Res, $Val extends Eew> implements $EewCopyWith<$Res> {
  _$EewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Eew
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? reportTime = freezed,
    Object? regionCode = freezed,
    Object? requestTime = freezed,
    Object? regionName = freezed,
    Object? longitude = freezed,
    Object? isCancel = freezed,
    Object? depth = freezed,
    Object? intensity = freezed,
    Object? isFinal = freezed,
    Object? isTraining = freezed,
    Object? latitude = freezed,
    Object? originTime = freezed,
    Object? security = freezed,
    Object? magnitude = freezed,
    Object? reportNum = freezed,
    Object? requestHypoType = freezed,
    Object? reportId = freezed,
    Object? alertFlag = freezed,
  }) {
    return _then(_value.copyWith(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      reportTime: freezed == reportTime
          ? _value.reportTime
          : reportTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      regionCode: freezed == regionCode
          ? _value.regionCode
          : regionCode // ignore: cast_nullable_to_non_nullable
              as String?,
      requestTime: freezed == requestTime
          ? _value.requestTime
          : requestTime // ignore: cast_nullable_to_non_nullable
              as String?,
      regionName: freezed == regionName
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      isCancel: freezed == isCancel
          ? _value.isCancel
          : isCancel // ignore: cast_nullable_to_non_nullable
              as bool?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      isFinal: freezed == isFinal
          ? _value.isFinal
          : isFinal // ignore: cast_nullable_to_non_nullable
              as bool?,
      isTraining: freezed == isTraining
          ? _value.isTraining
          : isTraining // ignore: cast_nullable_to_non_nullable
              as bool?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      security: freezed == security
          ? _value.security
          : security // ignore: cast_nullable_to_non_nullable
              as Security?,
      magnitude: freezed == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double?,
      reportNum: freezed == reportNum
          ? _value.reportNum
          : reportNum // ignore: cast_nullable_to_non_nullable
              as int?,
      requestHypoType: freezed == requestHypoType
          ? _value.requestHypoType
          : requestHypoType // ignore: cast_nullable_to_non_nullable
              as String?,
      reportId: freezed == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String?,
      alertFlag: freezed == alertFlag
          ? _value.alertFlag
          : alertFlag // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Eew
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $ResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }

  /// Create a copy of Eew
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SecurityCopyWith<$Res>? get security {
    if (_value.security == null) {
      return null;
    }

    return $SecurityCopyWith<$Res>(_value.security!, (value) {
      return _then(_value.copyWith(security: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EewImplCopyWith<$Res> implements $EewCopyWith<$Res> {
  factory _$$EewImplCopyWith(_$EewImpl value, $Res Function(_$EewImpl) then) =
      __$$EewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Result? result,
      @JsonKey(
          fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString)
      DateTime? reportTime,
      String? regionCode,
      String? requestTime,
      String? regionName,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      double? longitude,
      @JsonKey(name: 'is_cancel', fromJson: boolFromDynamic) bool? isCancel,
      @JsonKey(fromJson: depthFromString, toJson: depthToString) int? depth,
      @JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString)
      JmaIntensity? intensity,
      @JsonKey(name: 'is_final', fromJson: boolFromDynamic) bool? isFinal,
      @JsonKey(name: 'isTraining', fromJson: boolFromDynamic) bool? isTraining,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      double? latitude,
      @JsonKey(name: 'origin_time', fromJson: originTimeFromString)
      DateTime? originTime,
      Security? security,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      double? magnitude,
      @JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString)
      int? reportNum,
      String? requestHypoType,
      String? reportId,
      @JsonKey(name: 'alertflg') String? alertFlag});

  @override
  $ResultCopyWith<$Res>? get result;
  @override
  $SecurityCopyWith<$Res>? get security;
}

/// @nodoc
class __$$EewImplCopyWithImpl<$Res> extends _$EewCopyWithImpl<$Res, _$EewImpl>
    implements _$$EewImplCopyWith<$Res> {
  __$$EewImplCopyWithImpl(_$EewImpl _value, $Res Function(_$EewImpl) _then)
      : super(_value, _then);

  /// Create a copy of Eew
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? reportTime = freezed,
    Object? regionCode = freezed,
    Object? requestTime = freezed,
    Object? regionName = freezed,
    Object? longitude = freezed,
    Object? isCancel = freezed,
    Object? depth = freezed,
    Object? intensity = freezed,
    Object? isFinal = freezed,
    Object? isTraining = freezed,
    Object? latitude = freezed,
    Object? originTime = freezed,
    Object? security = freezed,
    Object? magnitude = freezed,
    Object? reportNum = freezed,
    Object? requestHypoType = freezed,
    Object? reportId = freezed,
    Object? alertFlag = freezed,
  }) {
    return _then(_$EewImpl(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      reportTime: freezed == reportTime
          ? _value.reportTime
          : reportTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      regionCode: freezed == regionCode
          ? _value.regionCode
          : regionCode // ignore: cast_nullable_to_non_nullable
              as String?,
      requestTime: freezed == requestTime
          ? _value.requestTime
          : requestTime // ignore: cast_nullable_to_non_nullable
              as String?,
      regionName: freezed == regionName
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      isCancel: freezed == isCancel
          ? _value.isCancel
          : isCancel // ignore: cast_nullable_to_non_nullable
              as bool?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      isFinal: freezed == isFinal
          ? _value.isFinal
          : isFinal // ignore: cast_nullable_to_non_nullable
              as bool?,
      isTraining: freezed == isTraining
          ? _value.isTraining
          : isTraining // ignore: cast_nullable_to_non_nullable
              as bool?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      security: freezed == security
          ? _value.security
          : security // ignore: cast_nullable_to_non_nullable
              as Security?,
      magnitude: freezed == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double?,
      reportNum: freezed == reportNum
          ? _value.reportNum
          : reportNum // ignore: cast_nullable_to_non_nullable
              as int?,
      requestHypoType: freezed == requestHypoType
          ? _value.requestHypoType
          : requestHypoType // ignore: cast_nullable_to_non_nullable
              as String?,
      reportId: freezed == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String?,
      alertFlag: freezed == alertFlag
          ? _value.alertFlag
          : alertFlag // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EewImpl extends _Eew {
  const _$EewImpl(
      {this.result,
      @JsonKey(
          fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString)
      this.reportTime,
      this.regionCode,
      this.requestTime,
      this.regionName,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      this.longitude,
      @JsonKey(name: 'is_cancel', fromJson: boolFromDynamic) this.isCancel,
      @JsonKey(fromJson: depthFromString, toJson: depthToString) this.depth,
      @JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString)
      this.intensity,
      @JsonKey(name: 'is_final', fromJson: boolFromDynamic) this.isFinal,
      @JsonKey(name: 'isTraining', fromJson: boolFromDynamic) this.isTraining,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      this.latitude,
      @JsonKey(name: 'origin_time', fromJson: originTimeFromString)
      this.originTime,
      this.security,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      this.magnitude,
      @JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString)
      this.reportNum,
      this.requestHypoType,
      this.reportId,
      @JsonKey(name: 'alertflg') this.alertFlag})
      : super._();

  factory _$EewImpl.fromJson(Map<String, dynamic> json) =>
      _$$EewImplFromJson(json);

  /// リザルト
  @override
  final Result? result;

  /// 発報時間
  @override
  @JsonKey(fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString)
  final DateTime? reportTime;

  /// 地域コード
  @override
  final String? regionCode;

  /// リクエスト時間
  @override
  final String? requestTime;

  /// 地域名
  @override
  final String? regionName;

  /// 経度
  @override
  @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
  final double? longitude;

  /// キャンセル報か
  @override
  @JsonKey(name: 'is_cancel', fromJson: boolFromDynamic)
  final bool? isCancel;

  /// 震源の深さ
  @override
  @JsonKey(fromJson: depthFromString, toJson: depthToString)
  final int? depth;

  /// 予想最大震度
  @override
  @JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString)
  final JmaIntensity? intensity;

  /// 最終報か
  @override
  @JsonKey(name: 'is_final', fromJson: boolFromDynamic)
  final bool? isFinal;

  /// 訓練報か
  @override
  @JsonKey(name: 'isTraining', fromJson: boolFromDynamic)
  final bool? isTraining;

  /// 緯度
  @override
  @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
  final double? latitude;

  /// 発生時間
  @override
  @JsonKey(name: 'origin_time', fromJson: originTimeFromString)
  final DateTime? originTime;

  /// セキュリティ情報
  @override
  final Security? security;

  /// マグニチュード
  @override
  @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
  final double? magnitude;

  /// 発報番号
  @override
  @JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString)
  final int? reportNum;

  /// なにこれ?
  @override
  final String? requestHypoType;

  /// 地震ID
  @override
  final String? reportId;

  /// 警報 or 予報
  @override
  @JsonKey(name: 'alertflg')
  final String? alertFlag;

  @override
  String toString() {
    return 'Eew(result: $result, reportTime: $reportTime, regionCode: $regionCode, requestTime: $requestTime, regionName: $regionName, longitude: $longitude, isCancel: $isCancel, depth: $depth, intensity: $intensity, isFinal: $isFinal, isTraining: $isTraining, latitude: $latitude, originTime: $originTime, security: $security, magnitude: $magnitude, reportNum: $reportNum, requestHypoType: $requestHypoType, reportId: $reportId, alertFlag: $alertFlag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EewImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.reportTime, reportTime) ||
                other.reportTime == reportTime) &&
            (identical(other.regionCode, regionCode) ||
                other.regionCode == regionCode) &&
            (identical(other.requestTime, requestTime) ||
                other.requestTime == requestTime) &&
            (identical(other.regionName, regionName) ||
                other.regionName == regionName) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isCancel, isCancel) ||
                other.isCancel == isCancel) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.isFinal, isFinal) || other.isFinal == isFinal) &&
            (identical(other.isTraining, isTraining) ||
                other.isTraining == isTraining) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.originTime, originTime) ||
                other.originTime == originTime) &&
            (identical(other.security, security) ||
                other.security == security) &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude) &&
            (identical(other.reportNum, reportNum) ||
                other.reportNum == reportNum) &&
            (identical(other.requestHypoType, requestHypoType) ||
                other.requestHypoType == requestHypoType) &&
            (identical(other.reportId, reportId) ||
                other.reportId == reportId) &&
            (identical(other.alertFlag, alertFlag) ||
                other.alertFlag == alertFlag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        result,
        reportTime,
        regionCode,
        requestTime,
        regionName,
        longitude,
        isCancel,
        depth,
        intensity,
        isFinal,
        isTraining,
        latitude,
        originTime,
        security,
        magnitude,
        reportNum,
        requestHypoType,
        reportId,
        alertFlag
      ]);

  /// Create a copy of Eew
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EewImplCopyWith<_$EewImpl> get copyWith =>
      __$$EewImplCopyWithImpl<_$EewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EewImplToJson(
      this,
    );
  }
}

abstract class _Eew extends Eew {
  const factory _Eew(
      {final Result? result,
      @JsonKey(
          fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString)
      final DateTime? reportTime,
      final String? regionCode,
      final String? requestTime,
      final String? regionName,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      final double? longitude,
      @JsonKey(name: 'is_cancel', fromJson: boolFromDynamic)
      final bool? isCancel,
      @JsonKey(fromJson: depthFromString, toJson: depthToString)
      final int? depth,
      @JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString)
      final JmaIntensity? intensity,
      @JsonKey(name: 'is_final', fromJson: boolFromDynamic) final bool? isFinal,
      @JsonKey(name: 'isTraining', fromJson: boolFromDynamic)
      final bool? isTraining,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      final double? latitude,
      @JsonKey(name: 'origin_time', fromJson: originTimeFromString)
      final DateTime? originTime,
      final Security? security,
      @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
      final double? magnitude,
      @JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString)
      final int? reportNum,
      final String? requestHypoType,
      final String? reportId,
      @JsonKey(name: 'alertflg') final String? alertFlag}) = _$EewImpl;
  const _Eew._() : super._();

  factory _Eew.fromJson(Map<String, dynamic> json) = _$EewImpl.fromJson;

  /// リザルト
  @override
  Result? get result;

  /// 発報時間
  @override
  @JsonKey(fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString)
  DateTime? get reportTime;

  /// 地域コード
  @override
  String? get regionCode;

  /// リクエスト時間
  @override
  String? get requestTime;

  /// 地域名
  @override
  String? get regionName;

  /// 経度
  @override
  @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
  double? get longitude;

  /// キャンセル報か
  @override
  @JsonKey(name: 'is_cancel', fromJson: boolFromDynamic)
  bool? get isCancel;

  /// 震源の深さ
  @override
  @JsonKey(fromJson: depthFromString, toJson: depthToString)
  int? get depth;

  /// 予想最大震度
  @override
  @JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString)
  JmaIntensity? get intensity;

  /// 最終報か
  @override
  @JsonKey(name: 'is_final', fromJson: boolFromDynamic)
  bool? get isFinal;

  /// 訓練報か
  @override
  @JsonKey(name: 'isTraining', fromJson: boolFromDynamic)
  bool? get isTraining;

  /// 緯度
  @override
  @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
  double? get latitude;

  /// 発生時間
  @override
  @JsonKey(name: 'origin_time', fromJson: originTimeFromString)
  DateTime? get originTime;

  /// セキュリティ情報
  @override
  Security? get security;

  /// マグニチュード
  @override
  @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
  double? get magnitude;

  /// 発報番号
  @override
  @JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString)
  int? get reportNum;

  /// なにこれ?
  @override
  String? get requestHypoType;

  /// 地震ID
  @override
  String? get reportId;

  /// 警報 or 予報
  @override
  @JsonKey(name: 'alertflg')
  String? get alertFlag;

  /// Create a copy of Eew
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EewImplCopyWith<_$EewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinMonitorSettingsModel {

/// 強震モニタの表示最低リアルタイム震度
 double? get minRealtimeShindo;/// スケールを表示するかどうか
 bool get showScale;/// 強震モニタを使用するかどうか
 bool get useKmoni;/// 強震モニタ観測点のマーカーの種類
 KyoshinMonitorMarkerType get kmoniMarkerType;/// 強震モニタのリアルタイムデータの種類
 RealtimeDataType get realtimeDataType;/// 強震モニタのリアルタイムデータのレイヤー
 RealtimeLayer get realtimeLayer;/// 強震モニタ API関連の設定
 KyoshinMonitorSettingsApiModel get api;
/// Create a copy of KyoshinMonitorSettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorSettingsModelCopyWith<KyoshinMonitorSettingsModel> get copyWith => _$KyoshinMonitorSettingsModelCopyWithImpl<KyoshinMonitorSettingsModel>(this as KyoshinMonitorSettingsModel, _$identity);

  /// Serializes this KyoshinMonitorSettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorSettingsModel&&(identical(other.minRealtimeShindo, minRealtimeShindo) || other.minRealtimeShindo == minRealtimeShindo)&&(identical(other.showScale, showScale) || other.showScale == showScale)&&(identical(other.useKmoni, useKmoni) || other.useKmoni == useKmoni)&&(identical(other.kmoniMarkerType, kmoniMarkerType) || other.kmoniMarkerType == kmoniMarkerType)&&(identical(other.realtimeDataType, realtimeDataType) || other.realtimeDataType == realtimeDataType)&&(identical(other.realtimeLayer, realtimeLayer) || other.realtimeLayer == realtimeLayer)&&(identical(other.api, api) || other.api == api));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minRealtimeShindo,showScale,useKmoni,kmoniMarkerType,realtimeDataType,realtimeLayer,api);

@override
String toString() {
  return 'KyoshinMonitorSettingsModel(minRealtimeShindo: $minRealtimeShindo, showScale: $showScale, useKmoni: $useKmoni, kmoniMarkerType: $kmoniMarkerType, realtimeDataType: $realtimeDataType, realtimeLayer: $realtimeLayer, api: $api)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorSettingsModelCopyWith<$Res>  {
  factory $KyoshinMonitorSettingsModelCopyWith(KyoshinMonitorSettingsModel value, $Res Function(KyoshinMonitorSettingsModel) _then) = _$KyoshinMonitorSettingsModelCopyWithImpl;
@useResult
$Res call({
 double? minRealtimeShindo, bool showScale, bool useKmoni, KyoshinMonitorMarkerType kmoniMarkerType, RealtimeDataType realtimeDataType, RealtimeLayer realtimeLayer, KyoshinMonitorSettingsApiModel api
});


$KyoshinMonitorSettingsApiModelCopyWith<$Res> get api;

}
/// @nodoc
class _$KyoshinMonitorSettingsModelCopyWithImpl<$Res>
    implements $KyoshinMonitorSettingsModelCopyWith<$Res> {
  _$KyoshinMonitorSettingsModelCopyWithImpl(this._self, this._then);

  final KyoshinMonitorSettingsModel _self;
  final $Res Function(KyoshinMonitorSettingsModel) _then;

/// Create a copy of KyoshinMonitorSettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minRealtimeShindo = freezed,Object? showScale = null,Object? useKmoni = null,Object? kmoniMarkerType = null,Object? realtimeDataType = null,Object? realtimeLayer = null,Object? api = null,}) {
  return _then(_self.copyWith(
minRealtimeShindo: freezed == minRealtimeShindo ? _self.minRealtimeShindo : minRealtimeShindo // ignore: cast_nullable_to_non_nullable
as double?,showScale: null == showScale ? _self.showScale : showScale // ignore: cast_nullable_to_non_nullable
as bool,useKmoni: null == useKmoni ? _self.useKmoni : useKmoni // ignore: cast_nullable_to_non_nullable
as bool,kmoniMarkerType: null == kmoniMarkerType ? _self.kmoniMarkerType : kmoniMarkerType // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorMarkerType,realtimeDataType: null == realtimeDataType ? _self.realtimeDataType : realtimeDataType // ignore: cast_nullable_to_non_nullable
as RealtimeDataType,realtimeLayer: null == realtimeLayer ? _self.realtimeLayer : realtimeLayer // ignore: cast_nullable_to_non_nullable
as RealtimeLayer,api: null == api ? _self.api : api // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorSettingsApiModel,
  ));
}
/// Create a copy of KyoshinMonitorSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinMonitorSettingsApiModelCopyWith<$Res> get api {
  
  return $KyoshinMonitorSettingsApiModelCopyWith<$Res>(_self.api, (value) {
    return _then(_self.copyWith(api: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _KyoshinMonitorSettingsModel implements KyoshinMonitorSettingsModel {
  const _KyoshinMonitorSettingsModel({this.minRealtimeShindo = null, this.showScale = true, this.useKmoni = true, this.kmoniMarkerType = KyoshinMonitorMarkerType.onlyEew, this.realtimeDataType = RealtimeDataType.shindo, this.realtimeLayer = RealtimeLayer.surface, this.api = const KyoshinMonitorSettingsApiModel()});
  factory _KyoshinMonitorSettingsModel.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorSettingsModelFromJson(json);

/// 強震モニタの表示最低リアルタイム震度
@override@JsonKey() final  double? minRealtimeShindo;
/// スケールを表示するかどうか
@override@JsonKey() final  bool showScale;
/// 強震モニタを使用するかどうか
@override@JsonKey() final  bool useKmoni;
/// 強震モニタ観測点のマーカーの種類
@override@JsonKey() final  KyoshinMonitorMarkerType kmoniMarkerType;
/// 強震モニタのリアルタイムデータの種類
@override@JsonKey() final  RealtimeDataType realtimeDataType;
/// 強震モニタのリアルタイムデータのレイヤー
@override@JsonKey() final  RealtimeLayer realtimeLayer;
/// 強震モニタ API関連の設定
@override@JsonKey() final  KyoshinMonitorSettingsApiModel api;

/// Create a copy of KyoshinMonitorSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorSettingsModelCopyWith<_KyoshinMonitorSettingsModel> get copyWith => __$KyoshinMonitorSettingsModelCopyWithImpl<_KyoshinMonitorSettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorSettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorSettingsModel&&(identical(other.minRealtimeShindo, minRealtimeShindo) || other.minRealtimeShindo == minRealtimeShindo)&&(identical(other.showScale, showScale) || other.showScale == showScale)&&(identical(other.useKmoni, useKmoni) || other.useKmoni == useKmoni)&&(identical(other.kmoniMarkerType, kmoniMarkerType) || other.kmoniMarkerType == kmoniMarkerType)&&(identical(other.realtimeDataType, realtimeDataType) || other.realtimeDataType == realtimeDataType)&&(identical(other.realtimeLayer, realtimeLayer) || other.realtimeLayer == realtimeLayer)&&(identical(other.api, api) || other.api == api));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minRealtimeShindo,showScale,useKmoni,kmoniMarkerType,realtimeDataType,realtimeLayer,api);

@override
String toString() {
  return 'KyoshinMonitorSettingsModel(minRealtimeShindo: $minRealtimeShindo, showScale: $showScale, useKmoni: $useKmoni, kmoniMarkerType: $kmoniMarkerType, realtimeDataType: $realtimeDataType, realtimeLayer: $realtimeLayer, api: $api)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorSettingsModelCopyWith<$Res> implements $KyoshinMonitorSettingsModelCopyWith<$Res> {
  factory _$KyoshinMonitorSettingsModelCopyWith(_KyoshinMonitorSettingsModel value, $Res Function(_KyoshinMonitorSettingsModel) _then) = __$KyoshinMonitorSettingsModelCopyWithImpl;
@override @useResult
$Res call({
 double? minRealtimeShindo, bool showScale, bool useKmoni, KyoshinMonitorMarkerType kmoniMarkerType, RealtimeDataType realtimeDataType, RealtimeLayer realtimeLayer, KyoshinMonitorSettingsApiModel api
});


@override $KyoshinMonitorSettingsApiModelCopyWith<$Res> get api;

}
/// @nodoc
class __$KyoshinMonitorSettingsModelCopyWithImpl<$Res>
    implements _$KyoshinMonitorSettingsModelCopyWith<$Res> {
  __$KyoshinMonitorSettingsModelCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorSettingsModel _self;
  final $Res Function(_KyoshinMonitorSettingsModel) _then;

/// Create a copy of KyoshinMonitorSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minRealtimeShindo = freezed,Object? showScale = null,Object? useKmoni = null,Object? kmoniMarkerType = null,Object? realtimeDataType = null,Object? realtimeLayer = null,Object? api = null,}) {
  return _then(_KyoshinMonitorSettingsModel(
minRealtimeShindo: freezed == minRealtimeShindo ? _self.minRealtimeShindo : minRealtimeShindo // ignore: cast_nullable_to_non_nullable
as double?,showScale: null == showScale ? _self.showScale : showScale // ignore: cast_nullable_to_non_nullable
as bool,useKmoni: null == useKmoni ? _self.useKmoni : useKmoni // ignore: cast_nullable_to_non_nullable
as bool,kmoniMarkerType: null == kmoniMarkerType ? _self.kmoniMarkerType : kmoniMarkerType // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorMarkerType,realtimeDataType: null == realtimeDataType ? _self.realtimeDataType : realtimeDataType // ignore: cast_nullable_to_non_nullable
as RealtimeDataType,realtimeLayer: null == realtimeLayer ? _self.realtimeLayer : realtimeLayer // ignore: cast_nullable_to_non_nullable
as RealtimeLayer,api: null == api ? _self.api : api // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorSettingsApiModel,
  ));
}

/// Create a copy of KyoshinMonitorSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinMonitorSettingsApiModelCopyWith<$Res> get api {
  
  return $KyoshinMonitorSettingsApiModelCopyWith<$Res>(_self.api, (value) {
    return _then(_self.copyWith(api: value));
  });
}
}


/// @nodoc
mixin _$KyoshinMonitorSettingsApiModel {

/// 強震モニタ APIのベースURL
@JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni) KyoshinMonitorEndpoint get endpoint;/// 画像取得頻度
@Assert('imageFetchInterval.inSeconds > 1', 'imageFetchInterval must be greater than 1 second') Duration get imageFetchInterval;/// 遅延調整間隔
 Duration get delayAdjustInterval;
/// Create a copy of KyoshinMonitorSettingsApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorSettingsApiModelCopyWith<KyoshinMonitorSettingsApiModel> get copyWith => _$KyoshinMonitorSettingsApiModelCopyWithImpl<KyoshinMonitorSettingsApiModel>(this as KyoshinMonitorSettingsApiModel, _$identity);

  /// Serializes this KyoshinMonitorSettingsApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorSettingsApiModel&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint)&&(identical(other.imageFetchInterval, imageFetchInterval) || other.imageFetchInterval == imageFetchInterval)&&(identical(other.delayAdjustInterval, delayAdjustInterval) || other.delayAdjustInterval == delayAdjustInterval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,endpoint,imageFetchInterval,delayAdjustInterval);

@override
String toString() {
  return 'KyoshinMonitorSettingsApiModel(endpoint: $endpoint, imageFetchInterval: $imageFetchInterval, delayAdjustInterval: $delayAdjustInterval)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorSettingsApiModelCopyWith<$Res>  {
  factory $KyoshinMonitorSettingsApiModelCopyWith(KyoshinMonitorSettingsApiModel value, $Res Function(KyoshinMonitorSettingsApiModel) _then) = _$KyoshinMonitorSettingsApiModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni) KyoshinMonitorEndpoint endpoint,@Assert('imageFetchInterval.inSeconds > 1', 'imageFetchInterval must be greater than 1 second') Duration imageFetchInterval, Duration delayAdjustInterval
});




}
/// @nodoc
class _$KyoshinMonitorSettingsApiModelCopyWithImpl<$Res>
    implements $KyoshinMonitorSettingsApiModelCopyWith<$Res> {
  _$KyoshinMonitorSettingsApiModelCopyWithImpl(this._self, this._then);

  final KyoshinMonitorSettingsApiModel _self;
  final $Res Function(KyoshinMonitorSettingsApiModel) _then;

/// Create a copy of KyoshinMonitorSettingsApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? endpoint = null,Object? imageFetchInterval = null,Object? delayAdjustInterval = null,}) {
  return _then(_self.copyWith(
endpoint: null == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorEndpoint,imageFetchInterval: null == imageFetchInterval ? _self.imageFetchInterval : imageFetchInterval // ignore: cast_nullable_to_non_nullable
as Duration,delayAdjustInterval: null == delayAdjustInterval ? _self.delayAdjustInterval : delayAdjustInterval // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _KyoshinMonitorSettingsApiModel implements KyoshinMonitorSettingsApiModel {
  const _KyoshinMonitorSettingsApiModel({@JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni) this.endpoint = KyoshinMonitorEndpoint.kmoni, @Assert('imageFetchInterval.inSeconds > 1', 'imageFetchInterval must be greater than 1 second') this.imageFetchInterval = const Duration(seconds: 1), this.delayAdjustInterval = const Duration(minutes: 10)});
  factory _KyoshinMonitorSettingsApiModel.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorSettingsApiModelFromJson(json);

/// 強震モニタ APIのベースURL
@override@JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni) final  KyoshinMonitorEndpoint endpoint;
/// 画像取得頻度
@override@JsonKey()@Assert('imageFetchInterval.inSeconds > 1', 'imageFetchInterval must be greater than 1 second') final  Duration imageFetchInterval;
/// 遅延調整間隔
@override@JsonKey() final  Duration delayAdjustInterval;

/// Create a copy of KyoshinMonitorSettingsApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorSettingsApiModelCopyWith<_KyoshinMonitorSettingsApiModel> get copyWith => __$KyoshinMonitorSettingsApiModelCopyWithImpl<_KyoshinMonitorSettingsApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorSettingsApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorSettingsApiModel&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint)&&(identical(other.imageFetchInterval, imageFetchInterval) || other.imageFetchInterval == imageFetchInterval)&&(identical(other.delayAdjustInterval, delayAdjustInterval) || other.delayAdjustInterval == delayAdjustInterval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,endpoint,imageFetchInterval,delayAdjustInterval);

@override
String toString() {
  return 'KyoshinMonitorSettingsApiModel(endpoint: $endpoint, imageFetchInterval: $imageFetchInterval, delayAdjustInterval: $delayAdjustInterval)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorSettingsApiModelCopyWith<$Res> implements $KyoshinMonitorSettingsApiModelCopyWith<$Res> {
  factory _$KyoshinMonitorSettingsApiModelCopyWith(_KyoshinMonitorSettingsApiModel value, $Res Function(_KyoshinMonitorSettingsApiModel) _then) = __$KyoshinMonitorSettingsApiModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni) KyoshinMonitorEndpoint endpoint,@Assert('imageFetchInterval.inSeconds > 1', 'imageFetchInterval must be greater than 1 second') Duration imageFetchInterval, Duration delayAdjustInterval
});




}
/// @nodoc
class __$KyoshinMonitorSettingsApiModelCopyWithImpl<$Res>
    implements _$KyoshinMonitorSettingsApiModelCopyWith<$Res> {
  __$KyoshinMonitorSettingsApiModelCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorSettingsApiModel _self;
  final $Res Function(_KyoshinMonitorSettingsApiModel) _then;

/// Create a copy of KyoshinMonitorSettingsApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? endpoint = null,Object? imageFetchInterval = null,Object? delayAdjustInterval = null,}) {
  return _then(_KyoshinMonitorSettingsApiModel(
endpoint: null == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorEndpoint,imageFetchInterval: null == imageFetchInterval ? _self.imageFetchInterval : imageFetchInterval // ignore: cast_nullable_to_non_nullable
as Duration,delayAdjustInterval: null == delayAdjustInterval ? _self.delayAdjustInterval : delayAdjustInterval // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on

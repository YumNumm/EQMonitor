// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_history_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeHistoryConfig {

 EarthquakeHistoryListConfig get list; EarthquakeHistoryDetailConfig get detail;
/// Create a copy of EarthquakeHistoryConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryConfigCopyWith<EarthquakeHistoryConfig> get copyWith => _$EarthquakeHistoryConfigCopyWithImpl<EarthquakeHistoryConfig>(this as EarthquakeHistoryConfig, _$identity);

  /// Serializes this EarthquakeHistoryConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryConfig&&(identical(other.list, list) || other.list == list)&&(identical(other.detail, detail) || other.detail == detail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,list,detail);

@override
String toString() {
  return 'EarthquakeHistoryConfig(list: $list, detail: $detail)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryConfigCopyWith<$Res>  {
  factory $EarthquakeHistoryConfigCopyWith(EarthquakeHistoryConfig value, $Res Function(EarthquakeHistoryConfig) _then) = _$EarthquakeHistoryConfigCopyWithImpl;
@useResult
$Res call({
 EarthquakeHistoryListConfig list, EarthquakeHistoryDetailConfig detail
});


$EarthquakeHistoryListConfigCopyWith<$Res> get list;$EarthquakeHistoryDetailConfigCopyWith<$Res> get detail;

}
/// @nodoc
class _$EarthquakeHistoryConfigCopyWithImpl<$Res>
    implements $EarthquakeHistoryConfigCopyWith<$Res> {
  _$EarthquakeHistoryConfigCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryConfig _self;
  final $Res Function(EarthquakeHistoryConfig) _then;

/// Create a copy of EarthquakeHistoryConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,Object? detail = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as EarthquakeHistoryListConfig,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as EarthquakeHistoryDetailConfig,
  ));
}
/// Create a copy of EarthquakeHistoryConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHistoryListConfigCopyWith<$Res> get list {
  
  return $EarthquakeHistoryListConfigCopyWith<$Res>(_self.list, (value) {
    return _then(_self.copyWith(list: value));
  });
}/// Create a copy of EarthquakeHistoryConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHistoryDetailConfigCopyWith<$Res> get detail {
  
  return $EarthquakeHistoryDetailConfigCopyWith<$Res>(_self.detail, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _EarthquakeHistoryConfig implements EarthquakeHistoryConfig {
  const _EarthquakeHistoryConfig({required this.list, required this.detail});
  factory _EarthquakeHistoryConfig.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryConfigFromJson(json);

@override final  EarthquakeHistoryListConfig list;
@override final  EarthquakeHistoryDetailConfig detail;

/// Create a copy of EarthquakeHistoryConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHistoryConfigCopyWith<_EarthquakeHistoryConfig> get copyWith => __$EarthquakeHistoryConfigCopyWithImpl<_EarthquakeHistoryConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryConfig&&(identical(other.list, list) || other.list == list)&&(identical(other.detail, detail) || other.detail == detail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,list,detail);

@override
String toString() {
  return 'EarthquakeHistoryConfig(list: $list, detail: $detail)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryConfigCopyWith<$Res> implements $EarthquakeHistoryConfigCopyWith<$Res> {
  factory _$EarthquakeHistoryConfigCopyWith(_EarthquakeHistoryConfig value, $Res Function(_EarthquakeHistoryConfig) _then) = __$EarthquakeHistoryConfigCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeHistoryListConfig list, EarthquakeHistoryDetailConfig detail
});


@override $EarthquakeHistoryListConfigCopyWith<$Res> get list;@override $EarthquakeHistoryDetailConfigCopyWith<$Res> get detail;

}
/// @nodoc
class __$EarthquakeHistoryConfigCopyWithImpl<$Res>
    implements _$EarthquakeHistoryConfigCopyWith<$Res> {
  __$EarthquakeHistoryConfigCopyWithImpl(this._self, this._then);

  final _EarthquakeHistoryConfig _self;
  final $Res Function(_EarthquakeHistoryConfig) _then;

/// Create a copy of EarthquakeHistoryConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,Object? detail = null,}) {
  return _then(_EarthquakeHistoryConfig(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as EarthquakeHistoryListConfig,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as EarthquakeHistoryDetailConfig,
  ));
}

/// Create a copy of EarthquakeHistoryConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHistoryListConfigCopyWith<$Res> get list {
  
  return $EarthquakeHistoryListConfigCopyWith<$Res>(_self.list, (value) {
    return _then(_self.copyWith(list: value));
  });
}/// Create a copy of EarthquakeHistoryConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHistoryDetailConfigCopyWith<$Res> get detail {
  
  return $EarthquakeHistoryDetailConfigCopyWith<$Res>(_self.detail, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}


/// @nodoc
mixin _$EarthquakeHistoryListConfig {

/// 背景塗りつぶしの有無
 bool get isFillBackground;
/// Create a copy of EarthquakeHistoryListConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryListConfigCopyWith<EarthquakeHistoryListConfig> get copyWith => _$EarthquakeHistoryListConfigCopyWithImpl<EarthquakeHistoryListConfig>(this as EarthquakeHistoryListConfig, _$identity);

  /// Serializes this EarthquakeHistoryListConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryListConfig&&(identical(other.isFillBackground, isFillBackground) || other.isFillBackground == isFillBackground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFillBackground);

@override
String toString() {
  return 'EarthquakeHistoryListConfig(isFillBackground: $isFillBackground)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryListConfigCopyWith<$Res>  {
  factory $EarthquakeHistoryListConfigCopyWith(EarthquakeHistoryListConfig value, $Res Function(EarthquakeHistoryListConfig) _then) = _$EarthquakeHistoryListConfigCopyWithImpl;
@useResult
$Res call({
 bool isFillBackground
});




}
/// @nodoc
class _$EarthquakeHistoryListConfigCopyWithImpl<$Res>
    implements $EarthquakeHistoryListConfigCopyWith<$Res> {
  _$EarthquakeHistoryListConfigCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryListConfig _self;
  final $Res Function(EarthquakeHistoryListConfig) _then;

/// Create a copy of EarthquakeHistoryListConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isFillBackground = null,}) {
  return _then(_self.copyWith(
isFillBackground: null == isFillBackground ? _self.isFillBackground : isFillBackground // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeHistoryListConfig implements EarthquakeHistoryListConfig {
  const _EarthquakeHistoryListConfig({this.isFillBackground = true});
  factory _EarthquakeHistoryListConfig.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryListConfigFromJson(json);

/// 背景塗りつぶしの有無
@override@JsonKey() final  bool isFillBackground;

/// Create a copy of EarthquakeHistoryListConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHistoryListConfigCopyWith<_EarthquakeHistoryListConfig> get copyWith => __$EarthquakeHistoryListConfigCopyWithImpl<_EarthquakeHistoryListConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryListConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryListConfig&&(identical(other.isFillBackground, isFillBackground) || other.isFillBackground == isFillBackground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFillBackground);

@override
String toString() {
  return 'EarthquakeHistoryListConfig(isFillBackground: $isFillBackground)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryListConfigCopyWith<$Res> implements $EarthquakeHistoryListConfigCopyWith<$Res> {
  factory _$EarthquakeHistoryListConfigCopyWith(_EarthquakeHistoryListConfig value, $Res Function(_EarthquakeHistoryListConfig) _then) = __$EarthquakeHistoryListConfigCopyWithImpl;
@override @useResult
$Res call({
 bool isFillBackground
});




}
/// @nodoc
class __$EarthquakeHistoryListConfigCopyWithImpl<$Res>
    implements _$EarthquakeHistoryListConfigCopyWith<$Res> {
  __$EarthquakeHistoryListConfigCopyWithImpl(this._self, this._then);

  final _EarthquakeHistoryListConfig _self;
  final $Res Function(_EarthquakeHistoryListConfig) _then;

/// Create a copy of EarthquakeHistoryListConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isFillBackground = null,}) {
  return _then(_EarthquakeHistoryListConfig(
isFillBackground: null == isFillBackground ? _self.isFillBackground : isFillBackground // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EarthquakeHistoryDetailConfig {

/// 震度の表示方法
 IntensityFillMode get intensityFillMode;/// 震度観測点のアイコン表示
 bool get showIntensityIcon;/// 長周期地震動階級を表示しているか
 bool get showingLpgmIntensity;
/// Create a copy of EarthquakeHistoryDetailConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryDetailConfigCopyWith<EarthquakeHistoryDetailConfig> get copyWith => _$EarthquakeHistoryDetailConfigCopyWithImpl<EarthquakeHistoryDetailConfig>(this as EarthquakeHistoryDetailConfig, _$identity);

  /// Serializes this EarthquakeHistoryDetailConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryDetailConfig&&(identical(other.intensityFillMode, intensityFillMode) || other.intensityFillMode == intensityFillMode)&&(identical(other.showIntensityIcon, showIntensityIcon) || other.showIntensityIcon == showIntensityIcon)&&(identical(other.showingLpgmIntensity, showingLpgmIntensity) || other.showingLpgmIntensity == showingLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensityFillMode,showIntensityIcon,showingLpgmIntensity);

@override
String toString() {
  return 'EarthquakeHistoryDetailConfig(intensityFillMode: $intensityFillMode, showIntensityIcon: $showIntensityIcon, showingLpgmIntensity: $showingLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryDetailConfigCopyWith<$Res>  {
  factory $EarthquakeHistoryDetailConfigCopyWith(EarthquakeHistoryDetailConfig value, $Res Function(EarthquakeHistoryDetailConfig) _then) = _$EarthquakeHistoryDetailConfigCopyWithImpl;
@useResult
$Res call({
 IntensityFillMode intensityFillMode, bool showIntensityIcon, bool showingLpgmIntensity
});




}
/// @nodoc
class _$EarthquakeHistoryDetailConfigCopyWithImpl<$Res>
    implements $EarthquakeHistoryDetailConfigCopyWith<$Res> {
  _$EarthquakeHistoryDetailConfigCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryDetailConfig _self;
  final $Res Function(EarthquakeHistoryDetailConfig) _then;

/// Create a copy of EarthquakeHistoryDetailConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intensityFillMode = null,Object? showIntensityIcon = null,Object? showingLpgmIntensity = null,}) {
  return _then(_self.copyWith(
intensityFillMode: null == intensityFillMode ? _self.intensityFillMode : intensityFillMode // ignore: cast_nullable_to_non_nullable
as IntensityFillMode,showIntensityIcon: null == showIntensityIcon ? _self.showIntensityIcon : showIntensityIcon // ignore: cast_nullable_to_non_nullable
as bool,showingLpgmIntensity: null == showingLpgmIntensity ? _self.showingLpgmIntensity : showingLpgmIntensity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeHistoryDetailConfig implements EarthquakeHistoryDetailConfig {
  const _EarthquakeHistoryDetailConfig({this.intensityFillMode = IntensityFillMode.fillCity, this.showIntensityIcon = true, this.showingLpgmIntensity = false});
  factory _EarthquakeHistoryDetailConfig.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryDetailConfigFromJson(json);

/// 震度の表示方法
@override@JsonKey() final  IntensityFillMode intensityFillMode;
/// 震度観測点のアイコン表示
@override@JsonKey() final  bool showIntensityIcon;
/// 長周期地震動階級を表示しているか
@override@JsonKey() final  bool showingLpgmIntensity;

/// Create a copy of EarthquakeHistoryDetailConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHistoryDetailConfigCopyWith<_EarthquakeHistoryDetailConfig> get copyWith => __$EarthquakeHistoryDetailConfigCopyWithImpl<_EarthquakeHistoryDetailConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryDetailConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryDetailConfig&&(identical(other.intensityFillMode, intensityFillMode) || other.intensityFillMode == intensityFillMode)&&(identical(other.showIntensityIcon, showIntensityIcon) || other.showIntensityIcon == showIntensityIcon)&&(identical(other.showingLpgmIntensity, showingLpgmIntensity) || other.showingLpgmIntensity == showingLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensityFillMode,showIntensityIcon,showingLpgmIntensity);

@override
String toString() {
  return 'EarthquakeHistoryDetailConfig(intensityFillMode: $intensityFillMode, showIntensityIcon: $showIntensityIcon, showingLpgmIntensity: $showingLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryDetailConfigCopyWith<$Res> implements $EarthquakeHistoryDetailConfigCopyWith<$Res> {
  factory _$EarthquakeHistoryDetailConfigCopyWith(_EarthquakeHistoryDetailConfig value, $Res Function(_EarthquakeHistoryDetailConfig) _then) = __$EarthquakeHistoryDetailConfigCopyWithImpl;
@override @useResult
$Res call({
 IntensityFillMode intensityFillMode, bool showIntensityIcon, bool showingLpgmIntensity
});




}
/// @nodoc
class __$EarthquakeHistoryDetailConfigCopyWithImpl<$Res>
    implements _$EarthquakeHistoryDetailConfigCopyWith<$Res> {
  __$EarthquakeHistoryDetailConfigCopyWithImpl(this._self, this._then);

  final _EarthquakeHistoryDetailConfig _self;
  final $Res Function(_EarthquakeHistoryDetailConfig) _then;

/// Create a copy of EarthquakeHistoryDetailConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intensityFillMode = null,Object? showIntensityIcon = null,Object? showingLpgmIntensity = null,}) {
  return _then(_EarthquakeHistoryDetailConfig(
intensityFillMode: null == intensityFillMode ? _self.intensityFillMode : intensityFillMode // ignore: cast_nullable_to_non_nullable
as IntensityFillMode,showIntensityIcon: null == showIntensityIcon ? _self.showIntensityIcon : showIntensityIcon // ignore: cast_nullable_to_non_nullable
as bool,showingLpgmIntensity: null == showingLpgmIntensity ? _self.showingLpgmIntensity : showingLpgmIntensity // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

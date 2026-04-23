// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [EarthquakeHistoryConfig].
extension EarthquakeHistoryConfigPatterns on EarthquakeHistoryConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeHistoryConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeHistoryConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeHistoryConfig value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeHistoryConfig value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeHistoryListConfig list,  EarthquakeHistoryDetailConfig detail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeHistoryConfig() when $default != null:
return $default(_that.list,_that.detail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeHistoryListConfig list,  EarthquakeHistoryDetailConfig detail)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryConfig():
return $default(_that.list,_that.detail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeHistoryListConfig list,  EarthquakeHistoryDetailConfig detail)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryConfig() when $default != null:
return $default(_that.list,_that.detail);case _:
  return null;

}
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
 bool get isFillBackground;/// ホーム「指定地域」用。将来の地域選択UIから設定
 RegionSearchType? get designatedRegionSearchType; String? get designatedRegionCode; String? get designatedRegionName;
/// Create a copy of EarthquakeHistoryListConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryListConfigCopyWith<EarthquakeHistoryListConfig> get copyWith => _$EarthquakeHistoryListConfigCopyWithImpl<EarthquakeHistoryListConfig>(this as EarthquakeHistoryListConfig, _$identity);

  /// Serializes this EarthquakeHistoryListConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryListConfig&&(identical(other.isFillBackground, isFillBackground) || other.isFillBackground == isFillBackground)&&(identical(other.designatedRegionSearchType, designatedRegionSearchType) || other.designatedRegionSearchType == designatedRegionSearchType)&&(identical(other.designatedRegionCode, designatedRegionCode) || other.designatedRegionCode == designatedRegionCode)&&(identical(other.designatedRegionName, designatedRegionName) || other.designatedRegionName == designatedRegionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFillBackground,designatedRegionSearchType,designatedRegionCode,designatedRegionName);

@override
String toString() {
  return 'EarthquakeHistoryListConfig(isFillBackground: $isFillBackground, designatedRegionSearchType: $designatedRegionSearchType, designatedRegionCode: $designatedRegionCode, designatedRegionName: $designatedRegionName)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryListConfigCopyWith<$Res>  {
  factory $EarthquakeHistoryListConfigCopyWith(EarthquakeHistoryListConfig value, $Res Function(EarthquakeHistoryListConfig) _then) = _$EarthquakeHistoryListConfigCopyWithImpl;
@useResult
$Res call({
 bool isFillBackground, RegionSearchType? designatedRegionSearchType, String? designatedRegionCode, String? designatedRegionName
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
@pragma('vm:prefer-inline') @override $Res call({Object? isFillBackground = null,Object? designatedRegionSearchType = freezed,Object? designatedRegionCode = freezed,Object? designatedRegionName = freezed,}) {
  return _then(_self.copyWith(
isFillBackground: null == isFillBackground ? _self.isFillBackground : isFillBackground // ignore: cast_nullable_to_non_nullable
as bool,designatedRegionSearchType: freezed == designatedRegionSearchType ? _self.designatedRegionSearchType : designatedRegionSearchType // ignore: cast_nullable_to_non_nullable
as RegionSearchType?,designatedRegionCode: freezed == designatedRegionCode ? _self.designatedRegionCode : designatedRegionCode // ignore: cast_nullable_to_non_nullable
as String?,designatedRegionName: freezed == designatedRegionName ? _self.designatedRegionName : designatedRegionName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeHistoryListConfig].
extension EarthquakeHistoryListConfigPatterns on EarthquakeHistoryListConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeHistoryListConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeHistoryListConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeHistoryListConfig value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryListConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeHistoryListConfig value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryListConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isFillBackground,  RegionSearchType? designatedRegionSearchType,  String? designatedRegionCode,  String? designatedRegionName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeHistoryListConfig() when $default != null:
return $default(_that.isFillBackground,_that.designatedRegionSearchType,_that.designatedRegionCode,_that.designatedRegionName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isFillBackground,  RegionSearchType? designatedRegionSearchType,  String? designatedRegionCode,  String? designatedRegionName)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryListConfig():
return $default(_that.isFillBackground,_that.designatedRegionSearchType,_that.designatedRegionCode,_that.designatedRegionName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isFillBackground,  RegionSearchType? designatedRegionSearchType,  String? designatedRegionCode,  String? designatedRegionName)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryListConfig() when $default != null:
return $default(_that.isFillBackground,_that.designatedRegionSearchType,_that.designatedRegionCode,_that.designatedRegionName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeHistoryListConfig implements EarthquakeHistoryListConfig {
  const _EarthquakeHistoryListConfig({this.isFillBackground = true, this.designatedRegionSearchType, this.designatedRegionCode, this.designatedRegionName});
  factory _EarthquakeHistoryListConfig.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryListConfigFromJson(json);

/// 背景塗りつぶしの有無
@override@JsonKey() final  bool isFillBackground;
/// ホーム「指定地域」用。将来の地域選択UIから設定
@override final  RegionSearchType? designatedRegionSearchType;
@override final  String? designatedRegionCode;
@override final  String? designatedRegionName;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryListConfig&&(identical(other.isFillBackground, isFillBackground) || other.isFillBackground == isFillBackground)&&(identical(other.designatedRegionSearchType, designatedRegionSearchType) || other.designatedRegionSearchType == designatedRegionSearchType)&&(identical(other.designatedRegionCode, designatedRegionCode) || other.designatedRegionCode == designatedRegionCode)&&(identical(other.designatedRegionName, designatedRegionName) || other.designatedRegionName == designatedRegionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFillBackground,designatedRegionSearchType,designatedRegionCode,designatedRegionName);

@override
String toString() {
  return 'EarthquakeHistoryListConfig(isFillBackground: $isFillBackground, designatedRegionSearchType: $designatedRegionSearchType, designatedRegionCode: $designatedRegionCode, designatedRegionName: $designatedRegionName)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryListConfigCopyWith<$Res> implements $EarthquakeHistoryListConfigCopyWith<$Res> {
  factory _$EarthquakeHistoryListConfigCopyWith(_EarthquakeHistoryListConfig value, $Res Function(_EarthquakeHistoryListConfig) _then) = __$EarthquakeHistoryListConfigCopyWithImpl;
@override @useResult
$Res call({
 bool isFillBackground, RegionSearchType? designatedRegionSearchType, String? designatedRegionCode, String? designatedRegionName
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
@override @pragma('vm:prefer-inline') $Res call({Object? isFillBackground = null,Object? designatedRegionSearchType = freezed,Object? designatedRegionCode = freezed,Object? designatedRegionName = freezed,}) {
  return _then(_EarthquakeHistoryListConfig(
isFillBackground: null == isFillBackground ? _self.isFillBackground : isFillBackground // ignore: cast_nullable_to_non_nullable
as bool,designatedRegionSearchType: freezed == designatedRegionSearchType ? _self.designatedRegionSearchType : designatedRegionSearchType // ignore: cast_nullable_to_non_nullable
as RegionSearchType?,designatedRegionCode: freezed == designatedRegionCode ? _self.designatedRegionCode : designatedRegionCode // ignore: cast_nullable_to_non_nullable
as String?,designatedRegionName: freezed == designatedRegionName ? _self.designatedRegionName : designatedRegionName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EarthquakeHistoryDetailConfig {

/// 地図の震度表示モード（旧値は unknownEnumValue で stationOnly に migration）
@JsonKey(unknownEnumValue: IntensityFillMode.stationOnly) IntensityFillMode get intensityFillMode;/// 観測点の表示方法
 StationDisplayMode get stationDisplayMode;/// 震央マーカーの表示方法
 HypocenterDisplayMode get hypocenterDisplayMode;/// 震央誤差矩形を表示するか
 bool get showHypocenterError;/// 観測点名ラベルを表示するか
 bool get showStationLabel;/// 推計震度データがある場合に自動で推計震度モードにするか（永続化）
 bool get useEstimatedIntensityWhenAvailable;/// 震度凡例を表示するか
 bool get showLegend;/// 長周期地震動階級を表示しているか
 bool get showingLpgmIntensity;/// 観測点に震度アイコンを重ねて表示するか (v2.6.0 互換)
 bool get showIntensityIcon;/// 観測点レイヤーを表示するか
 bool get showStation;
/// Create a copy of EarthquakeHistoryDetailConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryDetailConfigCopyWith<EarthquakeHistoryDetailConfig> get copyWith => _$EarthquakeHistoryDetailConfigCopyWithImpl<EarthquakeHistoryDetailConfig>(this as EarthquakeHistoryDetailConfig, _$identity);

  /// Serializes this EarthquakeHistoryDetailConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryDetailConfig&&(identical(other.intensityFillMode, intensityFillMode) || other.intensityFillMode == intensityFillMode)&&(identical(other.stationDisplayMode, stationDisplayMode) || other.stationDisplayMode == stationDisplayMode)&&(identical(other.hypocenterDisplayMode, hypocenterDisplayMode) || other.hypocenterDisplayMode == hypocenterDisplayMode)&&(identical(other.showHypocenterError, showHypocenterError) || other.showHypocenterError == showHypocenterError)&&(identical(other.showStationLabel, showStationLabel) || other.showStationLabel == showStationLabel)&&(identical(other.useEstimatedIntensityWhenAvailable, useEstimatedIntensityWhenAvailable) || other.useEstimatedIntensityWhenAvailable == useEstimatedIntensityWhenAvailable)&&(identical(other.showLegend, showLegend) || other.showLegend == showLegend)&&(identical(other.showingLpgmIntensity, showingLpgmIntensity) || other.showingLpgmIntensity == showingLpgmIntensity)&&(identical(other.showIntensityIcon, showIntensityIcon) || other.showIntensityIcon == showIntensityIcon)&&(identical(other.showStation, showStation) || other.showStation == showStation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensityFillMode,stationDisplayMode,hypocenterDisplayMode,showHypocenterError,showStationLabel,useEstimatedIntensityWhenAvailable,showLegend,showingLpgmIntensity,showIntensityIcon,showStation);

@override
String toString() {
  return 'EarthquakeHistoryDetailConfig(intensityFillMode: $intensityFillMode, stationDisplayMode: $stationDisplayMode, hypocenterDisplayMode: $hypocenterDisplayMode, showHypocenterError: $showHypocenterError, showStationLabel: $showStationLabel, useEstimatedIntensityWhenAvailable: $useEstimatedIntensityWhenAvailable, showLegend: $showLegend, showingLpgmIntensity: $showingLpgmIntensity, showIntensityIcon: $showIntensityIcon, showStation: $showStation)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryDetailConfigCopyWith<$Res>  {
  factory $EarthquakeHistoryDetailConfigCopyWith(EarthquakeHistoryDetailConfig value, $Res Function(EarthquakeHistoryDetailConfig) _then) = _$EarthquakeHistoryDetailConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: IntensityFillMode.stationOnly) IntensityFillMode intensityFillMode, StationDisplayMode stationDisplayMode, HypocenterDisplayMode hypocenterDisplayMode, bool showHypocenterError, bool showStationLabel, bool useEstimatedIntensityWhenAvailable, bool showLegend, bool showingLpgmIntensity, bool showIntensityIcon, bool showStation
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
@pragma('vm:prefer-inline') @override $Res call({Object? intensityFillMode = null,Object? stationDisplayMode = null,Object? hypocenterDisplayMode = null,Object? showHypocenterError = null,Object? showStationLabel = null,Object? useEstimatedIntensityWhenAvailable = null,Object? showLegend = null,Object? showingLpgmIntensity = null,Object? showIntensityIcon = null,Object? showStation = null,}) {
  return _then(_self.copyWith(
intensityFillMode: null == intensityFillMode ? _self.intensityFillMode : intensityFillMode // ignore: cast_nullable_to_non_nullable
as IntensityFillMode,stationDisplayMode: null == stationDisplayMode ? _self.stationDisplayMode : stationDisplayMode // ignore: cast_nullable_to_non_nullable
as StationDisplayMode,hypocenterDisplayMode: null == hypocenterDisplayMode ? _self.hypocenterDisplayMode : hypocenterDisplayMode // ignore: cast_nullable_to_non_nullable
as HypocenterDisplayMode,showHypocenterError: null == showHypocenterError ? _self.showHypocenterError : showHypocenterError // ignore: cast_nullable_to_non_nullable
as bool,showStationLabel: null == showStationLabel ? _self.showStationLabel : showStationLabel // ignore: cast_nullable_to_non_nullable
as bool,useEstimatedIntensityWhenAvailable: null == useEstimatedIntensityWhenAvailable ? _self.useEstimatedIntensityWhenAvailable : useEstimatedIntensityWhenAvailable // ignore: cast_nullable_to_non_nullable
as bool,showLegend: null == showLegend ? _self.showLegend : showLegend // ignore: cast_nullable_to_non_nullable
as bool,showingLpgmIntensity: null == showingLpgmIntensity ? _self.showingLpgmIntensity : showingLpgmIntensity // ignore: cast_nullable_to_non_nullable
as bool,showIntensityIcon: null == showIntensityIcon ? _self.showIntensityIcon : showIntensityIcon // ignore: cast_nullable_to_non_nullable
as bool,showStation: null == showStation ? _self.showStation : showStation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeHistoryDetailConfig].
extension EarthquakeHistoryDetailConfigPatterns on EarthquakeHistoryDetailConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeHistoryDetailConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeHistoryDetailConfig value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeHistoryDetailConfig value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: IntensityFillMode.stationOnly)  IntensityFillMode intensityFillMode,  StationDisplayMode stationDisplayMode,  HypocenterDisplayMode hypocenterDisplayMode,  bool showHypocenterError,  bool showStationLabel,  bool useEstimatedIntensityWhenAvailable,  bool showLegend,  bool showingLpgmIntensity,  bool showIntensityIcon,  bool showStation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailConfig() when $default != null:
return $default(_that.intensityFillMode,_that.stationDisplayMode,_that.hypocenterDisplayMode,_that.showHypocenterError,_that.showStationLabel,_that.useEstimatedIntensityWhenAvailable,_that.showLegend,_that.showingLpgmIntensity,_that.showIntensityIcon,_that.showStation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: IntensityFillMode.stationOnly)  IntensityFillMode intensityFillMode,  StationDisplayMode stationDisplayMode,  HypocenterDisplayMode hypocenterDisplayMode,  bool showHypocenterError,  bool showStationLabel,  bool useEstimatedIntensityWhenAvailable,  bool showLegend,  bool showingLpgmIntensity,  bool showIntensityIcon,  bool showStation)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailConfig():
return $default(_that.intensityFillMode,_that.stationDisplayMode,_that.hypocenterDisplayMode,_that.showHypocenterError,_that.showStationLabel,_that.useEstimatedIntensityWhenAvailable,_that.showLegend,_that.showingLpgmIntensity,_that.showIntensityIcon,_that.showStation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: IntensityFillMode.stationOnly)  IntensityFillMode intensityFillMode,  StationDisplayMode stationDisplayMode,  HypocenterDisplayMode hypocenterDisplayMode,  bool showHypocenterError,  bool showStationLabel,  bool useEstimatedIntensityWhenAvailable,  bool showLegend,  bool showingLpgmIntensity,  bool showIntensityIcon,  bool showStation)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailConfig() when $default != null:
return $default(_that.intensityFillMode,_that.stationDisplayMode,_that.hypocenterDisplayMode,_that.showHypocenterError,_that.showStationLabel,_that.useEstimatedIntensityWhenAvailable,_that.showLegend,_that.showingLpgmIntensity,_that.showIntensityIcon,_that.showStation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeHistoryDetailConfig implements EarthquakeHistoryDetailConfig {
  const _EarthquakeHistoryDetailConfig({@JsonKey(unknownEnumValue: IntensityFillMode.stationOnly) this.intensityFillMode = IntensityFillMode.stationOnly, this.stationDisplayMode = StationDisplayMode.maxFocused, this.hypocenterDisplayMode = HypocenterDisplayMode.zoomFade, this.showHypocenterError = false, this.showStationLabel = false, this.useEstimatedIntensityWhenAvailable = true, this.showLegend = true, this.showingLpgmIntensity = false, this.showIntensityIcon = true, this.showStation = true});
  factory _EarthquakeHistoryDetailConfig.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryDetailConfigFromJson(json);

/// 地図の震度表示モード（旧値は unknownEnumValue で stationOnly に migration）
@override@JsonKey(unknownEnumValue: IntensityFillMode.stationOnly) final  IntensityFillMode intensityFillMode;
/// 観測点の表示方法
@override@JsonKey() final  StationDisplayMode stationDisplayMode;
/// 震央マーカーの表示方法
@override@JsonKey() final  HypocenterDisplayMode hypocenterDisplayMode;
/// 震央誤差矩形を表示するか
@override@JsonKey() final  bool showHypocenterError;
/// 観測点名ラベルを表示するか
@override@JsonKey() final  bool showStationLabel;
/// 推計震度データがある場合に自動で推計震度モードにするか（永続化）
@override@JsonKey() final  bool useEstimatedIntensityWhenAvailable;
/// 震度凡例を表示するか
@override@JsonKey() final  bool showLegend;
/// 長周期地震動階級を表示しているか
@override@JsonKey() final  bool showingLpgmIntensity;
/// 観測点に震度アイコンを重ねて表示するか (v2.6.0 互換)
@override@JsonKey() final  bool showIntensityIcon;
/// 観測点レイヤーを表示するか
@override@JsonKey() final  bool showStation;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryDetailConfig&&(identical(other.intensityFillMode, intensityFillMode) || other.intensityFillMode == intensityFillMode)&&(identical(other.stationDisplayMode, stationDisplayMode) || other.stationDisplayMode == stationDisplayMode)&&(identical(other.hypocenterDisplayMode, hypocenterDisplayMode) || other.hypocenterDisplayMode == hypocenterDisplayMode)&&(identical(other.showHypocenterError, showHypocenterError) || other.showHypocenterError == showHypocenterError)&&(identical(other.showStationLabel, showStationLabel) || other.showStationLabel == showStationLabel)&&(identical(other.useEstimatedIntensityWhenAvailable, useEstimatedIntensityWhenAvailable) || other.useEstimatedIntensityWhenAvailable == useEstimatedIntensityWhenAvailable)&&(identical(other.showLegend, showLegend) || other.showLegend == showLegend)&&(identical(other.showingLpgmIntensity, showingLpgmIntensity) || other.showingLpgmIntensity == showingLpgmIntensity)&&(identical(other.showIntensityIcon, showIntensityIcon) || other.showIntensityIcon == showIntensityIcon)&&(identical(other.showStation, showStation) || other.showStation == showStation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensityFillMode,stationDisplayMode,hypocenterDisplayMode,showHypocenterError,showStationLabel,useEstimatedIntensityWhenAvailable,showLegend,showingLpgmIntensity,showIntensityIcon,showStation);

@override
String toString() {
  return 'EarthquakeHistoryDetailConfig(intensityFillMode: $intensityFillMode, stationDisplayMode: $stationDisplayMode, hypocenterDisplayMode: $hypocenterDisplayMode, showHypocenterError: $showHypocenterError, showStationLabel: $showStationLabel, useEstimatedIntensityWhenAvailable: $useEstimatedIntensityWhenAvailable, showLegend: $showLegend, showingLpgmIntensity: $showingLpgmIntensity, showIntensityIcon: $showIntensityIcon, showStation: $showStation)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryDetailConfigCopyWith<$Res> implements $EarthquakeHistoryDetailConfigCopyWith<$Res> {
  factory _$EarthquakeHistoryDetailConfigCopyWith(_EarthquakeHistoryDetailConfig value, $Res Function(_EarthquakeHistoryDetailConfig) _then) = __$EarthquakeHistoryDetailConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: IntensityFillMode.stationOnly) IntensityFillMode intensityFillMode, StationDisplayMode stationDisplayMode, HypocenterDisplayMode hypocenterDisplayMode, bool showHypocenterError, bool showStationLabel, bool useEstimatedIntensityWhenAvailable, bool showLegend, bool showingLpgmIntensity, bool showIntensityIcon, bool showStation
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
@override @pragma('vm:prefer-inline') $Res call({Object? intensityFillMode = null,Object? stationDisplayMode = null,Object? hypocenterDisplayMode = null,Object? showHypocenterError = null,Object? showStationLabel = null,Object? useEstimatedIntensityWhenAvailable = null,Object? showLegend = null,Object? showingLpgmIntensity = null,Object? showIntensityIcon = null,Object? showStation = null,}) {
  return _then(_EarthquakeHistoryDetailConfig(
intensityFillMode: null == intensityFillMode ? _self.intensityFillMode : intensityFillMode // ignore: cast_nullable_to_non_nullable
as IntensityFillMode,stationDisplayMode: null == stationDisplayMode ? _self.stationDisplayMode : stationDisplayMode // ignore: cast_nullable_to_non_nullable
as StationDisplayMode,hypocenterDisplayMode: null == hypocenterDisplayMode ? _self.hypocenterDisplayMode : hypocenterDisplayMode // ignore: cast_nullable_to_non_nullable
as HypocenterDisplayMode,showHypocenterError: null == showHypocenterError ? _self.showHypocenterError : showHypocenterError // ignore: cast_nullable_to_non_nullable
as bool,showStationLabel: null == showStationLabel ? _self.showStationLabel : showStationLabel // ignore: cast_nullable_to_non_nullable
as bool,useEstimatedIntensityWhenAvailable: null == useEstimatedIntensityWhenAvailable ? _self.useEstimatedIntensityWhenAvailable : useEstimatedIntensityWhenAvailable // ignore: cast_nullable_to_non_nullable
as bool,showLegend: null == showLegend ? _self.showLegend : showLegend // ignore: cast_nullable_to_non_nullable
as bool,showingLpgmIntensity: null == showingLpgmIntensity ? _self.showingLpgmIntensity : showingLpgmIntensity // ignore: cast_nullable_to_non_nullable
as bool,showIntensityIcon: null == showIntensityIcon ? _self.showIntensityIcon : showIntensityIcon // ignore: cast_nullable_to_non_nullable
as bool,showStation: null == showStation ? _self.showStation : showStation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

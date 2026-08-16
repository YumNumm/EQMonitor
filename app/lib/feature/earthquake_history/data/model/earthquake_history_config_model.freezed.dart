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

 EarthquakeHistoryListConfig get list; EarthquakeHistoryDetailsConfig get details;
/// Create a copy of EarthquakeHistoryConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryConfigCopyWith<EarthquakeHistoryConfig> get copyWith => _$EarthquakeHistoryConfigCopyWithImpl<EarthquakeHistoryConfig>(this as EarthquakeHistoryConfig, _$identity);

  /// Serializes this EarthquakeHistoryConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryConfig&&(identical(other.list, list) || other.list == list)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,list,details);

@override
String toString() {
  return 'EarthquakeHistoryConfig(list: $list, details: $details)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryConfigCopyWith<$Res>  {
  factory $EarthquakeHistoryConfigCopyWith(EarthquakeHistoryConfig value, $Res Function(EarthquakeHistoryConfig) _then) = _$EarthquakeHistoryConfigCopyWithImpl;
@useResult
$Res call({
 EarthquakeHistoryListConfig list, EarthquakeHistoryDetailsConfig details
});


$EarthquakeHistoryListConfigCopyWith<$Res> get list;$EarthquakeHistoryDetailsConfigCopyWith<$Res> get details;

}
/// @nodoc
class _$EarthquakeHistoryConfigCopyWithImpl<$Res>
    implements $EarthquakeHistoryConfigCopyWith<$Res> {
  _$EarthquakeHistoryConfigCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryConfig _self;
  final $Res Function(EarthquakeHistoryConfig) _then;

/// Create a copy of EarthquakeHistoryConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,Object? details = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as EarthquakeHistoryListConfig,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as EarthquakeHistoryDetailsConfig,
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
$EarthquakeHistoryDetailsConfigCopyWith<$Res> get details {
  
  return $EarthquakeHistoryDetailsConfigCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeHistoryListConfig list,  EarthquakeHistoryDetailsConfig details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeHistoryConfig() when $default != null:
return $default(_that.list,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeHistoryListConfig list,  EarthquakeHistoryDetailsConfig details)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryConfig():
return $default(_that.list,_that.details);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeHistoryListConfig list,  EarthquakeHistoryDetailsConfig details)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryConfig() when $default != null:
return $default(_that.list,_that.details);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _EarthquakeHistoryConfig implements EarthquakeHistoryConfig {
  const _EarthquakeHistoryConfig({required this.list, this.details = const EarthquakeHistoryDetailsConfig()});
  factory _EarthquakeHistoryConfig.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryConfigFromJson(json);

@override final  EarthquakeHistoryListConfig list;
@override@JsonKey() final  EarthquakeHistoryDetailsConfig details;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryConfig&&(identical(other.list, list) || other.list == list)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,list,details);

@override
String toString() {
  return 'EarthquakeHistoryConfig(list: $list, details: $details)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryConfigCopyWith<$Res> implements $EarthquakeHistoryConfigCopyWith<$Res> {
  factory _$EarthquakeHistoryConfigCopyWith(_EarthquakeHistoryConfig value, $Res Function(_EarthquakeHistoryConfig) _then) = __$EarthquakeHistoryConfigCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeHistoryListConfig list, EarthquakeHistoryDetailsConfig details
});


@override $EarthquakeHistoryListConfigCopyWith<$Res> get list;@override $EarthquakeHistoryDetailsConfigCopyWith<$Res> get details;

}
/// @nodoc
class __$EarthquakeHistoryConfigCopyWithImpl<$Res>
    implements _$EarthquakeHistoryConfigCopyWith<$Res> {
  __$EarthquakeHistoryConfigCopyWithImpl(this._self, this._then);

  final _EarthquakeHistoryConfig _self;
  final $Res Function(_EarthquakeHistoryConfig) _then;

/// Create a copy of EarthquakeHistoryConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,Object? details = null,}) {
  return _then(_EarthquakeHistoryConfig(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as EarthquakeHistoryListConfig,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as EarthquakeHistoryDetailsConfig,
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
$EarthquakeHistoryDetailsConfigCopyWith<$Res> get details {
  
  return $EarthquakeHistoryDetailsConfigCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}
}


/// @nodoc
mixin _$EarthquakeHistoryListConfig {

/// 背景塗りつぶしの有無
 bool get isFillBackground;/// 発生時刻ソート時に日付区切りを表示するか
 bool get showDateSeparator;/// ホーム「指定地域」用。将来の地域選択UIから設定
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryListConfig&&(identical(other.isFillBackground, isFillBackground) || other.isFillBackground == isFillBackground)&&(identical(other.showDateSeparator, showDateSeparator) || other.showDateSeparator == showDateSeparator)&&(identical(other.designatedRegionSearchType, designatedRegionSearchType) || other.designatedRegionSearchType == designatedRegionSearchType)&&(identical(other.designatedRegionCode, designatedRegionCode) || other.designatedRegionCode == designatedRegionCode)&&(identical(other.designatedRegionName, designatedRegionName) || other.designatedRegionName == designatedRegionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFillBackground,showDateSeparator,designatedRegionSearchType,designatedRegionCode,designatedRegionName);

@override
String toString() {
  return 'EarthquakeHistoryListConfig(isFillBackground: $isFillBackground, showDateSeparator: $showDateSeparator, designatedRegionSearchType: $designatedRegionSearchType, designatedRegionCode: $designatedRegionCode, designatedRegionName: $designatedRegionName)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryListConfigCopyWith<$Res>  {
  factory $EarthquakeHistoryListConfigCopyWith(EarthquakeHistoryListConfig value, $Res Function(EarthquakeHistoryListConfig) _then) = _$EarthquakeHistoryListConfigCopyWithImpl;
@useResult
$Res call({
 bool isFillBackground, bool showDateSeparator, RegionSearchType? designatedRegionSearchType, String? designatedRegionCode, String? designatedRegionName
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
@pragma('vm:prefer-inline') @override $Res call({Object? isFillBackground = null,Object? showDateSeparator = null,Object? designatedRegionSearchType = freezed,Object? designatedRegionCode = freezed,Object? designatedRegionName = freezed,}) {
  return _then(_self.copyWith(
isFillBackground: null == isFillBackground ? _self.isFillBackground : isFillBackground // ignore: cast_nullable_to_non_nullable
as bool,showDateSeparator: null == showDateSeparator ? _self.showDateSeparator : showDateSeparator // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isFillBackground,  bool showDateSeparator,  RegionSearchType? designatedRegionSearchType,  String? designatedRegionCode,  String? designatedRegionName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeHistoryListConfig() when $default != null:
return $default(_that.isFillBackground,_that.showDateSeparator,_that.designatedRegionSearchType,_that.designatedRegionCode,_that.designatedRegionName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isFillBackground,  bool showDateSeparator,  RegionSearchType? designatedRegionSearchType,  String? designatedRegionCode,  String? designatedRegionName)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryListConfig():
return $default(_that.isFillBackground,_that.showDateSeparator,_that.designatedRegionSearchType,_that.designatedRegionCode,_that.designatedRegionName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isFillBackground,  bool showDateSeparator,  RegionSearchType? designatedRegionSearchType,  String? designatedRegionCode,  String? designatedRegionName)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryListConfig() when $default != null:
return $default(_that.isFillBackground,_that.showDateSeparator,_that.designatedRegionSearchType,_that.designatedRegionCode,_that.designatedRegionName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeHistoryListConfig implements EarthquakeHistoryListConfig {
  const _EarthquakeHistoryListConfig({this.isFillBackground = true, this.showDateSeparator = true, this.designatedRegionSearchType, this.designatedRegionCode, this.designatedRegionName});
  factory _EarthquakeHistoryListConfig.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryListConfigFromJson(json);

/// 背景塗りつぶしの有無
@override@JsonKey() final  bool isFillBackground;
/// 発生時刻ソート時に日付区切りを表示するか
@override@JsonKey() final  bool showDateSeparator;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryListConfig&&(identical(other.isFillBackground, isFillBackground) || other.isFillBackground == isFillBackground)&&(identical(other.showDateSeparator, showDateSeparator) || other.showDateSeparator == showDateSeparator)&&(identical(other.designatedRegionSearchType, designatedRegionSearchType) || other.designatedRegionSearchType == designatedRegionSearchType)&&(identical(other.designatedRegionCode, designatedRegionCode) || other.designatedRegionCode == designatedRegionCode)&&(identical(other.designatedRegionName, designatedRegionName) || other.designatedRegionName == designatedRegionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFillBackground,showDateSeparator,designatedRegionSearchType,designatedRegionCode,designatedRegionName);

@override
String toString() {
  return 'EarthquakeHistoryListConfig(isFillBackground: $isFillBackground, showDateSeparator: $showDateSeparator, designatedRegionSearchType: $designatedRegionSearchType, designatedRegionCode: $designatedRegionCode, designatedRegionName: $designatedRegionName)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryListConfigCopyWith<$Res> implements $EarthquakeHistoryListConfigCopyWith<$Res> {
  factory _$EarthquakeHistoryListConfigCopyWith(_EarthquakeHistoryListConfig value, $Res Function(_EarthquakeHistoryListConfig) _then) = __$EarthquakeHistoryListConfigCopyWithImpl;
@override @useResult
$Res call({
 bool isFillBackground, bool showDateSeparator, RegionSearchType? designatedRegionSearchType, String? designatedRegionCode, String? designatedRegionName
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
@override @pragma('vm:prefer-inline') $Res call({Object? isFillBackground = null,Object? showDateSeparator = null,Object? designatedRegionSearchType = freezed,Object? designatedRegionCode = freezed,Object? designatedRegionName = freezed,}) {
  return _then(_EarthquakeHistoryListConfig(
isFillBackground: null == isFillBackground ? _self.isFillBackground : isFillBackground // ignore: cast_nullable_to_non_nullable
as bool,showDateSeparator: null == showDateSeparator ? _self.showDateSeparator : showDateSeparator // ignore: cast_nullable_to_non_nullable
as bool,designatedRegionSearchType: freezed == designatedRegionSearchType ? _self.designatedRegionSearchType : designatedRegionSearchType // ignore: cast_nullable_to_non_nullable
as RegionSearchType?,designatedRegionCode: freezed == designatedRegionCode ? _self.designatedRegionCode : designatedRegionCode // ignore: cast_nullable_to_non_nullable
as String?,designatedRegionName: freezed == designatedRegionName ? _self.designatedRegionName : designatedRegionName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EarthquakeHistoryDetailsConfig {

/// 観測点アイコンの表示モード
 StationDisplayMode get stationDisplayMode;
/// Create a copy of EarthquakeHistoryDetailsConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryDetailsConfigCopyWith<EarthquakeHistoryDetailsConfig> get copyWith => _$EarthquakeHistoryDetailsConfigCopyWithImpl<EarthquakeHistoryDetailsConfig>(this as EarthquakeHistoryDetailsConfig, _$identity);

  /// Serializes this EarthquakeHistoryDetailsConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryDetailsConfig&&(identical(other.stationDisplayMode, stationDisplayMode) || other.stationDisplayMode == stationDisplayMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stationDisplayMode);

@override
String toString() {
  return 'EarthquakeHistoryDetailsConfig(stationDisplayMode: $stationDisplayMode)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryDetailsConfigCopyWith<$Res>  {
  factory $EarthquakeHistoryDetailsConfigCopyWith(EarthquakeHistoryDetailsConfig value, $Res Function(EarthquakeHistoryDetailsConfig) _then) = _$EarthquakeHistoryDetailsConfigCopyWithImpl;
@useResult
$Res call({
 StationDisplayMode stationDisplayMode
});




}
/// @nodoc
class _$EarthquakeHistoryDetailsConfigCopyWithImpl<$Res>
    implements $EarthquakeHistoryDetailsConfigCopyWith<$Res> {
  _$EarthquakeHistoryDetailsConfigCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryDetailsConfig _self;
  final $Res Function(EarthquakeHistoryDetailsConfig) _then;

/// Create a copy of EarthquakeHistoryDetailsConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stationDisplayMode = null,}) {
  return _then(_self.copyWith(
stationDisplayMode: null == stationDisplayMode ? _self.stationDisplayMode : stationDisplayMode // ignore: cast_nullable_to_non_nullable
as StationDisplayMode,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeHistoryDetailsConfig].
extension EarthquakeHistoryDetailsConfigPatterns on EarthquakeHistoryDetailsConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeHistoryDetailsConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailsConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeHistoryDetailsConfig value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailsConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeHistoryDetailsConfig value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailsConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StationDisplayMode stationDisplayMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailsConfig() when $default != null:
return $default(_that.stationDisplayMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StationDisplayMode stationDisplayMode)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailsConfig():
return $default(_that.stationDisplayMode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StationDisplayMode stationDisplayMode)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryDetailsConfig() when $default != null:
return $default(_that.stationDisplayMode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeHistoryDetailsConfig implements EarthquakeHistoryDetailsConfig {
  const _EarthquakeHistoryDetailsConfig({this.stationDisplayMode = StationDisplayMode.auto});
  factory _EarthquakeHistoryDetailsConfig.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryDetailsConfigFromJson(json);

/// 観測点アイコンの表示モード
@override@JsonKey() final  StationDisplayMode stationDisplayMode;

/// Create a copy of EarthquakeHistoryDetailsConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHistoryDetailsConfigCopyWith<_EarthquakeHistoryDetailsConfig> get copyWith => __$EarthquakeHistoryDetailsConfigCopyWithImpl<_EarthquakeHistoryDetailsConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryDetailsConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryDetailsConfig&&(identical(other.stationDisplayMode, stationDisplayMode) || other.stationDisplayMode == stationDisplayMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stationDisplayMode);

@override
String toString() {
  return 'EarthquakeHistoryDetailsConfig(stationDisplayMode: $stationDisplayMode)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryDetailsConfigCopyWith<$Res> implements $EarthquakeHistoryDetailsConfigCopyWith<$Res> {
  factory _$EarthquakeHistoryDetailsConfigCopyWith(_EarthquakeHistoryDetailsConfig value, $Res Function(_EarthquakeHistoryDetailsConfig) _then) = __$EarthquakeHistoryDetailsConfigCopyWithImpl;
@override @useResult
$Res call({
 StationDisplayMode stationDisplayMode
});




}
/// @nodoc
class __$EarthquakeHistoryDetailsConfigCopyWithImpl<$Res>
    implements _$EarthquakeHistoryDetailsConfigCopyWith<$Res> {
  __$EarthquakeHistoryDetailsConfigCopyWithImpl(this._self, this._then);

  final _EarthquakeHistoryDetailsConfig _self;
  final $Res Function(_EarthquakeHistoryDetailsConfig) _then;

/// Create a copy of EarthquakeHistoryDetailsConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stationDisplayMode = null,}) {
  return _then(_EarthquakeHistoryDetailsConfig(
stationDisplayMode: null == stationDisplayMode ? _self.stationDisplayMode : stationDisplayMode // ignore: cast_nullable_to_non_nullable
as StationDisplayMode,
  ));
}


}

// dart format on

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_style_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapStyleConfig {

 MapStyleTheme get theme;@JsonKey(includeToJson: false, includeFromJson: false) MapStyleColorScheme? get colorScheme;@JsonKey(includeToJson: false, includeFromJson: false) String? get styleString;
/// Create a copy of MapStyleConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapStyleConfigCopyWith<MapStyleConfig> get copyWith => _$MapStyleConfigCopyWithImpl<MapStyleConfig>(this as MapStyleConfig, _$identity);

  /// Serializes this MapStyleConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapStyleConfig&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.colorScheme, colorScheme) || other.colorScheme == colorScheme)&&(identical(other.styleString, styleString) || other.styleString == styleString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,colorScheme,styleString);

@override
String toString() {
  return 'MapStyleConfig(theme: $theme, colorScheme: $colorScheme, styleString: $styleString)';
}


}

/// @nodoc
abstract mixin class $MapStyleConfigCopyWith<$Res>  {
  factory $MapStyleConfigCopyWith(MapStyleConfig value, $Res Function(MapStyleConfig) _then) = _$MapStyleConfigCopyWithImpl;
@useResult
$Res call({
 MapStyleTheme theme,@JsonKey(includeToJson: false, includeFromJson: false) MapStyleColorScheme? colorScheme,@JsonKey(includeToJson: false, includeFromJson: false) String? styleString
});


$MapStyleColorSchemeCopyWith<$Res>? get colorScheme;

}
/// @nodoc
class _$MapStyleConfigCopyWithImpl<$Res>
    implements $MapStyleConfigCopyWith<$Res> {
  _$MapStyleConfigCopyWithImpl(this._self, this._then);

  final MapStyleConfig _self;
  final $Res Function(MapStyleConfig) _then;

/// Create a copy of MapStyleConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? colorScheme = freezed,Object? styleString = freezed,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as MapStyleTheme,colorScheme: freezed == colorScheme ? _self.colorScheme : colorScheme // ignore: cast_nullable_to_non_nullable
as MapStyleColorScheme?,styleString: freezed == styleString ? _self.styleString : styleString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MapStyleConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapStyleColorSchemeCopyWith<$Res>? get colorScheme {
    if (_self.colorScheme == null) {
    return null;
  }

  return $MapStyleColorSchemeCopyWith<$Res>(_self.colorScheme!, (value) {
    return _then(_self.copyWith(colorScheme: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _MapStyleConfig implements MapStyleConfig {
  const _MapStyleConfig({required this.theme, @JsonKey(includeToJson: false, includeFromJson: false) this.colorScheme, @JsonKey(includeToJson: false, includeFromJson: false) this.styleString});
  factory _MapStyleConfig.fromJson(Map<String, dynamic> json) => _$MapStyleConfigFromJson(json);

@override final  MapStyleTheme theme;
@override@JsonKey(includeToJson: false, includeFromJson: false) final  MapStyleColorScheme? colorScheme;
@override@JsonKey(includeToJson: false, includeFromJson: false) final  String? styleString;

/// Create a copy of MapStyleConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapStyleConfigCopyWith<_MapStyleConfig> get copyWith => __$MapStyleConfigCopyWithImpl<_MapStyleConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapStyleConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapStyleConfig&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.colorScheme, colorScheme) || other.colorScheme == colorScheme)&&(identical(other.styleString, styleString) || other.styleString == styleString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,colorScheme,styleString);

@override
String toString() {
  return 'MapStyleConfig(theme: $theme, colorScheme: $colorScheme, styleString: $styleString)';
}


}

/// @nodoc
abstract mixin class _$MapStyleConfigCopyWith<$Res> implements $MapStyleConfigCopyWith<$Res> {
  factory _$MapStyleConfigCopyWith(_MapStyleConfig value, $Res Function(_MapStyleConfig) _then) = __$MapStyleConfigCopyWithImpl;
@override @useResult
$Res call({
 MapStyleTheme theme,@JsonKey(includeToJson: false, includeFromJson: false) MapStyleColorScheme? colorScheme,@JsonKey(includeToJson: false, includeFromJson: false) String? styleString
});


@override $MapStyleColorSchemeCopyWith<$Res>? get colorScheme;

}
/// @nodoc
class __$MapStyleConfigCopyWithImpl<$Res>
    implements _$MapStyleConfigCopyWith<$Res> {
  __$MapStyleConfigCopyWithImpl(this._self, this._then);

  final _MapStyleConfig _self;
  final $Res Function(_MapStyleConfig) _then;

/// Create a copy of MapStyleConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? colorScheme = freezed,Object? styleString = freezed,}) {
  return _then(_MapStyleConfig(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as MapStyleTheme,colorScheme: freezed == colorScheme ? _self.colorScheme : colorScheme // ignore: cast_nullable_to_non_nullable
as MapStyleColorScheme?,styleString: freezed == styleString ? _self.styleString : styleString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MapStyleConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapStyleColorSchemeCopyWith<$Res>? get colorScheme {
    if (_self.colorScheme == null) {
    return null;
  }

  return $MapStyleColorSchemeCopyWith<$Res>(_self.colorScheme!, (value) {
    return _then(_self.copyWith(colorScheme: value));
  });
}
}


/// @nodoc
mixin _$MapStyleColorScheme {

@ColorConverter() Color get backgroundColor;@ColorConverter() Color get landColor;@ColorConverter() Color get lineColor;@ColorConverter() Color get japanLandColor;@ColorConverter() Color get japanLineColor;
/// Create a copy of MapStyleColorScheme
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapStyleColorSchemeCopyWith<MapStyleColorScheme> get copyWith => _$MapStyleColorSchemeCopyWithImpl<MapStyleColorScheme>(this as MapStyleColorScheme, _$identity);

  /// Serializes this MapStyleColorScheme to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapStyleColorScheme&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.landColor, landColor) || other.landColor == landColor)&&(identical(other.lineColor, lineColor) || other.lineColor == lineColor)&&(identical(other.japanLandColor, japanLandColor) || other.japanLandColor == japanLandColor)&&(identical(other.japanLineColor, japanLineColor) || other.japanLineColor == japanLineColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,landColor,lineColor,japanLandColor,japanLineColor);

@override
String toString() {
  return 'MapStyleColorScheme(backgroundColor: $backgroundColor, landColor: $landColor, lineColor: $lineColor, japanLandColor: $japanLandColor, japanLineColor: $japanLineColor)';
}


}

/// @nodoc
abstract mixin class $MapStyleColorSchemeCopyWith<$Res>  {
  factory $MapStyleColorSchemeCopyWith(MapStyleColorScheme value, $Res Function(MapStyleColorScheme) _then) = _$MapStyleColorSchemeCopyWithImpl;
@useResult
$Res call({
@ColorConverter() Color backgroundColor,@ColorConverter() Color landColor,@ColorConverter() Color lineColor,@ColorConverter() Color japanLandColor,@ColorConverter() Color japanLineColor
});




}
/// @nodoc
class _$MapStyleColorSchemeCopyWithImpl<$Res>
    implements $MapStyleColorSchemeCopyWith<$Res> {
  _$MapStyleColorSchemeCopyWithImpl(this._self, this._then);

  final MapStyleColorScheme _self;
  final $Res Function(MapStyleColorScheme) _then;

/// Create a copy of MapStyleColorScheme
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = null,Object? landColor = null,Object? lineColor = null,Object? japanLandColor = null,Object? japanLineColor = null,}) {
  return _then(_self.copyWith(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color,landColor: null == landColor ? _self.landColor : landColor // ignore: cast_nullable_to_non_nullable
as Color,lineColor: null == lineColor ? _self.lineColor : lineColor // ignore: cast_nullable_to_non_nullable
as Color,japanLandColor: null == japanLandColor ? _self.japanLandColor : japanLandColor // ignore: cast_nullable_to_non_nullable
as Color,japanLineColor: null == japanLineColor ? _self.japanLineColor : japanLineColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MapStyleColorScheme implements MapStyleColorScheme {
  const _MapStyleColorScheme({@ColorConverter() required this.backgroundColor, @ColorConverter() required this.landColor, @ColorConverter() required this.lineColor, @ColorConverter() required this.japanLandColor, @ColorConverter() required this.japanLineColor});
  factory _MapStyleColorScheme.fromJson(Map<String, dynamic> json) => _$MapStyleColorSchemeFromJson(json);

@override@ColorConverter() final  Color backgroundColor;
@override@ColorConverter() final  Color landColor;
@override@ColorConverter() final  Color lineColor;
@override@ColorConverter() final  Color japanLandColor;
@override@ColorConverter() final  Color japanLineColor;

/// Create a copy of MapStyleColorScheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapStyleColorSchemeCopyWith<_MapStyleColorScheme> get copyWith => __$MapStyleColorSchemeCopyWithImpl<_MapStyleColorScheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapStyleColorSchemeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapStyleColorScheme&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.landColor, landColor) || other.landColor == landColor)&&(identical(other.lineColor, lineColor) || other.lineColor == lineColor)&&(identical(other.japanLandColor, japanLandColor) || other.japanLandColor == japanLandColor)&&(identical(other.japanLineColor, japanLineColor) || other.japanLineColor == japanLineColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,landColor,lineColor,japanLandColor,japanLineColor);

@override
String toString() {
  return 'MapStyleColorScheme(backgroundColor: $backgroundColor, landColor: $landColor, lineColor: $lineColor, japanLandColor: $japanLandColor, japanLineColor: $japanLineColor)';
}


}

/// @nodoc
abstract mixin class _$MapStyleColorSchemeCopyWith<$Res> implements $MapStyleColorSchemeCopyWith<$Res> {
  factory _$MapStyleColorSchemeCopyWith(_MapStyleColorScheme value, $Res Function(_MapStyleColorScheme) _then) = __$MapStyleColorSchemeCopyWithImpl;
@override @useResult
$Res call({
@ColorConverter() Color backgroundColor,@ColorConverter() Color landColor,@ColorConverter() Color lineColor,@ColorConverter() Color japanLandColor,@ColorConverter() Color japanLineColor
});




}
/// @nodoc
class __$MapStyleColorSchemeCopyWithImpl<$Res>
    implements _$MapStyleColorSchemeCopyWith<$Res> {
  __$MapStyleColorSchemeCopyWithImpl(this._self, this._then);

  final _MapStyleColorScheme _self;
  final $Res Function(_MapStyleColorScheme) _then;

/// Create a copy of MapStyleColorScheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backgroundColor = null,Object? landColor = null,Object? lineColor = null,Object? japanLandColor = null,Object? japanLineColor = null,}) {
  return _then(_MapStyleColorScheme(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color,landColor: null == landColor ? _self.landColor : landColor // ignore: cast_nullable_to_non_nullable
as Color,lineColor: null == lineColor ? _self.lineColor : lineColor // ignore: cast_nullable_to_non_nullable
as Color,japanLandColor: null == japanLandColor ? _self.japanLandColor : japanLandColor // ignore: cast_nullable_to_non_nullable
as Color,japanLineColor: null == japanLineColor ? _self.japanLineColor : japanLineColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on

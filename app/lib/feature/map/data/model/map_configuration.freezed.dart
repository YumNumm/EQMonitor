// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapConfiguration {

 MapTheme get theme;@JsonKey(includeToJson: false, includeFromJson: false) MapColorScheme? get colorScheme;@JsonKey(includeToJson: false, includeFromJson: false) String? get styleString;
/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapConfigurationCopyWith<MapConfiguration> get copyWith => _$MapConfigurationCopyWithImpl<MapConfiguration>(this as MapConfiguration, _$identity);

  /// Serializes this MapConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapConfiguration&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.colorScheme, colorScheme) || other.colorScheme == colorScheme)&&(identical(other.styleString, styleString) || other.styleString == styleString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,colorScheme,styleString);

@override
String toString() {
  return 'MapConfiguration(theme: $theme, colorScheme: $colorScheme, styleString: $styleString)';
}


}

/// @nodoc
abstract mixin class $MapConfigurationCopyWith<$Res>  {
  factory $MapConfigurationCopyWith(MapConfiguration value, $Res Function(MapConfiguration) _then) = _$MapConfigurationCopyWithImpl;
@useResult
$Res call({
 MapTheme theme,@JsonKey(includeToJson: false, includeFromJson: false) MapColorScheme? colorScheme,@JsonKey(includeToJson: false, includeFromJson: false) String? styleString
});


$MapColorSchemeCopyWith<$Res>? get colorScheme;

}
/// @nodoc
class _$MapConfigurationCopyWithImpl<$Res>
    implements $MapConfigurationCopyWith<$Res> {
  _$MapConfigurationCopyWithImpl(this._self, this._then);

  final MapConfiguration _self;
  final $Res Function(MapConfiguration) _then;

/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? colorScheme = freezed,Object? styleString = freezed,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as MapTheme,colorScheme: freezed == colorScheme ? _self.colorScheme : colorScheme // ignore: cast_nullable_to_non_nullable
as MapColorScheme?,styleString: freezed == styleString ? _self.styleString : styleString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapColorSchemeCopyWith<$Res>? get colorScheme {
    if (_self.colorScheme == null) {
    return null;
  }

  return $MapColorSchemeCopyWith<$Res>(_self.colorScheme!, (value) {
    return _then(_self.copyWith(colorScheme: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _MapConfiguration implements MapConfiguration {
  const _MapConfiguration({required this.theme, @JsonKey(includeToJson: false, includeFromJson: false) this.colorScheme, @JsonKey(includeToJson: false, includeFromJson: false) this.styleString});
  factory _MapConfiguration.fromJson(Map<String, dynamic> json) => _$MapConfigurationFromJson(json);

@override final  MapTheme theme;
@override@JsonKey(includeToJson: false, includeFromJson: false) final  MapColorScheme? colorScheme;
@override@JsonKey(includeToJson: false, includeFromJson: false) final  String? styleString;

/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapConfigurationCopyWith<_MapConfiguration> get copyWith => __$MapConfigurationCopyWithImpl<_MapConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapConfiguration&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.colorScheme, colorScheme) || other.colorScheme == colorScheme)&&(identical(other.styleString, styleString) || other.styleString == styleString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,colorScheme,styleString);

@override
String toString() {
  return 'MapConfiguration(theme: $theme, colorScheme: $colorScheme, styleString: $styleString)';
}


}

/// @nodoc
abstract mixin class _$MapConfigurationCopyWith<$Res> implements $MapConfigurationCopyWith<$Res> {
  factory _$MapConfigurationCopyWith(_MapConfiguration value, $Res Function(_MapConfiguration) _then) = __$MapConfigurationCopyWithImpl;
@override @useResult
$Res call({
 MapTheme theme,@JsonKey(includeToJson: false, includeFromJson: false) MapColorScheme? colorScheme,@JsonKey(includeToJson: false, includeFromJson: false) String? styleString
});


@override $MapColorSchemeCopyWith<$Res>? get colorScheme;

}
/// @nodoc
class __$MapConfigurationCopyWithImpl<$Res>
    implements _$MapConfigurationCopyWith<$Res> {
  __$MapConfigurationCopyWithImpl(this._self, this._then);

  final _MapConfiguration _self;
  final $Res Function(_MapConfiguration) _then;

/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? colorScheme = freezed,Object? styleString = freezed,}) {
  return _then(_MapConfiguration(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as MapTheme,colorScheme: freezed == colorScheme ? _self.colorScheme : colorScheme // ignore: cast_nullable_to_non_nullable
as MapColorScheme?,styleString: freezed == styleString ? _self.styleString : styleString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MapConfiguration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapColorSchemeCopyWith<$Res>? get colorScheme {
    if (_self.colorScheme == null) {
    return null;
  }

  return $MapColorSchemeCopyWith<$Res>(_self.colorScheme!, (value) {
    return _then(_self.copyWith(colorScheme: value));
  });
}
}


/// @nodoc
mixin _$MapColorScheme {

@ColorConverter() Color get backgroundColor;@ColorConverter() Color get worldLandColor;@ColorConverter() Color get worldLineColor;@ColorConverter() Color get japanLandColor;@ColorConverter() Color get japanLineColor;
/// Create a copy of MapColorScheme
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapColorSchemeCopyWith<MapColorScheme> get copyWith => _$MapColorSchemeCopyWithImpl<MapColorScheme>(this as MapColorScheme, _$identity);

  /// Serializes this MapColorScheme to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapColorScheme&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.worldLandColor, worldLandColor) || other.worldLandColor == worldLandColor)&&(identical(other.worldLineColor, worldLineColor) || other.worldLineColor == worldLineColor)&&(identical(other.japanLandColor, japanLandColor) || other.japanLandColor == japanLandColor)&&(identical(other.japanLineColor, japanLineColor) || other.japanLineColor == japanLineColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,worldLandColor,worldLineColor,japanLandColor,japanLineColor);

@override
String toString() {
  return 'MapColorScheme(backgroundColor: $backgroundColor, worldLandColor: $worldLandColor, worldLineColor: $worldLineColor, japanLandColor: $japanLandColor, japanLineColor: $japanLineColor)';
}


}

/// @nodoc
abstract mixin class $MapColorSchemeCopyWith<$Res>  {
  factory $MapColorSchemeCopyWith(MapColorScheme value, $Res Function(MapColorScheme) _then) = _$MapColorSchemeCopyWithImpl;
@useResult
$Res call({
@ColorConverter() Color backgroundColor,@ColorConverter() Color worldLandColor,@ColorConverter() Color worldLineColor,@ColorConverter() Color japanLandColor,@ColorConverter() Color japanLineColor
});




}
/// @nodoc
class _$MapColorSchemeCopyWithImpl<$Res>
    implements $MapColorSchemeCopyWith<$Res> {
  _$MapColorSchemeCopyWithImpl(this._self, this._then);

  final MapColorScheme _self;
  final $Res Function(MapColorScheme) _then;

/// Create a copy of MapColorScheme
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = null,Object? worldLandColor = null,Object? worldLineColor = null,Object? japanLandColor = null,Object? japanLineColor = null,}) {
  return _then(_self.copyWith(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color,worldLandColor: null == worldLandColor ? _self.worldLandColor : worldLandColor // ignore: cast_nullable_to_non_nullable
as Color,worldLineColor: null == worldLineColor ? _self.worldLineColor : worldLineColor // ignore: cast_nullable_to_non_nullable
as Color,japanLandColor: null == japanLandColor ? _self.japanLandColor : japanLandColor // ignore: cast_nullable_to_non_nullable
as Color,japanLineColor: null == japanLineColor ? _self.japanLineColor : japanLineColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MapColorScheme implements MapColorScheme {
  const _MapColorScheme({@ColorConverter() required this.backgroundColor, @ColorConverter() required this.worldLandColor, @ColorConverter() required this.worldLineColor, @ColorConverter() required this.japanLandColor, @ColorConverter() required this.japanLineColor});
  factory _MapColorScheme.fromJson(Map<String, dynamic> json) => _$MapColorSchemeFromJson(json);

@override@ColorConverter() final  Color backgroundColor;
@override@ColorConverter() final  Color worldLandColor;
@override@ColorConverter() final  Color worldLineColor;
@override@ColorConverter() final  Color japanLandColor;
@override@ColorConverter() final  Color japanLineColor;

/// Create a copy of MapColorScheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapColorSchemeCopyWith<_MapColorScheme> get copyWith => __$MapColorSchemeCopyWithImpl<_MapColorScheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapColorSchemeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapColorScheme&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.worldLandColor, worldLandColor) || other.worldLandColor == worldLandColor)&&(identical(other.worldLineColor, worldLineColor) || other.worldLineColor == worldLineColor)&&(identical(other.japanLandColor, japanLandColor) || other.japanLandColor == japanLandColor)&&(identical(other.japanLineColor, japanLineColor) || other.japanLineColor == japanLineColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,worldLandColor,worldLineColor,japanLandColor,japanLineColor);

@override
String toString() {
  return 'MapColorScheme(backgroundColor: $backgroundColor, worldLandColor: $worldLandColor, worldLineColor: $worldLineColor, japanLandColor: $japanLandColor, japanLineColor: $japanLineColor)';
}


}

/// @nodoc
abstract mixin class _$MapColorSchemeCopyWith<$Res> implements $MapColorSchemeCopyWith<$Res> {
  factory _$MapColorSchemeCopyWith(_MapColorScheme value, $Res Function(_MapColorScheme) _then) = __$MapColorSchemeCopyWithImpl;
@override @useResult
$Res call({
@ColorConverter() Color backgroundColor,@ColorConverter() Color worldLandColor,@ColorConverter() Color worldLineColor,@ColorConverter() Color japanLandColor,@ColorConverter() Color japanLineColor
});




}
/// @nodoc
class __$MapColorSchemeCopyWithImpl<$Res>
    implements _$MapColorSchemeCopyWith<$Res> {
  __$MapColorSchemeCopyWithImpl(this._self, this._then);

  final _MapColorScheme _self;
  final $Res Function(_MapColorScheme) _then;

/// Create a copy of MapColorScheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backgroundColor = null,Object? worldLandColor = null,Object? worldLineColor = null,Object? japanLandColor = null,Object? japanLineColor = null,}) {
  return _then(_MapColorScheme(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color,worldLandColor: null == worldLandColor ? _self.worldLandColor : worldLandColor // ignore: cast_nullable_to_non_nullable
as Color,worldLineColor: null == worldLineColor ? _self.worldLineColor : worldLineColor // ignore: cast_nullable_to_non_nullable
as Color,japanLandColor: null == japanLandColor ? _self.japanLandColor : japanLandColor // ignore: cast_nullable_to_non_nullable
as Color,japanLineColor: null == japanLineColor ? _self.japanLineColor : japanLineColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on

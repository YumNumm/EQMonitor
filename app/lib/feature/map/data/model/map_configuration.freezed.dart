// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MapConfiguration _$MapConfigurationFromJson(Map<String, dynamic> json) {
  return _MapConfiguration.fromJson(json);
}

/// @nodoc
mixin _$MapConfiguration {
  MapTheme get theme => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  MapColorScheme? get colorScheme => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? get styleString => throw _privateConstructorUsedError;

  /// Serializes this MapConfiguration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MapConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapConfigurationCopyWith<MapConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapConfigurationCopyWith<$Res> {
  factory $MapConfigurationCopyWith(
          MapConfiguration value, $Res Function(MapConfiguration) then) =
      _$MapConfigurationCopyWithImpl<$Res, MapConfiguration>;
  @useResult
  $Res call(
      {MapTheme theme,
      @JsonKey(includeToJson: false, includeFromJson: false)
      MapColorScheme? colorScheme,
      @JsonKey(includeToJson: false, includeFromJson: false)
      String? styleString});

  $MapColorSchemeCopyWith<$Res>? get colorScheme;
}

/// @nodoc
class _$MapConfigurationCopyWithImpl<$Res, $Val extends MapConfiguration>
    implements $MapConfigurationCopyWith<$Res> {
  _$MapConfigurationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? colorScheme = freezed,
    Object? styleString = freezed,
  }) {
    return _then(_value.copyWith(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as MapTheme,
      colorScheme: freezed == colorScheme
          ? _value.colorScheme
          : colorScheme // ignore: cast_nullable_to_non_nullable
              as MapColorScheme?,
      styleString: freezed == styleString
          ? _value.styleString
          : styleString // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of MapConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapColorSchemeCopyWith<$Res>? get colorScheme {
    if (_value.colorScheme == null) {
      return null;
    }

    return $MapColorSchemeCopyWith<$Res>(_value.colorScheme!, (value) {
      return _then(_value.copyWith(colorScheme: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MapConfigurationImplCopyWith<$Res>
    implements $MapConfigurationCopyWith<$Res> {
  factory _$$MapConfigurationImplCopyWith(_$MapConfigurationImpl value,
          $Res Function(_$MapConfigurationImpl) then) =
      __$$MapConfigurationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MapTheme theme,
      @JsonKey(includeToJson: false, includeFromJson: false)
      MapColorScheme? colorScheme,
      @JsonKey(includeToJson: false, includeFromJson: false)
      String? styleString});

  @override
  $MapColorSchemeCopyWith<$Res>? get colorScheme;
}

/// @nodoc
class __$$MapConfigurationImplCopyWithImpl<$Res>
    extends _$MapConfigurationCopyWithImpl<$Res, _$MapConfigurationImpl>
    implements _$$MapConfigurationImplCopyWith<$Res> {
  __$$MapConfigurationImplCopyWithImpl(_$MapConfigurationImpl _value,
      $Res Function(_$MapConfigurationImpl) _then)
      : super(_value, _then);

  /// Create a copy of MapConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? colorScheme = freezed,
    Object? styleString = freezed,
  }) {
    return _then(_$MapConfigurationImpl(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as MapTheme,
      colorScheme: freezed == colorScheme
          ? _value.colorScheme
          : colorScheme // ignore: cast_nullable_to_non_nullable
              as MapColorScheme?,
      styleString: freezed == styleString
          ? _value.styleString
          : styleString // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapConfigurationImpl implements _MapConfiguration {
  const _$MapConfigurationImpl(
      {required this.theme,
      @JsonKey(includeToJson: false, includeFromJson: false) this.colorScheme,
      @JsonKey(includeToJson: false, includeFromJson: false) this.styleString});

  factory _$MapConfigurationImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapConfigurationImplFromJson(json);

  @override
  final MapTheme theme;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final MapColorScheme? colorScheme;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final String? styleString;

  @override
  String toString() {
    return 'MapConfiguration(theme: $theme, colorScheme: $colorScheme, styleString: $styleString)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapConfigurationImpl &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.colorScheme, colorScheme) ||
                other.colorScheme == colorScheme) &&
            (identical(other.styleString, styleString) ||
                other.styleString == styleString));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, theme, colorScheme, styleString);

  /// Create a copy of MapConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapConfigurationImplCopyWith<_$MapConfigurationImpl> get copyWith =>
      __$$MapConfigurationImplCopyWithImpl<_$MapConfigurationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapConfigurationImplToJson(
      this,
    );
  }
}

abstract class _MapConfiguration implements MapConfiguration {
  const factory _MapConfiguration(
      {required final MapTheme theme,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final MapColorScheme? colorScheme,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final String? styleString}) = _$MapConfigurationImpl;

  factory _MapConfiguration.fromJson(Map<String, dynamic> json) =
      _$MapConfigurationImpl.fromJson;

  @override
  MapTheme get theme;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  MapColorScheme? get colorScheme;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? get styleString;

  /// Create a copy of MapConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapConfigurationImplCopyWith<_$MapConfigurationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MapColorScheme _$MapColorSchemeFromJson(Map<String, dynamic> json) {
  return _MapColorScheme.fromJson(json);
}

/// @nodoc
mixin _$MapColorScheme {
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get backgroundColor => throw _privateConstructorUsedError;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get worldLandColor => throw _privateConstructorUsedError;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get worldLineColor => throw _privateConstructorUsedError;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get japanLandColor => throw _privateConstructorUsedError;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get japanLineColor => throw _privateConstructorUsedError;

  /// Serializes this MapColorScheme to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MapColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapColorSchemeCopyWith<MapColorScheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapColorSchemeCopyWith<$Res> {
  factory $MapColorSchemeCopyWith(
          MapColorScheme value, $Res Function(MapColorScheme) then) =
      _$MapColorSchemeCopyWithImpl<$Res, MapColorScheme>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color backgroundColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color worldLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color worldLineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color japanLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color japanLineColor});
}

/// @nodoc
class _$MapColorSchemeCopyWithImpl<$Res, $Val extends MapColorScheme>
    implements $MapColorSchemeCopyWith<$Res> {
  _$MapColorSchemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? worldLandColor = null,
    Object? worldLineColor = null,
    Object? japanLandColor = null,
    Object? japanLineColor = null,
  }) {
    return _then(_value.copyWith(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      worldLandColor: null == worldLandColor
          ? _value.worldLandColor
          : worldLandColor // ignore: cast_nullable_to_non_nullable
              as Color,
      worldLineColor: null == worldLineColor
          ? _value.worldLineColor
          : worldLineColor // ignore: cast_nullable_to_non_nullable
              as Color,
      japanLandColor: null == japanLandColor
          ? _value.japanLandColor
          : japanLandColor // ignore: cast_nullable_to_non_nullable
              as Color,
      japanLineColor: null == japanLineColor
          ? _value.japanLineColor
          : japanLineColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapColorSchemeImplCopyWith<$Res>
    implements $MapColorSchemeCopyWith<$Res> {
  factory _$$MapColorSchemeImplCopyWith(_$MapColorSchemeImpl value,
          $Res Function(_$MapColorSchemeImpl) then) =
      __$$MapColorSchemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color backgroundColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color worldLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color worldLineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color japanLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color japanLineColor});
}

/// @nodoc
class __$$MapColorSchemeImplCopyWithImpl<$Res>
    extends _$MapColorSchemeCopyWithImpl<$Res, _$MapColorSchemeImpl>
    implements _$$MapColorSchemeImplCopyWith<$Res> {
  __$$MapColorSchemeImplCopyWithImpl(
      _$MapColorSchemeImpl _value, $Res Function(_$MapColorSchemeImpl) _then)
      : super(_value, _then);

  /// Create a copy of MapColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? worldLandColor = null,
    Object? worldLineColor = null,
    Object? japanLandColor = null,
    Object? japanLineColor = null,
  }) {
    return _then(_$MapColorSchemeImpl(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      worldLandColor: null == worldLandColor
          ? _value.worldLandColor
          : worldLandColor // ignore: cast_nullable_to_non_nullable
              as Color,
      worldLineColor: null == worldLineColor
          ? _value.worldLineColor
          : worldLineColor // ignore: cast_nullable_to_non_nullable
              as Color,
      japanLandColor: null == japanLandColor
          ? _value.japanLandColor
          : japanLandColor // ignore: cast_nullable_to_non_nullable
              as Color,
      japanLineColor: null == japanLineColor
          ? _value.japanLineColor
          : japanLineColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapColorSchemeImpl implements _MapColorScheme {
  const _$MapColorSchemeImpl(
      {@JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required this.backgroundColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required this.worldLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required this.worldLineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required this.japanLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required this.japanLineColor});

  factory _$MapColorSchemeImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapColorSchemeImplFromJson(json);

  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color backgroundColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color worldLandColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color worldLineColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color japanLandColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color japanLineColor;

  @override
  String toString() {
    return 'MapColorScheme(backgroundColor: $backgroundColor, worldLandColor: $worldLandColor, worldLineColor: $worldLineColor, japanLandColor: $japanLandColor, japanLineColor: $japanLineColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapColorSchemeImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.worldLandColor, worldLandColor) ||
                other.worldLandColor == worldLandColor) &&
            (identical(other.worldLineColor, worldLineColor) ||
                other.worldLineColor == worldLineColor) &&
            (identical(other.japanLandColor, japanLandColor) ||
                other.japanLandColor == japanLandColor) &&
            (identical(other.japanLineColor, japanLineColor) ||
                other.japanLineColor == japanLineColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, backgroundColor, worldLandColor,
      worldLineColor, japanLandColor, japanLineColor);

  /// Create a copy of MapColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapColorSchemeImplCopyWith<_$MapColorSchemeImpl> get copyWith =>
      __$$MapColorSchemeImplCopyWithImpl<_$MapColorSchemeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapColorSchemeImplToJson(
      this,
    );
  }
}

abstract class _MapColorScheme implements MapColorScheme {
  const factory _MapColorScheme(
      {@JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required final Color backgroundColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required final Color worldLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required final Color worldLineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required final Color japanLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required final Color japanLineColor}) = _$MapColorSchemeImpl;

  factory _MapColorScheme.fromJson(Map<String, dynamic> json) =
      _$MapColorSchemeImpl.fromJson;

  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get backgroundColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get worldLandColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get worldLineColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get japanLandColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get japanLineColor;

  /// Create a copy of MapColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapColorSchemeImplCopyWith<_$MapColorSchemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

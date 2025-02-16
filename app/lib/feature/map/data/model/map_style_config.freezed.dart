// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_style_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MapStyleConfig _$MapStyleConfigFromJson(
  Map<String, dynamic> json,
) {
  return _MapStyleConfig.fromJson(json);
}

/// @nodoc
mixin _$MapStyleConfig {
  MapStyleTheme get theme =>
      throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  MapStyleColorScheme? get colorScheme =>
      throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? get styleString =>
      throw _privateConstructorUsedError;

  /// Serializes this MapStyleConfig to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of MapStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapStyleConfigCopyWith<MapStyleConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapStyleConfigCopyWith<$Res> {
  factory $MapStyleConfigCopyWith(
    MapStyleConfig value,
    $Res Function(MapStyleConfig) then,
  ) = _$MapStyleConfigCopyWithImpl<$Res, MapStyleConfig>;
  @useResult
  $Res call({
    MapStyleTheme theme,
    @JsonKey(includeToJson: false, includeFromJson: false)
    MapStyleColorScheme? colorScheme,
    @JsonKey(includeToJson: false, includeFromJson: false)
    String? styleString,
  });

  $MapStyleColorSchemeCopyWith<$Res>? get colorScheme;
}

/// @nodoc
class _$MapStyleConfigCopyWithImpl<
  $Res,
  $Val extends MapStyleConfig
>
    implements $MapStyleConfigCopyWith<$Res> {
  _$MapStyleConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? colorScheme = freezed,
    Object? styleString = freezed,
  }) {
    return _then(
      _value.copyWith(
            theme:
                null == theme
                    ? _value.theme
                    : theme // ignore: cast_nullable_to_non_nullable
                        as MapStyleTheme,
            colorScheme:
                freezed == colorScheme
                    ? _value.colorScheme
                    : colorScheme // ignore: cast_nullable_to_non_nullable
                        as MapStyleColorScheme?,
            styleString:
                freezed == styleString
                    ? _value.styleString
                    : styleString // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of MapStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapStyleColorSchemeCopyWith<$Res>? get colorScheme {
    if (_value.colorScheme == null) {
      return null;
    }

    return $MapStyleColorSchemeCopyWith<$Res>(
      _value.colorScheme!,
      (value) {
        return _then(
          _value.copyWith(colorScheme: value) as $Val,
        );
      },
    );
  }
}

/// @nodoc
abstract class _$$MapStyleConfigImplCopyWith<$Res>
    implements $MapStyleConfigCopyWith<$Res> {
  factory _$$MapStyleConfigImplCopyWith(
    _$MapStyleConfigImpl value,
    $Res Function(_$MapStyleConfigImpl) then,
  ) = __$$MapStyleConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    MapStyleTheme theme,
    @JsonKey(includeToJson: false, includeFromJson: false)
    MapStyleColorScheme? colorScheme,
    @JsonKey(includeToJson: false, includeFromJson: false)
    String? styleString,
  });

  @override
  $MapStyleColorSchemeCopyWith<$Res>? get colorScheme;
}

/// @nodoc
class __$$MapStyleConfigImplCopyWithImpl<$Res>
    extends
        _$MapStyleConfigCopyWithImpl<
          $Res,
          _$MapStyleConfigImpl
        >
    implements _$$MapStyleConfigImplCopyWith<$Res> {
  __$$MapStyleConfigImplCopyWithImpl(
    _$MapStyleConfigImpl _value,
    $Res Function(_$MapStyleConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? colorScheme = freezed,
    Object? styleString = freezed,
  }) {
    return _then(
      _$MapStyleConfigImpl(
        theme:
            null == theme
                ? _value.theme
                : theme // ignore: cast_nullable_to_non_nullable
                    as MapStyleTheme,
        colorScheme:
            freezed == colorScheme
                ? _value.colorScheme
                : colorScheme // ignore: cast_nullable_to_non_nullable
                    as MapStyleColorScheme?,
        styleString:
            freezed == styleString
                ? _value.styleString
                : styleString // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MapStyleConfigImpl implements _MapStyleConfig {
  const _$MapStyleConfigImpl({
    required this.theme,
    @JsonKey(includeToJson: false, includeFromJson: false)
    this.colorScheme,
    @JsonKey(includeToJson: false, includeFromJson: false)
    this.styleString,
  });

  factory _$MapStyleConfigImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$MapStyleConfigImplFromJson(json);

  @override
  final MapStyleTheme theme;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final MapStyleColorScheme? colorScheme;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final String? styleString;

  @override
  String toString() {
    return 'MapStyleConfig(theme: $theme, colorScheme: $colorScheme, styleString: $styleString)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapStyleConfigImpl &&
            (identical(other.theme, theme) ||
                other.theme == theme) &&
            (identical(other.colorScheme, colorScheme) ||
                other.colorScheme == colorScheme) &&
            (identical(other.styleString, styleString) ||
                other.styleString == styleString));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    theme,
    colorScheme,
    styleString,
  );

  /// Create a copy of MapStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapStyleConfigImplCopyWith<_$MapStyleConfigImpl>
  get copyWith => __$$MapStyleConfigImplCopyWithImpl<
    _$MapStyleConfigImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapStyleConfigImplToJson(this);
  }
}

abstract class _MapStyleConfig implements MapStyleConfig {
  const factory _MapStyleConfig({
    required final MapStyleTheme theme,
    @JsonKey(includeToJson: false, includeFromJson: false)
    final MapStyleColorScheme? colorScheme,
    @JsonKey(includeToJson: false, includeFromJson: false)
    final String? styleString,
  }) = _$MapStyleConfigImpl;

  factory _MapStyleConfig.fromJson(
    Map<String, dynamic> json,
  ) = _$MapStyleConfigImpl.fromJson;

  @override
  MapStyleTheme get theme;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  MapStyleColorScheme? get colorScheme;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? get styleString;

  /// Create a copy of MapStyleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapStyleConfigImplCopyWith<_$MapStyleConfigImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MapStyleColorScheme _$MapStyleColorSchemeFromJson(
  Map<String, dynamic> json,
) {
  return _MapStyleColorScheme.fromJson(json);
}

/// @nodoc
mixin _$MapStyleColorScheme {
  @ColorConverter()
  Color get backgroundColor =>
      throw _privateConstructorUsedError;
  @ColorConverter()
  Color get landColor => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get lineColor => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get japanLandColor =>
      throw _privateConstructorUsedError;
  @ColorConverter()
  Color get japanLineColor =>
      throw _privateConstructorUsedError;

  /// Serializes this MapStyleColorScheme to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of MapStyleColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapStyleColorSchemeCopyWith<MapStyleColorScheme>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapStyleColorSchemeCopyWith<$Res> {
  factory $MapStyleColorSchemeCopyWith(
    MapStyleColorScheme value,
    $Res Function(MapStyleColorScheme) then,
  ) =
      _$MapStyleColorSchemeCopyWithImpl<
        $Res,
        MapStyleColorScheme
      >;
  @useResult
  $Res call({
    @ColorConverter() Color backgroundColor,
    @ColorConverter() Color landColor,
    @ColorConverter() Color lineColor,
    @ColorConverter() Color japanLandColor,
    @ColorConverter() Color japanLineColor,
  });
}

/// @nodoc
class _$MapStyleColorSchemeCopyWithImpl<
  $Res,
  $Val extends MapStyleColorScheme
>
    implements $MapStyleColorSchemeCopyWith<$Res> {
  _$MapStyleColorSchemeCopyWithImpl(
    this._value,
    this._then,
  );

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapStyleColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? landColor = null,
    Object? lineColor = null,
    Object? japanLandColor = null,
    Object? japanLineColor = null,
  }) {
    return _then(
      _value.copyWith(
            backgroundColor:
                null == backgroundColor
                    ? _value.backgroundColor
                    : backgroundColor // ignore: cast_nullable_to_non_nullable
                        as Color,
            landColor:
                null == landColor
                    ? _value.landColor
                    : landColor // ignore: cast_nullable_to_non_nullable
                        as Color,
            lineColor:
                null == lineColor
                    ? _value.lineColor
                    : lineColor // ignore: cast_nullable_to_non_nullable
                        as Color,
            japanLandColor:
                null == japanLandColor
                    ? _value.japanLandColor
                    : japanLandColor // ignore: cast_nullable_to_non_nullable
                        as Color,
            japanLineColor:
                null == japanLineColor
                    ? _value.japanLineColor
                    : japanLineColor // ignore: cast_nullable_to_non_nullable
                        as Color,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MapStyleColorSchemeImplCopyWith<$Res>
    implements $MapStyleColorSchemeCopyWith<$Res> {
  factory _$$MapStyleColorSchemeImplCopyWith(
    _$MapStyleColorSchemeImpl value,
    $Res Function(_$MapStyleColorSchemeImpl) then,
  ) = __$$MapStyleColorSchemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @ColorConverter() Color backgroundColor,
    @ColorConverter() Color landColor,
    @ColorConverter() Color lineColor,
    @ColorConverter() Color japanLandColor,
    @ColorConverter() Color japanLineColor,
  });
}

/// @nodoc
class __$$MapStyleColorSchemeImplCopyWithImpl<$Res>
    extends
        _$MapStyleColorSchemeCopyWithImpl<
          $Res,
          _$MapStyleColorSchemeImpl
        >
    implements _$$MapStyleColorSchemeImplCopyWith<$Res> {
  __$$MapStyleColorSchemeImplCopyWithImpl(
    _$MapStyleColorSchemeImpl _value,
    $Res Function(_$MapStyleColorSchemeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapStyleColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? landColor = null,
    Object? lineColor = null,
    Object? japanLandColor = null,
    Object? japanLineColor = null,
  }) {
    return _then(
      _$MapStyleColorSchemeImpl(
        backgroundColor:
            null == backgroundColor
                ? _value.backgroundColor
                : backgroundColor // ignore: cast_nullable_to_non_nullable
                    as Color,
        landColor:
            null == landColor
                ? _value.landColor
                : landColor // ignore: cast_nullable_to_non_nullable
                    as Color,
        lineColor:
            null == lineColor
                ? _value.lineColor
                : lineColor // ignore: cast_nullable_to_non_nullable
                    as Color,
        japanLandColor:
            null == japanLandColor
                ? _value.japanLandColor
                : japanLandColor // ignore: cast_nullable_to_non_nullable
                    as Color,
        japanLineColor:
            null == japanLineColor
                ? _value.japanLineColor
                : japanLineColor // ignore: cast_nullable_to_non_nullable
                    as Color,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MapStyleColorSchemeImpl
    implements _MapStyleColorScheme {
  const _$MapStyleColorSchemeImpl({
    @ColorConverter() required this.backgroundColor,
    @ColorConverter() required this.landColor,
    @ColorConverter() required this.lineColor,
    @ColorConverter() required this.japanLandColor,
    @ColorConverter() required this.japanLineColor,
  });

  factory _$MapStyleColorSchemeImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$MapStyleColorSchemeImplFromJson(json);

  @override
  @ColorConverter()
  final Color backgroundColor;
  @override
  @ColorConverter()
  final Color landColor;
  @override
  @ColorConverter()
  final Color lineColor;
  @override
  @ColorConverter()
  final Color japanLandColor;
  @override
  @ColorConverter()
  final Color japanLineColor;

  @override
  String toString() {
    return 'MapStyleColorScheme(backgroundColor: $backgroundColor, landColor: $landColor, lineColor: $lineColor, japanLandColor: $japanLandColor, japanLineColor: $japanLineColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapStyleColorSchemeImpl &&
            (identical(
                  other.backgroundColor,
                  backgroundColor,
                ) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.landColor, landColor) ||
                other.landColor == landColor) &&
            (identical(other.lineColor, lineColor) ||
                other.lineColor == lineColor) &&
            (identical(
                  other.japanLandColor,
                  japanLandColor,
                ) ||
                other.japanLandColor == japanLandColor) &&
            (identical(
                  other.japanLineColor,
                  japanLineColor,
                ) ||
                other.japanLineColor == japanLineColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    backgroundColor,
    landColor,
    lineColor,
    japanLandColor,
    japanLineColor,
  );

  /// Create a copy of MapStyleColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapStyleColorSchemeImplCopyWith<
    _$MapStyleColorSchemeImpl
  >
  get copyWith => __$$MapStyleColorSchemeImplCopyWithImpl<
    _$MapStyleColorSchemeImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapStyleColorSchemeImplToJson(this);
  }
}

abstract class _MapStyleColorScheme
    implements MapStyleColorScheme {
  const factory _MapStyleColorScheme({
    @ColorConverter() required final Color backgroundColor,
    @ColorConverter() required final Color landColor,
    @ColorConverter() required final Color lineColor,
    @ColorConverter() required final Color japanLandColor,
    @ColorConverter() required final Color japanLineColor,
  }) = _$MapStyleColorSchemeImpl;

  factory _MapStyleColorScheme.fromJson(
    Map<String, dynamic> json,
  ) = _$MapStyleColorSchemeImpl.fromJson;

  @override
  @ColorConverter()
  Color get backgroundColor;
  @override
  @ColorConverter()
  Color get landColor;
  @override
  @ColorConverter()
  Color get lineColor;
  @override
  @ColorConverter()
  Color get japanLandColor;
  @override
  @ColorConverter()
  Color get japanLineColor;

  /// Create a copy of MapStyleColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapStyleColorSchemeImplCopyWith<
    _$MapStyleColorSchemeImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

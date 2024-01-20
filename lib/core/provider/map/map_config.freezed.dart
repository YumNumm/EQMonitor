// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MapConfig _$MapConfigFromJson(Map<String, dynamic> json) {
  return _MapConfig.fromJson(json);
}

/// @nodoc
mixin _$MapConfig {
  double get minScale => throw _privateConstructorUsedError;
  double get maxScale => throw _privateConstructorUsedError;
  MapColorScheme get colorScheme => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapConfigCopyWith<MapConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapConfigCopyWith<$Res> {
  factory $MapConfigCopyWith(MapConfig value, $Res Function(MapConfig) then) =
      _$MapConfigCopyWithImpl<$Res, MapConfig>;
  @useResult
  $Res call({double minScale, double maxScale, MapColorScheme colorScheme});

  $MapColorSchemeCopyWith<$Res> get colorScheme;
}

/// @nodoc
class _$MapConfigCopyWithImpl<$Res, $Val extends MapConfig>
    implements $MapConfigCopyWith<$Res> {
  _$MapConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minScale = null,
    Object? maxScale = null,
    Object? colorScheme = null,
  }) {
    return _then(_value.copyWith(
      minScale: null == minScale
          ? _value.minScale
          : minScale // ignore: cast_nullable_to_non_nullable
              as double,
      maxScale: null == maxScale
          ? _value.maxScale
          : maxScale // ignore: cast_nullable_to_non_nullable
              as double,
      colorScheme: null == colorScheme
          ? _value.colorScheme
          : colorScheme // ignore: cast_nullable_to_non_nullable
              as MapColorScheme,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MapColorSchemeCopyWith<$Res> get colorScheme {
    return $MapColorSchemeCopyWith<$Res>(_value.colorScheme, (value) {
      return _then(_value.copyWith(colorScheme: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MapConfigImplCopyWith<$Res>
    implements $MapConfigCopyWith<$Res> {
  factory _$$MapConfigImplCopyWith(
          _$MapConfigImpl value, $Res Function(_$MapConfigImpl) then) =
      __$$MapConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double minScale, double maxScale, MapColorScheme colorScheme});

  @override
  $MapColorSchemeCopyWith<$Res> get colorScheme;
}

/// @nodoc
class __$$MapConfigImplCopyWithImpl<$Res>
    extends _$MapConfigCopyWithImpl<$Res, _$MapConfigImpl>
    implements _$$MapConfigImplCopyWith<$Res> {
  __$$MapConfigImplCopyWithImpl(
      _$MapConfigImpl _value, $Res Function(_$MapConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minScale = null,
    Object? maxScale = null,
    Object? colorScheme = null,
  }) {
    return _then(_$MapConfigImpl(
      minScale: null == minScale
          ? _value.minScale
          : minScale // ignore: cast_nullable_to_non_nullable
              as double,
      maxScale: null == maxScale
          ? _value.maxScale
          : maxScale // ignore: cast_nullable_to_non_nullable
              as double,
      colorScheme: null == colorScheme
          ? _value.colorScheme
          : colorScheme // ignore: cast_nullable_to_non_nullable
              as MapColorScheme,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapConfigImpl implements _MapConfig {
  const _$MapConfigImpl(
      {this.minScale = 0.8, this.maxScale = 20, required this.colorScheme});

  factory _$MapConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapConfigImplFromJson(json);

  @override
  @JsonKey()
  final double minScale;
  @override
  @JsonKey()
  final double maxScale;
  @override
  final MapColorScheme colorScheme;

  @override
  String toString() {
    return 'MapConfig(minScale: $minScale, maxScale: $maxScale, colorScheme: $colorScheme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapConfigImpl &&
            (identical(other.minScale, minScale) ||
                other.minScale == minScale) &&
            (identical(other.maxScale, maxScale) ||
                other.maxScale == maxScale) &&
            (identical(other.colorScheme, colorScheme) ||
                other.colorScheme == colorScheme));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, minScale, maxScale, colorScheme);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapConfigImplCopyWith<_$MapConfigImpl> get copyWith =>
      __$$MapConfigImplCopyWithImpl<_$MapConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapConfigImplToJson(
      this,
    );
  }
}

abstract class _MapConfig implements MapConfig {
  const factory _MapConfig(
      {final double minScale,
      final double maxScale,
      required final MapColorScheme colorScheme}) = _$MapConfigImpl;

  factory _MapConfig.fromJson(Map<String, dynamic> json) =
      _$MapConfigImpl.fromJson;

  @override
  double get minScale;
  @override
  double get maxScale;
  @override
  MapColorScheme get colorScheme;
  @override
  @JsonKey(ignore: true)
  _$$MapConfigImplCopyWith<_$MapConfigImpl> get copyWith =>
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
  Color get worldCoastlineColor => throw _privateConstructorUsedError;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get worldBorderLineColor => throw _privateConstructorUsedError;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get japanLandColor => throw _privateConstructorUsedError;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get japanCoastlineColor => throw _privateConstructorUsedError;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get japanBorderLineColor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      Color worldCoastlineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color worldBorderLineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color japanLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color japanCoastlineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color japanBorderLineColor});
}

/// @nodoc
class _$MapColorSchemeCopyWithImpl<$Res, $Val extends MapColorScheme>
    implements $MapColorSchemeCopyWith<$Res> {
  _$MapColorSchemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? worldLandColor = null,
    Object? worldCoastlineColor = null,
    Object? worldBorderLineColor = null,
    Object? japanLandColor = null,
    Object? japanCoastlineColor = null,
    Object? japanBorderLineColor = null,
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
      worldCoastlineColor: null == worldCoastlineColor
          ? _value.worldCoastlineColor
          : worldCoastlineColor // ignore: cast_nullable_to_non_nullable
              as Color,
      worldBorderLineColor: null == worldBorderLineColor
          ? _value.worldBorderLineColor
          : worldBorderLineColor // ignore: cast_nullable_to_non_nullable
              as Color,
      japanLandColor: null == japanLandColor
          ? _value.japanLandColor
          : japanLandColor // ignore: cast_nullable_to_non_nullable
              as Color,
      japanCoastlineColor: null == japanCoastlineColor
          ? _value.japanCoastlineColor
          : japanCoastlineColor // ignore: cast_nullable_to_non_nullable
              as Color,
      japanBorderLineColor: null == japanBorderLineColor
          ? _value.japanBorderLineColor
          : japanBorderLineColor // ignore: cast_nullable_to_non_nullable
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
      Color worldCoastlineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color worldBorderLineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color japanLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color japanCoastlineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      Color japanBorderLineColor});
}

/// @nodoc
class __$$MapColorSchemeImplCopyWithImpl<$Res>
    extends _$MapColorSchemeCopyWithImpl<$Res, _$MapColorSchemeImpl>
    implements _$$MapColorSchemeImplCopyWith<$Res> {
  __$$MapColorSchemeImplCopyWithImpl(
      _$MapColorSchemeImpl _value, $Res Function(_$MapColorSchemeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? worldLandColor = null,
    Object? worldCoastlineColor = null,
    Object? worldBorderLineColor = null,
    Object? japanLandColor = null,
    Object? japanCoastlineColor = null,
    Object? japanBorderLineColor = null,
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
      worldCoastlineColor: null == worldCoastlineColor
          ? _value.worldCoastlineColor
          : worldCoastlineColor // ignore: cast_nullable_to_non_nullable
              as Color,
      worldBorderLineColor: null == worldBorderLineColor
          ? _value.worldBorderLineColor
          : worldBorderLineColor // ignore: cast_nullable_to_non_nullable
              as Color,
      japanLandColor: null == japanLandColor
          ? _value.japanLandColor
          : japanLandColor // ignore: cast_nullable_to_non_nullable
              as Color,
      japanCoastlineColor: null == japanCoastlineColor
          ? _value.japanCoastlineColor
          : japanCoastlineColor // ignore: cast_nullable_to_non_nullable
              as Color,
      japanBorderLineColor: null == japanBorderLineColor
          ? _value.japanBorderLineColor
          : japanBorderLineColor // ignore: cast_nullable_to_non_nullable
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
      required this.worldCoastlineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required this.worldBorderLineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required this.japanLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required this.japanCoastlineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required this.japanBorderLineColor});

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
  final Color worldCoastlineColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color worldBorderLineColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color japanLandColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color japanCoastlineColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color japanBorderLineColor;

  @override
  String toString() {
    return 'MapColorScheme(backgroundColor: $backgroundColor, worldLandColor: $worldLandColor, worldCoastlineColor: $worldCoastlineColor, worldBorderLineColor: $worldBorderLineColor, japanLandColor: $japanLandColor, japanCoastlineColor: $japanCoastlineColor, japanBorderLineColor: $japanBorderLineColor)';
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
            (identical(other.worldCoastlineColor, worldCoastlineColor) ||
                other.worldCoastlineColor == worldCoastlineColor) &&
            (identical(other.worldBorderLineColor, worldBorderLineColor) ||
                other.worldBorderLineColor == worldBorderLineColor) &&
            (identical(other.japanLandColor, japanLandColor) ||
                other.japanLandColor == japanLandColor) &&
            (identical(other.japanCoastlineColor, japanCoastlineColor) ||
                other.japanCoastlineColor == japanCoastlineColor) &&
            (identical(other.japanBorderLineColor, japanBorderLineColor) ||
                other.japanBorderLineColor == japanBorderLineColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      backgroundColor,
      worldLandColor,
      worldCoastlineColor,
      worldBorderLineColor,
      japanLandColor,
      japanCoastlineColor,
      japanBorderLineColor);

  @JsonKey(ignore: true)
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
      required final Color worldCoastlineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required final Color worldBorderLineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required final Color japanLandColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required final Color japanCoastlineColor,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required final Color japanBorderLineColor}) = _$MapColorSchemeImpl;

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
  Color get worldCoastlineColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get worldBorderLineColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get japanLandColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get japanCoastlineColor;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get japanBorderLineColor;
  @override
  @JsonKey(ignore: true)
  _$$MapColorSchemeImplCopyWith<_$MapColorSchemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

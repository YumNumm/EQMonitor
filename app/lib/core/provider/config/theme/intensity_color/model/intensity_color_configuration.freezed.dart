// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_color_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IntensityColorConfiguration _$IntensityColorConfigurationFromJson(Map<String, dynamic> json) {
  return _IntensityColorConfiguration.fromJson(json);
}

/// @nodoc
mixin _$IntensityColorConfiguration {
  IntensityColorSchemeType get schemeType => throw _privateConstructorUsedError;
  IntensityColorModel? get customColors => throw _privateConstructorUsedError;

  /// Serializes this IntensityColorConfiguration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntensityColorConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntensityColorConfigurationCopyWith<IntensityColorConfiguration> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntensityColorConfigurationCopyWith<$Res> {
  factory $IntensityColorConfigurationCopyWith(IntensityColorConfiguration value, $Res Function(IntensityColorConfiguration) then) =
      _$IntensityColorConfigurationCopyWithImpl<$Res, IntensityColorConfiguration>;
  @useResult
  $Res call({IntensityColorSchemeType schemeType, IntensityColorModel? customColors});

  $IntensityColorSchemeTypeCopyWith<$Res> get schemeType;
  $IntensityColorModelCopyWith<$Res>? get customColors;
}

/// @nodoc
class _$IntensityColorConfigurationCopyWithImpl<$Res, $Val extends IntensityColorConfiguration>
    implements $IntensityColorConfigurationCopyWith<$Res> {
  _$IntensityColorConfigurationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntensityColorConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schemeType = null,
    Object? customColors = freezed,
  }) {
    return _then(_value.copyWith(
      schemeType: null == schemeType
          ? _value.schemeType
          : schemeType // ignore: cast_nullable_to_non_nullable
              as IntensityColorSchemeType,
      customColors: freezed == customColors
          ? _value.customColors
          : customColors // ignore: cast_nullable_to_non_nullable
              as IntensityColorModel?,
    ) as $Val);
  }

  /// Create a copy of IntensityColorConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntensityColorSchemeTypeCopyWith<$Res> get schemeType {
    return $IntensityColorSchemeTypeCopyWith<$Res>(_value.schemeType, (value) {
      return _then(_value.copyWith(schemeType: value) as $Val);
    });
  }

  /// Create a copy of IntensityColorConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntensityColorModelCopyWith<$Res>? get customColors {
    if (_value.customColors == null) {
      return null;
    }

    return $IntensityColorModelCopyWith<$Res>(_value.customColors!, (value) {
      return _then(_value.copyWith(customColors: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IntensityColorConfigurationImplCopyWith<$Res> implements $IntensityColorConfigurationCopyWith<$Res> {
  factory _$$IntensityColorConfigurationImplCopyWith(
          _$IntensityColorConfigurationImpl value, $Res Function(_$IntensityColorConfigurationImpl) then) =
      __$$IntensityColorConfigurationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IntensityColorSchemeType schemeType, IntensityColorModel? customColors});

  @override
  $IntensityColorSchemeTypeCopyWith<$Res> get schemeType;
  @override
  $IntensityColorModelCopyWith<$Res>? get customColors;
}

/// @nodoc
class __$$IntensityColorConfigurationImplCopyWithImpl<$Res>
    extends _$IntensityColorConfigurationCopyWithImpl<$Res, _$IntensityColorConfigurationImpl>
    implements _$$IntensityColorConfigurationImplCopyWith<$Res> {
  __$$IntensityColorConfigurationImplCopyWithImpl(
      _$IntensityColorConfigurationImpl _value, $Res Function(_$IntensityColorConfigurationImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntensityColorConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schemeType = null,
    Object? customColors = freezed,
  }) {
    return _then(_$IntensityColorConfigurationImpl(
      schemeType: null == schemeType
          ? _value.schemeType
          : schemeType // ignore: cast_nullable_to_non_nullable
              as IntensityColorSchemeType,
      customColors: freezed == customColors
          ? _value.customColors
          : customColors // ignore: cast_nullable_to_non_nullable
              as IntensityColorModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntensityColorConfigurationImpl implements _IntensityColorConfiguration {
  const _$IntensityColorConfigurationImpl({required this.schemeType, this.customColors});

  factory _$IntensityColorConfigurationImpl.fromJson(Map<String, dynamic> json) => _$$IntensityColorConfigurationImplFromJson(json);

  @override
  final IntensityColorSchemeType schemeType;
  @override
  final IntensityColorModel? customColors;

  @override
  String toString() {
    return 'IntensityColorConfiguration(schemeType: $schemeType, customColors: $customColors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntensityColorConfigurationImpl &&
            (identical(other.schemeType, schemeType) || other.schemeType == schemeType) &&
            (identical(other.customColors, customColors) || other.customColors == customColors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, schemeType, customColors);

  /// Create a copy of IntensityColorConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntensityColorConfigurationImplCopyWith<_$IntensityColorConfigurationImpl> get copyWith =>
      __$$IntensityColorConfigurationImplCopyWithImpl<_$IntensityColorConfigurationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntensityColorConfigurationImplToJson(
      this,
    );
  }
}

abstract class _IntensityColorConfiguration implements IntensityColorConfiguration {
  const factory _IntensityColorConfiguration(
      {required final IntensityColorSchemeType schemeType, final IntensityColorModel? customColors}) = _$IntensityColorConfigurationImpl;

  factory _IntensityColorConfiguration.fromJson(Map<String, dynamic> json) = _$IntensityColorConfigurationImpl.fromJson;

  @override
  IntensityColorSchemeType get schemeType;
  @override
  IntensityColorModel? get customColors;

  /// Create a copy of IntensityColorConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntensityColorConfigurationImplCopyWith<_$IntensityColorConfigurationImpl> get copyWith => throw _privateConstructorUsedError;
}
// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_color_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityColorConfiguration {

 PredefinedScheme get schemeType; IntensityColorModel? get customColors;
/// Create a copy of IntensityColorConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityColorConfigurationCopyWith<IntensityColorConfiguration> get copyWith => _$IntensityColorConfigurationCopyWithImpl<IntensityColorConfiguration>(this as IntensityColorConfiguration, _$identity);

  /// Serializes this IntensityColorConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityColorConfiguration&&(identical(other.schemeType, schemeType) || other.schemeType == schemeType)&&(identical(other.customColors, customColors) || other.customColors == customColors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemeType,customColors);

@override
String toString() {
  return 'IntensityColorConfiguration(schemeType: $schemeType, customColors: $customColors)';
}


}

/// @nodoc
abstract mixin class $IntensityColorConfigurationCopyWith<$Res>  {
  factory $IntensityColorConfigurationCopyWith(IntensityColorConfiguration value, $Res Function(IntensityColorConfiguration) _then) = _$IntensityColorConfigurationCopyWithImpl;
@useResult
$Res call({
 PredefinedScheme schemeType, IntensityColorModel? customColors
});


$IntensityColorModelCopyWith<$Res>? get customColors;

}
/// @nodoc
class _$IntensityColorConfigurationCopyWithImpl<$Res>
    implements $IntensityColorConfigurationCopyWith<$Res> {
  _$IntensityColorConfigurationCopyWithImpl(this._self, this._then);

  final IntensityColorConfiguration _self;
  final $Res Function(IntensityColorConfiguration) _then;

/// Create a copy of IntensityColorConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemeType = null,Object? customColors = freezed,}) {
  return _then(_self.copyWith(
schemeType: null == schemeType ? _self.schemeType : schemeType // ignore: cast_nullable_to_non_nullable
as PredefinedScheme,customColors: freezed == customColors ? _self.customColors : customColors // ignore: cast_nullable_to_non_nullable
as IntensityColorModel?,
  ));
}
/// Create a copy of IntensityColorConfiguration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityColorModelCopyWith<$Res>? get customColors {
    if (_self.customColors == null) {
    return null;
  }

  return $IntensityColorModelCopyWith<$Res>(_self.customColors!, (value) {
    return _then(_self.copyWith(customColors: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _IntensityColorConfiguration implements IntensityColorConfiguration {
  const _IntensityColorConfiguration({required this.schemeType, this.customColors});
  factory _IntensityColorConfiguration.fromJson(Map<String, dynamic> json) => _$IntensityColorConfigurationFromJson(json);

@override final  PredefinedScheme schemeType;
@override final  IntensityColorModel? customColors;

/// Create a copy of IntensityColorConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityColorConfigurationCopyWith<_IntensityColorConfiguration> get copyWith => __$IntensityColorConfigurationCopyWithImpl<_IntensityColorConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityColorConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityColorConfiguration&&(identical(other.schemeType, schemeType) || other.schemeType == schemeType)&&(identical(other.customColors, customColors) || other.customColors == customColors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemeType,customColors);

@override
String toString() {
  return 'IntensityColorConfiguration(schemeType: $schemeType, customColors: $customColors)';
}


}

/// @nodoc
abstract mixin class _$IntensityColorConfigurationCopyWith<$Res> implements $IntensityColorConfigurationCopyWith<$Res> {
  factory _$IntensityColorConfigurationCopyWith(_IntensityColorConfiguration value, $Res Function(_IntensityColorConfiguration) _then) = __$IntensityColorConfigurationCopyWithImpl;
@override @useResult
$Res call({
 PredefinedScheme schemeType, IntensityColorModel? customColors
});


@override $IntensityColorModelCopyWith<$Res>? get customColors;

}
/// @nodoc
class __$IntensityColorConfigurationCopyWithImpl<$Res>
    implements _$IntensityColorConfigurationCopyWith<$Res> {
  __$IntensityColorConfigurationCopyWithImpl(this._self, this._then);

  final _IntensityColorConfiguration _self;
  final $Res Function(_IntensityColorConfiguration) _then;

/// Create a copy of IntensityColorConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemeType = null,Object? customColors = freezed,}) {
  return _then(_IntensityColorConfiguration(
schemeType: null == schemeType ? _self.schemeType : schemeType // ignore: cast_nullable_to_non_nullable
as PredefinedScheme,customColors: freezed == customColors ? _self.customColors : customColors // ignore: cast_nullable_to_non_nullable
as IntensityColorModel?,
  ));
}

/// Create a copy of IntensityColorConfiguration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityColorModelCopyWith<$Res>? get customColors {
    if (_self.customColors == null) {
    return null;
  }

  return $IntensityColorModelCopyWith<$Res>(_self.customColors!, (value) {
    return _then(_self.copyWith(customColors: value));
  });
}
}

// dart format on

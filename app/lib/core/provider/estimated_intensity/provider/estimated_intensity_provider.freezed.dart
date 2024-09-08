// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimated_intensity_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EstimatedIntensityPoint {
  String get regionCode => throw _privateConstructorUsedError;
  String get cityCode => throw _privateConstructorUsedError;
  EarthquakeParameterStationItem get station =>
      throw _privateConstructorUsedError;
  double get intensity => throw _privateConstructorUsedError;

  /// Create a copy of EstimatedIntensityPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EstimatedIntensityPointCopyWith<EstimatedIntensityPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstimatedIntensityPointCopyWith<$Res> {
  factory $EstimatedIntensityPointCopyWith(EstimatedIntensityPoint value,
          $Res Function(EstimatedIntensityPoint) then) =
      _$EstimatedIntensityPointCopyWithImpl<$Res, EstimatedIntensityPoint>;
  @useResult
  $Res call(
      {String regionCode,
      String cityCode,
      EarthquakeParameterStationItem station,
      double intensity});
}

/// @nodoc
class _$EstimatedIntensityPointCopyWithImpl<$Res,
        $Val extends EstimatedIntensityPoint>
    implements $EstimatedIntensityPointCopyWith<$Res> {
  _$EstimatedIntensityPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EstimatedIntensityPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionCode = null,
    Object? cityCode = null,
    Object? station = null,
    Object? intensity = null,
  }) {
    return _then(_value.copyWith(
      regionCode: null == regionCode
          ? _value.regionCode
          : regionCode // ignore: cast_nullable_to_non_nullable
              as String,
      cityCode: null == cityCode
          ? _value.cityCode
          : cityCode // ignore: cast_nullable_to_non_nullable
              as String,
      station: null == station
          ? _value.station
          : station // ignore: cast_nullable_to_non_nullable
              as EarthquakeParameterStationItem,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EstimatedIntensityPointImplCopyWith<$Res>
    implements $EstimatedIntensityPointCopyWith<$Res> {
  factory _$$EstimatedIntensityPointImplCopyWith(
          _$EstimatedIntensityPointImpl value,
          $Res Function(_$EstimatedIntensityPointImpl) then) =
      __$$EstimatedIntensityPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String regionCode,
      String cityCode,
      EarthquakeParameterStationItem station,
      double intensity});
}

/// @nodoc
class __$$EstimatedIntensityPointImplCopyWithImpl<$Res>
    extends _$EstimatedIntensityPointCopyWithImpl<$Res,
        _$EstimatedIntensityPointImpl>
    implements _$$EstimatedIntensityPointImplCopyWith<$Res> {
  __$$EstimatedIntensityPointImplCopyWithImpl(
      _$EstimatedIntensityPointImpl _value,
      $Res Function(_$EstimatedIntensityPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of EstimatedIntensityPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionCode = null,
    Object? cityCode = null,
    Object? station = null,
    Object? intensity = null,
  }) {
    return _then(_$EstimatedIntensityPointImpl(
      regionCode: null == regionCode
          ? _value.regionCode
          : regionCode // ignore: cast_nullable_to_non_nullable
              as String,
      cityCode: null == cityCode
          ? _value.cityCode
          : cityCode // ignore: cast_nullable_to_non_nullable
              as String,
      station: null == station
          ? _value.station
          : station // ignore: cast_nullable_to_non_nullable
              as EarthquakeParameterStationItem,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$EstimatedIntensityPointImpl
    with DiagnosticableTreeMixin
    implements _EstimatedIntensityPoint {
  const _$EstimatedIntensityPointImpl(
      {required this.regionCode,
      required this.cityCode,
      required this.station,
      required this.intensity});

  @override
  final String regionCode;
  @override
  final String cityCode;
  @override
  final EarthquakeParameterStationItem station;
  @override
  final double intensity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EstimatedIntensityPoint(regionCode: $regionCode, cityCode: $cityCode, station: $station, intensity: $intensity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EstimatedIntensityPoint'))
      ..add(DiagnosticsProperty('regionCode', regionCode))
      ..add(DiagnosticsProperty('cityCode', cityCode))
      ..add(DiagnosticsProperty('station', station))
      ..add(DiagnosticsProperty('intensity', intensity));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstimatedIntensityPointImpl &&
            (identical(other.regionCode, regionCode) ||
                other.regionCode == regionCode) &&
            (identical(other.cityCode, cityCode) ||
                other.cityCode == cityCode) &&
            (identical(other.station, station) || other.station == station) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, regionCode, cityCode, station, intensity);

  /// Create a copy of EstimatedIntensityPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EstimatedIntensityPointImplCopyWith<_$EstimatedIntensityPointImpl>
      get copyWith => __$$EstimatedIntensityPointImplCopyWithImpl<
          _$EstimatedIntensityPointImpl>(this, _$identity);
}

abstract class _EstimatedIntensityPoint implements EstimatedIntensityPoint {
  const factory _EstimatedIntensityPoint(
      {required final String regionCode,
      required final String cityCode,
      required final EarthquakeParameterStationItem station,
      required final double intensity}) = _$EstimatedIntensityPointImpl;

  @override
  String get regionCode;
  @override
  String get cityCode;
  @override
  EarthquakeParameterStationItem get station;
  @override
  double get intensity;

  /// Create a copy of EstimatedIntensityPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstimatedIntensityPointImplCopyWith<_$EstimatedIntensityPointImpl>
      get copyWith => throw _privateConstructorUsedError;
}

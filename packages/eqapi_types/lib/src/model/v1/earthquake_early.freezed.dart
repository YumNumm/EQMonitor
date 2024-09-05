// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_early.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EarthquakeEarly _$EarthquakeEarlyFromJson(Map<String, dynamic> json) {
  return _EarthquakeEarly.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeEarly {
  String get id => throw _privateConstructorUsedError;
  int? get depth => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get magnitude => throw _privateConstructorUsedError;
  JmaForecastIntensity? get maxIntensity => throw _privateConstructorUsedError;
  bool get maxIntensityIsEarly => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get originTime => throw _privateConstructorUsedError;
  OriginTimePrecision get originTimePrecision =>
      throw _privateConstructorUsedError;

  /// Serializes this EarthquakeEarly to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EarthquakeEarly
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarthquakeEarlyCopyWith<EarthquakeEarly> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeEarlyCopyWith<$Res> {
  factory $EarthquakeEarlyCopyWith(
          EarthquakeEarly value, $Res Function(EarthquakeEarly) then) =
      _$EarthquakeEarlyCopyWithImpl<$Res, EarthquakeEarly>;
  @useResult
  $Res call(
      {String id,
      int? depth,
      double? latitude,
      double? longitude,
      double? magnitude,
      JmaForecastIntensity? maxIntensity,
      bool maxIntensityIsEarly,
      String name,
      DateTime originTime,
      OriginTimePrecision originTimePrecision});
}

/// @nodoc
class _$EarthquakeEarlyCopyWithImpl<$Res, $Val extends EarthquakeEarly>
    implements $EarthquakeEarlyCopyWith<$Res> {
  _$EarthquakeEarlyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarthquakeEarly
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? depth = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? magnitude = freezed,
    Object? maxIntensity = freezed,
    Object? maxIntensityIsEarly = null,
    Object? name = null,
    Object? originTime = null,
    Object? originTimePrecision = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      magnitude: freezed == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      maxIntensityIsEarly: null == maxIntensityIsEarly
          ? _value.maxIntensityIsEarly
          : maxIntensityIsEarly // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originTime: null == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      originTimePrecision: null == originTimePrecision
          ? _value.originTimePrecision
          : originTimePrecision // ignore: cast_nullable_to_non_nullable
              as OriginTimePrecision,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeEarlyImplCopyWith<$Res>
    implements $EarthquakeEarlyCopyWith<$Res> {
  factory _$$EarthquakeEarlyImplCopyWith(_$EarthquakeEarlyImpl value,
          $Res Function(_$EarthquakeEarlyImpl) then) =
      __$$EarthquakeEarlyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int? depth,
      double? latitude,
      double? longitude,
      double? magnitude,
      JmaForecastIntensity? maxIntensity,
      bool maxIntensityIsEarly,
      String name,
      DateTime originTime,
      OriginTimePrecision originTimePrecision});
}

/// @nodoc
class __$$EarthquakeEarlyImplCopyWithImpl<$Res>
    extends _$EarthquakeEarlyCopyWithImpl<$Res, _$EarthquakeEarlyImpl>
    implements _$$EarthquakeEarlyImplCopyWith<$Res> {
  __$$EarthquakeEarlyImplCopyWithImpl(
      _$EarthquakeEarlyImpl _value, $Res Function(_$EarthquakeEarlyImpl) _then)
      : super(_value, _then);

  /// Create a copy of EarthquakeEarly
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? depth = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? magnitude = freezed,
    Object? maxIntensity = freezed,
    Object? maxIntensityIsEarly = null,
    Object? name = null,
    Object? originTime = null,
    Object? originTimePrecision = null,
  }) {
    return _then(_$EarthquakeEarlyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      magnitude: freezed == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      maxIntensityIsEarly: null == maxIntensityIsEarly
          ? _value.maxIntensityIsEarly
          : maxIntensityIsEarly // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originTime: null == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      originTimePrecision: null == originTimePrecision
          ? _value.originTimePrecision
          : originTimePrecision // ignore: cast_nullable_to_non_nullable
              as OriginTimePrecision,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeEarlyImpl implements _EarthquakeEarly {
  const _$EarthquakeEarlyImpl(
      {required this.id,
      required this.depth,
      required this.latitude,
      required this.longitude,
      required this.magnitude,
      required this.maxIntensity,
      required this.maxIntensityIsEarly,
      required this.name,
      required this.originTime,
      required this.originTimePrecision});

  factory _$EarthquakeEarlyImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeEarlyImplFromJson(json);

  @override
  final String id;
  @override
  final int? depth;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final double? magnitude;
  @override
  final JmaForecastIntensity? maxIntensity;
  @override
  final bool maxIntensityIsEarly;
  @override
  final String name;
  @override
  final DateTime originTime;
  @override
  final OriginTimePrecision originTimePrecision;

  @override
  String toString() {
    return 'EarthquakeEarly(id: $id, depth: $depth, latitude: $latitude, longitude: $longitude, magnitude: $magnitude, maxIntensity: $maxIntensity, maxIntensityIsEarly: $maxIntensityIsEarly, name: $name, originTime: $originTime, originTimePrecision: $originTimePrecision)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeEarlyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            (identical(other.maxIntensityIsEarly, maxIntensityIsEarly) ||
                other.maxIntensityIsEarly == maxIntensityIsEarly) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.originTime, originTime) ||
                other.originTime == originTime) &&
            (identical(other.originTimePrecision, originTimePrecision) ||
                other.originTimePrecision == originTimePrecision));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      depth,
      latitude,
      longitude,
      magnitude,
      maxIntensity,
      maxIntensityIsEarly,
      name,
      originTime,
      originTimePrecision);

  /// Create a copy of EarthquakeEarly
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeEarlyImplCopyWith<_$EarthquakeEarlyImpl> get copyWith =>
      __$$EarthquakeEarlyImplCopyWithImpl<_$EarthquakeEarlyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeEarlyImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeEarly implements EarthquakeEarly {
  const factory _EarthquakeEarly(
          {required final String id,
          required final int? depth,
          required final double? latitude,
          required final double? longitude,
          required final double? magnitude,
          required final JmaForecastIntensity? maxIntensity,
          required final bool maxIntensityIsEarly,
          required final String name,
          required final DateTime originTime,
          required final OriginTimePrecision originTimePrecision}) =
      _$EarthquakeEarlyImpl;

  factory _EarthquakeEarly.fromJson(Map<String, dynamic> json) =
      _$EarthquakeEarlyImpl.fromJson;

  @override
  String get id;
  @override
  int? get depth;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  double? get magnitude;
  @override
  JmaForecastIntensity? get maxIntensity;
  @override
  bool get maxIntensityIsEarly;
  @override
  String get name;
  @override
  DateTime get originTime;
  @override
  OriginTimePrecision get originTimePrecision;

  /// Create a copy of EarthquakeEarly
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarthquakeEarlyImplCopyWith<_$EarthquakeEarlyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

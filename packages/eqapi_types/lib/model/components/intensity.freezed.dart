// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Intensity _$IntensityFromJson(Map<String, dynamic> json) {
  return _Intensity.fromJson(json);
}

/// @nodoc
mixin _$Intensity {
  JmaIntensity get maxInt => throw _privateConstructorUsedError;
  JmaLgIntensity? get maxLgInt => throw _privateConstructorUsedError;
  LgType? get lgCategory => throw _privateConstructorUsedError;
  List<RegionIntensity> get prefectures => throw _privateConstructorUsedError;
  List<RegionIntensity> get regions => throw _privateConstructorUsedError;
  List<RegionIntensity>? get cities => throw _privateConstructorUsedError;
  List<RegionIntensity>? get stations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IntensityCopyWith<Intensity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntensityCopyWith<$Res> {
  factory $IntensityCopyWith(Intensity value, $Res Function(Intensity) then) =
      _$IntensityCopyWithImpl<$Res, Intensity>;
  @useResult
  $Res call(
      {JmaIntensity maxInt,
      JmaLgIntensity? maxLgInt,
      LgType? lgCategory,
      List<RegionIntensity> prefectures,
      List<RegionIntensity> regions,
      List<RegionIntensity>? cities,
      List<RegionIntensity>? stations});
}

/// @nodoc
class _$IntensityCopyWithImpl<$Res, $Val extends Intensity>
    implements $IntensityCopyWith<$Res> {
  _$IntensityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxInt = null,
    Object? maxLgInt = freezed,
    Object? lgCategory = freezed,
    Object? prefectures = null,
    Object? regions = null,
    Object? cities = freezed,
    Object? stations = freezed,
  }) {
    return _then(_value.copyWith(
      maxInt: null == maxInt
          ? _value.maxInt
          : maxInt // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
      maxLgInt: freezed == maxLgInt
          ? _value.maxLgInt
          : maxLgInt // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
      lgCategory: freezed == lgCategory
          ? _value.lgCategory
          : lgCategory // ignore: cast_nullable_to_non_nullable
              as LgType?,
      prefectures: null == prefectures
          ? _value.prefectures
          : prefectures // ignore: cast_nullable_to_non_nullable
              as List<RegionIntensity>,
      regions: null == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<RegionIntensity>,
      cities: freezed == cities
          ? _value.cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<RegionIntensity>?,
      stations: freezed == stations
          ? _value.stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<RegionIntensity>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntensityImplCopyWith<$Res>
    implements $IntensityCopyWith<$Res> {
  factory _$$IntensityImplCopyWith(
          _$IntensityImpl value, $Res Function(_$IntensityImpl) then) =
      __$$IntensityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {JmaIntensity maxInt,
      JmaLgIntensity? maxLgInt,
      LgType? lgCategory,
      List<RegionIntensity> prefectures,
      List<RegionIntensity> regions,
      List<RegionIntensity>? cities,
      List<RegionIntensity>? stations});
}

/// @nodoc
class __$$IntensityImplCopyWithImpl<$Res>
    extends _$IntensityCopyWithImpl<$Res, _$IntensityImpl>
    implements _$$IntensityImplCopyWith<$Res> {
  __$$IntensityImplCopyWithImpl(
      _$IntensityImpl _value, $Res Function(_$IntensityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxInt = null,
    Object? maxLgInt = freezed,
    Object? lgCategory = freezed,
    Object? prefectures = null,
    Object? regions = null,
    Object? cities = freezed,
    Object? stations = freezed,
  }) {
    return _then(_$IntensityImpl(
      maxInt: null == maxInt
          ? _value.maxInt
          : maxInt // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
      maxLgInt: freezed == maxLgInt
          ? _value.maxLgInt
          : maxLgInt // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
      lgCategory: freezed == lgCategory
          ? _value.lgCategory
          : lgCategory // ignore: cast_nullable_to_non_nullable
              as LgType?,
      prefectures: null == prefectures
          ? _value._prefectures
          : prefectures // ignore: cast_nullable_to_non_nullable
              as List<RegionIntensity>,
      regions: null == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<RegionIntensity>,
      cities: freezed == cities
          ? _value._cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<RegionIntensity>?,
      stations: freezed == stations
          ? _value._stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<RegionIntensity>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$IntensityImpl implements _Intensity {
  const _$IntensityImpl(
      {required this.maxInt,
      this.maxLgInt = null,
      this.lgCategory = null,
      required final List<RegionIntensity> prefectures,
      required final List<RegionIntensity> regions,
      required final List<RegionIntensity>? cities,
      required final List<RegionIntensity>? stations})
      : _prefectures = prefectures,
        _regions = regions,
        _cities = cities,
        _stations = stations;

  factory _$IntensityImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntensityImplFromJson(json);

  @override
  final JmaIntensity maxInt;
  @override
  @JsonKey()
  final JmaLgIntensity? maxLgInt;
  @override
  @JsonKey()
  final LgType? lgCategory;
  final List<RegionIntensity> _prefectures;
  @override
  List<RegionIntensity> get prefectures {
    if (_prefectures is EqualUnmodifiableListView) return _prefectures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prefectures);
  }

  final List<RegionIntensity> _regions;
  @override
  List<RegionIntensity> get regions {
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regions);
  }

  final List<RegionIntensity>? _cities;
  @override
  List<RegionIntensity>? get cities {
    final value = _cities;
    if (value == null) return null;
    if (_cities is EqualUnmodifiableListView) return _cities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<RegionIntensity>? _stations;
  @override
  List<RegionIntensity>? get stations {
    final value = _stations;
    if (value == null) return null;
    if (_stations is EqualUnmodifiableListView) return _stations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Intensity(maxInt: $maxInt, maxLgInt: $maxLgInt, lgCategory: $lgCategory, prefectures: $prefectures, regions: $regions, cities: $cities, stations: $stations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntensityImpl &&
            (identical(other.maxInt, maxInt) || other.maxInt == maxInt) &&
            (identical(other.maxLgInt, maxLgInt) ||
                other.maxLgInt == maxLgInt) &&
            (identical(other.lgCategory, lgCategory) ||
                other.lgCategory == lgCategory) &&
            const DeepCollectionEquality()
                .equals(other._prefectures, _prefectures) &&
            const DeepCollectionEquality().equals(other._regions, _regions) &&
            const DeepCollectionEquality().equals(other._cities, _cities) &&
            const DeepCollectionEquality().equals(other._stations, _stations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      maxInt,
      maxLgInt,
      lgCategory,
      const DeepCollectionEquality().hash(_prefectures),
      const DeepCollectionEquality().hash(_regions),
      const DeepCollectionEquality().hash(_cities),
      const DeepCollectionEquality().hash(_stations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntensityImplCopyWith<_$IntensityImpl> get copyWith =>
      __$$IntensityImplCopyWithImpl<_$IntensityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntensityImplToJson(
      this,
    );
  }
}

abstract class _Intensity implements Intensity {
  const factory _Intensity(
      {required final JmaIntensity maxInt,
      final JmaLgIntensity? maxLgInt,
      final LgType? lgCategory,
      required final List<RegionIntensity> prefectures,
      required final List<RegionIntensity> regions,
      required final List<RegionIntensity>? cities,
      required final List<RegionIntensity>? stations}) = _$IntensityImpl;

  factory _Intensity.fromJson(Map<String, dynamic> json) =
      _$IntensityImpl.fromJson;

  @override
  JmaIntensity get maxInt;
  @override
  JmaLgIntensity? get maxLgInt;
  @override
  LgType? get lgCategory;
  @override
  List<RegionIntensity> get prefectures;
  @override
  List<RegionIntensity> get regions;
  @override
  List<RegionIntensity>? get cities;
  @override
  List<RegionIntensity>? get stations;
  @override
  @JsonKey(ignore: true)
  _$$IntensityImplCopyWith<_$IntensityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

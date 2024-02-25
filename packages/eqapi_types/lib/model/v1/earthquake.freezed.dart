// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EarthquakeV1 _$EarthquakeV1FromJson(Map<String, dynamic> json) {
  return _EarthquakeV1.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeV1 {
  DateTime? get arrivalTime => throw _privateConstructorUsedError;
  int? get depth => throw _privateConstructorUsedError;
  int? get epicenterCode => throw _privateConstructorUsedError;
  int? get epicenterDetailCode => throw _privateConstructorUsedError;
  int get eventId => throw _privateConstructorUsedError;
  String? get headline => throw _privateConstructorUsedError;
  List<ObservedRegionIntensity>? get intensityCities =>
      throw _privateConstructorUsedError;
  List<ObservedRegionIntensity>? get intensityPrefectures =>
      throw _privateConstructorUsedError;
  List<ObservedRegionIntensity>? get intensityRegions =>
      throw _privateConstructorUsedError;
  List<ObservedRegionIntensity>? get intensityStations =>
      throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  List<ObservedRegionLpgmIntensity>? get lpgmIntensityPrefectures =>
      throw _privateConstructorUsedError;
  List<ObservedRegionLpgmIntensity>? get lpgmIntensityRegions =>
      throw _privateConstructorUsedError;
  List<ObservedRegionLpgmIntensity>? get lpgmIntenstiyStations =>
      throw _privateConstructorUsedError;
  double? get magnitude => throw _privateConstructorUsedError;
  String? get magnitudeCondition => throw _privateConstructorUsedError;
  JmaIntensity? get maxIntensity => throw _privateConstructorUsedError;
  List<int>? get maxIntensityRegionIds => throw _privateConstructorUsedError;
  JmaLgIntensity? get maxLpgmIntensity => throw _privateConstructorUsedError;
  DateTime? get originTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeV1CopyWith<EarthquakeV1> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeV1CopyWith<$Res> {
  factory $EarthquakeV1CopyWith(
          EarthquakeV1 value, $Res Function(EarthquakeV1) then) =
      _$EarthquakeV1CopyWithImpl<$Res, EarthquakeV1>;
  @useResult
  $Res call(
      {DateTime? arrivalTime,
      int? depth,
      int? epicenterCode,
      int? epicenterDetailCode,
      int eventId,
      String? headline,
      List<ObservedRegionIntensity>? intensityCities,
      List<ObservedRegionIntensity>? intensityPrefectures,
      List<ObservedRegionIntensity>? intensityRegions,
      List<ObservedRegionIntensity>? intensityStations,
      double? latitude,
      double? longitude,
      List<ObservedRegionLpgmIntensity>? lpgmIntensityPrefectures,
      List<ObservedRegionLpgmIntensity>? lpgmIntensityRegions,
      List<ObservedRegionLpgmIntensity>? lpgmIntenstiyStations,
      double? magnitude,
      String? magnitudeCondition,
      JmaIntensity? maxIntensity,
      List<int>? maxIntensityRegionIds,
      JmaLgIntensity? maxLpgmIntensity,
      DateTime? originTime,
      String status,
      String? text});
}

/// @nodoc
class _$EarthquakeV1CopyWithImpl<$Res, $Val extends EarthquakeV1>
    implements $EarthquakeV1CopyWith<$Res> {
  _$EarthquakeV1CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arrivalTime = freezed,
    Object? depth = freezed,
    Object? epicenterCode = freezed,
    Object? epicenterDetailCode = freezed,
    Object? eventId = null,
    Object? headline = freezed,
    Object? intensityCities = freezed,
    Object? intensityPrefectures = freezed,
    Object? intensityRegions = freezed,
    Object? intensityStations = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? lpgmIntensityPrefectures = freezed,
    Object? lpgmIntensityRegions = freezed,
    Object? lpgmIntenstiyStations = freezed,
    Object? magnitude = freezed,
    Object? magnitudeCondition = freezed,
    Object? maxIntensity = freezed,
    Object? maxIntensityRegionIds = freezed,
    Object? maxLpgmIntensity = freezed,
    Object? originTime = freezed,
    Object? status = null,
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      epicenterCode: freezed == epicenterCode
          ? _value.epicenterCode
          : epicenterCode // ignore: cast_nullable_to_non_nullable
              as int?,
      epicenterDetailCode: freezed == epicenterDetailCode
          ? _value.epicenterDetailCode
          : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
              as int?,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
      intensityCities: freezed == intensityCities
          ? _value.intensityCities
          : intensityCities // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionIntensity>?,
      intensityPrefectures: freezed == intensityPrefectures
          ? _value.intensityPrefectures
          : intensityPrefectures // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionIntensity>?,
      intensityRegions: freezed == intensityRegions
          ? _value.intensityRegions
          : intensityRegions // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionIntensity>?,
      intensityStations: freezed == intensityStations
          ? _value.intensityStations
          : intensityStations // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionIntensity>?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      lpgmIntensityPrefectures: freezed == lpgmIntensityPrefectures
          ? _value.lpgmIntensityPrefectures
          : lpgmIntensityPrefectures // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionLpgmIntensity>?,
      lpgmIntensityRegions: freezed == lpgmIntensityRegions
          ? _value.lpgmIntensityRegions
          : lpgmIntensityRegions // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionLpgmIntensity>?,
      lpgmIntenstiyStations: freezed == lpgmIntenstiyStations
          ? _value.lpgmIntenstiyStations
          : lpgmIntenstiyStations // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionLpgmIntensity>?,
      magnitude: freezed == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double?,
      magnitudeCondition: freezed == magnitudeCondition
          ? _value.magnitudeCondition
          : magnitudeCondition // ignore: cast_nullable_to_non_nullable
              as String?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      maxIntensityRegionIds: freezed == maxIntensityRegionIds
          ? _value.maxIntensityRegionIds
          : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      maxLpgmIntensity: freezed == maxLpgmIntensity
          ? _value.maxLpgmIntensity
          : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeV1ImplCopyWith<$Res>
    implements $EarthquakeV1CopyWith<$Res> {
  factory _$$EarthquakeV1ImplCopyWith(
          _$EarthquakeV1Impl value, $Res Function(_$EarthquakeV1Impl) then) =
      __$$EarthquakeV1ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? arrivalTime,
      int? depth,
      int? epicenterCode,
      int? epicenterDetailCode,
      int eventId,
      String? headline,
      List<ObservedRegionIntensity>? intensityCities,
      List<ObservedRegionIntensity>? intensityPrefectures,
      List<ObservedRegionIntensity>? intensityRegions,
      List<ObservedRegionIntensity>? intensityStations,
      double? latitude,
      double? longitude,
      List<ObservedRegionLpgmIntensity>? lpgmIntensityPrefectures,
      List<ObservedRegionLpgmIntensity>? lpgmIntensityRegions,
      List<ObservedRegionLpgmIntensity>? lpgmIntenstiyStations,
      double? magnitude,
      String? magnitudeCondition,
      JmaIntensity? maxIntensity,
      List<int>? maxIntensityRegionIds,
      JmaLgIntensity? maxLpgmIntensity,
      DateTime? originTime,
      String status,
      String? text});
}

/// @nodoc
class __$$EarthquakeV1ImplCopyWithImpl<$Res>
    extends _$EarthquakeV1CopyWithImpl<$Res, _$EarthquakeV1Impl>
    implements _$$EarthquakeV1ImplCopyWith<$Res> {
  __$$EarthquakeV1ImplCopyWithImpl(
      _$EarthquakeV1Impl _value, $Res Function(_$EarthquakeV1Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arrivalTime = freezed,
    Object? depth = freezed,
    Object? epicenterCode = freezed,
    Object? epicenterDetailCode = freezed,
    Object? eventId = null,
    Object? headline = freezed,
    Object? intensityCities = freezed,
    Object? intensityPrefectures = freezed,
    Object? intensityRegions = freezed,
    Object? intensityStations = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? lpgmIntensityPrefectures = freezed,
    Object? lpgmIntensityRegions = freezed,
    Object? lpgmIntenstiyStations = freezed,
    Object? magnitude = freezed,
    Object? magnitudeCondition = freezed,
    Object? maxIntensity = freezed,
    Object? maxIntensityRegionIds = freezed,
    Object? maxLpgmIntensity = freezed,
    Object? originTime = freezed,
    Object? status = null,
    Object? text = freezed,
  }) {
    return _then(_$EarthquakeV1Impl(
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      epicenterCode: freezed == epicenterCode
          ? _value.epicenterCode
          : epicenterCode // ignore: cast_nullable_to_non_nullable
              as int?,
      epicenterDetailCode: freezed == epicenterDetailCode
          ? _value.epicenterDetailCode
          : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
              as int?,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
      intensityCities: freezed == intensityCities
          ? _value._intensityCities
          : intensityCities // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionIntensity>?,
      intensityPrefectures: freezed == intensityPrefectures
          ? _value._intensityPrefectures
          : intensityPrefectures // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionIntensity>?,
      intensityRegions: freezed == intensityRegions
          ? _value._intensityRegions
          : intensityRegions // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionIntensity>?,
      intensityStations: freezed == intensityStations
          ? _value._intensityStations
          : intensityStations // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionIntensity>?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      lpgmIntensityPrefectures: freezed == lpgmIntensityPrefectures
          ? _value._lpgmIntensityPrefectures
          : lpgmIntensityPrefectures // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionLpgmIntensity>?,
      lpgmIntensityRegions: freezed == lpgmIntensityRegions
          ? _value._lpgmIntensityRegions
          : lpgmIntensityRegions // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionLpgmIntensity>?,
      lpgmIntenstiyStations: freezed == lpgmIntenstiyStations
          ? _value._lpgmIntenstiyStations
          : lpgmIntenstiyStations // ignore: cast_nullable_to_non_nullable
              as List<ObservedRegionLpgmIntensity>?,
      magnitude: freezed == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double?,
      magnitudeCondition: freezed == magnitudeCondition
          ? _value.magnitudeCondition
          : magnitudeCondition // ignore: cast_nullable_to_non_nullable
              as String?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      maxIntensityRegionIds: freezed == maxIntensityRegionIds
          ? _value._maxIntensityRegionIds
          : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      maxLpgmIntensity: freezed == maxLpgmIntensity
          ? _value.maxLpgmIntensity
          : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeV1Impl implements _EarthquakeV1 {
  const _$EarthquakeV1Impl(
      {this.arrivalTime,
      this.depth,
      this.epicenterCode,
      this.epicenterDetailCode,
      required this.eventId,
      this.headline,
      final List<ObservedRegionIntensity>? intensityCities,
      final List<ObservedRegionIntensity>? intensityPrefectures,
      final List<ObservedRegionIntensity>? intensityRegions,
      final List<ObservedRegionIntensity>? intensityStations,
      this.latitude,
      this.longitude,
      final List<ObservedRegionLpgmIntensity>? lpgmIntensityPrefectures,
      final List<ObservedRegionLpgmIntensity>? lpgmIntensityRegions,
      final List<ObservedRegionLpgmIntensity>? lpgmIntenstiyStations,
      this.magnitude,
      this.magnitudeCondition,
      this.maxIntensity,
      final List<int>? maxIntensityRegionIds,
      this.maxLpgmIntensity,
      this.originTime,
      required this.status,
      this.text})
      : _intensityCities = intensityCities,
        _intensityPrefectures = intensityPrefectures,
        _intensityRegions = intensityRegions,
        _intensityStations = intensityStations,
        _lpgmIntensityPrefectures = lpgmIntensityPrefectures,
        _lpgmIntensityRegions = lpgmIntensityRegions,
        _lpgmIntenstiyStations = lpgmIntenstiyStations,
        _maxIntensityRegionIds = maxIntensityRegionIds;

  factory _$EarthquakeV1Impl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeV1ImplFromJson(json);

  @override
  final DateTime? arrivalTime;
  @override
  final int? depth;
  @override
  final int? epicenterCode;
  @override
  final int? epicenterDetailCode;
  @override
  final int eventId;
  @override
  final String? headline;
  final List<ObservedRegionIntensity>? _intensityCities;
  @override
  List<ObservedRegionIntensity>? get intensityCities {
    final value = _intensityCities;
    if (value == null) return null;
    if (_intensityCities is EqualUnmodifiableListView) return _intensityCities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ObservedRegionIntensity>? _intensityPrefectures;
  @override
  List<ObservedRegionIntensity>? get intensityPrefectures {
    final value = _intensityPrefectures;
    if (value == null) return null;
    if (_intensityPrefectures is EqualUnmodifiableListView)
      return _intensityPrefectures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ObservedRegionIntensity>? _intensityRegions;
  @override
  List<ObservedRegionIntensity>? get intensityRegions {
    final value = _intensityRegions;
    if (value == null) return null;
    if (_intensityRegions is EqualUnmodifiableListView)
      return _intensityRegions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ObservedRegionIntensity>? _intensityStations;
  @override
  List<ObservedRegionIntensity>? get intensityStations {
    final value = _intensityStations;
    if (value == null) return null;
    if (_intensityStations is EqualUnmodifiableListView)
      return _intensityStations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? latitude;
  @override
  final double? longitude;
  final List<ObservedRegionLpgmIntensity>? _lpgmIntensityPrefectures;
  @override
  List<ObservedRegionLpgmIntensity>? get lpgmIntensityPrefectures {
    final value = _lpgmIntensityPrefectures;
    if (value == null) return null;
    if (_lpgmIntensityPrefectures is EqualUnmodifiableListView)
      return _lpgmIntensityPrefectures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ObservedRegionLpgmIntensity>? _lpgmIntensityRegions;
  @override
  List<ObservedRegionLpgmIntensity>? get lpgmIntensityRegions {
    final value = _lpgmIntensityRegions;
    if (value == null) return null;
    if (_lpgmIntensityRegions is EqualUnmodifiableListView)
      return _lpgmIntensityRegions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ObservedRegionLpgmIntensity>? _lpgmIntenstiyStations;
  @override
  List<ObservedRegionLpgmIntensity>? get lpgmIntenstiyStations {
    final value = _lpgmIntenstiyStations;
    if (value == null) return null;
    if (_lpgmIntenstiyStations is EqualUnmodifiableListView)
      return _lpgmIntenstiyStations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? magnitude;
  @override
  final String? magnitudeCondition;
  @override
  final JmaIntensity? maxIntensity;
  final List<int>? _maxIntensityRegionIds;
  @override
  List<int>? get maxIntensityRegionIds {
    final value = _maxIntensityRegionIds;
    if (value == null) return null;
    if (_maxIntensityRegionIds is EqualUnmodifiableListView)
      return _maxIntensityRegionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final JmaLgIntensity? maxLpgmIntensity;
  @override
  final DateTime? originTime;
  @override
  final String status;
  @override
  final String? text;

  @override
  String toString() {
    return 'EarthquakeV1(arrivalTime: $arrivalTime, depth: $depth, epicenterCode: $epicenterCode, epicenterDetailCode: $epicenterDetailCode, eventId: $eventId, headline: $headline, intensityCities: $intensityCities, intensityPrefectures: $intensityPrefectures, intensityRegions: $intensityRegions, intensityStations: $intensityStations, latitude: $latitude, longitude: $longitude, lpgmIntensityPrefectures: $lpgmIntensityPrefectures, lpgmIntensityRegions: $lpgmIntensityRegions, lpgmIntenstiyStations: $lpgmIntenstiyStations, magnitude: $magnitude, magnitudeCondition: $magnitudeCondition, maxIntensity: $maxIntensity, maxIntensityRegionIds: $maxIntensityRegionIds, maxLpgmIntensity: $maxLpgmIntensity, originTime: $originTime, status: $status, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeV1Impl &&
            (identical(other.arrivalTime, arrivalTime) ||
                other.arrivalTime == arrivalTime) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.epicenterCode, epicenterCode) ||
                other.epicenterCode == epicenterCode) &&
            (identical(other.epicenterDetailCode, epicenterDetailCode) ||
                other.epicenterDetailCode == epicenterDetailCode) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.headline, headline) ||
                other.headline == headline) &&
            const DeepCollectionEquality()
                .equals(other._intensityCities, _intensityCities) &&
            const DeepCollectionEquality()
                .equals(other._intensityPrefectures, _intensityPrefectures) &&
            const DeepCollectionEquality()
                .equals(other._intensityRegions, _intensityRegions) &&
            const DeepCollectionEquality()
                .equals(other._intensityStations, _intensityStations) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality().equals(
                other._lpgmIntensityPrefectures, _lpgmIntensityPrefectures) &&
            const DeepCollectionEquality()
                .equals(other._lpgmIntensityRegions, _lpgmIntensityRegions) &&
            const DeepCollectionEquality()
                .equals(other._lpgmIntenstiyStations, _lpgmIntenstiyStations) &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude) &&
            (identical(other.magnitudeCondition, magnitudeCondition) ||
                other.magnitudeCondition == magnitudeCondition) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            const DeepCollectionEquality()
                .equals(other._maxIntensityRegionIds, _maxIntensityRegionIds) &&
            (identical(other.maxLpgmIntensity, maxLpgmIntensity) ||
                other.maxLpgmIntensity == maxLpgmIntensity) &&
            (identical(other.originTime, originTime) ||
                other.originTime == originTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        arrivalTime,
        depth,
        epicenterCode,
        epicenterDetailCode,
        eventId,
        headline,
        const DeepCollectionEquality().hash(_intensityCities),
        const DeepCollectionEquality().hash(_intensityPrefectures),
        const DeepCollectionEquality().hash(_intensityRegions),
        const DeepCollectionEquality().hash(_intensityStations),
        latitude,
        longitude,
        const DeepCollectionEquality().hash(_lpgmIntensityPrefectures),
        const DeepCollectionEquality().hash(_lpgmIntensityRegions),
        const DeepCollectionEquality().hash(_lpgmIntenstiyStations),
        magnitude,
        magnitudeCondition,
        maxIntensity,
        const DeepCollectionEquality().hash(_maxIntensityRegionIds),
        maxLpgmIntensity,
        originTime,
        status,
        text
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeV1ImplCopyWith<_$EarthquakeV1Impl> get copyWith =>
      __$$EarthquakeV1ImplCopyWithImpl<_$EarthquakeV1Impl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeV1ImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeV1 implements EarthquakeV1 {
  const factory _EarthquakeV1(
      {final DateTime? arrivalTime,
      final int? depth,
      final int? epicenterCode,
      final int? epicenterDetailCode,
      required final int eventId,
      final String? headline,
      final List<ObservedRegionIntensity>? intensityCities,
      final List<ObservedRegionIntensity>? intensityPrefectures,
      final List<ObservedRegionIntensity>? intensityRegions,
      final List<ObservedRegionIntensity>? intensityStations,
      final double? latitude,
      final double? longitude,
      final List<ObservedRegionLpgmIntensity>? lpgmIntensityPrefectures,
      final List<ObservedRegionLpgmIntensity>? lpgmIntensityRegions,
      final List<ObservedRegionLpgmIntensity>? lpgmIntenstiyStations,
      final double? magnitude,
      final String? magnitudeCondition,
      final JmaIntensity? maxIntensity,
      final List<int>? maxIntensityRegionIds,
      final JmaLgIntensity? maxLpgmIntensity,
      final DateTime? originTime,
      required final String status,
      final String? text}) = _$EarthquakeV1Impl;

  factory _EarthquakeV1.fromJson(Map<String, dynamic> json) =
      _$EarthquakeV1Impl.fromJson;

  @override
  DateTime? get arrivalTime;
  @override
  int? get depth;
  @override
  int? get epicenterCode;
  @override
  int? get epicenterDetailCode;
  @override
  int get eventId;
  @override
  String? get headline;
  @override
  List<ObservedRegionIntensity>? get intensityCities;
  @override
  List<ObservedRegionIntensity>? get intensityPrefectures;
  @override
  List<ObservedRegionIntensity>? get intensityRegions;
  @override
  List<ObservedRegionIntensity>? get intensityStations;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  List<ObservedRegionLpgmIntensity>? get lpgmIntensityPrefectures;
  @override
  List<ObservedRegionLpgmIntensity>? get lpgmIntensityRegions;
  @override
  List<ObservedRegionLpgmIntensity>? get lpgmIntenstiyStations;
  @override
  double? get magnitude;
  @override
  String? get magnitudeCondition;
  @override
  JmaIntensity? get maxIntensity;
  @override
  List<int>? get maxIntensityRegionIds;
  @override
  JmaLgIntensity? get maxLpgmIntensity;
  @override
  DateTime? get originTime;
  @override
  String get status;
  @override
  String? get text;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeV1ImplCopyWith<_$EarthquakeV1Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

EarthquakeV1Base _$EarthquakeV1BaseFromJson(Map<String, dynamic> json) {
  return _EarthquakeV1Base.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeV1Base {
  DateTime? get arrivalTime => throw _privateConstructorUsedError;
  int? get depth => throw _privateConstructorUsedError;
  int? get epicenterCode => throw _privateConstructorUsedError;
  int? get epicenterDetailCode => throw _privateConstructorUsedError;
  int get eventId => throw _privateConstructorUsedError;
  String? get headline => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get magnitude => throw _privateConstructorUsedError;
  String? get magnitudeCondition => throw _privateConstructorUsedError;
  JmaIntensity? get maxIntensity => throw _privateConstructorUsedError;
  List<int>? get maxIntensityRegionIds => throw _privateConstructorUsedError;
  JmaLgIntensity? get maxLpgmIntensity => throw _privateConstructorUsedError;
  DateTime? get originTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeV1BaseCopyWith<EarthquakeV1Base> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeV1BaseCopyWith<$Res> {
  factory $EarthquakeV1BaseCopyWith(
          EarthquakeV1Base value, $Res Function(EarthquakeV1Base) then) =
      _$EarthquakeV1BaseCopyWithImpl<$Res, EarthquakeV1Base>;
  @useResult
  $Res call(
      {DateTime? arrivalTime,
      int? depth,
      int? epicenterCode,
      int? epicenterDetailCode,
      int eventId,
      String? headline,
      double? latitude,
      double? longitude,
      double? magnitude,
      String? magnitudeCondition,
      JmaIntensity? maxIntensity,
      List<int>? maxIntensityRegionIds,
      JmaLgIntensity? maxLpgmIntensity,
      DateTime? originTime,
      String status,
      String? text});
}

/// @nodoc
class _$EarthquakeV1BaseCopyWithImpl<$Res, $Val extends EarthquakeV1Base>
    implements $EarthquakeV1BaseCopyWith<$Res> {
  _$EarthquakeV1BaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arrivalTime = freezed,
    Object? depth = freezed,
    Object? epicenterCode = freezed,
    Object? epicenterDetailCode = freezed,
    Object? eventId = null,
    Object? headline = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? magnitude = freezed,
    Object? magnitudeCondition = freezed,
    Object? maxIntensity = freezed,
    Object? maxIntensityRegionIds = freezed,
    Object? maxLpgmIntensity = freezed,
    Object? originTime = freezed,
    Object? status = null,
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      epicenterCode: freezed == epicenterCode
          ? _value.epicenterCode
          : epicenterCode // ignore: cast_nullable_to_non_nullable
              as int?,
      epicenterDetailCode: freezed == epicenterDetailCode
          ? _value.epicenterDetailCode
          : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
              as int?,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
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
      magnitudeCondition: freezed == magnitudeCondition
          ? _value.magnitudeCondition
          : magnitudeCondition // ignore: cast_nullable_to_non_nullable
              as String?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      maxIntensityRegionIds: freezed == maxIntensityRegionIds
          ? _value.maxIntensityRegionIds
          : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      maxLpgmIntensity: freezed == maxLpgmIntensity
          ? _value.maxLpgmIntensity
          : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeV1BaseImplCopyWith<$Res>
    implements $EarthquakeV1BaseCopyWith<$Res> {
  factory _$$EarthquakeV1BaseImplCopyWith(_$EarthquakeV1BaseImpl value,
          $Res Function(_$EarthquakeV1BaseImpl) then) =
      __$$EarthquakeV1BaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? arrivalTime,
      int? depth,
      int? epicenterCode,
      int? epicenterDetailCode,
      int eventId,
      String? headline,
      double? latitude,
      double? longitude,
      double? magnitude,
      String? magnitudeCondition,
      JmaIntensity? maxIntensity,
      List<int>? maxIntensityRegionIds,
      JmaLgIntensity? maxLpgmIntensity,
      DateTime? originTime,
      String status,
      String? text});
}

/// @nodoc
class __$$EarthquakeV1BaseImplCopyWithImpl<$Res>
    extends _$EarthquakeV1BaseCopyWithImpl<$Res, _$EarthquakeV1BaseImpl>
    implements _$$EarthquakeV1BaseImplCopyWith<$Res> {
  __$$EarthquakeV1BaseImplCopyWithImpl(_$EarthquakeV1BaseImpl _value,
      $Res Function(_$EarthquakeV1BaseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arrivalTime = freezed,
    Object? depth = freezed,
    Object? epicenterCode = freezed,
    Object? epicenterDetailCode = freezed,
    Object? eventId = null,
    Object? headline = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? magnitude = freezed,
    Object? magnitudeCondition = freezed,
    Object? maxIntensity = freezed,
    Object? maxIntensityRegionIds = freezed,
    Object? maxLpgmIntensity = freezed,
    Object? originTime = freezed,
    Object? status = null,
    Object? text = freezed,
  }) {
    return _then(_$EarthquakeV1BaseImpl(
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      epicenterCode: freezed == epicenterCode
          ? _value.epicenterCode
          : epicenterCode // ignore: cast_nullable_to_non_nullable
              as int?,
      epicenterDetailCode: freezed == epicenterDetailCode
          ? _value.epicenterDetailCode
          : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
              as int?,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
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
      magnitudeCondition: freezed == magnitudeCondition
          ? _value.magnitudeCondition
          : magnitudeCondition // ignore: cast_nullable_to_non_nullable
              as String?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      maxIntensityRegionIds: freezed == maxIntensityRegionIds
          ? _value._maxIntensityRegionIds
          : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      maxLpgmIntensity: freezed == maxLpgmIntensity
          ? _value.maxLpgmIntensity
          : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeV1BaseImpl implements _EarthquakeV1Base {
  const _$EarthquakeV1BaseImpl(
      {this.arrivalTime,
      this.depth,
      this.epicenterCode,
      this.epicenterDetailCode,
      required this.eventId,
      this.headline,
      this.latitude,
      this.longitude,
      this.magnitude,
      this.magnitudeCondition,
      this.maxIntensity,
      final List<int>? maxIntensityRegionIds,
      this.maxLpgmIntensity,
      this.originTime,
      required this.status,
      this.text})
      : _maxIntensityRegionIds = maxIntensityRegionIds;

  factory _$EarthquakeV1BaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeV1BaseImplFromJson(json);

  @override
  final DateTime? arrivalTime;
  @override
  final int? depth;
  @override
  final int? epicenterCode;
  @override
  final int? epicenterDetailCode;
  @override
  final int eventId;
  @override
  final String? headline;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final double? magnitude;
  @override
  final String? magnitudeCondition;
  @override
  final JmaIntensity? maxIntensity;
  final List<int>? _maxIntensityRegionIds;
  @override
  List<int>? get maxIntensityRegionIds {
    final value = _maxIntensityRegionIds;
    if (value == null) return null;
    if (_maxIntensityRegionIds is EqualUnmodifiableListView)
      return _maxIntensityRegionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final JmaLgIntensity? maxLpgmIntensity;
  @override
  final DateTime? originTime;
  @override
  final String status;
  @override
  final String? text;

  @override
  String toString() {
    return 'EarthquakeV1Base(arrivalTime: $arrivalTime, depth: $depth, epicenterCode: $epicenterCode, epicenterDetailCode: $epicenterDetailCode, eventId: $eventId, headline: $headline, latitude: $latitude, longitude: $longitude, magnitude: $magnitude, magnitudeCondition: $magnitudeCondition, maxIntensity: $maxIntensity, maxIntensityRegionIds: $maxIntensityRegionIds, maxLpgmIntensity: $maxLpgmIntensity, originTime: $originTime, status: $status, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeV1BaseImpl &&
            (identical(other.arrivalTime, arrivalTime) ||
                other.arrivalTime == arrivalTime) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.epicenterCode, epicenterCode) ||
                other.epicenterCode == epicenterCode) &&
            (identical(other.epicenterDetailCode, epicenterDetailCode) ||
                other.epicenterDetailCode == epicenterDetailCode) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.headline, headline) ||
                other.headline == headline) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude) &&
            (identical(other.magnitudeCondition, magnitudeCondition) ||
                other.magnitudeCondition == magnitudeCondition) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            const DeepCollectionEquality()
                .equals(other._maxIntensityRegionIds, _maxIntensityRegionIds) &&
            (identical(other.maxLpgmIntensity, maxLpgmIntensity) ||
                other.maxLpgmIntensity == maxLpgmIntensity) &&
            (identical(other.originTime, originTime) ||
                other.originTime == originTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      arrivalTime,
      depth,
      epicenterCode,
      epicenterDetailCode,
      eventId,
      headline,
      latitude,
      longitude,
      magnitude,
      magnitudeCondition,
      maxIntensity,
      const DeepCollectionEquality().hash(_maxIntensityRegionIds),
      maxLpgmIntensity,
      originTime,
      status,
      text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeV1BaseImplCopyWith<_$EarthquakeV1BaseImpl> get copyWith =>
      __$$EarthquakeV1BaseImplCopyWithImpl<_$EarthquakeV1BaseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeV1BaseImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeV1Base implements EarthquakeV1Base {
  const factory _EarthquakeV1Base(
      {final DateTime? arrivalTime,
      final int? depth,
      final int? epicenterCode,
      final int? epicenterDetailCode,
      required final int eventId,
      final String? headline,
      final double? latitude,
      final double? longitude,
      final double? magnitude,
      final String? magnitudeCondition,
      final JmaIntensity? maxIntensity,
      final List<int>? maxIntensityRegionIds,
      final JmaLgIntensity? maxLpgmIntensity,
      final DateTime? originTime,
      required final String status,
      final String? text}) = _$EarthquakeV1BaseImpl;

  factory _EarthquakeV1Base.fromJson(Map<String, dynamic> json) =
      _$EarthquakeV1BaseImpl.fromJson;

  @override
  DateTime? get arrivalTime;
  @override
  int? get depth;
  @override
  int? get epicenterCode;
  @override
  int? get epicenterDetailCode;
  @override
  int get eventId;
  @override
  String? get headline;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  double? get magnitude;
  @override
  String? get magnitudeCondition;
  @override
  JmaIntensity? get maxIntensity;
  @override
  List<int>? get maxIntensityRegionIds;
  @override
  JmaLgIntensity? get maxLpgmIntensity;
  @override
  DateTime? get originTime;
  @override
  String get status;
  @override
  String? get text;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeV1BaseImplCopyWith<_$EarthquakeV1BaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ObservedRegionIntensity _$ObservedRegionIntensityFromJson(
    Map<String, dynamic> json) {
  return _ObservedRegionIntensity.fromJson(json);
}

/// @nodoc
mixin _$ObservedRegionIntensity {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'maxInt')
  JmaIntensity? get intensity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ObservedRegionIntensityCopyWith<ObservedRegionIntensity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObservedRegionIntensityCopyWith<$Res> {
  factory $ObservedRegionIntensityCopyWith(ObservedRegionIntensity value,
          $Res Function(ObservedRegionIntensity) then) =
      _$ObservedRegionIntensityCopyWithImpl<$Res, ObservedRegionIntensity>;
  @useResult
  $Res call(
      {String code,
      String name,
      @JsonKey(name: 'maxInt') JmaIntensity? intensity});
}

/// @nodoc
class _$ObservedRegionIntensityCopyWithImpl<$Res,
        $Val extends ObservedRegionIntensity>
    implements $ObservedRegionIntensityCopyWith<$Res> {
  _$ObservedRegionIntensityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? intensity = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ObservedRegionIntensityImplCopyWith<$Res>
    implements $ObservedRegionIntensityCopyWith<$Res> {
  factory _$$ObservedRegionIntensityImplCopyWith(
          _$ObservedRegionIntensityImpl value,
          $Res Function(_$ObservedRegionIntensityImpl) then) =
      __$$ObservedRegionIntensityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String name,
      @JsonKey(name: 'maxInt') JmaIntensity? intensity});
}

/// @nodoc
class __$$ObservedRegionIntensityImplCopyWithImpl<$Res>
    extends _$ObservedRegionIntensityCopyWithImpl<$Res,
        _$ObservedRegionIntensityImpl>
    implements _$$ObservedRegionIntensityImplCopyWith<$Res> {
  __$$ObservedRegionIntensityImplCopyWithImpl(
      _$ObservedRegionIntensityImpl _value,
      $Res Function(_$ObservedRegionIntensityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? intensity = freezed,
  }) {
    return _then(_$ObservedRegionIntensityImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ObservedRegionIntensityImpl implements _ObservedRegionIntensity {
  const _$ObservedRegionIntensityImpl(
      {required this.code,
      required this.name,
      @JsonKey(name: 'maxInt') required this.intensity});

  factory _$ObservedRegionIntensityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ObservedRegionIntensityImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  @JsonKey(name: 'maxInt')
  final JmaIntensity? intensity;

  @override
  String toString() {
    return 'ObservedRegionIntensity(code: $code, name: $name, intensity: $intensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ObservedRegionIntensityImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, intensity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ObservedRegionIntensityImplCopyWith<_$ObservedRegionIntensityImpl>
      get copyWith => __$$ObservedRegionIntensityImplCopyWithImpl<
          _$ObservedRegionIntensityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ObservedRegionIntensityImplToJson(
      this,
    );
  }
}

abstract class _ObservedRegionIntensity implements ObservedRegionIntensity {
  const factory _ObservedRegionIntensity(
          {required final String code,
          required final String name,
          @JsonKey(name: 'maxInt') required final JmaIntensity? intensity}) =
      _$ObservedRegionIntensityImpl;

  factory _ObservedRegionIntensity.fromJson(Map<String, dynamic> json) =
      _$ObservedRegionIntensityImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  @JsonKey(name: 'maxInt')
  JmaIntensity? get intensity;
  @override
  @JsonKey(ignore: true)
  _$$ObservedRegionIntensityImplCopyWith<_$ObservedRegionIntensityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ObservedRegionLpgmIntensity _$ObservedRegionLpgmIntensityFromJson(
    Map<String, dynamic> json) {
  return _ObservedRegionLpgmIntensity.fromJson(json);
}

/// @nodoc
mixin _$ObservedRegionLpgmIntensity {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'maxInt')
  JmaIntensity? get intensity => throw _privateConstructorUsedError;
  @JsonKey(name: 'maxLgInt')
  JmaLgIntensity? get lpgmIntensity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ObservedRegionLpgmIntensityCopyWith<ObservedRegionLpgmIntensity>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObservedRegionLpgmIntensityCopyWith<$Res> {
  factory $ObservedRegionLpgmIntensityCopyWith(
          ObservedRegionLpgmIntensity value,
          $Res Function(ObservedRegionLpgmIntensity) then) =
      _$ObservedRegionLpgmIntensityCopyWithImpl<$Res,
          ObservedRegionLpgmIntensity>;
  @useResult
  $Res call(
      {String code,
      String name,
      @JsonKey(name: 'maxInt') JmaIntensity? intensity,
      @JsonKey(name: 'maxLgInt') JmaLgIntensity? lpgmIntensity});
}

/// @nodoc
class _$ObservedRegionLpgmIntensityCopyWithImpl<$Res,
        $Val extends ObservedRegionLpgmIntensity>
    implements $ObservedRegionLpgmIntensityCopyWith<$Res> {
  _$ObservedRegionLpgmIntensityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? intensity = freezed,
    Object? lpgmIntensity = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      lpgmIntensity: freezed == lpgmIntensity
          ? _value.lpgmIntensity
          : lpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ObservedRegionLpgmIntensityImplCopyWith<$Res>
    implements $ObservedRegionLpgmIntensityCopyWith<$Res> {
  factory _$$ObservedRegionLpgmIntensityImplCopyWith(
          _$ObservedRegionLpgmIntensityImpl value,
          $Res Function(_$ObservedRegionLpgmIntensityImpl) then) =
      __$$ObservedRegionLpgmIntensityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String name,
      @JsonKey(name: 'maxInt') JmaIntensity? intensity,
      @JsonKey(name: 'maxLgInt') JmaLgIntensity? lpgmIntensity});
}

/// @nodoc
class __$$ObservedRegionLpgmIntensityImplCopyWithImpl<$Res>
    extends _$ObservedRegionLpgmIntensityCopyWithImpl<$Res,
        _$ObservedRegionLpgmIntensityImpl>
    implements _$$ObservedRegionLpgmIntensityImplCopyWith<$Res> {
  __$$ObservedRegionLpgmIntensityImplCopyWithImpl(
      _$ObservedRegionLpgmIntensityImpl _value,
      $Res Function(_$ObservedRegionLpgmIntensityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? intensity = freezed,
    Object? lpgmIntensity = freezed,
  }) {
    return _then(_$ObservedRegionLpgmIntensityImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      lpgmIntensity: freezed == lpgmIntensity
          ? _value.lpgmIntensity
          : lpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ObservedRegionLpgmIntensityImpl
    implements _ObservedRegionLpgmIntensity {
  const _$ObservedRegionLpgmIntensityImpl(
      {required this.code,
      required this.name,
      @JsonKey(name: 'maxInt') required this.intensity,
      @JsonKey(name: 'maxLgInt') required this.lpgmIntensity});

  factory _$ObservedRegionLpgmIntensityImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ObservedRegionLpgmIntensityImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  @JsonKey(name: 'maxInt')
  final JmaIntensity? intensity;
  @override
  @JsonKey(name: 'maxLgInt')
  final JmaLgIntensity? lpgmIntensity;

  @override
  String toString() {
    return 'ObservedRegionLpgmIntensity(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ObservedRegionLpgmIntensityImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.lpgmIntensity, lpgmIntensity) ||
                other.lpgmIntensity == lpgmIntensity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, code, name, intensity, lpgmIntensity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ObservedRegionLpgmIntensityImplCopyWith<_$ObservedRegionLpgmIntensityImpl>
      get copyWith => __$$ObservedRegionLpgmIntensityImplCopyWithImpl<
          _$ObservedRegionLpgmIntensityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ObservedRegionLpgmIntensityImplToJson(
      this,
    );
  }
}

abstract class _ObservedRegionLpgmIntensity
    implements ObservedRegionLpgmIntensity {
  const factory _ObservedRegionLpgmIntensity(
          {required final String code,
          required final String name,
          @JsonKey(name: 'maxInt') required final JmaIntensity? intensity,
          @JsonKey(name: 'maxLgInt')
          required final JmaLgIntensity? lpgmIntensity}) =
      _$ObservedRegionLpgmIntensityImpl;

  factory _ObservedRegionLpgmIntensity.fromJson(Map<String, dynamic> json) =
      _$ObservedRegionLpgmIntensityImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  @JsonKey(name: 'maxInt')
  JmaIntensity? get intensity;
  @override
  @JsonKey(name: 'maxLgInt')
  JmaLgIntensity? get lpgmIntensity;
  @override
  @JsonKey(ignore: true)
  _$$ObservedRegionLpgmIntensityImplCopyWith<_$ObservedRegionLpgmIntensityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

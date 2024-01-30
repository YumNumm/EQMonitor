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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EarthquakeV1 _$EarthquakeV1FromJson(Map<String, dynamic> json) {
  return _EarthquakeV1.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeV1 {
  int get id => throw _privateConstructorUsedError;
  int get eventId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  double? get magnitude => throw _privateConstructorUsedError;
  String? get magnitudeCondition => throw _privateConstructorUsedError;
  JmaIntensity? get maxIntensity => throw _privateConstructorUsedError;
  JmaLgIntensity? get maxLpgmIntensity => throw _privateConstructorUsedError;
  int? get depth => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  int? get epicenterCode => throw _privateConstructorUsedError;
  int? get epicenterDetailCode => throw _privateConstructorUsedError;
  DateTime? get arrivalTime => throw _privateConstructorUsedError;
  DateTime? get originTime => throw _privateConstructorUsedError;
  String? get latestHeadline => throw _privateConstructorUsedError;
  List<int>? get maxIntensityREgionIds => throw _privateConstructorUsedError;

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
      {int id,
      int eventId,
      String status,
      double? magnitude,
      String? magnitudeCondition,
      JmaIntensity? maxIntensity,
      JmaLgIntensity? maxLpgmIntensity,
      int? depth,
      double? latitude,
      double? longitude,
      int? epicenterCode,
      int? epicenterDetailCode,
      DateTime? arrivalTime,
      DateTime? originTime,
      String? latestHeadline,
      List<int>? maxIntensityREgionIds});
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
    Object? id = null,
    Object? eventId = null,
    Object? status = null,
    Object? magnitude = freezed,
    Object? magnitudeCondition = freezed,
    Object? maxIntensity = freezed,
    Object? maxLpgmIntensity = freezed,
    Object? depth = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? epicenterCode = freezed,
    Object? epicenterDetailCode = freezed,
    Object? arrivalTime = freezed,
    Object? originTime = freezed,
    Object? latestHeadline = freezed,
    Object? maxIntensityREgionIds = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
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
      maxLpgmIntensity: freezed == maxLpgmIntensity
          ? _value.maxLpgmIntensity
          : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
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
      epicenterCode: freezed == epicenterCode
          ? _value.epicenterCode
          : epicenterCode // ignore: cast_nullable_to_non_nullable
              as int?,
      epicenterDetailCode: freezed == epicenterDetailCode
          ? _value.epicenterDetailCode
          : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
              as int?,
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      latestHeadline: freezed == latestHeadline
          ? _value.latestHeadline
          : latestHeadline // ignore: cast_nullable_to_non_nullable
              as String?,
      maxIntensityREgionIds: freezed == maxIntensityREgionIds
          ? _value.maxIntensityREgionIds
          : maxIntensityREgionIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
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
      {int id,
      int eventId,
      String status,
      double? magnitude,
      String? magnitudeCondition,
      JmaIntensity? maxIntensity,
      JmaLgIntensity? maxLpgmIntensity,
      int? depth,
      double? latitude,
      double? longitude,
      int? epicenterCode,
      int? epicenterDetailCode,
      DateTime? arrivalTime,
      DateTime? originTime,
      String? latestHeadline,
      List<int>? maxIntensityREgionIds});
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
    Object? id = null,
    Object? eventId = null,
    Object? status = null,
    Object? magnitude = freezed,
    Object? magnitudeCondition = freezed,
    Object? maxIntensity = freezed,
    Object? maxLpgmIntensity = freezed,
    Object? depth = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? epicenterCode = freezed,
    Object? epicenterDetailCode = freezed,
    Object? arrivalTime = freezed,
    Object? originTime = freezed,
    Object? latestHeadline = freezed,
    Object? maxIntensityREgionIds = freezed,
  }) {
    return _then(_$EarthquakeV1Impl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
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
      maxLpgmIntensity: freezed == maxLpgmIntensity
          ? _value.maxLpgmIntensity
          : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
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
      epicenterCode: freezed == epicenterCode
          ? _value.epicenterCode
          : epicenterCode // ignore: cast_nullable_to_non_nullable
              as int?,
      epicenterDetailCode: freezed == epicenterDetailCode
          ? _value.epicenterDetailCode
          : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
              as int?,
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      latestHeadline: freezed == latestHeadline
          ? _value.latestHeadline
          : latestHeadline // ignore: cast_nullable_to_non_nullable
              as String?,
      maxIntensityREgionIds: freezed == maxIntensityREgionIds
          ? _value._maxIntensityREgionIds
          : maxIntensityREgionIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeV1Impl implements _EarthquakeV1 {
  const _$EarthquakeV1Impl(
      {required this.id,
      required this.eventId,
      required this.status,
      this.magnitude,
      this.magnitudeCondition,
      this.maxIntensity,
      this.maxLpgmIntensity,
      this.depth,
      this.latitude,
      this.longitude,
      this.epicenterCode,
      this.epicenterDetailCode,
      this.arrivalTime,
      this.originTime,
      this.latestHeadline,
      final List<int>? maxIntensityREgionIds})
      : _maxIntensityREgionIds = maxIntensityREgionIds;

  factory _$EarthquakeV1Impl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeV1ImplFromJson(json);

  @override
  final int id;
  @override
  final int eventId;
  @override
  final String status;
  @override
  final double? magnitude;
  @override
  final String? magnitudeCondition;
  @override
  final JmaIntensity? maxIntensity;
  @override
  final JmaLgIntensity? maxLpgmIntensity;
  @override
  final int? depth;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final int? epicenterCode;
  @override
  final int? epicenterDetailCode;
  @override
  final DateTime? arrivalTime;
  @override
  final DateTime? originTime;
  @override
  final String? latestHeadline;
  final List<int>? _maxIntensityREgionIds;
  @override
  List<int>? get maxIntensityREgionIds {
    final value = _maxIntensityREgionIds;
    if (value == null) return null;
    if (_maxIntensityREgionIds is EqualUnmodifiableListView)
      return _maxIntensityREgionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'EarthquakeV1(id: $id, eventId: $eventId, status: $status, magnitude: $magnitude, magnitudeCondition: $magnitudeCondition, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, depth: $depth, latitude: $latitude, longitude: $longitude, epicenterCode: $epicenterCode, epicenterDetailCode: $epicenterDetailCode, arrivalTime: $arrivalTime, originTime: $originTime, latestHeadline: $latestHeadline, maxIntensityREgionIds: $maxIntensityREgionIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeV1Impl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude) &&
            (identical(other.magnitudeCondition, magnitudeCondition) ||
                other.magnitudeCondition == magnitudeCondition) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            (identical(other.maxLpgmIntensity, maxLpgmIntensity) ||
                other.maxLpgmIntensity == maxLpgmIntensity) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.epicenterCode, epicenterCode) ||
                other.epicenterCode == epicenterCode) &&
            (identical(other.epicenterDetailCode, epicenterDetailCode) ||
                other.epicenterDetailCode == epicenterDetailCode) &&
            (identical(other.arrivalTime, arrivalTime) ||
                other.arrivalTime == arrivalTime) &&
            (identical(other.originTime, originTime) ||
                other.originTime == originTime) &&
            (identical(other.latestHeadline, latestHeadline) ||
                other.latestHeadline == latestHeadline) &&
            const DeepCollectionEquality()
                .equals(other._maxIntensityREgionIds, _maxIntensityREgionIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      eventId,
      status,
      magnitude,
      magnitudeCondition,
      maxIntensity,
      maxLpgmIntensity,
      depth,
      latitude,
      longitude,
      epicenterCode,
      epicenterDetailCode,
      arrivalTime,
      originTime,
      latestHeadline,
      const DeepCollectionEquality().hash(_maxIntensityREgionIds));

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
      {required final int id,
      required final int eventId,
      required final String status,
      final double? magnitude,
      final String? magnitudeCondition,
      final JmaIntensity? maxIntensity,
      final JmaLgIntensity? maxLpgmIntensity,
      final int? depth,
      final double? latitude,
      final double? longitude,
      final int? epicenterCode,
      final int? epicenterDetailCode,
      final DateTime? arrivalTime,
      final DateTime? originTime,
      final String? latestHeadline,
      final List<int>? maxIntensityREgionIds}) = _$EarthquakeV1Impl;

  factory _EarthquakeV1.fromJson(Map<String, dynamic> json) =
      _$EarthquakeV1Impl.fromJson;

  @override
  int get id;
  @override
  int get eventId;
  @override
  String get status;
  @override
  double? get magnitude;
  @override
  String? get magnitudeCondition;
  @override
  JmaIntensity? get maxIntensity;
  @override
  JmaLgIntensity? get maxLpgmIntensity;
  @override
  int? get depth;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  int? get epicenterCode;
  @override
  int? get epicenterDetailCode;
  @override
  DateTime? get arrivalTime;
  @override
  DateTime? get originTime;
  @override
  String? get latestHeadline;
  @override
  List<int>? get maxIntensityREgionIds;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeV1ImplCopyWith<_$EarthquakeV1Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

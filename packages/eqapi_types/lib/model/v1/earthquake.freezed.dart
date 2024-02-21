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

EarthquakeBaseComponent _$EarthquakeBaseComponentFromJson(
    Map<String, dynamic> json) {
  return _EarthquakeBaseComponent.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeBaseComponent {
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
  List<int>? get maxIntensityRegionIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeBaseComponentCopyWith<EarthquakeBaseComponent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeBaseComponentCopyWith<$Res> {
  factory $EarthquakeBaseComponentCopyWith(EarthquakeBaseComponent value,
          $Res Function(EarthquakeBaseComponent) then) =
      _$EarthquakeBaseComponentCopyWithImpl<$Res, EarthquakeBaseComponent>;
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
      List<int>? maxIntensityRegionIds});
}

/// @nodoc
class _$EarthquakeBaseComponentCopyWithImpl<$Res,
        $Val extends EarthquakeBaseComponent>
    implements $EarthquakeBaseComponentCopyWith<$Res> {
  _$EarthquakeBaseComponentCopyWithImpl(this._value, this._then);

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
    Object? maxIntensityRegionIds = freezed,
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
      maxIntensityRegionIds: freezed == maxIntensityRegionIds
          ? _value.maxIntensityRegionIds
          : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeBaseComponentImplCopyWith<$Res>
    implements $EarthquakeBaseComponentCopyWith<$Res> {
  factory _$$EarthquakeBaseComponentImplCopyWith(
          _$EarthquakeBaseComponentImpl value,
          $Res Function(_$EarthquakeBaseComponentImpl) then) =
      __$$EarthquakeBaseComponentImplCopyWithImpl<$Res>;
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
      List<int>? maxIntensityRegionIds});
}

/// @nodoc
class __$$EarthquakeBaseComponentImplCopyWithImpl<$Res>
    extends _$EarthquakeBaseComponentCopyWithImpl<$Res,
        _$EarthquakeBaseComponentImpl>
    implements _$$EarthquakeBaseComponentImplCopyWith<$Res> {
  __$$EarthquakeBaseComponentImplCopyWithImpl(
      _$EarthquakeBaseComponentImpl _value,
      $Res Function(_$EarthquakeBaseComponentImpl) _then)
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
    Object? maxIntensityRegionIds = freezed,
  }) {
    return _then(_$EarthquakeBaseComponentImpl(
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
      maxIntensityRegionIds: freezed == maxIntensityRegionIds
          ? _value._maxIntensityRegionIds
          : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeBaseComponentImpl implements _EarthquakeBaseComponent {
  const _$EarthquakeBaseComponentImpl(
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
      final List<int>? maxIntensityRegionIds})
      : _maxIntensityRegionIds = maxIntensityRegionIds;

  factory _$EarthquakeBaseComponentImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeBaseComponentImplFromJson(json);

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
  String toString() {
    return 'EarthquakeBaseComponent(id: $id, eventId: $eventId, status: $status, magnitude: $magnitude, magnitudeCondition: $magnitudeCondition, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, depth: $depth, latitude: $latitude, longitude: $longitude, epicenterCode: $epicenterCode, epicenterDetailCode: $epicenterDetailCode, arrivalTime: $arrivalTime, originTime: $originTime, latestHeadline: $latestHeadline, maxIntensityRegionIds: $maxIntensityRegionIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeBaseComponentImpl &&
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
                .equals(other._maxIntensityRegionIds, _maxIntensityRegionIds));
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
      const DeepCollectionEquality().hash(_maxIntensityRegionIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeBaseComponentImplCopyWith<_$EarthquakeBaseComponentImpl>
      get copyWith => __$$EarthquakeBaseComponentImplCopyWithImpl<
          _$EarthquakeBaseComponentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeBaseComponentImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeBaseComponent implements EarthquakeBaseComponent {
  const factory _EarthquakeBaseComponent(
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
      final List<int>? maxIntensityRegionIds}) = _$EarthquakeBaseComponentImpl;

  factory _EarthquakeBaseComponent.fromJson(Map<String, dynamic> json) =
      _$EarthquakeBaseComponentImpl.fromJson;

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
  List<int>? get maxIntensityRegionIds;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeBaseComponentImplCopyWith<_$EarthquakeBaseComponentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

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
  List<int>? get maxIntensityRegionIds => throw _privateConstructorUsedError;

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
      List<int>? maxIntensityRegionIds});
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
    Object? maxIntensityRegionIds = freezed,
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
      maxIntensityRegionIds: freezed == maxIntensityRegionIds
          ? _value.maxIntensityRegionIds
          : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
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
      List<int>? maxIntensityRegionIds});
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
    Object? maxIntensityRegionIds = freezed,
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
      maxIntensityRegionIds: freezed == maxIntensityRegionIds
          ? _value._maxIntensityRegionIds
          : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
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
      final List<int>? maxIntensityRegionIds})
      : _maxIntensityRegionIds = maxIntensityRegionIds;

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
  String toString() {
    return 'EarthquakeV1(id: $id, eventId: $eventId, status: $status, magnitude: $magnitude, magnitudeCondition: $magnitudeCondition, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, depth: $depth, latitude: $latitude, longitude: $longitude, epicenterCode: $epicenterCode, epicenterDetailCode: $epicenterDetailCode, arrivalTime: $arrivalTime, originTime: $originTime, latestHeadline: $latestHeadline, maxIntensityRegionIds: $maxIntensityRegionIds)';
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
                .equals(other._maxIntensityRegionIds, _maxIntensityRegionIds));
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
      const DeepCollectionEquality().hash(_maxIntensityRegionIds));

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
      final List<int>? maxIntensityRegionIds}) = _$EarthquakeV1Impl;

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
  List<int>? get maxIntensityRegionIds;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeV1ImplCopyWith<_$EarthquakeV1Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntensityObservationItem _$IntensityObservationItemFromJson(
    Map<String, dynamic> json) {
  return _IntensityObservationItem.fromJson(json);
}

/// @nodoc
mixin _$IntensityObservationItem {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  JmaIntensity get maxInt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IntensityObservationItemCopyWith<IntensityObservationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntensityObservationItemCopyWith<$Res> {
  factory $IntensityObservationItemCopyWith(IntensityObservationItem value,
          $Res Function(IntensityObservationItem) then) =
      _$IntensityObservationItemCopyWithImpl<$Res, IntensityObservationItem>;
  @useResult
  $Res call({String code, String name, JmaIntensity maxInt});
}

/// @nodoc
class _$IntensityObservationItemCopyWithImpl<$Res,
        $Val extends IntensityObservationItem>
    implements $IntensityObservationItemCopyWith<$Res> {
  _$IntensityObservationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? maxInt = null,
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
      maxInt: null == maxInt
          ? _value.maxInt
          : maxInt // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntensityObservationItemImplCopyWith<$Res>
    implements $IntensityObservationItemCopyWith<$Res> {
  factory _$$IntensityObservationItemImplCopyWith(
          _$IntensityObservationItemImpl value,
          $Res Function(_$IntensityObservationItemImpl) then) =
      __$$IntensityObservationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String name, JmaIntensity maxInt});
}

/// @nodoc
class __$$IntensityObservationItemImplCopyWithImpl<$Res>
    extends _$IntensityObservationItemCopyWithImpl<$Res,
        _$IntensityObservationItemImpl>
    implements _$$IntensityObservationItemImplCopyWith<$Res> {
  __$$IntensityObservationItemImplCopyWithImpl(
      _$IntensityObservationItemImpl _value,
      $Res Function(_$IntensityObservationItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? maxInt = null,
  }) {
    return _then(_$IntensityObservationItemImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxInt: null == maxInt
          ? _value.maxInt
          : maxInt // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntensityObservationItemImpl implements _IntensityObservationItem {
  const _$IntensityObservationItemImpl(
      {required this.code, required this.name, required this.maxInt});

  factory _$IntensityObservationItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntensityObservationItemImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final JmaIntensity maxInt;

  @override
  String toString() {
    return 'IntensityObservationItem(code: $code, name: $name, maxInt: $maxInt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntensityObservationItemImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxInt, maxInt) || other.maxInt == maxInt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, maxInt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntensityObservationItemImplCopyWith<_$IntensityObservationItemImpl>
      get copyWith => __$$IntensityObservationItemImplCopyWithImpl<
          _$IntensityObservationItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntensityObservationItemImplToJson(
      this,
    );
  }
}

abstract class _IntensityObservationItem implements IntensityObservationItem {
  const factory _IntensityObservationItem(
      {required final String code,
      required final String name,
      required final JmaIntensity maxInt}) = _$IntensityObservationItemImpl;

  factory _IntensityObservationItem.fromJson(Map<String, dynamic> json) =
      _$IntensityObservationItemImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  JmaIntensity get maxInt;
  @override
  @JsonKey(ignore: true)
  _$$IntensityObservationItemImplCopyWith<_$IntensityObservationItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

LgIntensityObservationItem _$LgIntensityObservationItemFromJson(
    Map<String, dynamic> json) {
  return _LgIntensityObservationItem.fromJson(json);
}

/// @nodoc
mixin _$LgIntensityObservationItem {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  JmaIntensity get maxInt => throw _privateConstructorUsedError;
  JmaLgIntensity get lgMaxInt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LgIntensityObservationItemCopyWith<LgIntensityObservationItem>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LgIntensityObservationItemCopyWith<$Res> {
  factory $LgIntensityObservationItemCopyWith(LgIntensityObservationItem value,
          $Res Function(LgIntensityObservationItem) then) =
      _$LgIntensityObservationItemCopyWithImpl<$Res,
          LgIntensityObservationItem>;
  @useResult
  $Res call(
      {String code, String name, JmaIntensity maxInt, JmaLgIntensity lgMaxInt});
}

/// @nodoc
class _$LgIntensityObservationItemCopyWithImpl<$Res,
        $Val extends LgIntensityObservationItem>
    implements $LgIntensityObservationItemCopyWith<$Res> {
  _$LgIntensityObservationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? maxInt = null,
    Object? lgMaxInt = null,
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
      maxInt: null == maxInt
          ? _value.maxInt
          : maxInt // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
      lgMaxInt: null == lgMaxInt
          ? _value.lgMaxInt
          : lgMaxInt // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LgIntensityObservationItemImplCopyWith<$Res>
    implements $LgIntensityObservationItemCopyWith<$Res> {
  factory _$$LgIntensityObservationItemImplCopyWith(
          _$LgIntensityObservationItemImpl value,
          $Res Function(_$LgIntensityObservationItemImpl) then) =
      __$$LgIntensityObservationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code, String name, JmaIntensity maxInt, JmaLgIntensity lgMaxInt});
}

/// @nodoc
class __$$LgIntensityObservationItemImplCopyWithImpl<$Res>
    extends _$LgIntensityObservationItemCopyWithImpl<$Res,
        _$LgIntensityObservationItemImpl>
    implements _$$LgIntensityObservationItemImplCopyWith<$Res> {
  __$$LgIntensityObservationItemImplCopyWithImpl(
      _$LgIntensityObservationItemImpl _value,
      $Res Function(_$LgIntensityObservationItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? maxInt = null,
    Object? lgMaxInt = null,
  }) {
    return _then(_$LgIntensityObservationItemImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxInt: null == maxInt
          ? _value.maxInt
          : maxInt // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
      lgMaxInt: null == lgMaxInt
          ? _value.lgMaxInt
          : lgMaxInt // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LgIntensityObservationItemImpl implements _LgIntensityObservationItem {
  const _$LgIntensityObservationItemImpl(
      {required this.code,
      required this.name,
      required this.maxInt,
      required this.lgMaxInt});

  factory _$LgIntensityObservationItemImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LgIntensityObservationItemImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final JmaIntensity maxInt;
  @override
  final JmaLgIntensity lgMaxInt;

  @override
  String toString() {
    return 'LgIntensityObservationItem(code: $code, name: $name, maxInt: $maxInt, lgMaxInt: $lgMaxInt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LgIntensityObservationItemImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxInt, maxInt) || other.maxInt == maxInt) &&
            (identical(other.lgMaxInt, lgMaxInt) ||
                other.lgMaxInt == lgMaxInt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, maxInt, lgMaxInt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LgIntensityObservationItemImplCopyWith<_$LgIntensityObservationItemImpl>
      get copyWith => __$$LgIntensityObservationItemImplCopyWithImpl<
          _$LgIntensityObservationItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LgIntensityObservationItemImplToJson(
      this,
    );
  }
}

abstract class _LgIntensityObservationItem
    implements LgIntensityObservationItem {
  const factory _LgIntensityObservationItem(
          {required final String code,
          required final String name,
          required final JmaIntensity maxInt,
          required final JmaLgIntensity lgMaxInt}) =
      _$LgIntensityObservationItemImpl;

  factory _LgIntensityObservationItem.fromJson(Map<String, dynamic> json) =
      _$LgIntensityObservationItemImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  JmaIntensity get maxInt;
  @override
  JmaLgIntensity get lgMaxInt;
  @override
  @JsonKey(ignore: true)
  _$$LgIntensityObservationItemImplCopyWith<_$LgIntensityObservationItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

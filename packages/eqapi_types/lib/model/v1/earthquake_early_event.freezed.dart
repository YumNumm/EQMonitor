// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_early_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EarthquakeEarlyEvent _$EarthquakeEarlyEventFromJson(Map<String, dynamic> json) {
  return _EarthquakeEarlyEvent.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeEarlyEvent {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get depth => throw _privateConstructorUsedError;
  DateTime get originTime => throw _privateConstructorUsedError;
  OriginTimePrecision get originTimePrecision =>
      throw _privateConstructorUsedError;
  JmaIntensity? get maxIntensity => throw _privateConstructorUsedError;
  bool get maxIntensityIsEarly => throw _privateConstructorUsedError;
  List<EarthquakeEarlyEventRegion> get regions =>
      throw _privateConstructorUsedError;
  List<EarthquakeEarlyEventObservationCity> get cities =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeEarlyEventCopyWith<EarthquakeEarlyEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeEarlyEventCopyWith<$Res> {
  factory $EarthquakeEarlyEventCopyWith(EarthquakeEarlyEvent value,
          $Res Function(EarthquakeEarlyEvent) then) =
      _$EarthquakeEarlyEventCopyWithImpl<$Res, EarthquakeEarlyEvent>;
  @useResult
  $Res call(
      {String id,
      String name,
      double? latitude,
      double? longitude,
      double? depth,
      DateTime originTime,
      OriginTimePrecision originTimePrecision,
      JmaIntensity? maxIntensity,
      bool maxIntensityIsEarly,
      List<EarthquakeEarlyEventRegion> regions,
      List<EarthquakeEarlyEventObservationCity> cities});
}

/// @nodoc
class _$EarthquakeEarlyEventCopyWithImpl<$Res,
        $Val extends EarthquakeEarlyEvent>
    implements $EarthquakeEarlyEventCopyWith<$Res> {
  _$EarthquakeEarlyEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? depth = freezed,
    Object? originTime = null,
    Object? originTimePrecision = null,
    Object? maxIntensity = freezed,
    Object? maxIntensityIsEarly = null,
    Object? regions = null,
    Object? cities = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as double?,
      originTime: null == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      originTimePrecision: null == originTimePrecision
          ? _value.originTimePrecision
          : originTimePrecision // ignore: cast_nullable_to_non_nullable
              as OriginTimePrecision,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      maxIntensityIsEarly: null == maxIntensityIsEarly
          ? _value.maxIntensityIsEarly
          : maxIntensityIsEarly // ignore: cast_nullable_to_non_nullable
              as bool,
      regions: null == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<EarthquakeEarlyEventRegion>,
      cities: null == cities
          ? _value.cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<EarthquakeEarlyEventObservationCity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeEarlyEventImplCopyWith<$Res>
    implements $EarthquakeEarlyEventCopyWith<$Res> {
  factory _$$EarthquakeEarlyEventImplCopyWith(_$EarthquakeEarlyEventImpl value,
          $Res Function(_$EarthquakeEarlyEventImpl) then) =
      __$$EarthquakeEarlyEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double? latitude,
      double? longitude,
      double? depth,
      DateTime originTime,
      OriginTimePrecision originTimePrecision,
      JmaIntensity? maxIntensity,
      bool maxIntensityIsEarly,
      List<EarthquakeEarlyEventRegion> regions,
      List<EarthquakeEarlyEventObservationCity> cities});
}

/// @nodoc
class __$$EarthquakeEarlyEventImplCopyWithImpl<$Res>
    extends _$EarthquakeEarlyEventCopyWithImpl<$Res, _$EarthquakeEarlyEventImpl>
    implements _$$EarthquakeEarlyEventImplCopyWith<$Res> {
  __$$EarthquakeEarlyEventImplCopyWithImpl(_$EarthquakeEarlyEventImpl _value,
      $Res Function(_$EarthquakeEarlyEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? depth = freezed,
    Object? originTime = null,
    Object? originTimePrecision = null,
    Object? maxIntensity = freezed,
    Object? maxIntensityIsEarly = null,
    Object? regions = null,
    Object? cities = null,
  }) {
    return _then(_$EarthquakeEarlyEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as double?,
      originTime: null == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      originTimePrecision: null == originTimePrecision
          ? _value.originTimePrecision
          : originTimePrecision // ignore: cast_nullable_to_non_nullable
              as OriginTimePrecision,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      maxIntensityIsEarly: null == maxIntensityIsEarly
          ? _value.maxIntensityIsEarly
          : maxIntensityIsEarly // ignore: cast_nullable_to_non_nullable
              as bool,
      regions: null == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<EarthquakeEarlyEventRegion>,
      cities: null == cities
          ? _value._cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<EarthquakeEarlyEventObservationCity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeEarlyEventImpl implements _EarthquakeEarlyEvent {
  const _$EarthquakeEarlyEventImpl(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.depth,
      required this.originTime,
      required this.originTimePrecision,
      required this.maxIntensity,
      required this.maxIntensityIsEarly,
      required final List<EarthquakeEarlyEventRegion> regions,
      required final List<EarthquakeEarlyEventObservationCity> cities})
      : _regions = regions,
        _cities = cities;

  factory _$EarthquakeEarlyEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeEarlyEventImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final double? depth;
  @override
  final DateTime originTime;
  @override
  final OriginTimePrecision originTimePrecision;
  @override
  final JmaIntensity? maxIntensity;
  @override
  final bool maxIntensityIsEarly;
  final List<EarthquakeEarlyEventRegion> _regions;
  @override
  List<EarthquakeEarlyEventRegion> get regions {
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regions);
  }

  final List<EarthquakeEarlyEventObservationCity> _cities;
  @override
  List<EarthquakeEarlyEventObservationCity> get cities {
    if (_cities is EqualUnmodifiableListView) return _cities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cities);
  }

  @override
  String toString() {
    return 'EarthquakeEarlyEvent(id: $id, name: $name, latitude: $latitude, longitude: $longitude, depth: $depth, originTime: $originTime, originTimePrecision: $originTimePrecision, maxIntensity: $maxIntensity, maxIntensityIsEarly: $maxIntensityIsEarly, regions: $regions, cities: $cities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeEarlyEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.originTime, originTime) ||
                other.originTime == originTime) &&
            (identical(other.originTimePrecision, originTimePrecision) ||
                other.originTimePrecision == originTimePrecision) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            (identical(other.maxIntensityIsEarly, maxIntensityIsEarly) ||
                other.maxIntensityIsEarly == maxIntensityIsEarly) &&
            const DeepCollectionEquality().equals(other._regions, _regions) &&
            const DeepCollectionEquality().equals(other._cities, _cities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      latitude,
      longitude,
      depth,
      originTime,
      originTimePrecision,
      maxIntensity,
      maxIntensityIsEarly,
      const DeepCollectionEquality().hash(_regions),
      const DeepCollectionEquality().hash(_cities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeEarlyEventImplCopyWith<_$EarthquakeEarlyEventImpl>
      get copyWith =>
          __$$EarthquakeEarlyEventImplCopyWithImpl<_$EarthquakeEarlyEventImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeEarlyEventImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeEarlyEvent implements EarthquakeEarlyEvent {
  const factory _EarthquakeEarlyEvent(
          {required final String id,
          required final String name,
          required final double? latitude,
          required final double? longitude,
          required final double? depth,
          required final DateTime originTime,
          required final OriginTimePrecision originTimePrecision,
          required final JmaIntensity? maxIntensity,
          required final bool maxIntensityIsEarly,
          required final List<EarthquakeEarlyEventRegion> regions,
          required final List<EarthquakeEarlyEventObservationCity> cities}) =
      _$EarthquakeEarlyEventImpl;

  factory _EarthquakeEarlyEvent.fromJson(Map<String, dynamic> json) =
      _$EarthquakeEarlyEventImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  double? get depth;
  @override
  DateTime get originTime;
  @override
  OriginTimePrecision get originTimePrecision;
  @override
  JmaIntensity? get maxIntensity;
  @override
  bool get maxIntensityIsEarly;
  @override
  List<EarthquakeEarlyEventRegion> get regions;
  @override
  List<EarthquakeEarlyEventObservationCity> get cities;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeEarlyEventImplCopyWith<_$EarthquakeEarlyEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EarthquakeEarlyEventRegion _$EarthquakeEarlyEventRegionFromJson(
    Map<String, dynamic> json) {
  return _EarthquakeEarlyEventRegion.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeEarlyEventRegion {
  String? get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  JmaIntensity? get maxIntensity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeEarlyEventRegionCopyWith<EarthquakeEarlyEventRegion>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeEarlyEventRegionCopyWith<$Res> {
  factory $EarthquakeEarlyEventRegionCopyWith(EarthquakeEarlyEventRegion value,
          $Res Function(EarthquakeEarlyEventRegion) then) =
      _$EarthquakeEarlyEventRegionCopyWithImpl<$Res,
          EarthquakeEarlyEventRegion>;
  @useResult
  $Res call({String? name, String? code, JmaIntensity? maxIntensity});
}

/// @nodoc
class _$EarthquakeEarlyEventRegionCopyWithImpl<$Res,
        $Val extends EarthquakeEarlyEventRegion>
    implements $EarthquakeEarlyEventRegionCopyWith<$Res> {
  _$EarthquakeEarlyEventRegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? maxIntensity = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeEarlyEventRegionImplCopyWith<$Res>
    implements $EarthquakeEarlyEventRegionCopyWith<$Res> {
  factory _$$EarthquakeEarlyEventRegionImplCopyWith(
          _$EarthquakeEarlyEventRegionImpl value,
          $Res Function(_$EarthquakeEarlyEventRegionImpl) then) =
      __$$EarthquakeEarlyEventRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? code, JmaIntensity? maxIntensity});
}

/// @nodoc
class __$$EarthquakeEarlyEventRegionImplCopyWithImpl<$Res>
    extends _$EarthquakeEarlyEventRegionCopyWithImpl<$Res,
        _$EarthquakeEarlyEventRegionImpl>
    implements _$$EarthquakeEarlyEventRegionImplCopyWith<$Res> {
  __$$EarthquakeEarlyEventRegionImplCopyWithImpl(
      _$EarthquakeEarlyEventRegionImpl _value,
      $Res Function(_$EarthquakeEarlyEventRegionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? maxIntensity = freezed,
  }) {
    return _then(_$EarthquakeEarlyEventRegionImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeEarlyEventRegionImpl implements _EarthquakeEarlyEventRegion {
  const _$EarthquakeEarlyEventRegionImpl(
      {required this.name, required this.code, required this.maxIntensity});

  factory _$EarthquakeEarlyEventRegionImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EarthquakeEarlyEventRegionImplFromJson(json);

  @override
  final String? name;
  @override
  final String? code;
  @override
  final JmaIntensity? maxIntensity;

  @override
  String toString() {
    return 'EarthquakeEarlyEventRegion(name: $name, code: $code, maxIntensity: $maxIntensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeEarlyEventRegionImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, code, maxIntensity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeEarlyEventRegionImplCopyWith<_$EarthquakeEarlyEventRegionImpl>
      get copyWith => __$$EarthquakeEarlyEventRegionImplCopyWithImpl<
          _$EarthquakeEarlyEventRegionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeEarlyEventRegionImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeEarlyEventRegion
    implements EarthquakeEarlyEventRegion {
  const factory _EarthquakeEarlyEventRegion(
          {required final String? name,
          required final String? code,
          required final JmaIntensity? maxIntensity}) =
      _$EarthquakeEarlyEventRegionImpl;

  factory _EarthquakeEarlyEventRegion.fromJson(Map<String, dynamic> json) =
      _$EarthquakeEarlyEventRegionImpl.fromJson;

  @override
  String? get name;
  @override
  String? get code;
  @override
  JmaIntensity? get maxIntensity;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeEarlyEventRegionImplCopyWith<_$EarthquakeEarlyEventRegionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EarthquakeEarlyEventObservationCity
    _$EarthquakeEarlyEventObservationCityFromJson(Map<String, dynamic> json) {
  return _EarthquakeEarlyEventObservationCity.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeEarlyEventObservationCity {
  String get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  JmaIntensity? get maxIntensity => throw _privateConstructorUsedError;
  List<EarthquakeEarlyEventObservationPoint> get observationPoints =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeEarlyEventObservationCityCopyWith<
          EarthquakeEarlyEventObservationCity>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeEarlyEventObservationCityCopyWith<$Res> {
  factory $EarthquakeEarlyEventObservationCityCopyWith(
          EarthquakeEarlyEventObservationCity value,
          $Res Function(EarthquakeEarlyEventObservationCity) then) =
      _$EarthquakeEarlyEventObservationCityCopyWithImpl<$Res,
          EarthquakeEarlyEventObservationCity>;
  @useResult
  $Res call(
      {String name,
      String? code,
      JmaIntensity? maxIntensity,
      List<EarthquakeEarlyEventObservationPoint> observationPoints});
}

/// @nodoc
class _$EarthquakeEarlyEventObservationCityCopyWithImpl<$Res,
        $Val extends EarthquakeEarlyEventObservationCity>
    implements $EarthquakeEarlyEventObservationCityCopyWith<$Res> {
  _$EarthquakeEarlyEventObservationCityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = freezed,
    Object? maxIntensity = freezed,
    Object? observationPoints = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      observationPoints: null == observationPoints
          ? _value.observationPoints
          : observationPoints // ignore: cast_nullable_to_non_nullable
              as List<EarthquakeEarlyEventObservationPoint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeEarlyEventObservationCityImplCopyWith<$Res>
    implements $EarthquakeEarlyEventObservationCityCopyWith<$Res> {
  factory _$$EarthquakeEarlyEventObservationCityImplCopyWith(
          _$EarthquakeEarlyEventObservationCityImpl value,
          $Res Function(_$EarthquakeEarlyEventObservationCityImpl) then) =
      __$$EarthquakeEarlyEventObservationCityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? code,
      JmaIntensity? maxIntensity,
      List<EarthquakeEarlyEventObservationPoint> observationPoints});
}

/// @nodoc
class __$$EarthquakeEarlyEventObservationCityImplCopyWithImpl<$Res>
    extends _$EarthquakeEarlyEventObservationCityCopyWithImpl<$Res,
        _$EarthquakeEarlyEventObservationCityImpl>
    implements _$$EarthquakeEarlyEventObservationCityImplCopyWith<$Res> {
  __$$EarthquakeEarlyEventObservationCityImplCopyWithImpl(
      _$EarthquakeEarlyEventObservationCityImpl _value,
      $Res Function(_$EarthquakeEarlyEventObservationCityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = freezed,
    Object? maxIntensity = freezed,
    Object? observationPoints = null,
  }) {
    return _then(_$EarthquakeEarlyEventObservationCityImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      observationPoints: null == observationPoints
          ? _value._observationPoints
          : observationPoints // ignore: cast_nullable_to_non_nullable
              as List<EarthquakeEarlyEventObservationPoint>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeEarlyEventObservationCityImpl
    implements _EarthquakeEarlyEventObservationCity {
  const _$EarthquakeEarlyEventObservationCityImpl(
      {required this.name,
      required this.code,
      required this.maxIntensity,
      required final List<EarthquakeEarlyEventObservationPoint>
          observationPoints})
      : _observationPoints = observationPoints;

  factory _$EarthquakeEarlyEventObservationCityImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EarthquakeEarlyEventObservationCityImplFromJson(json);

  @override
  final String name;
  @override
  final String? code;
  @override
  final JmaIntensity? maxIntensity;
  final List<EarthquakeEarlyEventObservationPoint> _observationPoints;
  @override
  List<EarthquakeEarlyEventObservationPoint> get observationPoints {
    if (_observationPoints is EqualUnmodifiableListView)
      return _observationPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_observationPoints);
  }

  @override
  String toString() {
    return 'EarthquakeEarlyEventObservationCity(name: $name, code: $code, maxIntensity: $maxIntensity, observationPoints: $observationPoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeEarlyEventObservationCityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            const DeepCollectionEquality()
                .equals(other._observationPoints, _observationPoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, code, maxIntensity,
      const DeepCollectionEquality().hash(_observationPoints));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeEarlyEventObservationCityImplCopyWith<
          _$EarthquakeEarlyEventObservationCityImpl>
      get copyWith => __$$EarthquakeEarlyEventObservationCityImplCopyWithImpl<
          _$EarthquakeEarlyEventObservationCityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeEarlyEventObservationCityImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeEarlyEventObservationCity
    implements EarthquakeEarlyEventObservationCity {
  const factory _EarthquakeEarlyEventObservationCity(
      {required final String name,
      required final String? code,
      required final JmaIntensity? maxIntensity,
      required final List<EarthquakeEarlyEventObservationPoint>
          observationPoints}) = _$EarthquakeEarlyEventObservationCityImpl;

  factory _EarthquakeEarlyEventObservationCity.fromJson(
          Map<String, dynamic> json) =
      _$EarthquakeEarlyEventObservationCityImpl.fromJson;

  @override
  String get name;
  @override
  String? get code;
  @override
  JmaIntensity? get maxIntensity;
  @override
  List<EarthquakeEarlyEventObservationPoint> get observationPoints;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeEarlyEventObservationCityImplCopyWith<
          _$EarthquakeEarlyEventObservationCityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EarthquakeEarlyEventObservationPoint
    _$EarthquakeEarlyEventObservationPointFromJson(Map<String, dynamic> json) {
  return _EarthquakeEarlyEventObservationPoint.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeEarlyEventObservationPoint {
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  JmaIntensity get intensity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeEarlyEventObservationPointCopyWith<
          EarthquakeEarlyEventObservationPoint>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeEarlyEventObservationPointCopyWith<$Res> {
  factory $EarthquakeEarlyEventObservationPointCopyWith(
          EarthquakeEarlyEventObservationPoint value,
          $Res Function(EarthquakeEarlyEventObservationPoint) then) =
      _$EarthquakeEarlyEventObservationPointCopyWithImpl<$Res,
          EarthquakeEarlyEventObservationPoint>;
  @useResult
  $Res call({double lat, double lon, String name, JmaIntensity intensity});
}

/// @nodoc
class _$EarthquakeEarlyEventObservationPointCopyWithImpl<$Res,
        $Val extends EarthquakeEarlyEventObservationPoint>
    implements $EarthquakeEarlyEventObservationPointCopyWith<$Res> {
  _$EarthquakeEarlyEventObservationPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lon = null,
    Object? name = null,
    Object? intensity = null,
  }) {
    return _then(_value.copyWith(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeEarlyEventObservationPointImplCopyWith<$Res>
    implements $EarthquakeEarlyEventObservationPointCopyWith<$Res> {
  factory _$$EarthquakeEarlyEventObservationPointImplCopyWith(
          _$EarthquakeEarlyEventObservationPointImpl value,
          $Res Function(_$EarthquakeEarlyEventObservationPointImpl) then) =
      __$$EarthquakeEarlyEventObservationPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lon, String name, JmaIntensity intensity});
}

/// @nodoc
class __$$EarthquakeEarlyEventObservationPointImplCopyWithImpl<$Res>
    extends _$EarthquakeEarlyEventObservationPointCopyWithImpl<$Res,
        _$EarthquakeEarlyEventObservationPointImpl>
    implements _$$EarthquakeEarlyEventObservationPointImplCopyWith<$Res> {
  __$$EarthquakeEarlyEventObservationPointImplCopyWithImpl(
      _$EarthquakeEarlyEventObservationPointImpl _value,
      $Res Function(_$EarthquakeEarlyEventObservationPointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lon = null,
    Object? name = null,
    Object? intensity = null,
  }) {
    return _then(_$EarthquakeEarlyEventObservationPointImpl(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeEarlyEventObservationPointImpl
    implements _EarthquakeEarlyEventObservationPoint {
  const _$EarthquakeEarlyEventObservationPointImpl(
      {required this.lat,
      required this.lon,
      required this.name,
      required this.intensity});

  factory _$EarthquakeEarlyEventObservationPointImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EarthquakeEarlyEventObservationPointImplFromJson(json);

  @override
  final double lat;
  @override
  final double lon;
  @override
  final String name;
  @override
  final JmaIntensity intensity;

  @override
  String toString() {
    return 'EarthquakeEarlyEventObservationPoint(lat: $lat, lon: $lon, name: $name, intensity: $intensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeEarlyEventObservationPointImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lon, name, intensity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeEarlyEventObservationPointImplCopyWith<
          _$EarthquakeEarlyEventObservationPointImpl>
      get copyWith => __$$EarthquakeEarlyEventObservationPointImplCopyWithImpl<
          _$EarthquakeEarlyEventObservationPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeEarlyEventObservationPointImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeEarlyEventObservationPoint
    implements EarthquakeEarlyEventObservationPoint {
  const factory _EarthquakeEarlyEventObservationPoint(
          {required final double lat,
          required final double lon,
          required final String name,
          required final JmaIntensity intensity}) =
      _$EarthquakeEarlyEventObservationPointImpl;

  factory _EarthquakeEarlyEventObservationPoint.fromJson(
          Map<String, dynamic> json) =
      _$EarthquakeEarlyEventObservationPointImpl.fromJson;

  @override
  double get lat;
  @override
  double get lon;
  @override
  String get name;
  @override
  JmaIntensity get intensity;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeEarlyEventObservationPointImplCopyWith<
          _$EarthquakeEarlyEventObservationPointImpl>
      get copyWith => throw _privateConstructorUsedError;
}

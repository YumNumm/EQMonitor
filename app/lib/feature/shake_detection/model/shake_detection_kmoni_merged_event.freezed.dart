// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_kmoni_merged_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShakeDetectionKmoniMergedEvent _$ShakeDetectionKmoniMergedEventFromJson(
    Map<String, dynamic> json) {
  return _ShakeDetectionKmoniMergedEvent.fromJson(json);
}

/// @nodoc
mixin _$ShakeDetectionKmoniMergedEvent {
  ShakeDetectionEvent get event => throw _privateConstructorUsedError;
  List<ShakeDetectionKmoniMergedRegion> get regions =>
      throw _privateConstructorUsedError;

  /// Serializes this ShakeDetectionKmoniMergedEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShakeDetectionKmoniMergedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShakeDetectionKmoniMergedEventCopyWith<ShakeDetectionKmoniMergedEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShakeDetectionKmoniMergedEventCopyWith<$Res> {
  factory $ShakeDetectionKmoniMergedEventCopyWith(
          ShakeDetectionKmoniMergedEvent value,
          $Res Function(ShakeDetectionKmoniMergedEvent) then) =
      _$ShakeDetectionKmoniMergedEventCopyWithImpl<$Res,
          ShakeDetectionKmoniMergedEvent>;
  @useResult
  $Res call(
      {ShakeDetectionEvent event,
      List<ShakeDetectionKmoniMergedRegion> regions});

  $ShakeDetectionEventCopyWith<$Res> get event;
}

/// @nodoc
class _$ShakeDetectionKmoniMergedEventCopyWithImpl<$Res,
        $Val extends ShakeDetectionKmoniMergedEvent>
    implements $ShakeDetectionKmoniMergedEventCopyWith<$Res> {
  _$ShakeDetectionKmoniMergedEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShakeDetectionKmoniMergedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? regions = null,
  }) {
    return _then(_value.copyWith(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as ShakeDetectionEvent,
      regions: null == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<ShakeDetectionKmoniMergedRegion>,
    ) as $Val);
  }

  /// Create a copy of ShakeDetectionKmoniMergedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShakeDetectionEventCopyWith<$Res> get event {
    return $ShakeDetectionEventCopyWith<$Res>(_value.event, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShakeDetectionKmoniMergedEventImplCopyWith<$Res>
    implements $ShakeDetectionKmoniMergedEventCopyWith<$Res> {
  factory _$$ShakeDetectionKmoniMergedEventImplCopyWith(
          _$ShakeDetectionKmoniMergedEventImpl value,
          $Res Function(_$ShakeDetectionKmoniMergedEventImpl) then) =
      __$$ShakeDetectionKmoniMergedEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ShakeDetectionEvent event,
      List<ShakeDetectionKmoniMergedRegion> regions});

  @override
  $ShakeDetectionEventCopyWith<$Res> get event;
}

/// @nodoc
class __$$ShakeDetectionKmoniMergedEventImplCopyWithImpl<$Res>
    extends _$ShakeDetectionKmoniMergedEventCopyWithImpl<$Res,
        _$ShakeDetectionKmoniMergedEventImpl>
    implements _$$ShakeDetectionKmoniMergedEventImplCopyWith<$Res> {
  __$$ShakeDetectionKmoniMergedEventImplCopyWithImpl(
      _$ShakeDetectionKmoniMergedEventImpl _value,
      $Res Function(_$ShakeDetectionKmoniMergedEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShakeDetectionKmoniMergedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? regions = null,
  }) {
    return _then(_$ShakeDetectionKmoniMergedEventImpl(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as ShakeDetectionEvent,
      regions: null == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<ShakeDetectionKmoniMergedRegion>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShakeDetectionKmoniMergedEventImpl
    implements _ShakeDetectionKmoniMergedEvent {
  const _$ShakeDetectionKmoniMergedEventImpl(
      {required this.event,
      required final List<ShakeDetectionKmoniMergedRegion> regions})
      : _regions = regions;

  factory _$ShakeDetectionKmoniMergedEventImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ShakeDetectionKmoniMergedEventImplFromJson(json);

  @override
  final ShakeDetectionEvent event;
  final List<ShakeDetectionKmoniMergedRegion> _regions;
  @override
  List<ShakeDetectionKmoniMergedRegion> get regions {
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regions);
  }

  @override
  String toString() {
    return 'ShakeDetectionKmoniMergedEvent(event: $event, regions: $regions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShakeDetectionKmoniMergedEventImpl &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality().equals(other._regions, _regions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, event, const DeepCollectionEquality().hash(_regions));

  /// Create a copy of ShakeDetectionKmoniMergedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShakeDetectionKmoniMergedEventImplCopyWith<
          _$ShakeDetectionKmoniMergedEventImpl>
      get copyWith => __$$ShakeDetectionKmoniMergedEventImplCopyWithImpl<
          _$ShakeDetectionKmoniMergedEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShakeDetectionKmoniMergedEventImplToJson(
      this,
    );
  }
}

abstract class _ShakeDetectionKmoniMergedEvent
    implements ShakeDetectionKmoniMergedEvent {
  const factory _ShakeDetectionKmoniMergedEvent(
          {required final ShakeDetectionEvent event,
          required final List<ShakeDetectionKmoniMergedRegion> regions}) =
      _$ShakeDetectionKmoniMergedEventImpl;

  factory _ShakeDetectionKmoniMergedEvent.fromJson(Map<String, dynamic> json) =
      _$ShakeDetectionKmoniMergedEventImpl.fromJson;

  @override
  ShakeDetectionEvent get event;
  @override
  List<ShakeDetectionKmoniMergedRegion> get regions;

  /// Create a copy of ShakeDetectionKmoniMergedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShakeDetectionKmoniMergedEventImplCopyWith<
          _$ShakeDetectionKmoniMergedEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ShakeDetectionKmoniMergedRegion _$ShakeDetectionKmoniMergedRegionFromJson(
    Map<String, dynamic> json) {
  return _ShakeDetectionKmoniMergedRegion.fromJson(json);
}

/// @nodoc
mixin _$ShakeDetectionKmoniMergedRegion {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'maxIntensity',
      unknownEnumValue: JmaForecastIntensity.unknown,
      defaultValue: JmaForecastIntensity.unknown)
  JmaForecastIntensity get maxIntensity => throw _privateConstructorUsedError;
  List<ShakeDetectionKmoniMergedPoint> get points =>
      throw _privateConstructorUsedError;

  /// Serializes this ShakeDetectionKmoniMergedRegion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShakeDetectionKmoniMergedRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShakeDetectionKmoniMergedRegionCopyWith<ShakeDetectionKmoniMergedRegion>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShakeDetectionKmoniMergedRegionCopyWith<$Res> {
  factory $ShakeDetectionKmoniMergedRegionCopyWith(
          ShakeDetectionKmoniMergedRegion value,
          $Res Function(ShakeDetectionKmoniMergedRegion) then) =
      _$ShakeDetectionKmoniMergedRegionCopyWithImpl<$Res,
          ShakeDetectionKmoniMergedRegion>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(
          name: 'maxIntensity',
          unknownEnumValue: JmaForecastIntensity.unknown,
          defaultValue: JmaForecastIntensity.unknown)
      JmaForecastIntensity maxIntensity,
      List<ShakeDetectionKmoniMergedPoint> points});
}

/// @nodoc
class _$ShakeDetectionKmoniMergedRegionCopyWithImpl<$Res,
        $Val extends ShakeDetectionKmoniMergedRegion>
    implements $ShakeDetectionKmoniMergedRegionCopyWith<$Res> {
  _$ShakeDetectionKmoniMergedRegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShakeDetectionKmoniMergedRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? maxIntensity = null,
    Object? points = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxIntensity: null == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<ShakeDetectionKmoniMergedPoint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShakeDetectionKmoniMergedRegionImplCopyWith<$Res>
    implements $ShakeDetectionKmoniMergedRegionCopyWith<$Res> {
  factory _$$ShakeDetectionKmoniMergedRegionImplCopyWith(
          _$ShakeDetectionKmoniMergedRegionImpl value,
          $Res Function(_$ShakeDetectionKmoniMergedRegionImpl) then) =
      __$$ShakeDetectionKmoniMergedRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(
          name: 'maxIntensity',
          unknownEnumValue: JmaForecastIntensity.unknown,
          defaultValue: JmaForecastIntensity.unknown)
      JmaForecastIntensity maxIntensity,
      List<ShakeDetectionKmoniMergedPoint> points});
}

/// @nodoc
class __$$ShakeDetectionKmoniMergedRegionImplCopyWithImpl<$Res>
    extends _$ShakeDetectionKmoniMergedRegionCopyWithImpl<$Res,
        _$ShakeDetectionKmoniMergedRegionImpl>
    implements _$$ShakeDetectionKmoniMergedRegionImplCopyWith<$Res> {
  __$$ShakeDetectionKmoniMergedRegionImplCopyWithImpl(
      _$ShakeDetectionKmoniMergedRegionImpl _value,
      $Res Function(_$ShakeDetectionKmoniMergedRegionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShakeDetectionKmoniMergedRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? maxIntensity = null,
    Object? points = null,
  }) {
    return _then(_$ShakeDetectionKmoniMergedRegionImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxIntensity: null == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      points: null == points
          ? _value._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<ShakeDetectionKmoniMergedPoint>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShakeDetectionKmoniMergedRegionImpl
    implements _ShakeDetectionKmoniMergedRegion {
  const _$ShakeDetectionKmoniMergedRegionImpl(
      {required this.name,
      @JsonKey(
          name: 'maxIntensity',
          unknownEnumValue: JmaForecastIntensity.unknown,
          defaultValue: JmaForecastIntensity.unknown)
      required this.maxIntensity,
      required final List<ShakeDetectionKmoniMergedPoint> points})
      : _points = points;

  factory _$ShakeDetectionKmoniMergedRegionImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ShakeDetectionKmoniMergedRegionImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(
      name: 'maxIntensity',
      unknownEnumValue: JmaForecastIntensity.unknown,
      defaultValue: JmaForecastIntensity.unknown)
  final JmaForecastIntensity maxIntensity;
  final List<ShakeDetectionKmoniMergedPoint> _points;
  @override
  List<ShakeDetectionKmoniMergedPoint> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  String toString() {
    return 'ShakeDetectionKmoniMergedRegion(name: $name, maxIntensity: $maxIntensity, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShakeDetectionKmoniMergedRegionImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            const DeepCollectionEquality().equals(other._points, _points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, maxIntensity,
      const DeepCollectionEquality().hash(_points));

  /// Create a copy of ShakeDetectionKmoniMergedRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShakeDetectionKmoniMergedRegionImplCopyWith<
          _$ShakeDetectionKmoniMergedRegionImpl>
      get copyWith => __$$ShakeDetectionKmoniMergedRegionImplCopyWithImpl<
          _$ShakeDetectionKmoniMergedRegionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShakeDetectionKmoniMergedRegionImplToJson(
      this,
    );
  }
}

abstract class _ShakeDetectionKmoniMergedRegion
    implements ShakeDetectionKmoniMergedRegion {
  const factory _ShakeDetectionKmoniMergedRegion(
          {required final String name,
          @JsonKey(
              name: 'maxIntensity',
              unknownEnumValue: JmaForecastIntensity.unknown,
              defaultValue: JmaForecastIntensity.unknown)
          required final JmaForecastIntensity maxIntensity,
          required final List<ShakeDetectionKmoniMergedPoint> points}) =
      _$ShakeDetectionKmoniMergedRegionImpl;

  factory _ShakeDetectionKmoniMergedRegion.fromJson(Map<String, dynamic> json) =
      _$ShakeDetectionKmoniMergedRegionImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(
      name: 'maxIntensity',
      unknownEnumValue: JmaForecastIntensity.unknown,
      defaultValue: JmaForecastIntensity.unknown)
  JmaForecastIntensity get maxIntensity;
  @override
  List<ShakeDetectionKmoniMergedPoint> get points;

  /// Create a copy of ShakeDetectionKmoniMergedRegion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShakeDetectionKmoniMergedRegionImplCopyWith<
          _$ShakeDetectionKmoniMergedRegionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ShakeDetectionKmoniMergedPoint _$ShakeDetectionKmoniMergedPointFromJson(
    Map<String, dynamic> json) {
  return _ShakeDetectionKmoniMergedPoint.fromJson(json);
}

/// @nodoc
mixin _$ShakeDetectionKmoniMergedPoint {
  @JsonKey(
      unknownEnumValue: JmaForecastIntensity.unknown,
      defaultValue: JmaForecastIntensity.unknown)
  JmaForecastIntensity get intensity => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  @JsonKey(fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson)
  KyoshinObservationPoint get point => throw _privateConstructorUsedError;

  /// Serializes this ShakeDetectionKmoniMergedPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShakeDetectionKmoniMergedPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShakeDetectionKmoniMergedPointCopyWith<ShakeDetectionKmoniMergedPoint>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShakeDetectionKmoniMergedPointCopyWith<$Res> {
  factory $ShakeDetectionKmoniMergedPointCopyWith(
          ShakeDetectionKmoniMergedPoint value,
          $Res Function(ShakeDetectionKmoniMergedPoint) then) =
      _$ShakeDetectionKmoniMergedPointCopyWithImpl<$Res,
          ShakeDetectionKmoniMergedPoint>;
  @useResult
  $Res call(
      {@JsonKey(
          unknownEnumValue: JmaForecastIntensity.unknown,
          defaultValue: JmaForecastIntensity.unknown)
      JmaForecastIntensity intensity,
      String code,
      @JsonKey(fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson)
      KyoshinObservationPoint point});
}

/// @nodoc
class _$ShakeDetectionKmoniMergedPointCopyWithImpl<$Res,
        $Val extends ShakeDetectionKmoniMergedPoint>
    implements $ShakeDetectionKmoniMergedPointCopyWith<$Res> {
  _$ShakeDetectionKmoniMergedPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShakeDetectionKmoniMergedPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensity = null,
    Object? code = null,
    Object? point = null,
  }) {
    return _then(_value.copyWith(
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as KyoshinObservationPoint,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShakeDetectionKmoniMergedPointImplCopyWith<$Res>
    implements $ShakeDetectionKmoniMergedPointCopyWith<$Res> {
  factory _$$ShakeDetectionKmoniMergedPointImplCopyWith(
          _$ShakeDetectionKmoniMergedPointImpl value,
          $Res Function(_$ShakeDetectionKmoniMergedPointImpl) then) =
      __$$ShakeDetectionKmoniMergedPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          unknownEnumValue: JmaForecastIntensity.unknown,
          defaultValue: JmaForecastIntensity.unknown)
      JmaForecastIntensity intensity,
      String code,
      @JsonKey(fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson)
      KyoshinObservationPoint point});
}

/// @nodoc
class __$$ShakeDetectionKmoniMergedPointImplCopyWithImpl<$Res>
    extends _$ShakeDetectionKmoniMergedPointCopyWithImpl<$Res,
        _$ShakeDetectionKmoniMergedPointImpl>
    implements _$$ShakeDetectionKmoniMergedPointImplCopyWith<$Res> {
  __$$ShakeDetectionKmoniMergedPointImplCopyWithImpl(
      _$ShakeDetectionKmoniMergedPointImpl _value,
      $Res Function(_$ShakeDetectionKmoniMergedPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShakeDetectionKmoniMergedPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensity = null,
    Object? code = null,
    Object? point = null,
  }) {
    return _then(_$ShakeDetectionKmoniMergedPointImpl(
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as KyoshinObservationPoint,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShakeDetectionKmoniMergedPointImpl
    implements _ShakeDetectionKmoniMergedPoint {
  const _$ShakeDetectionKmoniMergedPointImpl(
      {@JsonKey(
          unknownEnumValue: JmaForecastIntensity.unknown,
          defaultValue: JmaForecastIntensity.unknown)
      required this.intensity,
      required this.code,
      @JsonKey(fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson)
      required this.point});

  factory _$ShakeDetectionKmoniMergedPointImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ShakeDetectionKmoniMergedPointImplFromJson(json);

  @override
  @JsonKey(
      unknownEnumValue: JmaForecastIntensity.unknown,
      defaultValue: JmaForecastIntensity.unknown)
  final JmaForecastIntensity intensity;
  @override
  final String code;
  @override
  @JsonKey(fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson)
  final KyoshinObservationPoint point;

  @override
  String toString() {
    return 'ShakeDetectionKmoniMergedPoint(intensity: $intensity, code: $code, point: $point)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShakeDetectionKmoniMergedPointImpl &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.point, point) || other.point == point));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, intensity, code, point);

  /// Create a copy of ShakeDetectionKmoniMergedPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShakeDetectionKmoniMergedPointImplCopyWith<
          _$ShakeDetectionKmoniMergedPointImpl>
      get copyWith => __$$ShakeDetectionKmoniMergedPointImplCopyWithImpl<
          _$ShakeDetectionKmoniMergedPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShakeDetectionKmoniMergedPointImplToJson(
      this,
    );
  }
}

abstract class _ShakeDetectionKmoniMergedPoint
    implements ShakeDetectionKmoniMergedPoint {
  const factory _ShakeDetectionKmoniMergedPoint(
          {@JsonKey(
              unknownEnumValue: JmaForecastIntensity.unknown,
              defaultValue: JmaForecastIntensity.unknown)
          required final JmaForecastIntensity intensity,
          required final String code,
          @JsonKey(
              fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson)
          required final KyoshinObservationPoint point}) =
      _$ShakeDetectionKmoniMergedPointImpl;

  factory _ShakeDetectionKmoniMergedPoint.fromJson(Map<String, dynamic> json) =
      _$ShakeDetectionKmoniMergedPointImpl.fromJson;

  @override
  @JsonKey(
      unknownEnumValue: JmaForecastIntensity.unknown,
      defaultValue: JmaForecastIntensity.unknown)
  JmaForecastIntensity get intensity;
  @override
  String get code;
  @override
  @JsonKey(fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson)
  KyoshinObservationPoint get point;

  /// Create a copy of ShakeDetectionKmoniMergedPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShakeDetectionKmoniMergedPointImplCopyWith<
          _$ShakeDetectionKmoniMergedPointImpl>
      get copyWith => throw _privateConstructorUsedError;
}

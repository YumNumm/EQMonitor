// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShakeDetectionEvent _$ShakeDetectionEventFromJson(Map<String, dynamic> json) {
  return _ShakeDetectionEvent.fromJson(json);
}

/// @nodoc
mixin _$ShakeDetectionEvent {
  int get id => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;
  int get serialNo => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get insertedAt => throw _privateConstructorUsedError;

  /// `Unknown`もしくは`Error`の場合、Nullにフォールバックされます
  @JsonKey(unknownEnumValue: null, defaultValue: null)
  JmaIntensity? get maxIntensity => throw _privateConstructorUsedError;
  List<ShakeDetectionRegion> get regions => throw _privateConstructorUsedError;
  ShakeDetectionLatLng get topLeft => throw _privateConstructorUsedError;
  ShakeDetectionLatLng get bottomRight => throw _privateConstructorUsedError;
  int get pointCount => throw _privateConstructorUsedError;

  /// Serializes this ShakeDetectionEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShakeDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShakeDetectionEventCopyWith<ShakeDetectionEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShakeDetectionEventCopyWith<$Res> {
  factory $ShakeDetectionEventCopyWith(
          ShakeDetectionEvent value, $Res Function(ShakeDetectionEvent) then) =
      _$ShakeDetectionEventCopyWithImpl<$Res, ShakeDetectionEvent>;
  @useResult
  $Res call(
      {int id,
      String eventId,
      int serialNo,
      DateTime createdAt,
      DateTime insertedAt,
      @JsonKey(unknownEnumValue: null, defaultValue: null)
      JmaIntensity? maxIntensity,
      List<ShakeDetectionRegion> regions,
      ShakeDetectionLatLng topLeft,
      ShakeDetectionLatLng bottomRight,
      int pointCount});

  $ShakeDetectionLatLngCopyWith<$Res> get topLeft;
  $ShakeDetectionLatLngCopyWith<$Res> get bottomRight;
}

/// @nodoc
class _$ShakeDetectionEventCopyWithImpl<$Res, $Val extends ShakeDetectionEvent>
    implements $ShakeDetectionEventCopyWith<$Res> {
  _$ShakeDetectionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShakeDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? serialNo = null,
    Object? createdAt = null,
    Object? insertedAt = null,
    Object? maxIntensity = freezed,
    Object? regions = null,
    Object? topLeft = null,
    Object? bottomRight = null,
    Object? pointCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      serialNo: null == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      insertedAt: null == insertedAt
          ? _value.insertedAt
          : insertedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      regions: null == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<ShakeDetectionRegion>,
      topLeft: null == topLeft
          ? _value.topLeft
          : topLeft // ignore: cast_nullable_to_non_nullable
              as ShakeDetectionLatLng,
      bottomRight: null == bottomRight
          ? _value.bottomRight
          : bottomRight // ignore: cast_nullable_to_non_nullable
              as ShakeDetectionLatLng,
      pointCount: null == pointCount
          ? _value.pointCount
          : pointCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of ShakeDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShakeDetectionLatLngCopyWith<$Res> get topLeft {
    return $ShakeDetectionLatLngCopyWith<$Res>(_value.topLeft, (value) {
      return _then(_value.copyWith(topLeft: value) as $Val);
    });
  }

  /// Create a copy of ShakeDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShakeDetectionLatLngCopyWith<$Res> get bottomRight {
    return $ShakeDetectionLatLngCopyWith<$Res>(_value.bottomRight, (value) {
      return _then(_value.copyWith(bottomRight: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShakeDetectionEventImplCopyWith<$Res>
    implements $ShakeDetectionEventCopyWith<$Res> {
  factory _$$ShakeDetectionEventImplCopyWith(_$ShakeDetectionEventImpl value,
          $Res Function(_$ShakeDetectionEventImpl) then) =
      __$$ShakeDetectionEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String eventId,
      int serialNo,
      DateTime createdAt,
      DateTime insertedAt,
      @JsonKey(unknownEnumValue: null, defaultValue: null)
      JmaIntensity? maxIntensity,
      List<ShakeDetectionRegion> regions,
      ShakeDetectionLatLng topLeft,
      ShakeDetectionLatLng bottomRight,
      int pointCount});

  @override
  $ShakeDetectionLatLngCopyWith<$Res> get topLeft;
  @override
  $ShakeDetectionLatLngCopyWith<$Res> get bottomRight;
}

/// @nodoc
class __$$ShakeDetectionEventImplCopyWithImpl<$Res>
    extends _$ShakeDetectionEventCopyWithImpl<$Res, _$ShakeDetectionEventImpl>
    implements _$$ShakeDetectionEventImplCopyWith<$Res> {
  __$$ShakeDetectionEventImplCopyWithImpl(_$ShakeDetectionEventImpl _value,
      $Res Function(_$ShakeDetectionEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShakeDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? serialNo = null,
    Object? createdAt = null,
    Object? insertedAt = null,
    Object? maxIntensity = freezed,
    Object? regions = null,
    Object? topLeft = null,
    Object? bottomRight = null,
    Object? pointCount = null,
  }) {
    return _then(_$ShakeDetectionEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      serialNo: null == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      insertedAt: null == insertedAt
          ? _value.insertedAt
          : insertedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      regions: null == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<ShakeDetectionRegion>,
      topLeft: null == topLeft
          ? _value.topLeft
          : topLeft // ignore: cast_nullable_to_non_nullable
              as ShakeDetectionLatLng,
      bottomRight: null == bottomRight
          ? _value.bottomRight
          : bottomRight // ignore: cast_nullable_to_non_nullable
              as ShakeDetectionLatLng,
      pointCount: null == pointCount
          ? _value.pointCount
          : pointCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShakeDetectionEventImpl implements _ShakeDetectionEvent {
  const _$ShakeDetectionEventImpl(
      {required this.id,
      required this.eventId,
      required this.serialNo,
      required this.createdAt,
      required this.insertedAt,
      @JsonKey(unknownEnumValue: null, defaultValue: null)
      required this.maxIntensity,
      required final List<ShakeDetectionRegion> regions,
      required this.topLeft,
      required this.bottomRight,
      required this.pointCount})
      : _regions = regions;

  factory _$ShakeDetectionEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShakeDetectionEventImplFromJson(json);

  @override
  final int id;
  @override
  final String eventId;
  @override
  final int serialNo;
  @override
  final DateTime createdAt;
  @override
  final DateTime insertedAt;

  /// `Unknown`もしくは`Error`の場合、Nullにフォールバックされます
  @override
  @JsonKey(unknownEnumValue: null, defaultValue: null)
  final JmaIntensity? maxIntensity;
  final List<ShakeDetectionRegion> _regions;
  @override
  List<ShakeDetectionRegion> get regions {
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regions);
  }

  @override
  final ShakeDetectionLatLng topLeft;
  @override
  final ShakeDetectionLatLng bottomRight;
  @override
  final int pointCount;

  @override
  String toString() {
    return 'ShakeDetectionEvent(id: $id, eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, insertedAt: $insertedAt, maxIntensity: $maxIntensity, regions: $regions, topLeft: $topLeft, bottomRight: $bottomRight, pointCount: $pointCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShakeDetectionEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.insertedAt, insertedAt) ||
                other.insertedAt == insertedAt) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            const DeepCollectionEquality().equals(other._regions, _regions) &&
            (identical(other.topLeft, topLeft) || other.topLeft == topLeft) &&
            (identical(other.bottomRight, bottomRight) ||
                other.bottomRight == bottomRight) &&
            (identical(other.pointCount, pointCount) ||
                other.pointCount == pointCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      eventId,
      serialNo,
      createdAt,
      insertedAt,
      maxIntensity,
      const DeepCollectionEquality().hash(_regions),
      topLeft,
      bottomRight,
      pointCount);

  /// Create a copy of ShakeDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShakeDetectionEventImplCopyWith<_$ShakeDetectionEventImpl> get copyWith =>
      __$$ShakeDetectionEventImplCopyWithImpl<_$ShakeDetectionEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShakeDetectionEventImplToJson(
      this,
    );
  }
}

abstract class _ShakeDetectionEvent implements ShakeDetectionEvent {
  const factory _ShakeDetectionEvent(
      {required final int id,
      required final String eventId,
      required final int serialNo,
      required final DateTime createdAt,
      required final DateTime insertedAt,
      @JsonKey(unknownEnumValue: null, defaultValue: null)
      required final JmaIntensity? maxIntensity,
      required final List<ShakeDetectionRegion> regions,
      required final ShakeDetectionLatLng topLeft,
      required final ShakeDetectionLatLng bottomRight,
      required final int pointCount}) = _$ShakeDetectionEventImpl;

  factory _ShakeDetectionEvent.fromJson(Map<String, dynamic> json) =
      _$ShakeDetectionEventImpl.fromJson;

  @override
  int get id;
  @override
  String get eventId;
  @override
  int get serialNo;
  @override
  DateTime get createdAt;
  @override
  DateTime get insertedAt;

  /// `Unknown`もしくは`Error`の場合、Nullにフォールバックされます
  @override
  @JsonKey(unknownEnumValue: null, defaultValue: null)
  JmaIntensity? get maxIntensity;
  @override
  List<ShakeDetectionRegion> get regions;
  @override
  ShakeDetectionLatLng get topLeft;
  @override
  ShakeDetectionLatLng get bottomRight;
  @override
  int get pointCount;

  /// Create a copy of ShakeDetectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShakeDetectionEventImplCopyWith<_$ShakeDetectionEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShakeDetectionRegion _$ShakeDetectionRegionFromJson(Map<String, dynamic> json) {
  return _ShakeDetectionRegion.fromJson(json);
}

/// @nodoc
mixin _$ShakeDetectionRegion {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'maxIntensity', unknownEnumValue: null, defaultValue: null)
  JmaIntensity? get maxIntensity => throw _privateConstructorUsedError;
  List<ShakeDetectionPoint> get points => throw _privateConstructorUsedError;

  /// Serializes this ShakeDetectionRegion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShakeDetectionRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShakeDetectionRegionCopyWith<ShakeDetectionRegion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShakeDetectionRegionCopyWith<$Res> {
  factory $ShakeDetectionRegionCopyWith(ShakeDetectionRegion value,
          $Res Function(ShakeDetectionRegion) then) =
      _$ShakeDetectionRegionCopyWithImpl<$Res, ShakeDetectionRegion>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'maxIntensity', unknownEnumValue: null, defaultValue: null)
      JmaIntensity? maxIntensity,
      List<ShakeDetectionPoint> points});
}

/// @nodoc
class _$ShakeDetectionRegionCopyWithImpl<$Res,
        $Val extends ShakeDetectionRegion>
    implements $ShakeDetectionRegionCopyWith<$Res> {
  _$ShakeDetectionRegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShakeDetectionRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? maxIntensity = freezed,
    Object? points = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<ShakeDetectionPoint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShakeDetectionRegionImplCopyWith<$Res>
    implements $ShakeDetectionRegionCopyWith<$Res> {
  factory _$$ShakeDetectionRegionImplCopyWith(_$ShakeDetectionRegionImpl value,
          $Res Function(_$ShakeDetectionRegionImpl) then) =
      __$$ShakeDetectionRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'maxIntensity', unknownEnumValue: null, defaultValue: null)
      JmaIntensity? maxIntensity,
      List<ShakeDetectionPoint> points});
}

/// @nodoc
class __$$ShakeDetectionRegionImplCopyWithImpl<$Res>
    extends _$ShakeDetectionRegionCopyWithImpl<$Res, _$ShakeDetectionRegionImpl>
    implements _$$ShakeDetectionRegionImplCopyWith<$Res> {
  __$$ShakeDetectionRegionImplCopyWithImpl(_$ShakeDetectionRegionImpl _value,
      $Res Function(_$ShakeDetectionRegionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShakeDetectionRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? maxIntensity = freezed,
    Object? points = null,
  }) {
    return _then(_$ShakeDetectionRegionImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      points: null == points
          ? _value._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<ShakeDetectionPoint>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShakeDetectionRegionImpl implements _ShakeDetectionRegion {
  const _$ShakeDetectionRegionImpl(
      {required this.name,
      @JsonKey(name: 'maxIntensity', unknownEnumValue: null, defaultValue: null)
      required this.maxIntensity,
      required final List<ShakeDetectionPoint> points})
      : _points = points;

  factory _$ShakeDetectionRegionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShakeDetectionRegionImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'maxIntensity', unknownEnumValue: null, defaultValue: null)
  final JmaIntensity? maxIntensity;
  final List<ShakeDetectionPoint> _points;
  @override
  List<ShakeDetectionPoint> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  String toString() {
    return 'ShakeDetectionRegion(name: $name, maxIntensity: $maxIntensity, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShakeDetectionRegionImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            const DeepCollectionEquality().equals(other._points, _points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, maxIntensity,
      const DeepCollectionEquality().hash(_points));

  /// Create a copy of ShakeDetectionRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShakeDetectionRegionImplCopyWith<_$ShakeDetectionRegionImpl>
      get copyWith =>
          __$$ShakeDetectionRegionImplCopyWithImpl<_$ShakeDetectionRegionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShakeDetectionRegionImplToJson(
      this,
    );
  }
}

abstract class _ShakeDetectionRegion implements ShakeDetectionRegion {
  const factory _ShakeDetectionRegion(
          {required final String name,
          @JsonKey(
              name: 'maxIntensity', unknownEnumValue: null, defaultValue: null)
          required final JmaIntensity? maxIntensity,
          required final List<ShakeDetectionPoint> points}) =
      _$ShakeDetectionRegionImpl;

  factory _ShakeDetectionRegion.fromJson(Map<String, dynamic> json) =
      _$ShakeDetectionRegionImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'maxIntensity', unknownEnumValue: null, defaultValue: null)
  JmaIntensity? get maxIntensity;
  @override
  List<ShakeDetectionPoint> get points;

  /// Create a copy of ShakeDetectionRegion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShakeDetectionRegionImplCopyWith<_$ShakeDetectionRegionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ShakeDetectionPoint _$ShakeDetectionPointFromJson(Map<String, dynamic> json) {
  return _ShakeDetectionPoint.fromJson(json);
}

/// @nodoc
mixin _$ShakeDetectionPoint {
  @JsonKey(unknownEnumValue: null, defaultValue: null)
  JmaIntensity? get intensity => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  /// Serializes this ShakeDetectionPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShakeDetectionPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShakeDetectionPointCopyWith<ShakeDetectionPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShakeDetectionPointCopyWith<$Res> {
  factory $ShakeDetectionPointCopyWith(
          ShakeDetectionPoint value, $Res Function(ShakeDetectionPoint) then) =
      _$ShakeDetectionPointCopyWithImpl<$Res, ShakeDetectionPoint>;
  @useResult
  $Res call(
      {@JsonKey(unknownEnumValue: null, defaultValue: null)
      JmaIntensity? intensity,
      String code});
}

/// @nodoc
class _$ShakeDetectionPointCopyWithImpl<$Res, $Val extends ShakeDetectionPoint>
    implements $ShakeDetectionPointCopyWith<$Res> {
  _$ShakeDetectionPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShakeDetectionPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensity = freezed,
    Object? code = null,
  }) {
    return _then(_value.copyWith(
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShakeDetectionPointImplCopyWith<$Res>
    implements $ShakeDetectionPointCopyWith<$Res> {
  factory _$$ShakeDetectionPointImplCopyWith(_$ShakeDetectionPointImpl value,
          $Res Function(_$ShakeDetectionPointImpl) then) =
      __$$ShakeDetectionPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(unknownEnumValue: null, defaultValue: null)
      JmaIntensity? intensity,
      String code});
}

/// @nodoc
class __$$ShakeDetectionPointImplCopyWithImpl<$Res>
    extends _$ShakeDetectionPointCopyWithImpl<$Res, _$ShakeDetectionPointImpl>
    implements _$$ShakeDetectionPointImplCopyWith<$Res> {
  __$$ShakeDetectionPointImplCopyWithImpl(_$ShakeDetectionPointImpl _value,
      $Res Function(_$ShakeDetectionPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShakeDetectionPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensity = freezed,
    Object? code = null,
  }) {
    return _then(_$ShakeDetectionPointImpl(
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShakeDetectionPointImpl implements _ShakeDetectionPoint {
  const _$ShakeDetectionPointImpl(
      {@JsonKey(unknownEnumValue: null, defaultValue: null)
      required this.intensity,
      required this.code});

  factory _$ShakeDetectionPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShakeDetectionPointImplFromJson(json);

  @override
  @JsonKey(unknownEnumValue: null, defaultValue: null)
  final JmaIntensity? intensity;
  @override
  final String code;

  @override
  String toString() {
    return 'ShakeDetectionPoint(intensity: $intensity, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShakeDetectionPointImpl &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, intensity, code);

  /// Create a copy of ShakeDetectionPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShakeDetectionPointImplCopyWith<_$ShakeDetectionPointImpl> get copyWith =>
      __$$ShakeDetectionPointImplCopyWithImpl<_$ShakeDetectionPointImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShakeDetectionPointImplToJson(
      this,
    );
  }
}

abstract class _ShakeDetectionPoint implements ShakeDetectionPoint {
  const factory _ShakeDetectionPoint(
      {@JsonKey(unknownEnumValue: null, defaultValue: null)
      required final JmaIntensity? intensity,
      required final String code}) = _$ShakeDetectionPointImpl;

  factory _ShakeDetectionPoint.fromJson(Map<String, dynamic> json) =
      _$ShakeDetectionPointImpl.fromJson;

  @override
  @JsonKey(unknownEnumValue: null, defaultValue: null)
  JmaIntensity? get intensity;
  @override
  String get code;

  /// Create a copy of ShakeDetectionPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShakeDetectionPointImplCopyWith<_$ShakeDetectionPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShakeDetectionLatLng _$ShakeDetectionLatLngFromJson(Map<String, dynamic> json) {
  return _ShakeDetectionLatLng.fromJson(json);
}

/// @nodoc
mixin _$ShakeDetectionLatLng {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Serializes this ShakeDetectionLatLng to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShakeDetectionLatLng
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShakeDetectionLatLngCopyWith<ShakeDetectionLatLng> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShakeDetectionLatLngCopyWith<$Res> {
  factory $ShakeDetectionLatLngCopyWith(ShakeDetectionLatLng value,
          $Res Function(ShakeDetectionLatLng) then) =
      _$ShakeDetectionLatLngCopyWithImpl<$Res, ShakeDetectionLatLng>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$ShakeDetectionLatLngCopyWithImpl<$Res,
        $Val extends ShakeDetectionLatLng>
    implements $ShakeDetectionLatLngCopyWith<$Res> {
  _$ShakeDetectionLatLngCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShakeDetectionLatLng
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShakeDetectionLatLngImplCopyWith<$Res>
    implements $ShakeDetectionLatLngCopyWith<$Res> {
  factory _$$ShakeDetectionLatLngImplCopyWith(_$ShakeDetectionLatLngImpl value,
          $Res Function(_$ShakeDetectionLatLngImpl) then) =
      __$$ShakeDetectionLatLngImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$ShakeDetectionLatLngImplCopyWithImpl<$Res>
    extends _$ShakeDetectionLatLngCopyWithImpl<$Res, _$ShakeDetectionLatLngImpl>
    implements _$$ShakeDetectionLatLngImplCopyWith<$Res> {
  __$$ShakeDetectionLatLngImplCopyWithImpl(_$ShakeDetectionLatLngImpl _value,
      $Res Function(_$ShakeDetectionLatLngImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShakeDetectionLatLng
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$ShakeDetectionLatLngImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShakeDetectionLatLngImpl implements _ShakeDetectionLatLng {
  const _$ShakeDetectionLatLngImpl(
      {required this.latitude, required this.longitude});

  factory _$ShakeDetectionLatLngImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShakeDetectionLatLngImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'ShakeDetectionLatLng(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShakeDetectionLatLngImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  /// Create a copy of ShakeDetectionLatLng
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShakeDetectionLatLngImplCopyWith<_$ShakeDetectionLatLngImpl>
      get copyWith =>
          __$$ShakeDetectionLatLngImplCopyWithImpl<_$ShakeDetectionLatLngImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShakeDetectionLatLngImplToJson(
      this,
    );
  }
}

abstract class _ShakeDetectionLatLng implements ShakeDetectionLatLng {
  const factory _ShakeDetectionLatLng(
      {required final double latitude,
      required final double longitude}) = _$ShakeDetectionLatLngImpl;

  factory _ShakeDetectionLatLng.fromJson(Map<String, dynamic> json) =
      _$ShakeDetectionLatLngImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;

  /// Create a copy of ShakeDetectionLatLng
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShakeDetectionLatLngImplCopyWith<_$ShakeDetectionLatLngImpl>
      get copyWith => throw _privateConstructorUsedError;
}

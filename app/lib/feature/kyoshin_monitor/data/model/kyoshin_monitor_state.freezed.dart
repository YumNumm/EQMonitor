// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KyoshinMonitorState _$KyoshinMonitorStateFromJson(Map<String, dynamic> json) {
  return _KyoshinMonitorState.fromJson(json);
}

/// @nodoc
mixin _$KyoshinMonitorState {
  RealtimeDataType? get currentRealtimeDataType =>
      throw _privateConstructorUsedError;
  RealtimeLayer? get currentRealtimeLayer => throw _privateConstructorUsedError;
  KyoshinMonitorStatus get status => throw _privateConstructorUsedError;
  DateTime? get lastUpdatedAt => throw _privateConstructorUsedError;
  DateTime? get lastImageFetchTargetTime => throw _privateConstructorUsedError;
  Duration? get lastImageFetchDuration => throw _privateConstructorUsedError;
  List<KyoshinMonitorImageParseObservationPoint>? get analyzedPoints =>
      throw _privateConstructorUsedError;
  List<int>? get currentImageRaw => throw _privateConstructorUsedError;

  /// Serializes this KyoshinMonitorState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KyoshinMonitorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinMonitorStateCopyWith<KyoshinMonitorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinMonitorStateCopyWith<$Res> {
  factory $KyoshinMonitorStateCopyWith(
          KyoshinMonitorState value, $Res Function(KyoshinMonitorState) then) =
      _$KyoshinMonitorStateCopyWithImpl<$Res, KyoshinMonitorState>;
  @useResult
  $Res call(
      {RealtimeDataType? currentRealtimeDataType,
      RealtimeLayer? currentRealtimeLayer,
      KyoshinMonitorStatus status,
      DateTime? lastUpdatedAt,
      DateTime? lastImageFetchTargetTime,
      Duration? lastImageFetchDuration,
      List<KyoshinMonitorImageParseObservationPoint>? analyzedPoints,
      List<int>? currentImageRaw});
}

/// @nodoc
class _$KyoshinMonitorStateCopyWithImpl<$Res, $Val extends KyoshinMonitorState>
    implements $KyoshinMonitorStateCopyWith<$Res> {
  _$KyoshinMonitorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinMonitorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentRealtimeDataType = freezed,
    Object? currentRealtimeLayer = freezed,
    Object? status = null,
    Object? lastUpdatedAt = freezed,
    Object? lastImageFetchTargetTime = freezed,
    Object? lastImageFetchDuration = freezed,
    Object? analyzedPoints = freezed,
    Object? currentImageRaw = freezed,
  }) {
    return _then(_value.copyWith(
      currentRealtimeDataType: freezed == currentRealtimeDataType
          ? _value.currentRealtimeDataType
          : currentRealtimeDataType // ignore: cast_nullable_to_non_nullable
              as RealtimeDataType?,
      currentRealtimeLayer: freezed == currentRealtimeLayer
          ? _value.currentRealtimeLayer
          : currentRealtimeLayer // ignore: cast_nullable_to_non_nullable
              as RealtimeLayer?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorStatus,
      lastUpdatedAt: freezed == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastImageFetchTargetTime: freezed == lastImageFetchTargetTime
          ? _value.lastImageFetchTargetTime
          : lastImageFetchTargetTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastImageFetchDuration: freezed == lastImageFetchDuration
          ? _value.lastImageFetchDuration
          : lastImageFetchDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      analyzedPoints: freezed == analyzedPoints
          ? _value.analyzedPoints
          : analyzedPoints // ignore: cast_nullable_to_non_nullable
              as List<KyoshinMonitorImageParseObservationPoint>?,
      currentImageRaw: freezed == currentImageRaw
          ? _value.currentImageRaw
          : currentImageRaw // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KyoshinMonitorStateImplCopyWith<$Res>
    implements $KyoshinMonitorStateCopyWith<$Res> {
  factory _$$KyoshinMonitorStateImplCopyWith(_$KyoshinMonitorStateImpl value,
          $Res Function(_$KyoshinMonitorStateImpl) then) =
      __$$KyoshinMonitorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RealtimeDataType? currentRealtimeDataType,
      RealtimeLayer? currentRealtimeLayer,
      KyoshinMonitorStatus status,
      DateTime? lastUpdatedAt,
      DateTime? lastImageFetchTargetTime,
      Duration? lastImageFetchDuration,
      List<KyoshinMonitorImageParseObservationPoint>? analyzedPoints,
      List<int>? currentImageRaw});
}

/// @nodoc
class __$$KyoshinMonitorStateImplCopyWithImpl<$Res>
    extends _$KyoshinMonitorStateCopyWithImpl<$Res, _$KyoshinMonitorStateImpl>
    implements _$$KyoshinMonitorStateImplCopyWith<$Res> {
  __$$KyoshinMonitorStateImplCopyWithImpl(_$KyoshinMonitorStateImpl _value,
      $Res Function(_$KyoshinMonitorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of KyoshinMonitorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentRealtimeDataType = freezed,
    Object? currentRealtimeLayer = freezed,
    Object? status = null,
    Object? lastUpdatedAt = freezed,
    Object? lastImageFetchTargetTime = freezed,
    Object? lastImageFetchDuration = freezed,
    Object? analyzedPoints = freezed,
    Object? currentImageRaw = freezed,
  }) {
    return _then(_$KyoshinMonitorStateImpl(
      currentRealtimeDataType: freezed == currentRealtimeDataType
          ? _value.currentRealtimeDataType
          : currentRealtimeDataType // ignore: cast_nullable_to_non_nullable
              as RealtimeDataType?,
      currentRealtimeLayer: freezed == currentRealtimeLayer
          ? _value.currentRealtimeLayer
          : currentRealtimeLayer // ignore: cast_nullable_to_non_nullable
              as RealtimeLayer?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorStatus,
      lastUpdatedAt: freezed == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastImageFetchTargetTime: freezed == lastImageFetchTargetTime
          ? _value.lastImageFetchTargetTime
          : lastImageFetchTargetTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastImageFetchDuration: freezed == lastImageFetchDuration
          ? _value.lastImageFetchDuration
          : lastImageFetchDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      analyzedPoints: freezed == analyzedPoints
          ? _value._analyzedPoints
          : analyzedPoints // ignore: cast_nullable_to_non_nullable
              as List<KyoshinMonitorImageParseObservationPoint>?,
      currentImageRaw: freezed == currentImageRaw
          ? _value._currentImageRaw
          : currentImageRaw // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KyoshinMonitorStateImpl implements _KyoshinMonitorState {
  const _$KyoshinMonitorStateImpl(
      {this.currentRealtimeDataType,
      this.currentRealtimeLayer,
      this.status = KyoshinMonitorStatus.initializing,
      this.lastUpdatedAt,
      this.lastImageFetchTargetTime,
      this.lastImageFetchDuration,
      final List<KyoshinMonitorImageParseObservationPoint>? analyzedPoints,
      final List<int>? currentImageRaw})
      : _analyzedPoints = analyzedPoints,
        _currentImageRaw = currentImageRaw;

  factory _$KyoshinMonitorStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$KyoshinMonitorStateImplFromJson(json);

  @override
  final RealtimeDataType? currentRealtimeDataType;
  @override
  final RealtimeLayer? currentRealtimeLayer;
  @override
  @JsonKey()
  final KyoshinMonitorStatus status;
  @override
  final DateTime? lastUpdatedAt;
  @override
  final DateTime? lastImageFetchTargetTime;
  @override
  final Duration? lastImageFetchDuration;
  final List<KyoshinMonitorImageParseObservationPoint>? _analyzedPoints;
  @override
  List<KyoshinMonitorImageParseObservationPoint>? get analyzedPoints {
    final value = _analyzedPoints;
    if (value == null) return null;
    if (_analyzedPoints is EqualUnmodifiableListView) return _analyzedPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _currentImageRaw;
  @override
  List<int>? get currentImageRaw {
    final value = _currentImageRaw;
    if (value == null) return null;
    if (_currentImageRaw is EqualUnmodifiableListView) return _currentImageRaw;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'KyoshinMonitorState(currentRealtimeDataType: $currentRealtimeDataType, currentRealtimeLayer: $currentRealtimeLayer, status: $status, lastUpdatedAt: $lastUpdatedAt, lastImageFetchTargetTime: $lastImageFetchTargetTime, lastImageFetchDuration: $lastImageFetchDuration, analyzedPoints: $analyzedPoints, currentImageRaw: $currentImageRaw)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KyoshinMonitorStateImpl &&
            (identical(
                    other.currentRealtimeDataType, currentRealtimeDataType) ||
                other.currentRealtimeDataType == currentRealtimeDataType) &&
            (identical(other.currentRealtimeLayer, currentRealtimeLayer) ||
                other.currentRealtimeLayer == currentRealtimeLayer) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(
                    other.lastImageFetchTargetTime, lastImageFetchTargetTime) ||
                other.lastImageFetchTargetTime == lastImageFetchTargetTime) &&
            (identical(other.lastImageFetchDuration, lastImageFetchDuration) ||
                other.lastImageFetchDuration == lastImageFetchDuration) &&
            const DeepCollectionEquality()
                .equals(other._analyzedPoints, _analyzedPoints) &&
            const DeepCollectionEquality()
                .equals(other._currentImageRaw, _currentImageRaw));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentRealtimeDataType,
      currentRealtimeLayer,
      status,
      lastUpdatedAt,
      lastImageFetchTargetTime,
      lastImageFetchDuration,
      const DeepCollectionEquality().hash(_analyzedPoints),
      const DeepCollectionEquality().hash(_currentImageRaw));

  /// Create a copy of KyoshinMonitorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinMonitorStateImplCopyWith<_$KyoshinMonitorStateImpl> get copyWith =>
      __$$KyoshinMonitorStateImplCopyWithImpl<_$KyoshinMonitorStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KyoshinMonitorStateImplToJson(
      this,
    );
  }
}

abstract class _KyoshinMonitorState implements KyoshinMonitorState {
  const factory _KyoshinMonitorState(
      {final RealtimeDataType? currentRealtimeDataType,
      final RealtimeLayer? currentRealtimeLayer,
      final KyoshinMonitorStatus status,
      final DateTime? lastUpdatedAt,
      final DateTime? lastImageFetchTargetTime,
      final Duration? lastImageFetchDuration,
      final List<KyoshinMonitorImageParseObservationPoint>? analyzedPoints,
      final List<int>? currentImageRaw}) = _$KyoshinMonitorStateImpl;

  factory _KyoshinMonitorState.fromJson(Map<String, dynamic> json) =
      _$KyoshinMonitorStateImpl.fromJson;

  @override
  RealtimeDataType? get currentRealtimeDataType;
  @override
  RealtimeLayer? get currentRealtimeLayer;
  @override
  KyoshinMonitorStatus get status;
  @override
  DateTime? get lastUpdatedAt;
  @override
  DateTime? get lastImageFetchTargetTime;
  @override
  Duration? get lastImageFetchDuration;
  @override
  List<KyoshinMonitorImageParseObservationPoint>? get analyzedPoints;
  @override
  List<int>? get currentImageRaw;

  /// Create a copy of KyoshinMonitorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinMonitorStateImplCopyWith<_$KyoshinMonitorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KyoshinMonitorImageParseObservationPoint
    _$KyoshinMonitorImageParseObservationPointFromJson(
        Map<String, dynamic> json) {
  return _KyoshinMonitorImageParseObservationPoint.fromJson(json);
}

/// @nodoc
mixin _$KyoshinMonitorImageParseObservationPoint {
  @JsonKey(
      fromJson: _kyoshinObservationPointFromJson,
      toJson: _kyoshinObservationPointToJson)
  KyoshinObservationPoint get point => throw _privateConstructorUsedError;
  KyoshinMonitorObservationAnalyzedPoint get observation =>
      throw _privateConstructorUsedError;

  /// Serializes this KyoshinMonitorImageParseObservationPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KyoshinMonitorImageParseObservationPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinMonitorImageParseObservationPointCopyWith<
          KyoshinMonitorImageParseObservationPoint>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinMonitorImageParseObservationPointCopyWith<$Res> {
  factory $KyoshinMonitorImageParseObservationPointCopyWith(
          KyoshinMonitorImageParseObservationPoint value,
          $Res Function(KyoshinMonitorImageParseObservationPoint) then) =
      _$KyoshinMonitorImageParseObservationPointCopyWithImpl<$Res,
          KyoshinMonitorImageParseObservationPoint>;
  @useResult
  $Res call(
      {@JsonKey(
          fromJson: _kyoshinObservationPointFromJson,
          toJson: _kyoshinObservationPointToJson)
      KyoshinObservationPoint point,
      KyoshinMonitorObservationAnalyzedPoint observation});

  $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> get observation;
}

/// @nodoc
class _$KyoshinMonitorImageParseObservationPointCopyWithImpl<$Res,
        $Val extends KyoshinMonitorImageParseObservationPoint>
    implements $KyoshinMonitorImageParseObservationPointCopyWith<$Res> {
  _$KyoshinMonitorImageParseObservationPointCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinMonitorImageParseObservationPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? point = null,
    Object? observation = null,
  }) {
    return _then(_value.copyWith(
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as KyoshinObservationPoint,
      observation: null == observation
          ? _value.observation
          : observation // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorObservationAnalyzedPoint,
    ) as $Val);
  }

  /// Create a copy of KyoshinMonitorImageParseObservationPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> get observation {
    return $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res>(
        _value.observation, (value) {
      return _then(_value.copyWith(observation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KyoshinMonitorImageParseObservationPointImplCopyWith<$Res>
    implements $KyoshinMonitorImageParseObservationPointCopyWith<$Res> {
  factory _$$KyoshinMonitorImageParseObservationPointImplCopyWith(
          _$KyoshinMonitorImageParseObservationPointImpl value,
          $Res Function(_$KyoshinMonitorImageParseObservationPointImpl) then) =
      __$$KyoshinMonitorImageParseObservationPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          fromJson: _kyoshinObservationPointFromJson,
          toJson: _kyoshinObservationPointToJson)
      KyoshinObservationPoint point,
      KyoshinMonitorObservationAnalyzedPoint observation});

  @override
  $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> get observation;
}

/// @nodoc
class __$$KyoshinMonitorImageParseObservationPointImplCopyWithImpl<$Res>
    extends _$KyoshinMonitorImageParseObservationPointCopyWithImpl<$Res,
        _$KyoshinMonitorImageParseObservationPointImpl>
    implements _$$KyoshinMonitorImageParseObservationPointImplCopyWith<$Res> {
  __$$KyoshinMonitorImageParseObservationPointImplCopyWithImpl(
      _$KyoshinMonitorImageParseObservationPointImpl _value,
      $Res Function(_$KyoshinMonitorImageParseObservationPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of KyoshinMonitorImageParseObservationPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? point = null,
    Object? observation = null,
  }) {
    return _then(_$KyoshinMonitorImageParseObservationPointImpl(
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as KyoshinObservationPoint,
      observation: null == observation
          ? _value.observation
          : observation // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorObservationAnalyzedPoint,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KyoshinMonitorImageParseObservationPointImpl
    implements _KyoshinMonitorImageParseObservationPoint {
  const _$KyoshinMonitorImageParseObservationPointImpl(
      {@JsonKey(
          fromJson: _kyoshinObservationPointFromJson,
          toJson: _kyoshinObservationPointToJson)
      required this.point,
      required this.observation});

  factory _$KyoshinMonitorImageParseObservationPointImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$KyoshinMonitorImageParseObservationPointImplFromJson(json);

  @override
  @JsonKey(
      fromJson: _kyoshinObservationPointFromJson,
      toJson: _kyoshinObservationPointToJson)
  final KyoshinObservationPoint point;
  @override
  final KyoshinMonitorObservationAnalyzedPoint observation;

  @override
  String toString() {
    return 'KyoshinMonitorImageParseObservationPoint(point: $point, observation: $observation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KyoshinMonitorImageParseObservationPointImpl &&
            (identical(other.point, point) || other.point == point) &&
            (identical(other.observation, observation) ||
                other.observation == observation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, point, observation);

  /// Create a copy of KyoshinMonitorImageParseObservationPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinMonitorImageParseObservationPointImplCopyWith<
          _$KyoshinMonitorImageParseObservationPointImpl>
      get copyWith =>
          __$$KyoshinMonitorImageParseObservationPointImplCopyWithImpl<
              _$KyoshinMonitorImageParseObservationPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KyoshinMonitorImageParseObservationPointImplToJson(
      this,
    );
  }
}

abstract class _KyoshinMonitorImageParseObservationPoint
    implements KyoshinMonitorImageParseObservationPoint {
  const factory _KyoshinMonitorImageParseObservationPoint(
          {@JsonKey(
              fromJson: _kyoshinObservationPointFromJson,
              toJson: _kyoshinObservationPointToJson)
          required final KyoshinObservationPoint point,
          required final KyoshinMonitorObservationAnalyzedPoint observation}) =
      _$KyoshinMonitorImageParseObservationPointImpl;

  factory _KyoshinMonitorImageParseObservationPoint.fromJson(
          Map<String, dynamic> json) =
      _$KyoshinMonitorImageParseObservationPointImpl.fromJson;

  @override
  @JsonKey(
      fromJson: _kyoshinObservationPointFromJson,
      toJson: _kyoshinObservationPointToJson)
  KyoshinObservationPoint get point;
  @override
  KyoshinMonitorObservationAnalyzedPoint get observation;

  /// Create a copy of KyoshinMonitorImageParseObservationPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinMonitorImageParseObservationPointImplCopyWith<
          _$KyoshinMonitorImageParseObservationPointImpl>
      get copyWith => throw _privateConstructorUsedError;
}

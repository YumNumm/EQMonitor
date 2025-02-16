// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_layer_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$KyoshinMonitorObservationLayer {
  String get id => throw _privateConstructorUsedError;
  String get sourceId => throw _privateConstructorUsedError;
  bool get visible => throw _privateConstructorUsedError;
  List<KyoshinMonitorImageParseObservationPoint>
  get points => throw _privateConstructorUsedError;
  bool get isInEew => throw _privateConstructorUsedError;
  KyoshinMonitorMarkerType get markerType =>
      throw _privateConstructorUsedError;
  RealtimeDataType get realtimeDataType =>
      throw _privateConstructorUsedError;
  double? get minZoom => throw _privateConstructorUsedError;
  double? get maxZoom => throw _privateConstructorUsedError;
  dynamic get filter => throw _privateConstructorUsedError;

  /// Create a copy of KyoshinMonitorObservationLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinMonitorObservationLayerCopyWith<
    KyoshinMonitorObservationLayer
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinMonitorObservationLayerCopyWith<
  $Res
> {
  factory $KyoshinMonitorObservationLayerCopyWith(
    KyoshinMonitorObservationLayer value,
    $Res Function(KyoshinMonitorObservationLayer) then,
  ) =
      _$KyoshinMonitorObservationLayerCopyWithImpl<
        $Res,
        KyoshinMonitorObservationLayer
      >;
  @useResult
  $Res call({
    String id,
    String sourceId,
    bool visible,
    List<KyoshinMonitorImageParseObservationPoint> points,
    bool isInEew,
    KyoshinMonitorMarkerType markerType,
    RealtimeDataType realtimeDataType,
    double? minZoom,
    double? maxZoom,
    dynamic filter,
  });
}

/// @nodoc
class _$KyoshinMonitorObservationLayerCopyWithImpl<
  $Res,
  $Val extends KyoshinMonitorObservationLayer
>
    implements
        $KyoshinMonitorObservationLayerCopyWith<$Res> {
  _$KyoshinMonitorObservationLayerCopyWithImpl(
    this._value,
    this._then,
  );

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinMonitorObservationLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceId = null,
    Object? visible = null,
    Object? points = null,
    Object? isInEew = null,
    Object? markerType = null,
    Object? realtimeDataType = null,
    Object? minZoom = freezed,
    Object? maxZoom = freezed,
    Object? filter = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            sourceId:
                null == sourceId
                    ? _value.sourceId
                    : sourceId // ignore: cast_nullable_to_non_nullable
                        as String,
            visible:
                null == visible
                    ? _value.visible
                    : visible // ignore: cast_nullable_to_non_nullable
                        as bool,
            points:
                null == points
                    ? _value.points
                    : points // ignore: cast_nullable_to_non_nullable
                        as List<
                          KyoshinMonitorImageParseObservationPoint
                        >,
            isInEew:
                null == isInEew
                    ? _value.isInEew
                    : isInEew // ignore: cast_nullable_to_non_nullable
                        as bool,
            markerType:
                null == markerType
                    ? _value.markerType
                    : markerType // ignore: cast_nullable_to_non_nullable
                        as KyoshinMonitorMarkerType,
            realtimeDataType:
                null == realtimeDataType
                    ? _value.realtimeDataType
                    : realtimeDataType // ignore: cast_nullable_to_non_nullable
                        as RealtimeDataType,
            minZoom:
                freezed == minZoom
                    ? _value.minZoom
                    : minZoom // ignore: cast_nullable_to_non_nullable
                        as double?,
            maxZoom:
                freezed == maxZoom
                    ? _value.maxZoom
                    : maxZoom // ignore: cast_nullable_to_non_nullable
                        as double?,
            filter:
                freezed == filter
                    ? _value.filter
                    : filter // ignore: cast_nullable_to_non_nullable
                        as dynamic,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KyoshinMonitorObservationLayerImplCopyWith<
  $Res
>
    implements
        $KyoshinMonitorObservationLayerCopyWith<$Res> {
  factory _$$KyoshinMonitorObservationLayerImplCopyWith(
    _$KyoshinMonitorObservationLayerImpl value,
    $Res Function(_$KyoshinMonitorObservationLayerImpl)
    then,
  ) =
      __$$KyoshinMonitorObservationLayerImplCopyWithImpl<
        $Res
      >;
  @override
  @useResult
  $Res call({
    String id,
    String sourceId,
    bool visible,
    List<KyoshinMonitorImageParseObservationPoint> points,
    bool isInEew,
    KyoshinMonitorMarkerType markerType,
    RealtimeDataType realtimeDataType,
    double? minZoom,
    double? maxZoom,
    dynamic filter,
  });
}

/// @nodoc
class __$$KyoshinMonitorObservationLayerImplCopyWithImpl<
  $Res
>
    extends
        _$KyoshinMonitorObservationLayerCopyWithImpl<
          $Res,
          _$KyoshinMonitorObservationLayerImpl
        >
    implements
        _$$KyoshinMonitorObservationLayerImplCopyWith<
          $Res
        > {
  __$$KyoshinMonitorObservationLayerImplCopyWithImpl(
    _$KyoshinMonitorObservationLayerImpl _value,
    $Res Function(_$KyoshinMonitorObservationLayerImpl)
    _then,
  ) : super(_value, _then);

  /// Create a copy of KyoshinMonitorObservationLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceId = null,
    Object? visible = null,
    Object? points = null,
    Object? isInEew = null,
    Object? markerType = null,
    Object? realtimeDataType = null,
    Object? minZoom = freezed,
    Object? maxZoom = freezed,
    Object? filter = freezed,
  }) {
    return _then(
      _$KyoshinMonitorObservationLayerImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        sourceId:
            null == sourceId
                ? _value.sourceId
                : sourceId // ignore: cast_nullable_to_non_nullable
                    as String,
        visible:
            null == visible
                ? _value.visible
                : visible // ignore: cast_nullable_to_non_nullable
                    as bool,
        points:
            null == points
                ? _value._points
                : points // ignore: cast_nullable_to_non_nullable
                    as List<
                      KyoshinMonitorImageParseObservationPoint
                    >,
        isInEew:
            null == isInEew
                ? _value.isInEew
                : isInEew // ignore: cast_nullable_to_non_nullable
                    as bool,
        markerType:
            null == markerType
                ? _value.markerType
                : markerType // ignore: cast_nullable_to_non_nullable
                    as KyoshinMonitorMarkerType,
        realtimeDataType:
            null == realtimeDataType
                ? _value.realtimeDataType
                : realtimeDataType // ignore: cast_nullable_to_non_nullable
                    as RealtimeDataType,
        minZoom:
            freezed == minZoom
                ? _value.minZoom
                : minZoom // ignore: cast_nullable_to_non_nullable
                    as double?,
        maxZoom:
            freezed == maxZoom
                ? _value.maxZoom
                : maxZoom // ignore: cast_nullable_to_non_nullable
                    as double?,
        filter:
            freezed == filter
                ? _value.filter
                : filter // ignore: cast_nullable_to_non_nullable
                    as dynamic,
      ),
    );
  }
}

/// @nodoc

class _$KyoshinMonitorObservationLayerImpl
    extends _KyoshinMonitorObservationLayer {
  _$KyoshinMonitorObservationLayerImpl({
    required this.id,
    required this.sourceId,
    required this.visible,
    required final List<
      KyoshinMonitorImageParseObservationPoint
    >
    points,
    required this.isInEew,
    required this.markerType,
    required this.realtimeDataType,
    this.minZoom,
    this.maxZoom,
    this.filter,
  }) : _points = points,
       super._();

  @override
  final String id;
  @override
  final String sourceId;
  @override
  final bool visible;
  final List<KyoshinMonitorImageParseObservationPoint>
  _points;
  @override
  List<KyoshinMonitorImageParseObservationPoint>
  get points {
    if (_points is EqualUnmodifiableListView)
      return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  final bool isInEew;
  @override
  final KyoshinMonitorMarkerType markerType;
  @override
  final RealtimeDataType realtimeDataType;
  @override
  final double? minZoom;
  @override
  final double? maxZoom;
  @override
  final dynamic filter;

  @override
  String toString() {
    return 'KyoshinMonitorObservationLayer(id: $id, sourceId: $sourceId, visible: $visible, points: $points, isInEew: $isInEew, markerType: $markerType, realtimeDataType: $realtimeDataType, minZoom: $minZoom, maxZoom: $maxZoom, filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KyoshinMonitorObservationLayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.visible, visible) ||
                other.visible == visible) &&
            const DeepCollectionEquality().equals(
              other._points,
              _points,
            ) &&
            (identical(other.isInEew, isInEew) ||
                other.isInEew == isInEew) &&
            (identical(other.markerType, markerType) ||
                other.markerType == markerType) &&
            (identical(
                  other.realtimeDataType,
                  realtimeDataType,
                ) ||
                other.realtimeDataType ==
                    realtimeDataType) &&
            (identical(other.minZoom, minZoom) ||
                other.minZoom == minZoom) &&
            (identical(other.maxZoom, maxZoom) ||
                other.maxZoom == maxZoom) &&
            const DeepCollectionEquality().equals(
              other.filter,
              filter,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sourceId,
    visible,
    const DeepCollectionEquality().hash(_points),
    isInEew,
    markerType,
    realtimeDataType,
    minZoom,
    maxZoom,
    const DeepCollectionEquality().hash(filter),
  );

  /// Create a copy of KyoshinMonitorObservationLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinMonitorObservationLayerImplCopyWith<
    _$KyoshinMonitorObservationLayerImpl
  >
  get copyWith =>
      __$$KyoshinMonitorObservationLayerImplCopyWithImpl<
        _$KyoshinMonitorObservationLayerImpl
      >(this, _$identity);
}

abstract class _KyoshinMonitorObservationLayer
    extends KyoshinMonitorObservationLayer {
  factory _KyoshinMonitorObservationLayer({
    required final String id,
    required final String sourceId,
    required final bool visible,
    required final List<
      KyoshinMonitorImageParseObservationPoint
    >
    points,
    required final bool isInEew,
    required final KyoshinMonitorMarkerType markerType,
    required final RealtimeDataType realtimeDataType,
    final double? minZoom,
    final double? maxZoom,
    final dynamic filter,
  }) = _$KyoshinMonitorObservationLayerImpl;
  _KyoshinMonitorObservationLayer._() : super._();

  @override
  String get id;
  @override
  String get sourceId;
  @override
  bool get visible;
  @override
  List<KyoshinMonitorImageParseObservationPoint> get points;
  @override
  bool get isInEew;
  @override
  KyoshinMonitorMarkerType get markerType;
  @override
  RealtimeDataType get realtimeDataType;
  @override
  double? get minZoom;
  @override
  double? get maxZoom;
  @override
  dynamic get filter;

  /// Create a copy of KyoshinMonitorObservationLayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinMonitorObservationLayerImplCopyWith<
    _$KyoshinMonitorObservationLayerImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MapCameraPosition _$MapCameraPositionFromJson(
  Map<String, dynamic> json,
) {
  return _MapCameraPosition.fromJson(json);
}

/// @nodoc
mixin _$MapCameraPosition {
  /// カメラの中心座標
  @LatLngConverter()
  LatLng get target => throw _privateConstructorUsedError;

  /// ズームレベル
  double get zoom => throw _privateConstructorUsedError;

  /// カメラの傾き (0-60)
  double get tilt => throw _privateConstructorUsedError;

  /// カメラの向き (0-360)
  double get bearing => throw _privateConstructorUsedError;

  /// Serializes this MapCameraPosition to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of MapCameraPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapCameraPositionCopyWith<MapCameraPosition>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapCameraPositionCopyWith<$Res> {
  factory $MapCameraPositionCopyWith(
    MapCameraPosition value,
    $Res Function(MapCameraPosition) then,
  ) =
      _$MapCameraPositionCopyWithImpl<
        $Res,
        MapCameraPosition
      >;
  @useResult
  $Res call({
    @LatLngConverter() LatLng target,
    double zoom,
    double tilt,
    double bearing,
  });
}

/// @nodoc
class _$MapCameraPositionCopyWithImpl<
  $Res,
  $Val extends MapCameraPosition
>
    implements $MapCameraPositionCopyWith<$Res> {
  _$MapCameraPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapCameraPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? target = null,
    Object? zoom = null,
    Object? tilt = null,
    Object? bearing = null,
  }) {
    return _then(
      _value.copyWith(
            target:
                null == target
                    ? _value.target
                    : target // ignore: cast_nullable_to_non_nullable
                        as LatLng,
            zoom:
                null == zoom
                    ? _value.zoom
                    : zoom // ignore: cast_nullable_to_non_nullable
                        as double,
            tilt:
                null == tilt
                    ? _value.tilt
                    : tilt // ignore: cast_nullable_to_non_nullable
                        as double,
            bearing:
                null == bearing
                    ? _value.bearing
                    : bearing // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MapCameraPositionImplCopyWith<$Res>
    implements $MapCameraPositionCopyWith<$Res> {
  factory _$$MapCameraPositionImplCopyWith(
    _$MapCameraPositionImpl value,
    $Res Function(_$MapCameraPositionImpl) then,
  ) = __$$MapCameraPositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @LatLngConverter() LatLng target,
    double zoom,
    double tilt,
    double bearing,
  });
}

/// @nodoc
class __$$MapCameraPositionImplCopyWithImpl<$Res>
    extends
        _$MapCameraPositionCopyWithImpl<
          $Res,
          _$MapCameraPositionImpl
        >
    implements _$$MapCameraPositionImplCopyWith<$Res> {
  __$$MapCameraPositionImplCopyWithImpl(
    _$MapCameraPositionImpl _value,
    $Res Function(_$MapCameraPositionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapCameraPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? target = null,
    Object? zoom = null,
    Object? tilt = null,
    Object? bearing = null,
  }) {
    return _then(
      _$MapCameraPositionImpl(
        target:
            null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                    as LatLng,
        zoom:
            null == zoom
                ? _value.zoom
                : zoom // ignore: cast_nullable_to_non_nullable
                    as double,
        tilt:
            null == tilt
                ? _value.tilt
                : tilt // ignore: cast_nullable_to_non_nullable
                    as double,
        bearing:
            null == bearing
                ? _value.bearing
                : bearing // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MapCameraPositionImpl extends _MapCameraPosition {
  const _$MapCameraPositionImpl({
    @LatLngConverter() required this.target,
    this.zoom = 5.0,
    this.tilt = 0.0,
    this.bearing = 0.0,
  }) : super._();

  factory _$MapCameraPositionImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$MapCameraPositionImplFromJson(json);

  /// カメラの中心座標
  @override
  @LatLngConverter()
  final LatLng target;

  /// ズームレベル
  @override
  @JsonKey()
  final double zoom;

  /// カメラの傾き (0-60)
  @override
  @JsonKey()
  final double tilt;

  /// カメラの向き (0-360)
  @override
  @JsonKey()
  final double bearing;

  @override
  String toString() {
    return 'MapCameraPosition(target: $target, zoom: $zoom, tilt: $tilt, bearing: $bearing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapCameraPositionImpl &&
            (identical(other.target, target) ||
                other.target == target) &&
            (identical(other.zoom, zoom) ||
                other.zoom == zoom) &&
            (identical(other.tilt, tilt) ||
                other.tilt == tilt) &&
            (identical(other.bearing, bearing) ||
                other.bearing == bearing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, target, zoom, tilt, bearing);

  /// Create a copy of MapCameraPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapCameraPositionImplCopyWith<_$MapCameraPositionImpl>
  get copyWith => __$$MapCameraPositionImplCopyWithImpl<
    _$MapCameraPositionImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapCameraPositionImplToJson(this);
  }
}

abstract class _MapCameraPosition
    extends MapCameraPosition {
  const factory _MapCameraPosition({
    @LatLngConverter() required final LatLng target,
    final double zoom,
    final double tilt,
    final double bearing,
  }) = _$MapCameraPositionImpl;
  const _MapCameraPosition._() : super._();

  factory _MapCameraPosition.fromJson(
    Map<String, dynamic> json,
  ) = _$MapCameraPositionImpl.fromJson;

  /// カメラの中心座標
  @override
  @LatLngConverter()
  LatLng get target;

  /// ズームレベル
  @override
  double get zoom;

  /// カメラの傾き (0-60)
  @override
  double get tilt;

  /// カメラの向き (0-360)
  @override
  double get bearing;

  /// Create a copy of MapCameraPosition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapCameraPositionImplCopyWith<_$MapCameraPositionImpl>
  get copyWith => throw _privateConstructorUsedError;
}

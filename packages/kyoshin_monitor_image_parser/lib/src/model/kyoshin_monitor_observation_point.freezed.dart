// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_observation_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KyoshinMonitorObservationPoint _$KyoshinMonitorObservationPointFromJson(
    Map<String, dynamic> json) {
  return _KyoshinMonitorObservationPoint.fromJson(json);
}

/// @nodoc
mixin _$KyoshinMonitorObservationPoint {
  String get code => throw _privateConstructorUsedError;
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;

  /// Serializes this KyoshinMonitorObservationPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KyoshinMonitorObservationPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinMonitorObservationPointCopyWith<KyoshinMonitorObservationPoint>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinMonitorObservationPointCopyWith<$Res> {
  factory $KyoshinMonitorObservationPointCopyWith(
          KyoshinMonitorObservationPoint value,
          $Res Function(KyoshinMonitorObservationPoint) then) =
      _$KyoshinMonitorObservationPointCopyWithImpl<$Res,
          KyoshinMonitorObservationPoint>;
  @useResult
  $Res call({String code, int x, int y});
}

/// @nodoc
class _$KyoshinMonitorObservationPointCopyWithImpl<$Res,
        $Val extends KyoshinMonitorObservationPoint>
    implements $KyoshinMonitorObservationPointCopyWith<$Res> {
  _$KyoshinMonitorObservationPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinMonitorObservationPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KyoshinMonitorObservationPointImplCopyWith<$Res>
    implements $KyoshinMonitorObservationPointCopyWith<$Res> {
  factory _$$KyoshinMonitorObservationPointImplCopyWith(
          _$KyoshinMonitorObservationPointImpl value,
          $Res Function(_$KyoshinMonitorObservationPointImpl) then) =
      __$$KyoshinMonitorObservationPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, int x, int y});
}

/// @nodoc
class __$$KyoshinMonitorObservationPointImplCopyWithImpl<$Res>
    extends _$KyoshinMonitorObservationPointCopyWithImpl<$Res,
        _$KyoshinMonitorObservationPointImpl>
    implements _$$KyoshinMonitorObservationPointImplCopyWith<$Res> {
  __$$KyoshinMonitorObservationPointImplCopyWithImpl(
      _$KyoshinMonitorObservationPointImpl _value,
      $Res Function(_$KyoshinMonitorObservationPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of KyoshinMonitorObservationPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$KyoshinMonitorObservationPointImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KyoshinMonitorObservationPointImpl
    implements _KyoshinMonitorObservationPoint {
  const _$KyoshinMonitorObservationPointImpl(
      {required this.code, required this.x, required this.y});

  factory _$KyoshinMonitorObservationPointImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$KyoshinMonitorObservationPointImplFromJson(json);

  @override
  final String code;
  @override
  final int x;
  @override
  final int y;

  @override
  String toString() {
    return 'KyoshinMonitorObservationPoint(code: $code, x: $x, y: $y)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KyoshinMonitorObservationPointImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, x, y);

  /// Create a copy of KyoshinMonitorObservationPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinMonitorObservationPointImplCopyWith<
          _$KyoshinMonitorObservationPointImpl>
      get copyWith => __$$KyoshinMonitorObservationPointImplCopyWithImpl<
          _$KyoshinMonitorObservationPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KyoshinMonitorObservationPointImplToJson(
      this,
    );
  }
}

abstract class _KyoshinMonitorObservationPoint
    implements KyoshinMonitorObservationPoint {
  const factory _KyoshinMonitorObservationPoint(
      {required final String code,
      required final int x,
      required final int y}) = _$KyoshinMonitorObservationPointImpl;

  factory _KyoshinMonitorObservationPoint.fromJson(Map<String, dynamic> json) =
      _$KyoshinMonitorObservationPointImpl.fromJson;

  @override
  String get code;
  @override
  int get x;
  @override
  int get y;

  /// Create a copy of KyoshinMonitorObservationPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinMonitorObservationPointImplCopyWith<
          _$KyoshinMonitorObservationPointImpl>
      get copyWith => throw _privateConstructorUsedError;
}

KyoshinMonitorObservationAnalyzedPoint
    _$KyoshinMonitorObservationAnalyzedPointFromJson(
        Map<String, dynamic> json) {
  return _KyoshinMonitorObservationAnalyzedPoint.fromJson(json);
}

/// @nodoc
mixin _$KyoshinMonitorObservationAnalyzedPoint {
  KyoshinMonitorObservationPoint get point =>
      throw _privateConstructorUsedError;
  double get scale => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  ColorInt8 get color => throw _privateConstructorUsedError;

  /// Serializes this KyoshinMonitorObservationAnalyzedPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KyoshinMonitorObservationAnalyzedPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinMonitorObservationAnalyzedPointCopyWith<
          KyoshinMonitorObservationAnalyzedPoint>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> {
  factory $KyoshinMonitorObservationAnalyzedPointCopyWith(
          KyoshinMonitorObservationAnalyzedPoint value,
          $Res Function(KyoshinMonitorObservationAnalyzedPoint) then) =
      _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl<$Res,
          KyoshinMonitorObservationAnalyzedPoint>;
  @useResult
  $Res call(
      {KyoshinMonitorObservationPoint point,
      double scale,
      @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
      ColorInt8 color});

  $KyoshinMonitorObservationPointCopyWith<$Res> get point;
}

/// @nodoc
class _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl<$Res,
        $Val extends KyoshinMonitorObservationAnalyzedPoint>
    implements $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> {
  _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinMonitorObservationAnalyzedPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? point = null,
    Object? scale = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorObservationPoint,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorInt8,
    ) as $Val);
  }

  /// Create a copy of KyoshinMonitorObservationAnalyzedPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KyoshinMonitorObservationPointCopyWith<$Res> get point {
    return $KyoshinMonitorObservationPointCopyWith<$Res>(_value.point, (value) {
      return _then(_value.copyWith(point: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KyoshinMonitorObservationAnalyzedPointImplCopyWith<$Res>
    implements $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> {
  factory _$$KyoshinMonitorObservationAnalyzedPointImplCopyWith(
          _$KyoshinMonitorObservationAnalyzedPointImpl value,
          $Res Function(_$KyoshinMonitorObservationAnalyzedPointImpl) then) =
      __$$KyoshinMonitorObservationAnalyzedPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {KyoshinMonitorObservationPoint point,
      double scale,
      @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
      ColorInt8 color});

  @override
  $KyoshinMonitorObservationPointCopyWith<$Res> get point;
}

/// @nodoc
class __$$KyoshinMonitorObservationAnalyzedPointImplCopyWithImpl<$Res>
    extends _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl<$Res,
        _$KyoshinMonitorObservationAnalyzedPointImpl>
    implements _$$KyoshinMonitorObservationAnalyzedPointImplCopyWith<$Res> {
  __$$KyoshinMonitorObservationAnalyzedPointImplCopyWithImpl(
      _$KyoshinMonitorObservationAnalyzedPointImpl _value,
      $Res Function(_$KyoshinMonitorObservationAnalyzedPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of KyoshinMonitorObservationAnalyzedPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? point = null,
    Object? scale = null,
    Object? color = null,
  }) {
    return _then(_$KyoshinMonitorObservationAnalyzedPointImpl(
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as KyoshinMonitorObservationPoint,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorInt8,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KyoshinMonitorObservationAnalyzedPointImpl
    extends _KyoshinMonitorObservationAnalyzedPoint {
  const _$KyoshinMonitorObservationAnalyzedPointImpl(
      {required this.point,
      required this.scale,
      @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
      required this.color})
      : super._();

  factory _$KyoshinMonitorObservationAnalyzedPointImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$KyoshinMonitorObservationAnalyzedPointImplFromJson(json);

  @override
  final KyoshinMonitorObservationPoint point;
  @override
  final double scale;
  @override
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final ColorInt8 color;

  @override
  String toString() {
    return 'KyoshinMonitorObservationAnalyzedPoint(point: $point, scale: $scale, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KyoshinMonitorObservationAnalyzedPointImpl &&
            (identical(other.point, point) || other.point == point) &&
            (identical(other.scale, scale) || other.scale == scale) &&
            const DeepCollectionEquality().equals(other.color, color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, point, scale, const DeepCollectionEquality().hash(color));

  /// Create a copy of KyoshinMonitorObservationAnalyzedPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinMonitorObservationAnalyzedPointImplCopyWith<
          _$KyoshinMonitorObservationAnalyzedPointImpl>
      get copyWith =>
          __$$KyoshinMonitorObservationAnalyzedPointImplCopyWithImpl<
              _$KyoshinMonitorObservationAnalyzedPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KyoshinMonitorObservationAnalyzedPointImplToJson(
      this,
    );
  }
}

abstract class _KyoshinMonitorObservationAnalyzedPoint
    extends KyoshinMonitorObservationAnalyzedPoint {
  const factory _KyoshinMonitorObservationAnalyzedPoint(
          {required final KyoshinMonitorObservationPoint point,
          required final double scale,
          @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
          required final ColorInt8 color}) =
      _$KyoshinMonitorObservationAnalyzedPointImpl;
  const _KyoshinMonitorObservationAnalyzedPoint._() : super._();

  factory _KyoshinMonitorObservationAnalyzedPoint.fromJson(
          Map<String, dynamic> json) =
      _$KyoshinMonitorObservationAnalyzedPointImpl.fromJson;

  @override
  KyoshinMonitorObservationPoint get point;
  @override
  double get scale;
  @override
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  ColorInt8 get color;

  /// Create a copy of KyoshinMonitorObservationAnalyzedPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinMonitorObservationAnalyzedPointImplCopyWith<
          _$KyoshinMonitorObservationAnalyzedPointImpl>
      get copyWith => throw _privateConstructorUsedError;
}

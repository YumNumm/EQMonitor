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

Earthquake _$EarthquakeFromJson(Map<String, dynamic> json) {
  return _Earthquake.fromJson(json);
}

/// @nodoc
mixin _$Earthquake {
  DateTime get originTime => throw _privateConstructorUsedError;
  DateTime get arrivalTime => throw _privateConstructorUsedError;
  EarthquakeHypocenter get hypocenter => throw _privateConstructorUsedError;
  EarthquakeMagnitude get magnitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeCopyWith<Earthquake> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeCopyWith<$Res> {
  factory $EarthquakeCopyWith(
          Earthquake value, $Res Function(Earthquake) then) =
      _$EarthquakeCopyWithImpl<$Res, Earthquake>;
  @useResult
  $Res call(
      {DateTime originTime,
      DateTime arrivalTime,
      EarthquakeHypocenter hypocenter,
      EarthquakeMagnitude magnitude});

  $EarthquakeHypocenterCopyWith<$Res> get hypocenter;
  $EarthquakeMagnitudeCopyWith<$Res> get magnitude;
}

/// @nodoc
class _$EarthquakeCopyWithImpl<$Res, $Val extends Earthquake>
    implements $EarthquakeCopyWith<$Res> {
  _$EarthquakeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originTime = null,
    Object? arrivalTime = null,
    Object? hypocenter = null,
    Object? magnitude = null,
  }) {
    return _then(_value.copyWith(
      originTime: null == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      arrivalTime: null == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hypocenter: null == hypocenter
          ? _value.hypocenter
          : hypocenter // ignore: cast_nullable_to_non_nullable
              as EarthquakeHypocenter,
      magnitude: null == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as EarthquakeMagnitude,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeHypocenterCopyWith<$Res> get hypocenter {
    return $EarthquakeHypocenterCopyWith<$Res>(_value.hypocenter, (value) {
      return _then(_value.copyWith(hypocenter: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeMagnitudeCopyWith<$Res> get magnitude {
    return $EarthquakeMagnitudeCopyWith<$Res>(_value.magnitude, (value) {
      return _then(_value.copyWith(magnitude: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EarthquakeImplCopyWith<$Res>
    implements $EarthquakeCopyWith<$Res> {
  factory _$$EarthquakeImplCopyWith(
          _$EarthquakeImpl value, $Res Function(_$EarthquakeImpl) then) =
      __$$EarthquakeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime originTime,
      DateTime arrivalTime,
      EarthquakeHypocenter hypocenter,
      EarthquakeMagnitude magnitude});

  @override
  $EarthquakeHypocenterCopyWith<$Res> get hypocenter;
  @override
  $EarthquakeMagnitudeCopyWith<$Res> get magnitude;
}

/// @nodoc
class __$$EarthquakeImplCopyWithImpl<$Res>
    extends _$EarthquakeCopyWithImpl<$Res, _$EarthquakeImpl>
    implements _$$EarthquakeImplCopyWith<$Res> {
  __$$EarthquakeImplCopyWithImpl(
      _$EarthquakeImpl _value, $Res Function(_$EarthquakeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originTime = null,
    Object? arrivalTime = null,
    Object? hypocenter = null,
    Object? magnitude = null,
  }) {
    return _then(_$EarthquakeImpl(
      originTime: null == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      arrivalTime: null == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hypocenter: null == hypocenter
          ? _value.hypocenter
          : hypocenter // ignore: cast_nullable_to_non_nullable
              as EarthquakeHypocenter,
      magnitude: null == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as EarthquakeMagnitude,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeImpl implements _Earthquake {
  const _$EarthquakeImpl(
      {required this.originTime,
      required this.arrivalTime,
      required this.hypocenter,
      required this.magnitude});

  factory _$EarthquakeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeImplFromJson(json);

  @override
  final DateTime originTime;
  @override
  final DateTime arrivalTime;
  @override
  final EarthquakeHypocenter hypocenter;
  @override
  final EarthquakeMagnitude magnitude;

  @override
  String toString() {
    return 'Earthquake(originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, magnitude: $magnitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeImpl &&
            (identical(other.originTime, originTime) ||
                other.originTime == originTime) &&
            (identical(other.arrivalTime, arrivalTime) ||
                other.arrivalTime == arrivalTime) &&
            (identical(other.hypocenter, hypocenter) ||
                other.hypocenter == hypocenter) &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, originTime, arrivalTime, hypocenter, magnitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeImplCopyWith<_$EarthquakeImpl> get copyWith =>
      __$$EarthquakeImplCopyWithImpl<_$EarthquakeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeImplToJson(
      this,
    );
  }
}

abstract class _Earthquake implements Earthquake {
  const factory _Earthquake(
      {required final DateTime originTime,
      required final DateTime arrivalTime,
      required final EarthquakeHypocenter hypocenter,
      required final EarthquakeMagnitude magnitude}) = _$EarthquakeImpl;

  factory _Earthquake.fromJson(Map<String, dynamic> json) =
      _$EarthquakeImpl.fromJson;

  @override
  DateTime get originTime;
  @override
  DateTime get arrivalTime;
  @override
  EarthquakeHypocenter get hypocenter;
  @override
  EarthquakeMagnitude get magnitude;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeImplCopyWith<_$EarthquakeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EarthquakeHypocenter _$EarthquakeHypocenterFromJson(Map<String, dynamic> json) {
  return _EarthquakeHypocenter.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeHypocenter {
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  /// 0: ごく浅い
  /// 700: 700km以上
  /// null: 不明
  int? get depth => throw _privateConstructorUsedError;
  EarthquakeHypocenterDetailed? get detailed =>
      throw _privateConstructorUsedError;
  LatLng? get coordinate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeHypocenterCopyWith<EarthquakeHypocenter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeHypocenterCopyWith<$Res> {
  factory $EarthquakeHypocenterCopyWith(EarthquakeHypocenter value,
          $Res Function(EarthquakeHypocenter) then) =
      _$EarthquakeHypocenterCopyWithImpl<$Res, EarthquakeHypocenter>;
  @useResult
  $Res call(
      {String name,
      String code,
      int? depth,
      EarthquakeHypocenterDetailed? detailed,
      LatLng? coordinate});

  $EarthquakeHypocenterDetailedCopyWith<$Res>? get detailed;
}

/// @nodoc
class _$EarthquakeHypocenterCopyWithImpl<$Res,
        $Val extends EarthquakeHypocenter>
    implements $EarthquakeHypocenterCopyWith<$Res> {
  _$EarthquakeHypocenterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? depth = freezed,
    Object? detailed = freezed,
    Object? coordinate = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      detailed: freezed == detailed
          ? _value.detailed
          : detailed // ignore: cast_nullable_to_non_nullable
              as EarthquakeHypocenterDetailed?,
      coordinate: freezed == coordinate
          ? _value.coordinate
          : coordinate // ignore: cast_nullable_to_non_nullable
              as LatLng?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeHypocenterDetailedCopyWith<$Res>? get detailed {
    if (_value.detailed == null) {
      return null;
    }

    return $EarthquakeHypocenterDetailedCopyWith<$Res>(_value.detailed!,
        (value) {
      return _then(_value.copyWith(detailed: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EarthquakeHypocenterImplCopyWith<$Res>
    implements $EarthquakeHypocenterCopyWith<$Res> {
  factory _$$EarthquakeHypocenterImplCopyWith(_$EarthquakeHypocenterImpl value,
          $Res Function(_$EarthquakeHypocenterImpl) then) =
      __$$EarthquakeHypocenterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String code,
      int? depth,
      EarthquakeHypocenterDetailed? detailed,
      LatLng? coordinate});

  @override
  $EarthquakeHypocenterDetailedCopyWith<$Res>? get detailed;
}

/// @nodoc
class __$$EarthquakeHypocenterImplCopyWithImpl<$Res>
    extends _$EarthquakeHypocenterCopyWithImpl<$Res, _$EarthquakeHypocenterImpl>
    implements _$$EarthquakeHypocenterImplCopyWith<$Res> {
  __$$EarthquakeHypocenterImplCopyWithImpl(_$EarthquakeHypocenterImpl _value,
      $Res Function(_$EarthquakeHypocenterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? depth = freezed,
    Object? detailed = freezed,
    Object? coordinate = freezed,
  }) {
    return _then(_$EarthquakeHypocenterImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      detailed: freezed == detailed
          ? _value.detailed
          : detailed // ignore: cast_nullable_to_non_nullable
              as EarthquakeHypocenterDetailed?,
      coordinate: freezed == coordinate
          ? _value.coordinate
          : coordinate // ignore: cast_nullable_to_non_nullable
              as LatLng?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeHypocenterImpl implements _EarthquakeHypocenter {
  const _$EarthquakeHypocenterImpl(
      {required this.name,
      required this.code,
      required this.depth,
      required this.detailed,
      required this.coordinate});

  factory _$EarthquakeHypocenterImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeHypocenterImplFromJson(json);

  @override
  final String name;
  @override
  final String code;

  /// 0: ごく浅い
  /// 700: 700km以上
  /// null: 不明
  @override
  final int? depth;
  @override
  final EarthquakeHypocenterDetailed? detailed;
  @override
  final LatLng? coordinate;

  @override
  String toString() {
    return 'EarthquakeHypocenter(name: $name, code: $code, depth: $depth, detailed: $detailed, coordinate: $coordinate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeHypocenterImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.detailed, detailed) ||
                other.detailed == detailed) &&
            (identical(other.coordinate, coordinate) ||
                other.coordinate == coordinate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, code, depth, detailed, coordinate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeHypocenterImplCopyWith<_$EarthquakeHypocenterImpl>
      get copyWith =>
          __$$EarthquakeHypocenterImplCopyWithImpl<_$EarthquakeHypocenterImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeHypocenterImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeHypocenter implements EarthquakeHypocenter {
  const factory _EarthquakeHypocenter(
      {required final String name,
      required final String code,
      required final int? depth,
      required final EarthquakeHypocenterDetailed? detailed,
      required final LatLng? coordinate}) = _$EarthquakeHypocenterImpl;

  factory _EarthquakeHypocenter.fromJson(Map<String, dynamic> json) =
      _$EarthquakeHypocenterImpl.fromJson;

  @override
  String get name;
  @override
  String get code;
  @override

  /// 0: ごく浅い
  /// 700: 700km以上
  /// null: 不明
  int? get depth;
  @override
  EarthquakeHypocenterDetailed? get detailed;
  @override
  LatLng? get coordinate;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeHypocenterImplCopyWith<_$EarthquakeHypocenterImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EarthquakeHypocenterDetailed _$EarthquakeHypocenterDetailedFromJson(
    Map<String, dynamic> json) {
  return _EarthquakeHypocenterDetailed.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeHypocenterDetailed {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeHypocenterDetailedCopyWith<EarthquakeHypocenterDetailed>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeHypocenterDetailedCopyWith<$Res> {
  factory $EarthquakeHypocenterDetailedCopyWith(
          EarthquakeHypocenterDetailed value,
          $Res Function(EarthquakeHypocenterDetailed) then) =
      _$EarthquakeHypocenterDetailedCopyWithImpl<$Res,
          EarthquakeHypocenterDetailed>;
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class _$EarthquakeHypocenterDetailedCopyWithImpl<$Res,
        $Val extends EarthquakeHypocenterDetailed>
    implements $EarthquakeHypocenterDetailedCopyWith<$Res> {
  _$EarthquakeHypocenterDetailedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeHypocenterDetailedImplCopyWith<$Res>
    implements $EarthquakeHypocenterDetailedCopyWith<$Res> {
  factory _$$EarthquakeHypocenterDetailedImplCopyWith(
          _$EarthquakeHypocenterDetailedImpl value,
          $Res Function(_$EarthquakeHypocenterDetailedImpl) then) =
      __$$EarthquakeHypocenterDetailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class __$$EarthquakeHypocenterDetailedImplCopyWithImpl<$Res>
    extends _$EarthquakeHypocenterDetailedCopyWithImpl<$Res,
        _$EarthquakeHypocenterDetailedImpl>
    implements _$$EarthquakeHypocenterDetailedImplCopyWith<$Res> {
  __$$EarthquakeHypocenterDetailedImplCopyWithImpl(
      _$EarthquakeHypocenterDetailedImpl _value,
      $Res Function(_$EarthquakeHypocenterDetailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_$EarthquakeHypocenterDetailedImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeHypocenterDetailedImpl
    implements _EarthquakeHypocenterDetailed {
  const _$EarthquakeHypocenterDetailedImpl(
      {required this.code, required this.name});

  factory _$EarthquakeHypocenterDetailedImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EarthquakeHypocenterDetailedImplFromJson(json);

  @override
  final String code;
  @override
  final String name;

  @override
  String toString() {
    return 'EarthquakeHypocenterDetailed(code: $code, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeHypocenterDetailedImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeHypocenterDetailedImplCopyWith<
          _$EarthquakeHypocenterDetailedImpl>
      get copyWith => __$$EarthquakeHypocenterDetailedImplCopyWithImpl<
          _$EarthquakeHypocenterDetailedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeHypocenterDetailedImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeHypocenterDetailed
    implements EarthquakeHypocenterDetailed {
  const factory _EarthquakeHypocenterDetailed(
      {required final String code,
      required final String name}) = _$EarthquakeHypocenterDetailedImpl;

  factory _EarthquakeHypocenterDetailed.fromJson(Map<String, dynamic> json) =
      _$EarthquakeHypocenterDetailedImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeHypocenterDetailedImplCopyWith<
          _$EarthquakeHypocenterDetailedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EarthquakeMagnitude _$EarthquakeMagnitudeFromJson(Map<String, dynamic> json) {
  return _EarthquakeMagnitude.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeMagnitude {
  double? get value => throw _privateConstructorUsedError;
  String? get condition => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeMagnitudeCopyWith<EarthquakeMagnitude> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeMagnitudeCopyWith<$Res> {
  factory $EarthquakeMagnitudeCopyWith(
          EarthquakeMagnitude value, $Res Function(EarthquakeMagnitude) then) =
      _$EarthquakeMagnitudeCopyWithImpl<$Res, EarthquakeMagnitude>;
  @useResult
  $Res call({double? value, String? condition});
}

/// @nodoc
class _$EarthquakeMagnitudeCopyWithImpl<$Res, $Val extends EarthquakeMagnitude>
    implements $EarthquakeMagnitudeCopyWith<$Res> {
  _$EarthquakeMagnitudeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? condition = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeMagnitudeImplCopyWith<$Res>
    implements $EarthquakeMagnitudeCopyWith<$Res> {
  factory _$$EarthquakeMagnitudeImplCopyWith(_$EarthquakeMagnitudeImpl value,
          $Res Function(_$EarthquakeMagnitudeImpl) then) =
      __$$EarthquakeMagnitudeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? value, String? condition});
}

/// @nodoc
class __$$EarthquakeMagnitudeImplCopyWithImpl<$Res>
    extends _$EarthquakeMagnitudeCopyWithImpl<$Res, _$EarthquakeMagnitudeImpl>
    implements _$$EarthquakeMagnitudeImplCopyWith<$Res> {
  __$$EarthquakeMagnitudeImplCopyWithImpl(_$EarthquakeMagnitudeImpl _value,
      $Res Function(_$EarthquakeMagnitudeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? condition = freezed,
  }) {
    return _then(_$EarthquakeMagnitudeImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeMagnitudeImpl implements _EarthquakeMagnitude {
  const _$EarthquakeMagnitudeImpl(
      {required this.value, required this.condition});

  factory _$EarthquakeMagnitudeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeMagnitudeImplFromJson(json);

  @override
  final double? value;
  @override
  final String? condition;

  @override
  String toString() {
    return 'EarthquakeMagnitude(value: $value, condition: $condition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeMagnitudeImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.condition, condition) ||
                other.condition == condition));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, condition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeMagnitudeImplCopyWith<_$EarthquakeMagnitudeImpl> get copyWith =>
      __$$EarthquakeMagnitudeImplCopyWithImpl<_$EarthquakeMagnitudeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeMagnitudeImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeMagnitude implements EarthquakeMagnitude {
  const factory _EarthquakeMagnitude(
      {required final double? value,
      required final String? condition}) = _$EarthquakeMagnitudeImpl;

  factory _EarthquakeMagnitude.fromJson(Map<String, dynamic> json) =
      _$EarthquakeMagnitudeImpl.fromJson;

  @override
  double? get value;
  @override
  String? get condition;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeMagnitudeImplCopyWith<_$EarthquakeMagnitudeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

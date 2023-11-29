// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EewRegion _$EewRegionFromJson(Map<String, dynamic> json) {
  return _EewRegion.fromJson(json);
}

/// @nodoc
mixin _$EewRegion {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isPlum => throw _privateConstructorUsedError;
  bool get isWarning => throw _privateConstructorUsedError;
  ForecastMaxInt get forecastMaxInt => throw _privateConstructorUsedError;
  ForecastMaxLgInt? get forecastMaxLgInt => throw _privateConstructorUsedError;

  /// undefinedの場合は null
  /// PLUM法の場合は最初にその階級震度を予測した時刻
  DateTime? get arrivalTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EewRegionCopyWith<EewRegion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EewRegionCopyWith<$Res> {
  factory $EewRegionCopyWith(EewRegion value, $Res Function(EewRegion) then) =
      _$EewRegionCopyWithImpl<$Res, EewRegion>;
  @useResult
  $Res call(
      {String code,
      String name,
      bool isPlum,
      bool isWarning,
      ForecastMaxInt forecastMaxInt,
      ForecastMaxLgInt? forecastMaxLgInt,
      DateTime? arrivalTime});

  $ForecastMaxIntCopyWith<$Res> get forecastMaxInt;
  $ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt;
}

/// @nodoc
class _$EewRegionCopyWithImpl<$Res, $Val extends EewRegion>
    implements $EewRegionCopyWith<$Res> {
  _$EewRegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? isPlum = null,
    Object? isWarning = null,
    Object? forecastMaxInt = null,
    Object? forecastMaxLgInt = freezed,
    Object? arrivalTime = freezed,
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
      isPlum: null == isPlum
          ? _value.isPlum
          : isPlum // ignore: cast_nullable_to_non_nullable
              as bool,
      isWarning: null == isWarning
          ? _value.isWarning
          : isWarning // ignore: cast_nullable_to_non_nullable
              as bool,
      forecastMaxInt: null == forecastMaxInt
          ? _value.forecastMaxInt
          : forecastMaxInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxInt,
      forecastMaxLgInt: freezed == forecastMaxLgInt
          ? _value.forecastMaxLgInt
          : forecastMaxLgInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxLgInt?,
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ForecastMaxIntCopyWith<$Res> get forecastMaxInt {
    return $ForecastMaxIntCopyWith<$Res>(_value.forecastMaxInt, (value) {
      return _then(_value.copyWith(forecastMaxInt: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt {
    if (_value.forecastMaxLgInt == null) {
      return null;
    }

    return $ForecastMaxLgIntCopyWith<$Res>(_value.forecastMaxLgInt!, (value) {
      return _then(_value.copyWith(forecastMaxLgInt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EewRegionImplCopyWith<$Res>
    implements $EewRegionCopyWith<$Res> {
  factory _$$EewRegionImplCopyWith(
          _$EewRegionImpl value, $Res Function(_$EewRegionImpl) then) =
      __$$EewRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String name,
      bool isPlum,
      bool isWarning,
      ForecastMaxInt forecastMaxInt,
      ForecastMaxLgInt? forecastMaxLgInt,
      DateTime? arrivalTime});

  @override
  $ForecastMaxIntCopyWith<$Res> get forecastMaxInt;
  @override
  $ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt;
}

/// @nodoc
class __$$EewRegionImplCopyWithImpl<$Res>
    extends _$EewRegionCopyWithImpl<$Res, _$EewRegionImpl>
    implements _$$EewRegionImplCopyWith<$Res> {
  __$$EewRegionImplCopyWithImpl(
      _$EewRegionImpl _value, $Res Function(_$EewRegionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? isPlum = null,
    Object? isWarning = null,
    Object? forecastMaxInt = null,
    Object? forecastMaxLgInt = freezed,
    Object? arrivalTime = freezed,
  }) {
    return _then(_$EewRegionImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isPlum: null == isPlum
          ? _value.isPlum
          : isPlum // ignore: cast_nullable_to_non_nullable
              as bool,
      isWarning: null == isWarning
          ? _value.isWarning
          : isWarning // ignore: cast_nullable_to_non_nullable
              as bool,
      forecastMaxInt: null == forecastMaxInt
          ? _value.forecastMaxInt
          : forecastMaxInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxInt,
      forecastMaxLgInt: freezed == forecastMaxLgInt
          ? _value.forecastMaxLgInt
          : forecastMaxLgInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxLgInt?,
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EewRegionImpl implements _EewRegion {
  const _$EewRegionImpl(
      {required this.code,
      required this.name,
      required this.isPlum,
      required this.isWarning,
      required this.forecastMaxInt,
      required this.forecastMaxLgInt,
      required this.arrivalTime});

  factory _$EewRegionImpl.fromJson(Map<String, dynamic> json) =>
      _$$EewRegionImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final bool isPlum;
  @override
  final bool isWarning;
  @override
  final ForecastMaxInt forecastMaxInt;
  @override
  final ForecastMaxLgInt? forecastMaxLgInt;

  /// undefinedの場合は null
  /// PLUM法の場合は最初にその階級震度を予測した時刻
  @override
  final DateTime? arrivalTime;

  @override
  String toString() {
    return 'EewRegion(code: $code, name: $name, isPlum: $isPlum, isWarning: $isWarning, forecastMaxInt: $forecastMaxInt, forecastMaxLgInt: $forecastMaxLgInt, arrivalTime: $arrivalTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EewRegionImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isPlum, isPlum) || other.isPlum == isPlum) &&
            (identical(other.isWarning, isWarning) ||
                other.isWarning == isWarning) &&
            (identical(other.forecastMaxInt, forecastMaxInt) ||
                other.forecastMaxInt == forecastMaxInt) &&
            (identical(other.forecastMaxLgInt, forecastMaxLgInt) ||
                other.forecastMaxLgInt == forecastMaxLgInt) &&
            (identical(other.arrivalTime, arrivalTime) ||
                other.arrivalTime == arrivalTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, isPlum, isWarning,
      forecastMaxInt, forecastMaxLgInt, arrivalTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EewRegionImplCopyWith<_$EewRegionImpl> get copyWith =>
      __$$EewRegionImplCopyWithImpl<_$EewRegionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EewRegionImplToJson(
      this,
    );
  }
}

abstract class _EewRegion implements EewRegion {
  const factory _EewRegion(
      {required final String code,
      required final String name,
      required final bool isPlum,
      required final bool isWarning,
      required final ForecastMaxInt forecastMaxInt,
      required final ForecastMaxLgInt? forecastMaxLgInt,
      required final DateTime? arrivalTime}) = _$EewRegionImpl;

  factory _EewRegion.fromJson(Map<String, dynamic> json) =
      _$EewRegionImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  bool get isPlum;
  @override
  bool get isWarning;
  @override
  ForecastMaxInt get forecastMaxInt;
  @override
  ForecastMaxLgInt? get forecastMaxLgInt;
  @override

  /// undefinedの場合は null
  /// PLUM法の場合は最初にその階級震度を予測した時刻
  DateTime? get arrivalTime;
  @override
  @JsonKey(ignore: true)
  _$$EewRegionImplCopyWith<_$EewRegionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

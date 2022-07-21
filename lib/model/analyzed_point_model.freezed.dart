// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'analyzed_point_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnalyzedPoint {
  /// 観測点コード
  String get code => throw _privateConstructorUsedError;

  /// 観測点名
  String get name => throw _privateConstructorUsedError;

  /// 都道府県
  String get prefectureName => throw _privateConstructorUsedError;

  /// 緯度
  double get lat => throw _privateConstructorUsedError;

  /// 経度
  double get lon => throw _privateConstructorUsedError;

  /// リアルタイム震度
  double? get shindo => throw _privateConstructorUsedError;

  /// リアルタイム震度の色
  Color? get shindoColor => throw _privateConstructorUsedError;

  /// リアルタイム加速度(PGA)
  double? get pga => throw _privateConstructorUsedError;

  /// リアルタイム加速度(PGA)の色
  Color? get pgaColor => throw _privateConstructorUsedError;

  /// アプリ起動中に震度 もしくは PGAが値を持っていたかどうか
  bool get hadValue => throw _privateConstructorUsedError;

  /// リアルタイム震度をJMA-Intensityに変換したもの
  JmaIntensity? get intensity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnalyzedPointCopyWith<AnalyzedPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyzedPointCopyWith<$Res> {
  factory $AnalyzedPointCopyWith(
          AnalyzedPoint value, $Res Function(AnalyzedPoint) then) =
      _$AnalyzedPointCopyWithImpl<$Res>;
  $Res call(
      {String code,
      String name,
      String prefectureName,
      double lat,
      double lon,
      double? shindo,
      Color? shindoColor,
      double? pga,
      Color? pgaColor,
      bool hadValue,
      JmaIntensity? intensity});
}

/// @nodoc
class _$AnalyzedPointCopyWithImpl<$Res>
    implements $AnalyzedPointCopyWith<$Res> {
  _$AnalyzedPointCopyWithImpl(this._value, this._then);

  final AnalyzedPoint _value;
  // ignore: unused_field
  final $Res Function(AnalyzedPoint) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? prefectureName = freezed,
    Object? lat = freezed,
    Object? lon = freezed,
    Object? shindo = freezed,
    Object? shindoColor = freezed,
    Object? pga = freezed,
    Object? pgaColor = freezed,
    Object? hadValue = freezed,
    Object? intensity = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      prefectureName: prefectureName == freezed
          ? _value.prefectureName
          : prefectureName // ignore: cast_nullable_to_non_nullable
              as String,
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: lon == freezed
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      shindo: shindo == freezed
          ? _value.shindo
          : shindo // ignore: cast_nullable_to_non_nullable
              as double?,
      shindoColor: shindoColor == freezed
          ? _value.shindoColor
          : shindoColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      pga: pga == freezed
          ? _value.pga
          : pga // ignore: cast_nullable_to_non_nullable
              as double?,
      pgaColor: pgaColor == freezed
          ? _value.pgaColor
          : pgaColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      hadValue: hadValue == freezed
          ? _value.hadValue
          : hadValue // ignore: cast_nullable_to_non_nullable
              as bool,
      intensity: intensity == freezed
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
    ));
  }
}

/// @nodoc
abstract class _$$_AnalyzedPointCopyWith<$Res>
    implements $AnalyzedPointCopyWith<$Res> {
  factory _$$_AnalyzedPointCopyWith(
          _$_AnalyzedPoint value, $Res Function(_$_AnalyzedPoint) then) =
      __$$_AnalyzedPointCopyWithImpl<$Res>;
  @override
  $Res call(
      {String code,
      String name,
      String prefectureName,
      double lat,
      double lon,
      double? shindo,
      Color? shindoColor,
      double? pga,
      Color? pgaColor,
      bool hadValue,
      JmaIntensity? intensity});
}

/// @nodoc
class __$$_AnalyzedPointCopyWithImpl<$Res>
    extends _$AnalyzedPointCopyWithImpl<$Res>
    implements _$$_AnalyzedPointCopyWith<$Res> {
  __$$_AnalyzedPointCopyWithImpl(
      _$_AnalyzedPoint _value, $Res Function(_$_AnalyzedPoint) _then)
      : super(_value, (v) => _then(v as _$_AnalyzedPoint));

  @override
  _$_AnalyzedPoint get _value => super._value as _$_AnalyzedPoint;

  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? prefectureName = freezed,
    Object? lat = freezed,
    Object? lon = freezed,
    Object? shindo = freezed,
    Object? shindoColor = freezed,
    Object? pga = freezed,
    Object? pgaColor = freezed,
    Object? hadValue = freezed,
    Object? intensity = freezed,
  }) {
    return _then(_$_AnalyzedPoint(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      prefectureName: prefectureName == freezed
          ? _value.prefectureName
          : prefectureName // ignore: cast_nullable_to_non_nullable
              as String,
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: lon == freezed
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      shindo: shindo == freezed
          ? _value.shindo
          : shindo // ignore: cast_nullable_to_non_nullable
              as double?,
      shindoColor: shindoColor == freezed
          ? _value.shindoColor
          : shindoColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      pga: pga == freezed
          ? _value.pga
          : pga // ignore: cast_nullable_to_non_nullable
              as double?,
      pgaColor: pgaColor == freezed
          ? _value.pgaColor
          : pgaColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      hadValue: hadValue == freezed
          ? _value.hadValue
          : hadValue // ignore: cast_nullable_to_non_nullable
              as bool,
      intensity: intensity == freezed
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
    ));
  }
}

/// @nodoc

class _$_AnalyzedPoint implements _AnalyzedPoint {
  const _$_AnalyzedPoint(
      {required this.code,
      required this.name,
      required this.prefectureName,
      required this.lat,
      required this.lon,
      required this.shindo,
      required this.shindoColor,
      required this.pga,
      required this.pgaColor,
      required this.hadValue,
      required this.intensity});

  /// 観測点コード
  @override
  final String code;

  /// 観測点名
  @override
  final String name;

  /// 都道府県
  @override
  final String prefectureName;

  /// 緯度
  @override
  final double lat;

  /// 経度
  @override
  final double lon;

  /// リアルタイム震度
  @override
  final double? shindo;

  /// リアルタイム震度の色
  @override
  final Color? shindoColor;

  /// リアルタイム加速度(PGA)
  @override
  final double? pga;

  /// リアルタイム加速度(PGA)の色
  @override
  final Color? pgaColor;

  /// アプリ起動中に震度 もしくは PGAが値を持っていたかどうか
  @override
  final bool hadValue;

  /// リアルタイム震度をJMA-Intensityに変換したもの
  @override
  final JmaIntensity? intensity;

  @override
  String toString() {
    return 'AnalyzedPoint(code: $code, name: $name, prefectureName: $prefectureName, lat: $lat, lon: $lon, shindo: $shindo, shindoColor: $shindoColor, pga: $pga, pgaColor: $pgaColor, hadValue: $hadValue, intensity: $intensity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnalyzedPoint &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.prefectureName, prefectureName) &&
            const DeepCollectionEquality().equals(other.lat, lat) &&
            const DeepCollectionEquality().equals(other.lon, lon) &&
            const DeepCollectionEquality().equals(other.shindo, shindo) &&
            const DeepCollectionEquality()
                .equals(other.shindoColor, shindoColor) &&
            const DeepCollectionEquality().equals(other.pga, pga) &&
            const DeepCollectionEquality().equals(other.pgaColor, pgaColor) &&
            const DeepCollectionEquality().equals(other.hadValue, hadValue) &&
            const DeepCollectionEquality().equals(other.intensity, intensity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(prefectureName),
      const DeepCollectionEquality().hash(lat),
      const DeepCollectionEquality().hash(lon),
      const DeepCollectionEquality().hash(shindo),
      const DeepCollectionEquality().hash(shindoColor),
      const DeepCollectionEquality().hash(pga),
      const DeepCollectionEquality().hash(pgaColor),
      const DeepCollectionEquality().hash(hadValue),
      const DeepCollectionEquality().hash(intensity));

  @JsonKey(ignore: true)
  @override
  _$$_AnalyzedPointCopyWith<_$_AnalyzedPoint> get copyWith =>
      __$$_AnalyzedPointCopyWithImpl<_$_AnalyzedPoint>(this, _$identity);
}

abstract class _AnalyzedPoint implements AnalyzedPoint {
  const factory _AnalyzedPoint(
      {required final String code,
      required final String name,
      required final String prefectureName,
      required final double lat,
      required final double lon,
      required final double? shindo,
      required final Color? shindoColor,
      required final double? pga,
      required final Color? pgaColor,
      required final bool hadValue,
      required final JmaIntensity? intensity}) = _$_AnalyzedPoint;

  @override

  /// 観測点コード
  String get code => throw _privateConstructorUsedError;
  @override

  /// 観測点名
  String get name => throw _privateConstructorUsedError;
  @override

  /// 都道府県
  String get prefectureName => throw _privateConstructorUsedError;
  @override

  /// 緯度
  double get lat => throw _privateConstructorUsedError;
  @override

  /// 経度
  double get lon => throw _privateConstructorUsedError;
  @override

  /// リアルタイム震度
  double? get shindo => throw _privateConstructorUsedError;
  @override

  /// リアルタイム震度の色
  Color? get shindoColor => throw _privateConstructorUsedError;
  @override

  /// リアルタイム加速度(PGA)
  double? get pga => throw _privateConstructorUsedError;
  @override

  /// リアルタイム加速度(PGA)の色
  Color? get pgaColor => throw _privateConstructorUsedError;
  @override

  /// アプリ起動中に震度 もしくは PGAが値を持っていたかどうか
  bool get hadValue => throw _privateConstructorUsedError;
  @override

  /// リアルタイム震度をJMA-Intensityに変換したもの
  JmaIntensity? get intensity => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AnalyzedPointCopyWith<_$_AnalyzedPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

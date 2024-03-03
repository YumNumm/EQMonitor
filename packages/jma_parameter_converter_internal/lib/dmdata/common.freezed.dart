// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ParameterRegion _$ParameterRegionFromJson(Map<String, dynamic> json) {
  return _ParameterRegion.fromJson(json);
}

/// @nodoc
mixin _$ParameterRegion {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get kana => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParameterRegionCopyWith<ParameterRegion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParameterRegionCopyWith<$Res> {
  factory $ParameterRegionCopyWith(
          ParameterRegion value, $Res Function(ParameterRegion) then) =
      _$ParameterRegionCopyWithImpl<$Res, ParameterRegion>;
  @useResult
  $Res call({String code, String name, String kana});
}

/// @nodoc
class _$ParameterRegionCopyWithImpl<$Res, $Val extends ParameterRegion>
    implements $ParameterRegionCopyWith<$Res> {
  _$ParameterRegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? kana = null,
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
      kana: null == kana
          ? _value.kana
          : kana // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParameterRegionImplCopyWith<$Res>
    implements $ParameterRegionCopyWith<$Res> {
  factory _$$ParameterRegionImplCopyWith(_$ParameterRegionImpl value,
          $Res Function(_$ParameterRegionImpl) then) =
      __$$ParameterRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String name, String kana});
}

/// @nodoc
class __$$ParameterRegionImplCopyWithImpl<$Res>
    extends _$ParameterRegionCopyWithImpl<$Res, _$ParameterRegionImpl>
    implements _$$ParameterRegionImplCopyWith<$Res> {
  __$$ParameterRegionImplCopyWithImpl(
      _$ParameterRegionImpl _value, $Res Function(_$ParameterRegionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? kana = null,
  }) {
    return _then(_$ParameterRegionImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      kana: null == kana
          ? _value.kana
          : kana // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParameterRegionImpl implements _ParameterRegion {
  const _$ParameterRegionImpl(
      {required this.code, required this.name, required this.kana});

  factory _$ParameterRegionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParameterRegionImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final String kana;

  @override
  String toString() {
    return 'ParameterRegion(code: $code, name: $name, kana: $kana)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParameterRegionImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.kana, kana) || other.kana == kana));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, kana);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParameterRegionImplCopyWith<_$ParameterRegionImpl> get copyWith =>
      __$$ParameterRegionImplCopyWithImpl<_$ParameterRegionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParameterRegionImplToJson(
      this,
    );
  }
}

abstract class _ParameterRegion implements ParameterRegion {
  const factory _ParameterRegion(
      {required final String code,
      required final String name,
      required final String kana}) = _$ParameterRegionImpl;

  factory _ParameterRegion.fromJson(Map<String, dynamic> json) =
      _$ParameterRegionImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  String get kana;
  @override
  @JsonKey(ignore: true)
  _$$ParameterRegionImplCopyWith<_$ParameterRegionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParameterCity _$ParameterCityFromJson(Map<String, dynamic> json) {
  return _ParameterCity.fromJson(json);
}

/// @nodoc
mixin _$ParameterCity {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get kana => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParameterCityCopyWith<ParameterCity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParameterCityCopyWith<$Res> {
  factory $ParameterCityCopyWith(
          ParameterCity value, $Res Function(ParameterCity) then) =
      _$ParameterCityCopyWithImpl<$Res, ParameterCity>;
  @useResult
  $Res call({String code, String name, String kana});
}

/// @nodoc
class _$ParameterCityCopyWithImpl<$Res, $Val extends ParameterCity>
    implements $ParameterCityCopyWith<$Res> {
  _$ParameterCityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? kana = null,
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
      kana: null == kana
          ? _value.kana
          : kana // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParameterCityImplCopyWith<$Res>
    implements $ParameterCityCopyWith<$Res> {
  factory _$$ParameterCityImplCopyWith(
          _$ParameterCityImpl value, $Res Function(_$ParameterCityImpl) then) =
      __$$ParameterCityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String name, String kana});
}

/// @nodoc
class __$$ParameterCityImplCopyWithImpl<$Res>
    extends _$ParameterCityCopyWithImpl<$Res, _$ParameterCityImpl>
    implements _$$ParameterCityImplCopyWith<$Res> {
  __$$ParameterCityImplCopyWithImpl(
      _$ParameterCityImpl _value, $Res Function(_$ParameterCityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? kana = null,
  }) {
    return _then(_$ParameterCityImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      kana: null == kana
          ? _value.kana
          : kana // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParameterCityImpl implements _ParameterCity {
  const _$ParameterCityImpl(
      {required this.code, required this.name, required this.kana});

  factory _$ParameterCityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParameterCityImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final String kana;

  @override
  String toString() {
    return 'ParameterCity(code: $code, name: $name, kana: $kana)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParameterCityImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.kana, kana) || other.kana == kana));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, kana);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParameterCityImplCopyWith<_$ParameterCityImpl> get copyWith =>
      __$$ParameterCityImplCopyWithImpl<_$ParameterCityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParameterCityImplToJson(
      this,
    );
  }
}

abstract class _ParameterCity implements ParameterCity {
  const factory _ParameterCity(
      {required final String code,
      required final String name,
      required final String kana}) = _$ParameterCityImpl;

  factory _ParameterCity.fromJson(Map<String, dynamic> json) =
      _$ParameterCityImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  String get kana;
  @override
  @JsonKey(ignore: true)
  _$$ParameterCityImplCopyWith<_$ParameterCityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

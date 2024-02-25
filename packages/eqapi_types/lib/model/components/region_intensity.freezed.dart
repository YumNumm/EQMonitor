// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_intensity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegionIntensity _$RegionIntensityFromJson(Map<String, dynamic> json) {
  return _RegionIntensity.fromJson(json);
}

/// @nodoc
mixin _$RegionIntensity {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  JmaIntensity? get maxInt => throw _privateConstructorUsedError;
  JmaLgIntensity? get maxLgInt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegionIntensityCopyWith<RegionIntensity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionIntensityCopyWith<$Res> {
  factory $RegionIntensityCopyWith(
          RegionIntensity value, $Res Function(RegionIntensity) then) =
      _$RegionIntensityCopyWithImpl<$Res, RegionIntensity>;
  @useResult
  $Res call(
      {String code,
      String name,
      JmaIntensity? maxInt,
      JmaLgIntensity? maxLgInt});
}

/// @nodoc
class _$RegionIntensityCopyWithImpl<$Res, $Val extends RegionIntensity>
    implements $RegionIntensityCopyWith<$Res> {
  _$RegionIntensityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? maxInt = freezed,
    Object? maxLgInt = freezed,
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
      maxInt: freezed == maxInt
          ? _value.maxInt
          : maxInt // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      maxLgInt: freezed == maxLgInt
          ? _value.maxLgInt
          : maxLgInt // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegionIntensityImplCopyWith<$Res>
    implements $RegionIntensityCopyWith<$Res> {
  factory _$$RegionIntensityImplCopyWith(_$RegionIntensityImpl value,
          $Res Function(_$RegionIntensityImpl) then) =
      __$$RegionIntensityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String name,
      JmaIntensity? maxInt,
      JmaLgIntensity? maxLgInt});
}

/// @nodoc
class __$$RegionIntensityImplCopyWithImpl<$Res>
    extends _$RegionIntensityCopyWithImpl<$Res, _$RegionIntensityImpl>
    implements _$$RegionIntensityImplCopyWith<$Res> {
  __$$RegionIntensityImplCopyWithImpl(
      _$RegionIntensityImpl _value, $Res Function(_$RegionIntensityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? maxInt = freezed,
    Object? maxLgInt = freezed,
  }) {
    return _then(_$RegionIntensityImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxInt: freezed == maxInt
          ? _value.maxInt
          : maxInt // ignore: cast_nullable_to_non_nullable
              as JmaIntensity?,
      maxLgInt: freezed == maxLgInt
          ? _value.maxLgInt
          : maxLgInt // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$RegionIntensityImpl implements _RegionIntensity {
  const _$RegionIntensityImpl(
      {required this.code,
      required this.name,
      required this.maxInt,
      required this.maxLgInt});

  factory _$RegionIntensityImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegionIntensityImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final JmaIntensity? maxInt;
  @override
  final JmaLgIntensity? maxLgInt;

  @override
  String toString() {
    return 'RegionIntensity(code: $code, name: $name, maxInt: $maxInt, maxLgInt: $maxLgInt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegionIntensityImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxInt, maxInt) || other.maxInt == maxInt) &&
            (identical(other.maxLgInt, maxLgInt) ||
                other.maxLgInt == maxLgInt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, maxInt, maxLgInt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegionIntensityImplCopyWith<_$RegionIntensityImpl> get copyWith =>
      __$$RegionIntensityImplCopyWithImpl<_$RegionIntensityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegionIntensityImplToJson(
      this,
    );
  }
}

abstract class _RegionIntensity implements RegionIntensity {
  const factory _RegionIntensity(
      {required final String code,
      required final String name,
      required final JmaIntensity? maxInt,
      required final JmaLgIntensity? maxLgInt}) = _$RegionIntensityImpl;

  factory _RegionIntensity.fromJson(Map<String, dynamic> json) =
      _$RegionIntensityImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  JmaIntensity? get maxInt;
  @override
  JmaLgIntensity? get maxLgInt;
  @override
  @JsonKey(ignore: true)
  _$$RegionIntensityImplCopyWith<_$RegionIntensityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

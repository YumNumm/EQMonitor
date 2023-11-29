// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_hypocenter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EewHypocenter _$EewHypocenterFromJson(Map<String, dynamic> json) {
  return _EewHypocenter.fromJson(json);
}

/// @nodoc
mixin _$EewHypocenter {
  LatLng? get coordinate => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EewHypocenterCopyWith<EewHypocenter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EewHypocenterCopyWith<$Res> {
  factory $EewHypocenterCopyWith(
          EewHypocenter value, $Res Function(EewHypocenter) then) =
      _$EewHypocenterCopyWithImpl<$Res, EewHypocenter>;
  @useResult
  $Res call({LatLng? coordinate, String code, String name});
}

/// @nodoc
class _$EewHypocenterCopyWithImpl<$Res, $Val extends EewHypocenter>
    implements $EewHypocenterCopyWith<$Res> {
  _$EewHypocenterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coordinate = freezed,
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      coordinate: freezed == coordinate
          ? _value.coordinate
          : coordinate // ignore: cast_nullable_to_non_nullable
              as LatLng?,
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
abstract class _$$EewHypocenterImplCopyWith<$Res>
    implements $EewHypocenterCopyWith<$Res> {
  factory _$$EewHypocenterImplCopyWith(
          _$EewHypocenterImpl value, $Res Function(_$EewHypocenterImpl) then) =
      __$$EewHypocenterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LatLng? coordinate, String code, String name});
}

/// @nodoc
class __$$EewHypocenterImplCopyWithImpl<$Res>
    extends _$EewHypocenterCopyWithImpl<$Res, _$EewHypocenterImpl>
    implements _$$EewHypocenterImplCopyWith<$Res> {
  __$$EewHypocenterImplCopyWithImpl(
      _$EewHypocenterImpl _value, $Res Function(_$EewHypocenterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coordinate = freezed,
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_$EewHypocenterImpl(
      coordinate: freezed == coordinate
          ? _value.coordinate
          : coordinate // ignore: cast_nullable_to_non_nullable
              as LatLng?,
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
class _$EewHypocenterImpl implements _EewHypocenter {
  const _$EewHypocenterImpl(
      {required this.coordinate, required this.code, required this.name});

  factory _$EewHypocenterImpl.fromJson(Map<String, dynamic> json) =>
      _$$EewHypocenterImplFromJson(json);

  @override
  final LatLng? coordinate;
  @override
  final String code;
  @override
  final String name;

  @override
  String toString() {
    return 'EewHypocenter(coordinate: $coordinate, code: $code, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EewHypocenterImpl &&
            (identical(other.coordinate, coordinate) ||
                other.coordinate == coordinate) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, coordinate, code, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EewHypocenterImplCopyWith<_$EewHypocenterImpl> get copyWith =>
      __$$EewHypocenterImplCopyWithImpl<_$EewHypocenterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EewHypocenterImplToJson(
      this,
    );
  }
}

abstract class _EewHypocenter implements EewHypocenter {
  const factory _EewHypocenter(
      {required final LatLng? coordinate,
      required final String code,
      required final String name}) = _$EewHypocenterImpl;

  factory _EewHypocenter.fromJson(Map<String, dynamic> json) =
      _$EewHypocenterImpl.fromJson;

  @override
  LatLng? get coordinate;
  @override
  String get code;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$EewHypocenterImplCopyWith<_$EewHypocenterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

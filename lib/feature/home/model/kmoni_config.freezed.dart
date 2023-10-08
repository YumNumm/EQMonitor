// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kmoni_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KmoniConfig _$KmoniConfigFromJson(Map<String, dynamic> json) {
  return _KmoniConfig.fromJson(json);
}

/// @nodoc
mixin _$KmoniConfig {
  int get counter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KmoniConfigCopyWith<KmoniConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KmoniConfigCopyWith<$Res> {
  factory $KmoniConfigCopyWith(
          KmoniConfig value, $Res Function(KmoniConfig) then) =
      _$KmoniConfigCopyWithImpl<$Res, KmoniConfig>;
  @useResult
  $Res call({int counter});
}

/// @nodoc
class _$KmoniConfigCopyWithImpl<$Res, $Val extends KmoniConfig>
    implements $KmoniConfigCopyWith<$Res> {
  _$KmoniConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counter = null,
  }) {
    return _then(_value.copyWith(
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_KmoniConfigCopyWith<$Res>
    implements $KmoniConfigCopyWith<$Res> {
  factory _$$_KmoniConfigCopyWith(
          _$_KmoniConfig value, $Res Function(_$_KmoniConfig) then) =
      __$$_KmoniConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int counter});
}

/// @nodoc
class __$$_KmoniConfigCopyWithImpl<$Res>
    extends _$KmoniConfigCopyWithImpl<$Res, _$_KmoniConfig>
    implements _$$_KmoniConfigCopyWith<$Res> {
  __$$_KmoniConfigCopyWithImpl(
      _$_KmoniConfig _value, $Res Function(_$_KmoniConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counter = null,
  }) {
    return _then(_$_KmoniConfig(
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_KmoniConfig implements _KmoniConfig {
  const _$_KmoniConfig({this.counter = 0});

  factory _$_KmoniConfig.fromJson(Map<String, dynamic> json) =>
      _$$_KmoniConfigFromJson(json);

  @override
  @JsonKey()
  final int counter;

  @override
  String toString() {
    return 'KmoniConfig(counter: $counter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_KmoniConfig &&
            (identical(other.counter, counter) || other.counter == counter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, counter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_KmoniConfigCopyWith<_$_KmoniConfig> get copyWith =>
      __$$_KmoniConfigCopyWithImpl<_$_KmoniConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_KmoniConfigToJson(
      this,
    );
  }
}

abstract class _KmoniConfig implements KmoniConfig {
  const factory _KmoniConfig({final int counter}) = _$_KmoniConfig;

  factory _KmoniConfig.fromJson(Map<String, dynamic> json) =
      _$_KmoniConfig.fromJson;

  @override
  int get counter;
  @override
  @JsonKey(ignore: true)
  _$$_KmoniConfigCopyWith<_$_KmoniConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

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
abstract class _$$KmoniConfigImplCopyWith<$Res>
    implements $KmoniConfigCopyWith<$Res> {
  factory _$$KmoniConfigImplCopyWith(
          _$KmoniConfigImpl value, $Res Function(_$KmoniConfigImpl) then) =
      __$$KmoniConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int counter});
}

/// @nodoc
class __$$KmoniConfigImplCopyWithImpl<$Res>
    extends _$KmoniConfigCopyWithImpl<$Res, _$KmoniConfigImpl>
    implements _$$KmoniConfigImplCopyWith<$Res> {
  __$$KmoniConfigImplCopyWithImpl(
      _$KmoniConfigImpl _value, $Res Function(_$KmoniConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counter = null,
  }) {
    return _then(_$KmoniConfigImpl(
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KmoniConfigImpl implements _KmoniConfig {
  const _$KmoniConfigImpl({this.counter = 0});

  factory _$KmoniConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$KmoniConfigImplFromJson(json);

  @override
  @JsonKey()
  final int counter;

  @override
  String toString() {
    return 'KmoniConfig(counter: $counter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KmoniConfigImpl &&
            (identical(other.counter, counter) || other.counter == counter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, counter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KmoniConfigImplCopyWith<_$KmoniConfigImpl> get copyWith =>
      __$$KmoniConfigImplCopyWithImpl<_$KmoniConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KmoniConfigImplToJson(
      this,
    );
  }
}

abstract class _KmoniConfig implements KmoniConfig {
  const factory _KmoniConfig({final int counter}) = _$KmoniConfigImpl;

  factory _KmoniConfig.fromJson(Map<String, dynamic> json) =
      _$KmoniConfigImpl.fromJson;

  @override
  int get counter;
  @override
  @JsonKey(ignore: true)
  _$$KmoniConfigImplCopyWith<_$KmoniConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

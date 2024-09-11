// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ntp_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NtpConfigModel _$NtpConfigModelFromJson(Map<String, dynamic> json) {
  return _NtpConfigModel.fromJson(json);
}

/// @nodoc
mixin _$NtpConfigModel {
  String get lookUpAddress => throw _privateConstructorUsedError;
  Duration get timeout => throw _privateConstructorUsedError;
  Duration get interval => throw _privateConstructorUsedError;

  /// Serializes this NtpConfigModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NtpConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NtpConfigModelCopyWith<NtpConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NtpConfigModelCopyWith<$Res> {
  factory $NtpConfigModelCopyWith(
          NtpConfigModel value, $Res Function(NtpConfigModel) then) =
      _$NtpConfigModelCopyWithImpl<$Res, NtpConfigModel>;
  @useResult
  $Res call({String lookUpAddress, Duration timeout, Duration interval});
}

/// @nodoc
class _$NtpConfigModelCopyWithImpl<$Res, $Val extends NtpConfigModel>
    implements $NtpConfigModelCopyWith<$Res> {
  _$NtpConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NtpConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lookUpAddress = null,
    Object? timeout = null,
    Object? interval = null,
  }) {
    return _then(_value.copyWith(
      lookUpAddress: null == lookUpAddress
          ? _value.lookUpAddress
          : lookUpAddress // ignore: cast_nullable_to_non_nullable
              as String,
      timeout: null == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NtpConfigModelImplCopyWith<$Res>
    implements $NtpConfigModelCopyWith<$Res> {
  factory _$$NtpConfigModelImplCopyWith(_$NtpConfigModelImpl value,
          $Res Function(_$NtpConfigModelImpl) then) =
      __$$NtpConfigModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String lookUpAddress, Duration timeout, Duration interval});
}

/// @nodoc
class __$$NtpConfigModelImplCopyWithImpl<$Res>
    extends _$NtpConfigModelCopyWithImpl<$Res, _$NtpConfigModelImpl>
    implements _$$NtpConfigModelImplCopyWith<$Res> {
  __$$NtpConfigModelImplCopyWithImpl(
      _$NtpConfigModelImpl _value, $Res Function(_$NtpConfigModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NtpConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lookUpAddress = null,
    Object? timeout = null,
    Object? interval = null,
  }) {
    return _then(_$NtpConfigModelImpl(
      lookUpAddress: null == lookUpAddress
          ? _value.lookUpAddress
          : lookUpAddress // ignore: cast_nullable_to_non_nullable
              as String,
      timeout: null == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NtpConfigModelImpl implements _NtpConfigModel {
  const _$NtpConfigModelImpl(
      {this.lookUpAddress = 'ntp.nict.jp',
      this.timeout = const Duration(seconds: 10),
      this.interval = const Duration(minutes: 30)});

  factory _$NtpConfigModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NtpConfigModelImplFromJson(json);

  @override
  @JsonKey()
  final String lookUpAddress;
  @override
  @JsonKey()
  final Duration timeout;
  @override
  @JsonKey()
  final Duration interval;

  @override
  String toString() {
    return 'NtpConfigModel(lookUpAddress: $lookUpAddress, timeout: $timeout, interval: $interval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NtpConfigModelImpl &&
            (identical(other.lookUpAddress, lookUpAddress) ||
                other.lookUpAddress == lookUpAddress) &&
            (identical(other.timeout, timeout) || other.timeout == timeout) &&
            (identical(other.interval, interval) ||
                other.interval == interval));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, lookUpAddress, timeout, interval);

  /// Create a copy of NtpConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NtpConfigModelImplCopyWith<_$NtpConfigModelImpl> get copyWith =>
      __$$NtpConfigModelImplCopyWithImpl<_$NtpConfigModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NtpConfigModelImplToJson(
      this,
    );
  }
}

abstract class _NtpConfigModel implements NtpConfigModel {
  const factory _NtpConfigModel(
      {final String lookUpAddress,
      final Duration timeout,
      final Duration interval}) = _$NtpConfigModelImpl;

  factory _NtpConfigModel.fromJson(Map<String, dynamic> json) =
      _$NtpConfigModelImpl.fromJson;

  @override
  String get lookUpAddress;
  @override
  Duration get timeout;
  @override
  Duration get interval;

  /// Create a copy of NtpConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NtpConfigModelImplCopyWith<_$NtpConfigModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

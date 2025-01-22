// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KyoshinMonitorTimerState _$KyoshinMonitorTimerStateFromJson(
    Map<String, dynamic> json) {
  return _KyoshinMonitorTimerState.fromJson(json);
}

/// @nodoc
mixin _$KyoshinMonitorTimerState {
  Duration get delayFromDevice => throw _privateConstructorUsedError;
  DateTime? get lastSyncedAt => throw _privateConstructorUsedError;

  /// Serializes this KyoshinMonitorTimerState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KyoshinMonitorTimerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinMonitorTimerStateCopyWith<KyoshinMonitorTimerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinMonitorTimerStateCopyWith<$Res> {
  factory $KyoshinMonitorTimerStateCopyWith(KyoshinMonitorTimerState value,
          $Res Function(KyoshinMonitorTimerState) then) =
      _$KyoshinMonitorTimerStateCopyWithImpl<$Res, KyoshinMonitorTimerState>;
  @useResult
  $Res call({Duration delayFromDevice, DateTime? lastSyncedAt});
}

/// @nodoc
class _$KyoshinMonitorTimerStateCopyWithImpl<$Res,
        $Val extends KyoshinMonitorTimerState>
    implements $KyoshinMonitorTimerStateCopyWith<$Res> {
  _$KyoshinMonitorTimerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinMonitorTimerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? delayFromDevice = null,
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_value.copyWith(
      delayFromDevice: null == delayFromDevice
          ? _value.delayFromDevice
          : delayFromDevice // ignore: cast_nullable_to_non_nullable
              as Duration,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KyoshinMonitorTimerStateImplCopyWith<$Res>
    implements $KyoshinMonitorTimerStateCopyWith<$Res> {
  factory _$$KyoshinMonitorTimerStateImplCopyWith(
          _$KyoshinMonitorTimerStateImpl value,
          $Res Function(_$KyoshinMonitorTimerStateImpl) then) =
      __$$KyoshinMonitorTimerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration delayFromDevice, DateTime? lastSyncedAt});
}

/// @nodoc
class __$$KyoshinMonitorTimerStateImplCopyWithImpl<$Res>
    extends _$KyoshinMonitorTimerStateCopyWithImpl<$Res,
        _$KyoshinMonitorTimerStateImpl>
    implements _$$KyoshinMonitorTimerStateImplCopyWith<$Res> {
  __$$KyoshinMonitorTimerStateImplCopyWithImpl(
      _$KyoshinMonitorTimerStateImpl _value,
      $Res Function(_$KyoshinMonitorTimerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of KyoshinMonitorTimerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? delayFromDevice = null,
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_$KyoshinMonitorTimerStateImpl(
      delayFromDevice: null == delayFromDevice
          ? _value.delayFromDevice
          : delayFromDevice // ignore: cast_nullable_to_non_nullable
              as Duration,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KyoshinMonitorTimerStateImpl implements _KyoshinMonitorTimerState {
  const _$KyoshinMonitorTimerStateImpl(
      {required this.delayFromDevice, required this.lastSyncedAt});

  factory _$KyoshinMonitorTimerStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$KyoshinMonitorTimerStateImplFromJson(json);

  @override
  final Duration delayFromDevice;
  @override
  final DateTime? lastSyncedAt;

  @override
  String toString() {
    return 'KyoshinMonitorTimerState(delayFromDevice: $delayFromDevice, lastSyncedAt: $lastSyncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KyoshinMonitorTimerStateImpl &&
            (identical(other.delayFromDevice, delayFromDevice) ||
                other.delayFromDevice == delayFromDevice) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, delayFromDevice, lastSyncedAt);

  /// Create a copy of KyoshinMonitorTimerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinMonitorTimerStateImplCopyWith<_$KyoshinMonitorTimerStateImpl>
      get copyWith => __$$KyoshinMonitorTimerStateImplCopyWithImpl<
          _$KyoshinMonitorTimerStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KyoshinMonitorTimerStateImplToJson(
      this,
    );
  }
}

abstract class _KyoshinMonitorTimerState implements KyoshinMonitorTimerState {
  const factory _KyoshinMonitorTimerState(
      {required final Duration delayFromDevice,
      required final DateTime? lastSyncedAt}) = _$KyoshinMonitorTimerStateImpl;

  factory _KyoshinMonitorTimerState.fromJson(Map<String, dynamic> json) =
      _$KyoshinMonitorTimerStateImpl.fromJson;

  @override
  Duration get delayFromDevice;
  @override
  DateTime? get lastSyncedAt;

  /// Create a copy of KyoshinMonitorTimerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinMonitorTimerStateImplCopyWith<_$KyoshinMonitorTimerStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

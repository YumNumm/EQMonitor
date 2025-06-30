// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinMonitorTimerState {

 Duration get delayFromDevice; DateTime? get lastSyncedAt;
/// Create a copy of KyoshinMonitorTimerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorTimerStateCopyWith<KyoshinMonitorTimerState> get copyWith => _$KyoshinMonitorTimerStateCopyWithImpl<KyoshinMonitorTimerState>(this as KyoshinMonitorTimerState, _$identity);

  /// Serializes this KyoshinMonitorTimerState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorTimerState&&(identical(other.delayFromDevice, delayFromDevice) || other.delayFromDevice == delayFromDevice)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delayFromDevice,lastSyncedAt);

@override
String toString() {
  return 'KyoshinMonitorTimerState(delayFromDevice: $delayFromDevice, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorTimerStateCopyWith<$Res>  {
  factory $KyoshinMonitorTimerStateCopyWith(KyoshinMonitorTimerState value, $Res Function(KyoshinMonitorTimerState) _then) = _$KyoshinMonitorTimerStateCopyWithImpl;
@useResult
$Res call({
 Duration delayFromDevice, DateTime? lastSyncedAt
});




}
/// @nodoc
class _$KyoshinMonitorTimerStateCopyWithImpl<$Res>
    implements $KyoshinMonitorTimerStateCopyWith<$Res> {
  _$KyoshinMonitorTimerStateCopyWithImpl(this._self, this._then);

  final KyoshinMonitorTimerState _self;
  final $Res Function(KyoshinMonitorTimerState) _then;

/// Create a copy of KyoshinMonitorTimerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? delayFromDevice = null,Object? lastSyncedAt = freezed,}) {
  return _then(_self.copyWith(
delayFromDevice: null == delayFromDevice ? _self.delayFromDevice : delayFromDevice // ignore: cast_nullable_to_non_nullable
as Duration,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _KyoshinMonitorTimerState implements KyoshinMonitorTimerState {
  const _KyoshinMonitorTimerState({required this.delayFromDevice, required this.lastSyncedAt});
  factory _KyoshinMonitorTimerState.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorTimerStateFromJson(json);

@override final  Duration delayFromDevice;
@override final  DateTime? lastSyncedAt;

/// Create a copy of KyoshinMonitorTimerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorTimerStateCopyWith<_KyoshinMonitorTimerState> get copyWith => __$KyoshinMonitorTimerStateCopyWithImpl<_KyoshinMonitorTimerState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorTimerStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorTimerState&&(identical(other.delayFromDevice, delayFromDevice) || other.delayFromDevice == delayFromDevice)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delayFromDevice,lastSyncedAt);

@override
String toString() {
  return 'KyoshinMonitorTimerState(delayFromDevice: $delayFromDevice, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorTimerStateCopyWith<$Res> implements $KyoshinMonitorTimerStateCopyWith<$Res> {
  factory _$KyoshinMonitorTimerStateCopyWith(_KyoshinMonitorTimerState value, $Res Function(_KyoshinMonitorTimerState) _then) = __$KyoshinMonitorTimerStateCopyWithImpl;
@override @useResult
$Res call({
 Duration delayFromDevice, DateTime? lastSyncedAt
});




}
/// @nodoc
class __$KyoshinMonitorTimerStateCopyWithImpl<$Res>
    implements _$KyoshinMonitorTimerStateCopyWith<$Res> {
  __$KyoshinMonitorTimerStateCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorTimerState _self;
  final $Res Function(_KyoshinMonitorTimerState) _then;

/// Create a copy of KyoshinMonitorTimerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? delayFromDevice = null,Object? lastSyncedAt = freezed,}) {
  return _then(_KyoshinMonitorTimerState(
delayFromDevice: null == delayFromDevice ? _self.delayFromDevice : delayFromDevice // ignore: cast_nullable_to_non_nullable
as Duration,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

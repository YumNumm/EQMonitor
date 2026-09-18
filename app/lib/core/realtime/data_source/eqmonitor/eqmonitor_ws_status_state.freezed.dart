// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eqmonitor_ws_status_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EqMonitorWsStatusState {

 WsPhase get phase; DateTime? get lastPingAt; Duration? get serverPingInterval;
/// Create a copy of EqMonitorWsStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EqMonitorWsStatusStateCopyWith<EqMonitorWsStatusState> get copyWith => _$EqMonitorWsStatusStateCopyWithImpl<EqMonitorWsStatusState>(this as EqMonitorWsStatusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EqMonitorWsStatusState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.lastPingAt, lastPingAt) || other.lastPingAt == lastPingAt)&&(identical(other.serverPingInterval, serverPingInterval) || other.serverPingInterval == serverPingInterval));
}


@override
int get hashCode => Object.hash(runtimeType,phase,lastPingAt,serverPingInterval);

@override
String toString() {
  return 'EqMonitorWsStatusState(phase: $phase, lastPingAt: $lastPingAt, serverPingInterval: $serverPingInterval)';
}


}

/// @nodoc
abstract mixin class $EqMonitorWsStatusStateCopyWith<$Res>  {
  factory $EqMonitorWsStatusStateCopyWith(EqMonitorWsStatusState value, $Res Function(EqMonitorWsStatusState) _then) = _$EqMonitorWsStatusStateCopyWithImpl;
@useResult
$Res call({
 WsPhase phase, DateTime? lastPingAt, Duration? serverPingInterval
});




}
/// @nodoc
class _$EqMonitorWsStatusStateCopyWithImpl<$Res>
    implements $EqMonitorWsStatusStateCopyWith<$Res> {
  _$EqMonitorWsStatusStateCopyWithImpl(this._self, this._then);

  final EqMonitorWsStatusState _self;
  final $Res Function(EqMonitorWsStatusState) _then;

/// Create a copy of EqMonitorWsStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? lastPingAt = freezed,Object? serverPingInterval = freezed,}) {
  return _then(EqMonitorWsStatusState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as WsPhase,lastPingAt: freezed == lastPingAt ? _self.lastPingAt : lastPingAt // ignore: cast_nullable_to_non_nullable
as DateTime?,serverPingInterval: freezed == serverPingInterval ? _self.serverPingInterval : serverPingInterval // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

}


/// Adds pattern-matching-related methods to [EqMonitorWsStatusState].
extension EqMonitorWsStatusStatePatterns on EqMonitorWsStatusState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EqMonitorWsStatusState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EqMonitorWsStatusState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EqMonitorWsStatusState value)  $default,){
final _that = this;
switch (_that) {
case _EqMonitorWsStatusState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EqMonitorWsStatusState value)?  $default,){
final _that = this;
switch (_that) {
case _EqMonitorWsStatusState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WsPhase phase,  DateTime? lastPingAt,  Duration? serverPingInterval)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EqMonitorWsStatusState() when $default != null:
return $default(_that.phase,_that.lastPingAt,_that.serverPingInterval);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WsPhase phase,  DateTime? lastPingAt,  Duration? serverPingInterval)  $default,) {final _that = this;
switch (_that) {
case _EqMonitorWsStatusState():
return $default(_that.phase,_that.lastPingAt,_that.serverPingInterval);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WsPhase phase,  DateTime? lastPingAt,  Duration? serverPingInterval)?  $default,) {final _that = this;
switch (_that) {
case _EqMonitorWsStatusState() when $default != null:
return $default(_that.phase,_that.lastPingAt,_that.serverPingInterval);case _:
  return null;

}
}

}

/// @nodoc


class _EqMonitorWsStatusState implements EqMonitorWsStatusState {
  const _EqMonitorWsStatusState({this.phase = WsPhase.connecting, this.lastPingAt, this.serverPingInterval});
  

@override@JsonKey() final  WsPhase phase;
@override final  DateTime? lastPingAt;
@override final  Duration? serverPingInterval;

/// Create a copy of EqMonitorWsStatusState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EqMonitorWsStatusStateCopyWith<_EqMonitorWsStatusState> get copyWith => __$EqMonitorWsStatusStateCopyWithImpl<_EqMonitorWsStatusState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EqMonitorWsStatusState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.lastPingAt, lastPingAt) || other.lastPingAt == lastPingAt)&&(identical(other.serverPingInterval, serverPingInterval) || other.serverPingInterval == serverPingInterval));
}


@override
int get hashCode => Object.hash(runtimeType,phase,lastPingAt,serverPingInterval);

@override
String toString() {
  return 'EqMonitorWsStatusState(phase: $phase, lastPingAt: $lastPingAt, serverPingInterval: $serverPingInterval)';
}


}

/// @nodoc
abstract mixin class _$EqMonitorWsStatusStateCopyWith<$Res> implements $EqMonitorWsStatusStateCopyWith<$Res> {
  factory _$EqMonitorWsStatusStateCopyWith(_EqMonitorWsStatusState value, $Res Function(_EqMonitorWsStatusState) _then) = __$EqMonitorWsStatusStateCopyWithImpl;
@override @useResult
$Res call({
 WsPhase phase, DateTime? lastPingAt, Duration? serverPingInterval
});




}
/// @nodoc
class __$EqMonitorWsStatusStateCopyWithImpl<$Res>
    implements _$EqMonitorWsStatusStateCopyWith<$Res> {
  __$EqMonitorWsStatusStateCopyWithImpl(this._self, this._then);

  final _EqMonitorWsStatusState _self;
  final $Res Function(_EqMonitorWsStatusState) _then;

/// Create a copy of EqMonitorWsStatusState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? lastPingAt = freezed,Object? serverPingInterval = freezed,}) {
  return _then(_EqMonitorWsStatusState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as WsPhase,lastPingAt: freezed == lastPingAt ? _self.lastPingAt : lastPingAt // ignore: cast_nullable_to_non_nullable
as DateTime?,serverPingInterval: freezed == serverPingInterval ? _self.serverPingInterval : serverPingInterval // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on

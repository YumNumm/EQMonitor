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

 WsPhase get phase; String? get currentUrl;/// 直近にサーバー起因 ping を受信した時刻。
 DateTime? get lastPingAt;/// サーバー起因 ping の受信間隔（サーバー実装では 15 秒）。
///
/// ネットワーク RTT ではない。RTT はクライアント起因 ping で計測する
/// `eqmonitorWsPingProbeProvider` 側が持つ。
 Duration? get serverPingInterval;
/// Create a copy of EqMonitorWsStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EqMonitorWsStatusStateCopyWith<EqMonitorWsStatusState> get copyWith => _$EqMonitorWsStatusStateCopyWithImpl<EqMonitorWsStatusState>(this as EqMonitorWsStatusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EqMonitorWsStatusState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.currentUrl, currentUrl) || other.currentUrl == currentUrl)&&(identical(other.lastPingAt, lastPingAt) || other.lastPingAt == lastPingAt)&&(identical(other.serverPingInterval, serverPingInterval) || other.serverPingInterval == serverPingInterval));
}


@override
int get hashCode => Object.hash(runtimeType,phase,currentUrl,lastPingAt,serverPingInterval);

@override
String toString() {
  return 'EqMonitorWsStatusState(phase: $phase, currentUrl: $currentUrl, lastPingAt: $lastPingAt, serverPingInterval: $serverPingInterval)';
}


}

/// @nodoc
abstract mixin class $EqMonitorWsStatusStateCopyWith<$Res>  {
  factory $EqMonitorWsStatusStateCopyWith(EqMonitorWsStatusState value, $Res Function(EqMonitorWsStatusState) _then) = _$EqMonitorWsStatusStateCopyWithImpl;
@useResult
$Res call({
 WsPhase phase, String? currentUrl, DateTime? lastPingAt, Duration? serverPingInterval
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
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? currentUrl = freezed,Object? lastPingAt = freezed,Object? serverPingInterval = freezed,}) {
  return _then(EqMonitorWsStatusState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as WsPhase,currentUrl: freezed == currentUrl ? _self.currentUrl : currentUrl // ignore: cast_nullable_to_non_nullable
as String?,lastPingAt: freezed == lastPingAt ? _self.lastPingAt : lastPingAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WsPhase phase,  String? currentUrl,  DateTime? lastPingAt,  Duration? serverPingInterval)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EqMonitorWsStatusState() when $default != null:
return $default(_that.phase,_that.currentUrl,_that.lastPingAt,_that.serverPingInterval);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WsPhase phase,  String? currentUrl,  DateTime? lastPingAt,  Duration? serverPingInterval)  $default,) {final _that = this;
switch (_that) {
case _EqMonitorWsStatusState():
return $default(_that.phase,_that.currentUrl,_that.lastPingAt,_that.serverPingInterval);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WsPhase phase,  String? currentUrl,  DateTime? lastPingAt,  Duration? serverPingInterval)?  $default,) {final _that = this;
switch (_that) {
case _EqMonitorWsStatusState() when $default != null:
return $default(_that.phase,_that.currentUrl,_that.lastPingAt,_that.serverPingInterval);case _:
  return null;

}
}

}

/// @nodoc


class _EqMonitorWsStatusState implements EqMonitorWsStatusState {
  const _EqMonitorWsStatusState({this.phase = WsPhase.connecting, this.currentUrl, this.lastPingAt, this.serverPingInterval});
  

@override@JsonKey() final  WsPhase phase;
@override final  String? currentUrl;
/// 直近にサーバー起因 ping を受信した時刻。
@override final  DateTime? lastPingAt;
/// サーバー起因 ping の受信間隔（サーバー実装では 15 秒）。
///
/// ネットワーク RTT ではない。RTT はクライアント起因 ping で計測する
/// `eqmonitorWsPingProbeProvider` 側が持つ。
@override final  Duration? serverPingInterval;

/// Create a copy of EqMonitorWsStatusState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EqMonitorWsStatusStateCopyWith<_EqMonitorWsStatusState> get copyWith => __$EqMonitorWsStatusStateCopyWithImpl<_EqMonitorWsStatusState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EqMonitorWsStatusState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.currentUrl, currentUrl) || other.currentUrl == currentUrl)&&(identical(other.lastPingAt, lastPingAt) || other.lastPingAt == lastPingAt)&&(identical(other.serverPingInterval, serverPingInterval) || other.serverPingInterval == serverPingInterval));
}


@override
int get hashCode => Object.hash(runtimeType,phase,currentUrl,lastPingAt,serverPingInterval);

@override
String toString() {
  return 'EqMonitorWsStatusState(phase: $phase, currentUrl: $currentUrl, lastPingAt: $lastPingAt, serverPingInterval: $serverPingInterval)';
}


}

/// @nodoc
abstract mixin class _$EqMonitorWsStatusStateCopyWith<$Res> implements $EqMonitorWsStatusStateCopyWith<$Res> {
  factory _$EqMonitorWsStatusStateCopyWith(_EqMonitorWsStatusState value, $Res Function(_EqMonitorWsStatusState) _then) = __$EqMonitorWsStatusStateCopyWithImpl;
@override @useResult
$Res call({
 WsPhase phase, String? currentUrl, DateTime? lastPingAt, Duration? serverPingInterval
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
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? currentUrl = freezed,Object? lastPingAt = freezed,Object? serverPingInterval = freezed,}) {
  return _then(_EqMonitorWsStatusState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as WsPhase,currentUrl: freezed == currentUrl ? _self.currentUrl : currentUrl // ignore: cast_nullable_to_non_nullable
as String?,lastPingAt: freezed == lastPingAt ? _self.lastPingAt : lastPingAt // ignore: cast_nullable_to_non_nullable
as DateTime?,serverPingInterval: freezed == serverPingInterval ? _self.serverPingInterval : serverPingInterval // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on

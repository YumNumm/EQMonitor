// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
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
  return _then(KyoshinMonitorTimerState(
delayFromDevice: null == delayFromDevice ? _self.delayFromDevice : delayFromDevice // ignore: cast_nullable_to_non_nullable
as Duration,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [KyoshinMonitorTimerState].
extension KyoshinMonitorTimerStatePatterns on KyoshinMonitorTimerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinMonitorTimerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinMonitorTimerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinMonitorTimerState value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorTimerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinMonitorTimerState value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorTimerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration delayFromDevice,  DateTime? lastSyncedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinMonitorTimerState() when $default != null:
return $default(_that.delayFromDevice,_that.lastSyncedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration delayFromDevice,  DateTime? lastSyncedAt)  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorTimerState():
return $default(_that.delayFromDevice,_that.lastSyncedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration delayFromDevice,  DateTime? lastSyncedAt)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorTimerState() when $default != null:
return $default(_that.delayFromDevice,_that.lastSyncedAt);case _:
  return null;

}
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

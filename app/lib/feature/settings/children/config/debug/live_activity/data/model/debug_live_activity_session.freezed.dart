// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debug_live_activity_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebugLiveActivitySession {

 String get activityId; String get logicalId; String? get eventId;
/// Create a copy of DebugLiveActivitySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebugLiveActivitySessionCopyWith<DebugLiveActivitySession> get copyWith => _$DebugLiveActivitySessionCopyWithImpl<DebugLiveActivitySession>(this as DebugLiveActivitySession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugLiveActivitySession&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.logicalId, logicalId) || other.logicalId == logicalId)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}


@override
int get hashCode => Object.hash(runtimeType,activityId,logicalId,eventId);

@override
String toString() {
  return 'DebugLiveActivitySession(activityId: $activityId, logicalId: $logicalId, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $DebugLiveActivitySessionCopyWith<$Res>  {
  factory $DebugLiveActivitySessionCopyWith(DebugLiveActivitySession value, $Res Function(DebugLiveActivitySession) _then) = _$DebugLiveActivitySessionCopyWithImpl;
@useResult
$Res call({
 String activityId, String logicalId, String? eventId
});




}
/// @nodoc
class _$DebugLiveActivitySessionCopyWithImpl<$Res>
    implements $DebugLiveActivitySessionCopyWith<$Res> {
  _$DebugLiveActivitySessionCopyWithImpl(this._self, this._then);

  final DebugLiveActivitySession _self;
  final $Res Function(DebugLiveActivitySession) _then;

/// Create a copy of DebugLiveActivitySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activityId = null,Object? logicalId = null,Object? eventId = freezed,}) {
  return _then(DebugLiveActivitySession(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,logicalId: null == logicalId ? _self.logicalId : logicalId // ignore: cast_nullable_to_non_nullable
as String,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DebugLiveActivitySession].
extension DebugLiveActivitySessionPatterns on DebugLiveActivitySession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebugLiveActivitySession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebugLiveActivitySession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebugLiveActivitySession value)  $default,){
final _that = this;
switch (_that) {
case _DebugLiveActivitySession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebugLiveActivitySession value)?  $default,){
final _that = this;
switch (_that) {
case _DebugLiveActivitySession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String activityId,  String logicalId,  String? eventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebugLiveActivitySession() when $default != null:
return $default(_that.activityId,_that.logicalId,_that.eventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String activityId,  String logicalId,  String? eventId)  $default,) {final _that = this;
switch (_that) {
case _DebugLiveActivitySession():
return $default(_that.activityId,_that.logicalId,_that.eventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String activityId,  String logicalId,  String? eventId)?  $default,) {final _that = this;
switch (_that) {
case _DebugLiveActivitySession() when $default != null:
return $default(_that.activityId,_that.logicalId,_that.eventId);case _:
  return null;

}
}

}

/// @nodoc


class _DebugLiveActivitySession extends DebugLiveActivitySession {
  const _DebugLiveActivitySession({required this.activityId, required this.logicalId, required this.eventId}): super._();
  

@override final  String activityId;
@override final  String logicalId;
@override final  String? eventId;

/// Create a copy of DebugLiveActivitySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebugLiveActivitySessionCopyWith<_DebugLiveActivitySession> get copyWith => __$DebugLiveActivitySessionCopyWithImpl<_DebugLiveActivitySession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebugLiveActivitySession&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.logicalId, logicalId) || other.logicalId == logicalId)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}


@override
int get hashCode => Object.hash(runtimeType,activityId,logicalId,eventId);

@override
String toString() {
  return 'DebugLiveActivitySession(activityId: $activityId, logicalId: $logicalId, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class _$DebugLiveActivitySessionCopyWith<$Res> implements $DebugLiveActivitySessionCopyWith<$Res> {
  factory _$DebugLiveActivitySessionCopyWith(_DebugLiveActivitySession value, $Res Function(_DebugLiveActivitySession) _then) = __$DebugLiveActivitySessionCopyWithImpl;
@override @useResult
$Res call({
 String activityId, String logicalId, String? eventId
});




}
/// @nodoc
class __$DebugLiveActivitySessionCopyWithImpl<$Res>
    implements _$DebugLiveActivitySessionCopyWith<$Res> {
  __$DebugLiveActivitySessionCopyWithImpl(this._self, this._then);

  final _DebugLiveActivitySession _self;
  final $Res Function(_DebugLiveActivitySession) _then;

/// Create a copy of DebugLiveActivitySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityId = null,Object? logicalId = null,Object? eventId = freezed,}) {
  return _then(_DebugLiveActivitySession(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,logicalId: null == logicalId ? _self.logicalId : logicalId // ignore: cast_nullable_to_non_nullable
as String,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

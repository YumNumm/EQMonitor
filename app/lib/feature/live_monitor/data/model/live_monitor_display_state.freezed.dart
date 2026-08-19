// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_monitor_display_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LiveMonitorDisplayState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorDisplayState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LiveMonitorDisplayState()';
}


}

/// @nodoc
class $LiveMonitorDisplayStateCopyWith<$Res>  {
$LiveMonitorDisplayStateCopyWith(LiveMonitorDisplayState _, $Res Function(LiveMonitorDisplayState) __);
}


/// Adds pattern-matching-related methods to [LiveMonitorDisplayState].
extension LiveMonitorDisplayStatePatterns on LiveMonitorDisplayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LiveMonitorRealtimeDisplayState value)?  realtime,TResult Function( LiveMonitorEarthquakeDisplayState value)?  earthquake,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LiveMonitorRealtimeDisplayState() when realtime != null:
return realtime(_that);case LiveMonitorEarthquakeDisplayState() when earthquake != null:
return earthquake(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LiveMonitorRealtimeDisplayState value)  realtime,required TResult Function( LiveMonitorEarthquakeDisplayState value)  earthquake,}){
final _that = this;
switch (_that) {
case LiveMonitorRealtimeDisplayState():
return realtime(_that);case LiveMonitorEarthquakeDisplayState():
return earthquake(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LiveMonitorRealtimeDisplayState value)?  realtime,TResult? Function( LiveMonitorEarthquakeDisplayState value)?  earthquake,}){
final _that = this;
switch (_that) {
case LiveMonitorRealtimeDisplayState() when realtime != null:
return realtime(_that);case LiveMonitorEarthquakeDisplayState() when earthquake != null:
return earthquake(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  realtime,TResult Function( String eventId,  LiveMonitorEarthquakeTrigger trigger,  Earthquake earthquake,  DateTime shownAt,  DateTime minimumUntil,  DateTime expiresAt,  DateTime? returnToRealtimeAt)?  earthquake,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LiveMonitorRealtimeDisplayState() when realtime != null:
return realtime();case LiveMonitorEarthquakeDisplayState() when earthquake != null:
return earthquake(_that.eventId,_that.trigger,_that.earthquake,_that.shownAt,_that.minimumUntil,_that.expiresAt,_that.returnToRealtimeAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  realtime,required TResult Function( String eventId,  LiveMonitorEarthquakeTrigger trigger,  Earthquake earthquake,  DateTime shownAt,  DateTime minimumUntil,  DateTime expiresAt,  DateTime? returnToRealtimeAt)  earthquake,}) {final _that = this;
switch (_that) {
case LiveMonitorRealtimeDisplayState():
return realtime();case LiveMonitorEarthquakeDisplayState():
return earthquake(_that.eventId,_that.trigger,_that.earthquake,_that.shownAt,_that.minimumUntil,_that.expiresAt,_that.returnToRealtimeAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  realtime,TResult? Function( String eventId,  LiveMonitorEarthquakeTrigger trigger,  Earthquake earthquake,  DateTime shownAt,  DateTime minimumUntil,  DateTime expiresAt,  DateTime? returnToRealtimeAt)?  earthquake,}) {final _that = this;
switch (_that) {
case LiveMonitorRealtimeDisplayState() when realtime != null:
return realtime();case LiveMonitorEarthquakeDisplayState() when earthquake != null:
return earthquake(_that.eventId,_that.trigger,_that.earthquake,_that.shownAt,_that.minimumUntil,_that.expiresAt,_that.returnToRealtimeAt);case _:
  return null;

}
}

}

/// @nodoc


class LiveMonitorRealtimeDisplayState implements LiveMonitorDisplayState {
  const LiveMonitorRealtimeDisplayState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorRealtimeDisplayState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LiveMonitorDisplayState.realtime()';
}


}




/// @nodoc


class LiveMonitorEarthquakeDisplayState implements LiveMonitorDisplayState {
  const LiveMonitorEarthquakeDisplayState({required this.eventId, required this.trigger, required this.earthquake, required this.shownAt, required this.minimumUntil, required this.expiresAt, this.returnToRealtimeAt});
  

 final  String eventId;
 final  LiveMonitorEarthquakeTrigger trigger;
 final  Earthquake earthquake;
 final  DateTime shownAt;
 final  DateTime minimumUntil;
 final  DateTime expiresAt;
 final  DateTime? returnToRealtimeAt;

/// Create a copy of LiveMonitorDisplayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorEarthquakeDisplayStateCopyWith<LiveMonitorEarthquakeDisplayState> get copyWith => _$LiveMonitorEarthquakeDisplayStateCopyWithImpl<LiveMonitorEarthquakeDisplayState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorEarthquakeDisplayState&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake)&&(identical(other.shownAt, shownAt) || other.shownAt == shownAt)&&(identical(other.minimumUntil, minimumUntil) || other.minimumUntil == minimumUntil)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.returnToRealtimeAt, returnToRealtimeAt) || other.returnToRealtimeAt == returnToRealtimeAt));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,trigger,earthquake,shownAt,minimumUntil,expiresAt,returnToRealtimeAt);

@override
String toString() {
  return 'LiveMonitorDisplayState.earthquake(eventId: $eventId, trigger: $trigger, earthquake: $earthquake, shownAt: $shownAt, minimumUntil: $minimumUntil, expiresAt: $expiresAt, returnToRealtimeAt: $returnToRealtimeAt)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorEarthquakeDisplayStateCopyWith<$Res> implements $LiveMonitorDisplayStateCopyWith<$Res> {
  factory $LiveMonitorEarthquakeDisplayStateCopyWith(LiveMonitorEarthquakeDisplayState value, $Res Function(LiveMonitorEarthquakeDisplayState) _then) = _$LiveMonitorEarthquakeDisplayStateCopyWithImpl;
@useResult
$Res call({
 String eventId, LiveMonitorEarthquakeTrigger trigger, Earthquake earthquake, DateTime shownAt, DateTime minimumUntil, DateTime expiresAt, DateTime? returnToRealtimeAt
});


$LiveMonitorEarthquakeTriggerCopyWith<$Res> get trigger;$EarthquakeCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$LiveMonitorEarthquakeDisplayStateCopyWithImpl<$Res>
    implements $LiveMonitorEarthquakeDisplayStateCopyWith<$Res> {
  _$LiveMonitorEarthquakeDisplayStateCopyWithImpl(this._self, this._then);

  final LiveMonitorEarthquakeDisplayState _self;
  final $Res Function(LiveMonitorEarthquakeDisplayState) _then;

/// Create a copy of LiveMonitorDisplayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? trigger = null,Object? earthquake = null,Object? shownAt = null,Object? minimumUntil = null,Object? expiresAt = null,Object? returnToRealtimeAt = freezed,}) {
  return _then(LiveMonitorEarthquakeDisplayState(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as LiveMonitorEarthquakeTrigger,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as Earthquake,shownAt: null == shownAt ? _self.shownAt : shownAt // ignore: cast_nullable_to_non_nullable
as DateTime,minimumUntil: null == minimumUntil ? _self.minimumUntil : minimumUntil // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,returnToRealtimeAt: freezed == returnToRealtimeAt ? _self.returnToRealtimeAt : returnToRealtimeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of LiveMonitorDisplayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveMonitorEarthquakeTriggerCopyWith<$Res> get trigger {
  
  return $LiveMonitorEarthquakeTriggerCopyWith<$Res>(_self.trigger, (value) {
    return _then(_self.copyWith(trigger: value));
  });
}/// Create a copy of LiveMonitorDisplayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<$Res> get earthquake {
  
  return $EarthquakeCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

// dart format on

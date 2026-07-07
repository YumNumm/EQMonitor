// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telemetry_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TelemetryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelemetryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TelemetryEvent()';
}


}

/// @nodoc
class $TelemetryEventCopyWith<$Res>  {
$TelemetryEventCopyWith(TelemetryEvent _, $Res Function(TelemetryEvent) __);
}


/// Adds pattern-matching-related methods to [TelemetryEvent].
extension TelemetryEventPatterns on TelemetryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationReceivedEvent value)?  notificationReceived,TResult Function( NotificationOpenedEvent value)?  notificationOpened,TResult Function( LiveActivityStartedEvent value)?  liveActivityStarted,TResult Function( LiveActivityUpdatedEvent value)?  liveActivityUpdated,TResult Function( LiveActivityEndedEvent value)?  liveActivityEnded,TResult Function( ErrorTelemetryEvent value)?  error,TResult Function( AppLaunchEvent value)?  appLaunch,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationReceivedEvent() when notificationReceived != null:
return notificationReceived(_that);case NotificationOpenedEvent() when notificationOpened != null:
return notificationOpened(_that);case LiveActivityStartedEvent() when liveActivityStarted != null:
return liveActivityStarted(_that);case LiveActivityUpdatedEvent() when liveActivityUpdated != null:
return liveActivityUpdated(_that);case LiveActivityEndedEvent() when liveActivityEnded != null:
return liveActivityEnded(_that);case ErrorTelemetryEvent() when error != null:
return error(_that);case AppLaunchEvent() when appLaunch != null:
return appLaunch(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationReceivedEvent value)  notificationReceived,required TResult Function( NotificationOpenedEvent value)  notificationOpened,required TResult Function( LiveActivityStartedEvent value)  liveActivityStarted,required TResult Function( LiveActivityUpdatedEvent value)  liveActivityUpdated,required TResult Function( LiveActivityEndedEvent value)  liveActivityEnded,required TResult Function( ErrorTelemetryEvent value)  error,required TResult Function( StartupTimingEvent value)  startupTiming,required TResult Function( AppLaunchEvent value)  appLaunch,}){
final _that = this;
switch (_that) {
case NotificationReceivedEvent():
return notificationReceived(_that);case NotificationOpenedEvent():
return notificationOpened(_that);case LiveActivityStartedEvent():
return liveActivityStarted(_that);case LiveActivityUpdatedEvent():
return liveActivityUpdated(_that);case LiveActivityEndedEvent():
return liveActivityEnded(_that);case ErrorTelemetryEvent():
return error(_that);case StartupTimingEvent():
return startupTiming(_that);case AppLaunchEvent():
return appLaunch(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationReceivedEvent value)?  notificationReceived,TResult? Function( NotificationOpenedEvent value)?  notificationOpened,TResult? Function( LiveActivityStartedEvent value)?  liveActivityStarted,TResult? Function( LiveActivityUpdatedEvent value)?  liveActivityUpdated,TResult? Function( LiveActivityEndedEvent value)?  liveActivityEnded,TResult? Function( ErrorTelemetryEvent value)?  error,TResult? Function( AppLaunchEvent value)?  appLaunch,}){
final _that = this;
switch (_that) {
case NotificationReceivedEvent() when notificationReceived != null:
return notificationReceived(_that);case NotificationOpenedEvent() when notificationOpened != null:
return notificationOpened(_that);case LiveActivityStartedEvent() when liveActivityStarted != null:
return liveActivityStarted(_that);case LiveActivityUpdatedEvent() when liveActivityUpdated != null:
return liveActivityUpdated(_that);case LiveActivityEndedEvent() when liveActivityEnded != null:
return liveActivityEnded(_that);case ErrorTelemetryEvent() when error != null:
return error(_that);case AppLaunchEvent() when appLaunch != null:
return appLaunch(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( NotificationFramework framework,  String channelId,  String? title,  String? eventId,  String? priority)?  notificationReceived,TResult Function( bool coldStart,  String? eventId,  int? elapsedMs)?  notificationOpened,TResult Function( LiveActivityType activityType,  String activityId)?  liveActivityStarted,TResult Function( LiveActivityType activityType,  String activityId,  String? eventId)?  liveActivityUpdated,TResult Function( LiveActivityType activityType,  String activityId,  LiveActivityEndReason endReason,  int? durationMs)?  liveActivityEnded,TResult Function( String errorType,  String message,  String? stackTrace)?  error,TResult Function( String launchType,  String appVersion,  int buildNumber,  String platform,  String osVersion,  String deviceModel,  String locale,  bool isPhysicalDevice,  int physicalRamMb,  int cpuCores,  String manufacturer,  int? androidSdkInt,  String? securityPatch,  bool? isLowRamDevice,  String? installerStore)?  appLaunch,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationReceivedEvent() when notificationReceived != null:
return notificationReceived(_that.framework,_that.channelId,_that.title,_that.eventId,_that.priority);case NotificationOpenedEvent() when notificationOpened != null:
return notificationOpened(_that.coldStart,_that.eventId,_that.elapsedMs);case LiveActivityStartedEvent() when liveActivityStarted != null:
return liveActivityStarted(_that.activityType,_that.activityId);case LiveActivityUpdatedEvent() when liveActivityUpdated != null:
return liveActivityUpdated(_that.activityType,_that.activityId,_that.eventId);case LiveActivityEndedEvent() when liveActivityEnded != null:
return liveActivityEnded(_that.activityType,_that.activityId,_that.endReason,_that.durationMs);case ErrorTelemetryEvent() when error != null:
return error(_that.errorType,_that.message,_that.stackTrace);case AppLaunchEvent() when appLaunch != null:
return appLaunch(_that.launchType,_that.appVersion,_that.buildNumber,_that.platform,_that.osVersion,_that.deviceModel,_that.locale,_that.isPhysicalDevice,_that.physicalRamMb,_that.cpuCores,_that.manufacturer,_that.androidSdkInt,_that.securityPatch,_that.isLowRamDevice,_that.installerStore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( NotificationFramework framework,  String channelId,  String? title,  String? eventId,  String? priority)  notificationReceived,required TResult Function( bool coldStart,  String? eventId,  int? elapsedMs)  notificationOpened,required TResult Function( LiveActivityType activityType,  String activityId)  liveActivityStarted,required TResult Function( LiveActivityType activityType,  String activityId,  String? eventId)  liveActivityUpdated,required TResult Function( LiveActivityType activityType,  String activityId,  LiveActivityEndReason endReason,  int? durationMs)  liveActivityEnded,required TResult Function( String errorType,  String message,  String? stackTrace)  error,required TResult Function( Map<String, int> phasesMicros)  startupTiming,required TResult Function( String launchType,  String appVersion,  int buildNumber,  String platform,  String osVersion,  String deviceModel,  String locale,  bool isPhysicalDevice,  int physicalRamMb,  int cpuCores,  String manufacturer,  int? androidSdkInt,  String? securityPatch,  bool? isLowRamDevice,  String? installerStore)  appLaunch,}) {final _that = this;
switch (_that) {
case NotificationReceivedEvent():
return notificationReceived(_that.framework,_that.channelId,_that.title,_that.eventId,_that.priority);case NotificationOpenedEvent():
return notificationOpened(_that.coldStart,_that.eventId,_that.elapsedMs);case LiveActivityStartedEvent():
return liveActivityStarted(_that.activityType,_that.activityId);case LiveActivityUpdatedEvent():
return liveActivityUpdated(_that.activityType,_that.activityId,_that.eventId);case LiveActivityEndedEvent():
return liveActivityEnded(_that.activityType,_that.activityId,_that.endReason,_that.durationMs);case ErrorTelemetryEvent():
return error(_that.errorType,_that.message,_that.stackTrace);case StartupTimingEvent():
return startupTiming(_that.phasesMicros);case AppLaunchEvent():
return appLaunch(_that.launchType,_that.appVersion,_that.buildNumber,_that.platform,_that.osVersion,_that.deviceModel,_that.locale,_that.isPhysicalDevice,_that.physicalRamMb,_that.cpuCores,_that.manufacturer,_that.androidSdkInt,_that.securityPatch,_that.isLowRamDevice,_that.installerStore);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( NotificationFramework framework,  String channelId,  String? title,  String? eventId,  String? priority)?  notificationReceived,TResult? Function( bool coldStart,  String? eventId,  int? elapsedMs)?  notificationOpened,TResult? Function( LiveActivityType activityType,  String activityId)?  liveActivityStarted,TResult? Function( LiveActivityType activityType,  String activityId,  String? eventId)?  liveActivityUpdated,TResult? Function( LiveActivityType activityType,  String activityId,  LiveActivityEndReason endReason,  int? durationMs)?  liveActivityEnded,TResult? Function( String errorType,  String message,  String? stackTrace)?  error,TResult? Function( String launchType,  String appVersion,  int buildNumber,  String platform,  String osVersion,  String deviceModel,  String locale,  bool isPhysicalDevice,  int physicalRamMb,  int cpuCores,  String manufacturer,  int? androidSdkInt,  String? securityPatch,  bool? isLowRamDevice,  String? installerStore)?  appLaunch,}) {final _that = this;
switch (_that) {
case NotificationReceivedEvent() when notificationReceived != null:
return notificationReceived(_that.framework,_that.channelId,_that.title,_that.eventId,_that.priority);case NotificationOpenedEvent() when notificationOpened != null:
return notificationOpened(_that.coldStart,_that.eventId,_that.elapsedMs);case LiveActivityStartedEvent() when liveActivityStarted != null:
return liveActivityStarted(_that.activityType,_that.activityId);case LiveActivityUpdatedEvent() when liveActivityUpdated != null:
return liveActivityUpdated(_that.activityType,_that.activityId,_that.eventId);case LiveActivityEndedEvent() when liveActivityEnded != null:
return liveActivityEnded(_that.activityType,_that.activityId,_that.endReason,_that.durationMs);case ErrorTelemetryEvent() when error != null:
return error(_that.errorType,_that.message,_that.stackTrace);case AppLaunchEvent() when appLaunch != null:
return appLaunch(_that.launchType,_that.appVersion,_that.buildNumber,_that.platform,_that.osVersion,_that.deviceModel,_that.locale,_that.isPhysicalDevice,_that.physicalRamMb,_that.cpuCores,_that.manufacturer,_that.androidSdkInt,_that.securityPatch,_that.isLowRamDevice,_that.installerStore);case _:
  return null;

}
}

}

/// @nodoc


class NotificationReceivedEvent extends TelemetryEvent {
  const NotificationReceivedEvent({required this.framework, required this.channelId, this.title, this.eventId, this.priority}): super._();
  

 final  NotificationFramework framework;
 final  String channelId;
 final  String? title;
 final  String? eventId;
 final  String? priority;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationReceivedEventCopyWith<NotificationReceivedEvent> get copyWith => _$NotificationReceivedEventCopyWithImpl<NotificationReceivedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationReceivedEvent&&(identical(other.framework, framework) || other.framework == framework)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.title, title) || other.title == title)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.priority, priority) || other.priority == priority));
}


@override
int get hashCode => Object.hash(runtimeType,framework,channelId,title,eventId,priority);

@override
String toString() {
  return 'TelemetryEvent.notificationReceived(framework: $framework, channelId: $channelId, title: $title, eventId: $eventId, priority: $priority)';
}


}

/// @nodoc
abstract mixin class $NotificationReceivedEventCopyWith<$Res> implements $TelemetryEventCopyWith<$Res> {
  factory $NotificationReceivedEventCopyWith(NotificationReceivedEvent value, $Res Function(NotificationReceivedEvent) _then) = _$NotificationReceivedEventCopyWithImpl;
@useResult
$Res call({
 NotificationFramework framework, String channelId, String? title, String? eventId, String? priority
});




}
/// @nodoc
class _$NotificationReceivedEventCopyWithImpl<$Res>
    implements $NotificationReceivedEventCopyWith<$Res> {
  _$NotificationReceivedEventCopyWithImpl(this._self, this._then);

  final NotificationReceivedEvent _self;
  final $Res Function(NotificationReceivedEvent) _then;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? framework = null,Object? channelId = null,Object? title = freezed,Object? eventId = freezed,Object? priority = freezed,}) {
  return _then(NotificationReceivedEvent(
framework: null == framework ? _self.framework : framework // ignore: cast_nullable_to_non_nullable
as NotificationFramework,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class NotificationOpenedEvent extends TelemetryEvent {
  const NotificationOpenedEvent({required this.coldStart, this.eventId, this.elapsedMs}): super._();
  

 final  bool coldStart;
 final  String? eventId;
 final  int? elapsedMs;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationOpenedEventCopyWith<NotificationOpenedEvent> get copyWith => _$NotificationOpenedEventCopyWithImpl<NotificationOpenedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationOpenedEvent&&(identical(other.coldStart, coldStart) || other.coldStart == coldStart)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.elapsedMs, elapsedMs) || other.elapsedMs == elapsedMs));
}


@override
int get hashCode => Object.hash(runtimeType,coldStart,eventId,elapsedMs);

@override
String toString() {
  return 'TelemetryEvent.notificationOpened(coldStart: $coldStart, eventId: $eventId, elapsedMs: $elapsedMs)';
}


}

/// @nodoc
abstract mixin class $NotificationOpenedEventCopyWith<$Res> implements $TelemetryEventCopyWith<$Res> {
  factory $NotificationOpenedEventCopyWith(NotificationOpenedEvent value, $Res Function(NotificationOpenedEvent) _then) = _$NotificationOpenedEventCopyWithImpl;
@useResult
$Res call({
 bool coldStart, String? eventId, int? elapsedMs
});




}
/// @nodoc
class _$NotificationOpenedEventCopyWithImpl<$Res>
    implements $NotificationOpenedEventCopyWith<$Res> {
  _$NotificationOpenedEventCopyWithImpl(this._self, this._then);

  final NotificationOpenedEvent _self;
  final $Res Function(NotificationOpenedEvent) _then;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? coldStart = null,Object? eventId = freezed,Object? elapsedMs = freezed,}) {
  return _then(NotificationOpenedEvent(
coldStart: null == coldStart ? _self.coldStart : coldStart // ignore: cast_nullable_to_non_nullable
as bool,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,elapsedMs: freezed == elapsedMs ? _self.elapsedMs : elapsedMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class LiveActivityStartedEvent extends TelemetryEvent {
  const LiveActivityStartedEvent({required this.activityType, required this.activityId}): super._();
  

 final  LiveActivityType activityType;
 final  String activityId;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveActivityStartedEventCopyWith<LiveActivityStartedEvent> get copyWith => _$LiveActivityStartedEventCopyWithImpl<LiveActivityStartedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveActivityStartedEvent&&(identical(other.activityType, activityType) || other.activityType == activityType)&&(identical(other.activityId, activityId) || other.activityId == activityId));
}


@override
int get hashCode => Object.hash(runtimeType,activityType,activityId);

@override
String toString() {
  return 'TelemetryEvent.liveActivityStarted(activityType: $activityType, activityId: $activityId)';
}


}

/// @nodoc
abstract mixin class $LiveActivityStartedEventCopyWith<$Res> implements $TelemetryEventCopyWith<$Res> {
  factory $LiveActivityStartedEventCopyWith(LiveActivityStartedEvent value, $Res Function(LiveActivityStartedEvent) _then) = _$LiveActivityStartedEventCopyWithImpl;
@useResult
$Res call({
 LiveActivityType activityType, String activityId
});




}
/// @nodoc
class _$LiveActivityStartedEventCopyWithImpl<$Res>
    implements $LiveActivityStartedEventCopyWith<$Res> {
  _$LiveActivityStartedEventCopyWithImpl(this._self, this._then);

  final LiveActivityStartedEvent _self;
  final $Res Function(LiveActivityStartedEvent) _then;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? activityType = null,Object? activityId = null,}) {
  return _then(LiveActivityStartedEvent(
activityType: null == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as LiveActivityType,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LiveActivityUpdatedEvent extends TelemetryEvent {
  const LiveActivityUpdatedEvent({required this.activityType, required this.activityId, this.eventId}): super._();
  

 final  LiveActivityType activityType;
 final  String activityId;
 final  String? eventId;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveActivityUpdatedEventCopyWith<LiveActivityUpdatedEvent> get copyWith => _$LiveActivityUpdatedEventCopyWithImpl<LiveActivityUpdatedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveActivityUpdatedEvent&&(identical(other.activityType, activityType) || other.activityType == activityType)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}


@override
int get hashCode => Object.hash(runtimeType,activityType,activityId,eventId);

@override
String toString() {
  return 'TelemetryEvent.liveActivityUpdated(activityType: $activityType, activityId: $activityId, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $LiveActivityUpdatedEventCopyWith<$Res> implements $TelemetryEventCopyWith<$Res> {
  factory $LiveActivityUpdatedEventCopyWith(LiveActivityUpdatedEvent value, $Res Function(LiveActivityUpdatedEvent) _then) = _$LiveActivityUpdatedEventCopyWithImpl;
@useResult
$Res call({
 LiveActivityType activityType, String activityId, String? eventId
});




}
/// @nodoc
class _$LiveActivityUpdatedEventCopyWithImpl<$Res>
    implements $LiveActivityUpdatedEventCopyWith<$Res> {
  _$LiveActivityUpdatedEventCopyWithImpl(this._self, this._then);

  final LiveActivityUpdatedEvent _self;
  final $Res Function(LiveActivityUpdatedEvent) _then;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? activityType = null,Object? activityId = null,Object? eventId = freezed,}) {
  return _then(LiveActivityUpdatedEvent(
activityType: null == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as LiveActivityType,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class LiveActivityEndedEvent extends TelemetryEvent {
  const LiveActivityEndedEvent({required this.activityType, required this.activityId, required this.endReason, this.durationMs}): super._();
  

 final  LiveActivityType activityType;
 final  String activityId;
 final  LiveActivityEndReason endReason;
 final  int? durationMs;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveActivityEndedEventCopyWith<LiveActivityEndedEvent> get copyWith => _$LiveActivityEndedEventCopyWithImpl<LiveActivityEndedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveActivityEndedEvent&&(identical(other.activityType, activityType) || other.activityType == activityType)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.endReason, endReason) || other.endReason == endReason)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}


@override
int get hashCode => Object.hash(runtimeType,activityType,activityId,endReason,durationMs);

@override
String toString() {
  return 'TelemetryEvent.liveActivityEnded(activityType: $activityType, activityId: $activityId, endReason: $endReason, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class $LiveActivityEndedEventCopyWith<$Res> implements $TelemetryEventCopyWith<$Res> {
  factory $LiveActivityEndedEventCopyWith(LiveActivityEndedEvent value, $Res Function(LiveActivityEndedEvent) _then) = _$LiveActivityEndedEventCopyWithImpl;
@useResult
$Res call({
 LiveActivityType activityType, String activityId, LiveActivityEndReason endReason, int? durationMs
});




}
/// @nodoc
class _$LiveActivityEndedEventCopyWithImpl<$Res>
    implements $LiveActivityEndedEventCopyWith<$Res> {
  _$LiveActivityEndedEventCopyWithImpl(this._self, this._then);

  final LiveActivityEndedEvent _self;
  final $Res Function(LiveActivityEndedEvent) _then;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? activityType = null,Object? activityId = null,Object? endReason = null,Object? durationMs = freezed,}) {
  return _then(LiveActivityEndedEvent(
activityType: null == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as LiveActivityType,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,endReason: null == endReason ? _self.endReason : endReason // ignore: cast_nullable_to_non_nullable
as LiveActivityEndReason,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class ErrorTelemetryEvent extends TelemetryEvent {
  const ErrorTelemetryEvent({required this.errorType, required this.message, this.stackTrace}): super._();
  

 final  String errorType;
 final  String message;
 final  String? stackTrace;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorTelemetryEventCopyWith<ErrorTelemetryEvent> get copyWith => _$ErrorTelemetryEventCopyWithImpl<ErrorTelemetryEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorTelemetryEvent&&(identical(other.errorType, errorType) || other.errorType == errorType)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,errorType,message,stackTrace);

@override
String toString() {
  return 'TelemetryEvent.error(errorType: $errorType, message: $message, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $ErrorTelemetryEventCopyWith<$Res> implements $TelemetryEventCopyWith<$Res> {
  factory $ErrorTelemetryEventCopyWith(ErrorTelemetryEvent value, $Res Function(ErrorTelemetryEvent) _then) = _$ErrorTelemetryEventCopyWithImpl;
@useResult
$Res call({
 String errorType, String message, String? stackTrace
});




}
/// @nodoc
class _$ErrorTelemetryEventCopyWithImpl<$Res>
    implements $ErrorTelemetryEventCopyWith<$Res> {
  _$ErrorTelemetryEventCopyWithImpl(this._self, this._then);

  final ErrorTelemetryEvent _self;
  final $Res Function(ErrorTelemetryEvent) _then;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorType = null,Object? message = null,Object? stackTrace = freezed,}) {
  return _then(ErrorTelemetryEvent(
errorType: null == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class StartupTimingEvent extends TelemetryEvent {
  const StartupTimingEvent({required this.phasesMicros}): super._();


 final  Map<String, int> phasesMicros;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartupTimingEventCopyWith<StartupTimingEvent> get copyWith => _$StartupTimingEventCopyWithImpl<StartupTimingEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupTimingEvent&&(identical(other.phasesMicros, phasesMicros) || other.phasesMicros == phasesMicros));
}


@override
int get hashCode => Object.hash(runtimeType,phasesMicros);

@override
String toString() {
  return 'TelemetryEvent.startupTiming(phasesMicros: $phasesMicros)';
}


}

/// @nodoc
abstract mixin class $StartupTimingEventCopyWith<$Res> implements $TelemetryEventCopyWith<$Res> {
  factory $StartupTimingEventCopyWith(StartupTimingEvent value, $Res Function(StartupTimingEvent) _then) = _$StartupTimingEventCopyWithImpl;
@useResult
$Res call({
 Map<String, int> phasesMicros
});




}
/// @nodoc
class _$StartupTimingEventCopyWithImpl<$Res>
    implements $StartupTimingEventCopyWith<$Res> {
  _$StartupTimingEventCopyWithImpl(this._self, this._then);

  final StartupTimingEvent _self;
  final $Res Function(StartupTimingEvent) _then;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phasesMicros = null,}) {
  return _then(StartupTimingEvent(
phasesMicros: null == phasesMicros ? _self.phasesMicros : phasesMicros // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

/// @nodoc


class AppLaunchEvent extends TelemetryEvent {
  const AppLaunchEvent({required this.launchType, required this.appVersion, required this.buildNumber, required this.platform, required this.osVersion, required this.deviceModel, required this.locale, required this.isPhysicalDevice, required this.physicalRamMb, required this.cpuCores, required this.manufacturer, this.androidSdkInt, this.securityPatch, this.isLowRamDevice, this.installerStore}): super._();
  

 final  String launchType;
 final  String appVersion;
 final  int buildNumber;
 final  String platform;
 final  String osVersion;
 final  String deviceModel;
 final  String locale;
 final  bool isPhysicalDevice;
 final  int physicalRamMb;
 final  int cpuCores;
 final  String manufacturer;
 final  int? androidSdkInt;
 final  String? securityPatch;
 final  bool? isLowRamDevice;
 final  String? installerStore;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppLaunchEventCopyWith<AppLaunchEvent> get copyWith => _$AppLaunchEventCopyWithImpl<AppLaunchEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppLaunchEvent&&(identical(other.launchType, launchType) || other.launchType == launchType)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.buildNumber, buildNumber) || other.buildNumber == buildNumber)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.osVersion, osVersion) || other.osVersion == osVersion)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.isPhysicalDevice, isPhysicalDevice) || other.isPhysicalDevice == isPhysicalDevice)&&(identical(other.physicalRamMb, physicalRamMb) || other.physicalRamMb == physicalRamMb)&&(identical(other.cpuCores, cpuCores) || other.cpuCores == cpuCores)&&(identical(other.manufacturer, manufacturer) || other.manufacturer == manufacturer)&&(identical(other.androidSdkInt, androidSdkInt) || other.androidSdkInt == androidSdkInt)&&(identical(other.securityPatch, securityPatch) || other.securityPatch == securityPatch)&&(identical(other.isLowRamDevice, isLowRamDevice) || other.isLowRamDevice == isLowRamDevice)&&(identical(other.installerStore, installerStore) || other.installerStore == installerStore));
}


@override
int get hashCode => Object.hash(runtimeType,launchType,appVersion,buildNumber,platform,osVersion,deviceModel,locale,isPhysicalDevice,physicalRamMb,cpuCores,manufacturer,androidSdkInt,securityPatch,isLowRamDevice,installerStore);

@override
String toString() {
  return 'TelemetryEvent.appLaunch(launchType: $launchType, appVersion: $appVersion, buildNumber: $buildNumber, platform: $platform, osVersion: $osVersion, deviceModel: $deviceModel, locale: $locale, isPhysicalDevice: $isPhysicalDevice, physicalRamMb: $physicalRamMb, cpuCores: $cpuCores, manufacturer: $manufacturer, androidSdkInt: $androidSdkInt, securityPatch: $securityPatch, isLowRamDevice: $isLowRamDevice, installerStore: $installerStore)';
}


}

/// @nodoc
abstract mixin class $AppLaunchEventCopyWith<$Res> implements $TelemetryEventCopyWith<$Res> {
  factory $AppLaunchEventCopyWith(AppLaunchEvent value, $Res Function(AppLaunchEvent) _then) = _$AppLaunchEventCopyWithImpl;
@useResult
$Res call({
 String launchType, String appVersion, int buildNumber, String platform, String osVersion, String deviceModel, String locale, bool isPhysicalDevice, int physicalRamMb, int cpuCores, String manufacturer, int? androidSdkInt, String? securityPatch, bool? isLowRamDevice, String? installerStore
});




}
/// @nodoc
class _$AppLaunchEventCopyWithImpl<$Res>
    implements $AppLaunchEventCopyWith<$Res> {
  _$AppLaunchEventCopyWithImpl(this._self, this._then);

  final AppLaunchEvent _self;
  final $Res Function(AppLaunchEvent) _then;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? launchType = null,Object? appVersion = null,Object? buildNumber = null,Object? platform = null,Object? osVersion = null,Object? deviceModel = null,Object? locale = null,Object? isPhysicalDevice = null,Object? physicalRamMb = null,Object? cpuCores = null,Object? manufacturer = null,Object? androidSdkInt = freezed,Object? securityPatch = freezed,Object? isLowRamDevice = freezed,Object? installerStore = freezed,}) {
  return _then(AppLaunchEvent(
launchType: null == launchType ? _self.launchType : launchType // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,buildNumber: null == buildNumber ? _self.buildNumber : buildNumber // ignore: cast_nullable_to_non_nullable
as int,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,osVersion: null == osVersion ? _self.osVersion : osVersion // ignore: cast_nullable_to_non_nullable
as String,deviceModel: null == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,isPhysicalDevice: null == isPhysicalDevice ? _self.isPhysicalDevice : isPhysicalDevice // ignore: cast_nullable_to_non_nullable
as bool,physicalRamMb: null == physicalRamMb ? _self.physicalRamMb : physicalRamMb // ignore: cast_nullable_to_non_nullable
as int,cpuCores: null == cpuCores ? _self.cpuCores : cpuCores // ignore: cast_nullable_to_non_nullable
as int,manufacturer: null == manufacturer ? _self.manufacturer : manufacturer // ignore: cast_nullable_to_non_nullable
as String,androidSdkInt: freezed == androidSdkInt ? _self.androidSdkInt : androidSdkInt // ignore: cast_nullable_to_non_nullable
as int?,securityPatch: freezed == securityPatch ? _self.securityPatch : securityPatch // ignore: cast_nullable_to_non_nullable
as String?,isLowRamDevice: freezed == isLowRamDevice ? _self.isLowRamDevice : isLowRamDevice // ignore: cast_nullable_to_non_nullable
as bool?,installerStore: freezed == installerStore ? _self.installerStore : installerStore // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

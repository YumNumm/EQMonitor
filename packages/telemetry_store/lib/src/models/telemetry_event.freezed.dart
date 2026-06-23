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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationReceivedEvent value)?  notificationReceived,TResult Function( NotificationOpenedEvent value)?  notificationOpened,TResult Function( LiveActivityStartedEvent value)?  liveActivityStarted,TResult Function( LiveActivityUpdatedEvent value)?  liveActivityUpdated,TResult Function( LiveActivityEndedEvent value)?  liveActivityEnded,TResult Function( ErrorTelemetryEvent value)?  error,TResult Function( UserActionEvent value)?  userAction,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationReceivedEvent() when notificationReceived != null:
return notificationReceived(_that);case NotificationOpenedEvent() when notificationOpened != null:
return notificationOpened(_that);case LiveActivityStartedEvent() when liveActivityStarted != null:
return liveActivityStarted(_that);case LiveActivityUpdatedEvent() when liveActivityUpdated != null:
return liveActivityUpdated(_that);case LiveActivityEndedEvent() when liveActivityEnded != null:
return liveActivityEnded(_that);case ErrorTelemetryEvent() when error != null:
return error(_that);case UserActionEvent() when userAction != null:
return userAction(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationReceivedEvent value)  notificationReceived,required TResult Function( NotificationOpenedEvent value)  notificationOpened,required TResult Function( LiveActivityStartedEvent value)  liveActivityStarted,required TResult Function( LiveActivityUpdatedEvent value)  liveActivityUpdated,required TResult Function( LiveActivityEndedEvent value)  liveActivityEnded,required TResult Function( ErrorTelemetryEvent value)  error,required TResult Function( UserActionEvent value)  userAction,}){
final _that = this;
switch (_that) {
case NotificationReceivedEvent():
return notificationReceived(_that);case NotificationOpenedEvent():
return notificationOpened(_that);case LiveActivityStartedEvent():
return liveActivityStarted(_that);case LiveActivityUpdatedEvent():
return liveActivityUpdated(_that);case LiveActivityEndedEvent():
return liveActivityEnded(_that);case ErrorTelemetryEvent():
return error(_that);case UserActionEvent():
return userAction(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationReceivedEvent value)?  notificationReceived,TResult? Function( NotificationOpenedEvent value)?  notificationOpened,TResult? Function( LiveActivityStartedEvent value)?  liveActivityStarted,TResult? Function( LiveActivityUpdatedEvent value)?  liveActivityUpdated,TResult? Function( LiveActivityEndedEvent value)?  liveActivityEnded,TResult? Function( ErrorTelemetryEvent value)?  error,TResult? Function( UserActionEvent value)?  userAction,}){
final _that = this;
switch (_that) {
case NotificationReceivedEvent() when notificationReceived != null:
return notificationReceived(_that);case NotificationOpenedEvent() when notificationOpened != null:
return notificationOpened(_that);case LiveActivityStartedEvent() when liveActivityStarted != null:
return liveActivityStarted(_that);case LiveActivityUpdatedEvent() when liveActivityUpdated != null:
return liveActivityUpdated(_that);case LiveActivityEndedEvent() when liveActivityEnded != null:
return liveActivityEnded(_that);case ErrorTelemetryEvent() when error != null:
return error(_that);case UserActionEvent() when userAction != null:
return userAction(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( NotificationFramework framework,  String channelId,  String? title,  String? eventId,  String? priority)?  notificationReceived,TResult Function( bool coldStart,  String? eventId,  int? elapsedMs)?  notificationOpened,TResult Function( LiveActivityType activityType,  String activityId)?  liveActivityStarted,TResult Function( LiveActivityType activityType,  String activityId,  String? eventId)?  liveActivityUpdated,TResult Function( LiveActivityType activityType,  String activityId,  LiveActivityEndReason endReason,  int? durationMs)?  liveActivityEnded,TResult Function( String errorType,  String message,  String? stackTrace)?  error,TResult Function( UserActionType action,  Map<String, dynamic>? params)?  userAction,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationReceivedEvent() when notificationReceived != null:
return notificationReceived(_that.framework,_that.channelId,_that.title,_that.eventId,_that.priority);case NotificationOpenedEvent() when notificationOpened != null:
return notificationOpened(_that.coldStart,_that.eventId,_that.elapsedMs);case LiveActivityStartedEvent() when liveActivityStarted != null:
return liveActivityStarted(_that.activityType,_that.activityId);case LiveActivityUpdatedEvent() when liveActivityUpdated != null:
return liveActivityUpdated(_that.activityType,_that.activityId,_that.eventId);case LiveActivityEndedEvent() when liveActivityEnded != null:
return liveActivityEnded(_that.activityType,_that.activityId,_that.endReason,_that.durationMs);case ErrorTelemetryEvent() when error != null:
return error(_that.errorType,_that.message,_that.stackTrace);case UserActionEvent() when userAction != null:
return userAction(_that.action,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( NotificationFramework framework,  String channelId,  String? title,  String? eventId,  String? priority)  notificationReceived,required TResult Function( bool coldStart,  String? eventId,  int? elapsedMs)  notificationOpened,required TResult Function( LiveActivityType activityType,  String activityId)  liveActivityStarted,required TResult Function( LiveActivityType activityType,  String activityId,  String? eventId)  liveActivityUpdated,required TResult Function( LiveActivityType activityType,  String activityId,  LiveActivityEndReason endReason,  int? durationMs)  liveActivityEnded,required TResult Function( String errorType,  String message,  String? stackTrace)  error,required TResult Function( UserActionType action,  Map<String, dynamic>? params)  userAction,}) {final _that = this;
switch (_that) {
case NotificationReceivedEvent():
return notificationReceived(_that.framework,_that.channelId,_that.title,_that.eventId,_that.priority);case NotificationOpenedEvent():
return notificationOpened(_that.coldStart,_that.eventId,_that.elapsedMs);case LiveActivityStartedEvent():
return liveActivityStarted(_that.activityType,_that.activityId);case LiveActivityUpdatedEvent():
return liveActivityUpdated(_that.activityType,_that.activityId,_that.eventId);case LiveActivityEndedEvent():
return liveActivityEnded(_that.activityType,_that.activityId,_that.endReason,_that.durationMs);case ErrorTelemetryEvent():
return error(_that.errorType,_that.message,_that.stackTrace);case UserActionEvent():
return userAction(_that.action,_that.params);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( NotificationFramework framework,  String channelId,  String? title,  String? eventId,  String? priority)?  notificationReceived,TResult? Function( bool coldStart,  String? eventId,  int? elapsedMs)?  notificationOpened,TResult? Function( LiveActivityType activityType,  String activityId)?  liveActivityStarted,TResult? Function( LiveActivityType activityType,  String activityId,  String? eventId)?  liveActivityUpdated,TResult? Function( LiveActivityType activityType,  String activityId,  LiveActivityEndReason endReason,  int? durationMs)?  liveActivityEnded,TResult? Function( String errorType,  String message,  String? stackTrace)?  error,TResult? Function( UserActionType action,  Map<String, dynamic>? params)?  userAction,}) {final _that = this;
switch (_that) {
case NotificationReceivedEvent() when notificationReceived != null:
return notificationReceived(_that.framework,_that.channelId,_that.title,_that.eventId,_that.priority);case NotificationOpenedEvent() when notificationOpened != null:
return notificationOpened(_that.coldStart,_that.eventId,_that.elapsedMs);case LiveActivityStartedEvent() when liveActivityStarted != null:
return liveActivityStarted(_that.activityType,_that.activityId);case LiveActivityUpdatedEvent() when liveActivityUpdated != null:
return liveActivityUpdated(_that.activityType,_that.activityId,_that.eventId);case LiveActivityEndedEvent() when liveActivityEnded != null:
return liveActivityEnded(_that.activityType,_that.activityId,_that.endReason,_that.durationMs);case ErrorTelemetryEvent() when error != null:
return error(_that.errorType,_that.message,_that.stackTrace);case UserActionEvent() when userAction != null:
return userAction(_that.action,_that.params);case _:
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


class UserActionEvent extends TelemetryEvent {
  const UserActionEvent({required this.action, final  Map<String, dynamic>? params}): _params = params,super._();
  

 final  UserActionType action;
 final  Map<String, dynamic>? _params;
 Map<String, dynamic>? get params {
  final value = _params;
  if (value == null) return null;
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserActionEventCopyWith<UserActionEvent> get copyWith => _$UserActionEventCopyWithImpl<UserActionEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserActionEvent&&(identical(other.action, action) || other.action == action)&&const DeepCollectionEquality().equals(other._params, _params));
}


@override
int get hashCode => Object.hash(runtimeType,action,const DeepCollectionEquality().hash(_params));

@override
String toString() {
  return 'TelemetryEvent.userAction(action: $action, params: $params)';
}


}

/// @nodoc
abstract mixin class $UserActionEventCopyWith<$Res> implements $TelemetryEventCopyWith<$Res> {
  factory $UserActionEventCopyWith(UserActionEvent value, $Res Function(UserActionEvent) _then) = _$UserActionEventCopyWithImpl;
@useResult
$Res call({
 UserActionType action, Map<String, dynamic>? params
});




}
/// @nodoc
class _$UserActionEventCopyWithImpl<$Res>
    implements $UserActionEventCopyWith<$Res> {
  _$UserActionEventCopyWithImpl(this._self, this._then);

  final UserActionEvent _self;
  final $Res Function(UserActionEvent) _then;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? action = null,Object? params = freezed,}) {
  return _then(UserActionEvent(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as UserActionType,params: freezed == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on

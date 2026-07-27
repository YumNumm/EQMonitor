// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_monitor_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LiveMonitorEarthquakeTrigger {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorEarthquakeTrigger);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LiveMonitorEarthquakeTrigger()';
}


}

/// @nodoc
class $LiveMonitorEarthquakeTriggerCopyWith<$Res>  {
$LiveMonitorEarthquakeTriggerCopyWith(LiveMonitorEarthquakeTrigger _, $Res Function(LiveMonitorEarthquakeTrigger) __);
}


/// Adds pattern-matching-related methods to [LiveMonitorEarthquakeTrigger].
extension LiveMonitorEarthquakeTriggerPatterns on LiveMonitorEarthquakeTrigger {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LiveMonitorTelegramTrigger value)?  telegram,TResult Function( LiveMonitorEstimatedIntensityTrigger value)?  estimatedIntensity,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LiveMonitorTelegramTrigger() when telegram != null:
return telegram(_that);case LiveMonitorEstimatedIntensityTrigger() when estimatedIntensity != null:
return estimatedIntensity(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LiveMonitorTelegramTrigger value)  telegram,required TResult Function( LiveMonitorEstimatedIntensityTrigger value)  estimatedIntensity,}){
final _that = this;
switch (_that) {
case LiveMonitorTelegramTrigger():
return telegram(_that);case LiveMonitorEstimatedIntensityTrigger():
return estimatedIntensity(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LiveMonitorTelegramTrigger value)?  telegram,TResult? Function( LiveMonitorEstimatedIntensityTrigger value)?  estimatedIntensity,}){
final _that = this;
switch (_that) {
case LiveMonitorTelegramTrigger() when telegram != null:
return telegram(_that);case LiveMonitorEstimatedIntensityTrigger() when estimatedIntensity != null:
return estimatedIntensity(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( LiveMonitorEarthquakeTriggerKind kind,  DateTime reportedAt)?  telegram,TResult Function( DateTime? generatedAt)?  estimatedIntensity,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LiveMonitorTelegramTrigger() when telegram != null:
return telegram(_that.kind,_that.reportedAt);case LiveMonitorEstimatedIntensityTrigger() when estimatedIntensity != null:
return estimatedIntensity(_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( LiveMonitorEarthquakeTriggerKind kind,  DateTime reportedAt)  telegram,required TResult Function( DateTime? generatedAt)  estimatedIntensity,}) {final _that = this;
switch (_that) {
case LiveMonitorTelegramTrigger():
return telegram(_that.kind,_that.reportedAt);case LiveMonitorEstimatedIntensityTrigger():
return estimatedIntensity(_that.generatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( LiveMonitorEarthquakeTriggerKind kind,  DateTime reportedAt)?  telegram,TResult? Function( DateTime? generatedAt)?  estimatedIntensity,}) {final _that = this;
switch (_that) {
case LiveMonitorTelegramTrigger() when telegram != null:
return telegram(_that.kind,_that.reportedAt);case LiveMonitorEstimatedIntensityTrigger() when estimatedIntensity != null:
return estimatedIntensity(_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc


class LiveMonitorTelegramTrigger implements LiveMonitorEarthquakeTrigger {
  const LiveMonitorTelegramTrigger({required this.kind, required this.reportedAt});
  

 final  LiveMonitorEarthquakeTriggerKind kind;
 final  DateTime reportedAt;

/// Create a copy of LiveMonitorEarthquakeTrigger
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorTelegramTriggerCopyWith<LiveMonitorTelegramTrigger> get copyWith => _$LiveMonitorTelegramTriggerCopyWithImpl<LiveMonitorTelegramTrigger>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorTelegramTrigger&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt));
}


@override
int get hashCode => Object.hash(runtimeType,kind,reportedAt);

@override
String toString() {
  return 'LiveMonitorEarthquakeTrigger.telegram(kind: $kind, reportedAt: $reportedAt)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorTelegramTriggerCopyWith<$Res> implements $LiveMonitorEarthquakeTriggerCopyWith<$Res> {
  factory $LiveMonitorTelegramTriggerCopyWith(LiveMonitorTelegramTrigger value, $Res Function(LiveMonitorTelegramTrigger) _then) = _$LiveMonitorTelegramTriggerCopyWithImpl;
@useResult
$Res call({
 LiveMonitorEarthquakeTriggerKind kind, DateTime reportedAt
});




}
/// @nodoc
class _$LiveMonitorTelegramTriggerCopyWithImpl<$Res>
    implements $LiveMonitorTelegramTriggerCopyWith<$Res> {
  _$LiveMonitorTelegramTriggerCopyWithImpl(this._self, this._then);

  final LiveMonitorTelegramTrigger _self;
  final $Res Function(LiveMonitorTelegramTrigger) _then;

/// Create a copy of LiveMonitorEarthquakeTrigger
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? reportedAt = null,}) {
  return _then(LiveMonitorTelegramTrigger(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LiveMonitorEarthquakeTriggerKind,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class LiveMonitorEstimatedIntensityTrigger implements LiveMonitorEarthquakeTrigger {
  const LiveMonitorEstimatedIntensityTrigger({required this.generatedAt});
  

 final  DateTime? generatedAt;

/// Create a copy of LiveMonitorEarthquakeTrigger
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorEstimatedIntensityTriggerCopyWith<LiveMonitorEstimatedIntensityTrigger> get copyWith => _$LiveMonitorEstimatedIntensityTriggerCopyWithImpl<LiveMonitorEstimatedIntensityTrigger>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorEstimatedIntensityTrigger&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,generatedAt);

@override
String toString() {
  return 'LiveMonitorEarthquakeTrigger.estimatedIntensity(generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorEstimatedIntensityTriggerCopyWith<$Res> implements $LiveMonitorEarthquakeTriggerCopyWith<$Res> {
  factory $LiveMonitorEstimatedIntensityTriggerCopyWith(LiveMonitorEstimatedIntensityTrigger value, $Res Function(LiveMonitorEstimatedIntensityTrigger) _then) = _$LiveMonitorEstimatedIntensityTriggerCopyWithImpl;
@useResult
$Res call({
 DateTime? generatedAt
});




}
/// @nodoc
class _$LiveMonitorEstimatedIntensityTriggerCopyWithImpl<$Res>
    implements $LiveMonitorEstimatedIntensityTriggerCopyWith<$Res> {
  _$LiveMonitorEstimatedIntensityTriggerCopyWithImpl(this._self, this._then);

  final LiveMonitorEstimatedIntensityTrigger _self;
  final $Res Function(LiveMonitorEstimatedIntensityTrigger) _then;

/// Create a copy of LiveMonitorEarthquakeTrigger
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? generatedAt = freezed,}) {
  return _then(LiveMonitorEstimatedIntensityTrigger(
generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$LiveMonitorDetectedEvent {

 String get eventId;
/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorDetectedEventCopyWith<LiveMonitorDetectedEvent> get copyWith => _$LiveMonitorDetectedEventCopyWithImpl<LiveMonitorDetectedEvent>(this as LiveMonitorDetectedEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorDetectedEvent&&(identical(other.eventId, eventId) || other.eventId == eventId));
}


@override
int get hashCode => Object.hash(runtimeType,eventId);

@override
String toString() {
  return 'LiveMonitorDetectedEvent(eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorDetectedEventCopyWith<$Res>  {
  factory $LiveMonitorDetectedEventCopyWith(LiveMonitorDetectedEvent value, $Res Function(LiveMonitorDetectedEvent) _then) = _$LiveMonitorDetectedEventCopyWithImpl;
@useResult
$Res call({
 String eventId
});




}
/// @nodoc
class _$LiveMonitorDetectedEventCopyWithImpl<$Res>
    implements $LiveMonitorDetectedEventCopyWith<$Res> {
  _$LiveMonitorDetectedEventCopyWithImpl(this._self, this._then);

  final LiveMonitorDetectedEvent _self;
  final $Res Function(LiveMonitorDetectedEvent) _then;

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveMonitorDetectedEvent].
extension LiveMonitorDetectedEventPatterns on LiveMonitorDetectedEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LiveMonitorEewStartedEvent value)?  eewStarted,TResult Function( LiveMonitorEewUpdatedEvent value)?  eewUpdated,TResult Function( LiveMonitorShakeDetectedEvent value)?  shakeDetected,TResult Function( LiveMonitorEarthquakeUpsertEvent value)?  earthquakeUpsert,TResult Function( LiveMonitorEarthquakeDeletedEvent value)?  earthquakeDeleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LiveMonitorEewStartedEvent() when eewStarted != null:
return eewStarted(_that);case LiveMonitorEewUpdatedEvent() when eewUpdated != null:
return eewUpdated(_that);case LiveMonitorShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that);case LiveMonitorEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that);case LiveMonitorEarthquakeDeletedEvent() when earthquakeDeleted != null:
return earthquakeDeleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LiveMonitorEewStartedEvent value)  eewStarted,required TResult Function( LiveMonitorEewUpdatedEvent value)  eewUpdated,required TResult Function( LiveMonitorShakeDetectedEvent value)  shakeDetected,required TResult Function( LiveMonitorEarthquakeUpsertEvent value)  earthquakeUpsert,required TResult Function( LiveMonitorEarthquakeDeletedEvent value)  earthquakeDeleted,}){
final _that = this;
switch (_that) {
case LiveMonitorEewStartedEvent():
return eewStarted(_that);case LiveMonitorEewUpdatedEvent():
return eewUpdated(_that);case LiveMonitorShakeDetectedEvent():
return shakeDetected(_that);case LiveMonitorEarthquakeUpsertEvent():
return earthquakeUpsert(_that);case LiveMonitorEarthquakeDeletedEvent():
return earthquakeDeleted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LiveMonitorEewStartedEvent value)?  eewStarted,TResult? Function( LiveMonitorEewUpdatedEvent value)?  eewUpdated,TResult? Function( LiveMonitorShakeDetectedEvent value)?  shakeDetected,TResult? Function( LiveMonitorEarthquakeUpsertEvent value)?  earthquakeUpsert,TResult? Function( LiveMonitorEarthquakeDeletedEvent value)?  earthquakeDeleted,}){
final _that = this;
switch (_that) {
case LiveMonitorEewStartedEvent() when eewStarted != null:
return eewStarted(_that);case LiveMonitorEewUpdatedEvent() when eewUpdated != null:
return eewUpdated(_that);case LiveMonitorShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that);case LiveMonitorEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that);case LiveMonitorEarthquakeDeletedEvent() when earthquakeDeleted != null:
return earthquakeDeleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String eventId,  int serialNo)?  eewStarted,TResult Function( String eventId,  int serialNo)?  eewUpdated,TResult Function( String eventId,  int serialNo)?  shakeDetected,TResult Function( String eventId,  LiveMonitorEarthquakeTrigger trigger,  Earthquake earthquake)?  earthquakeUpsert,TResult Function( String eventId)?  earthquakeDeleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LiveMonitorEewStartedEvent() when eewStarted != null:
return eewStarted(_that.eventId,_that.serialNo);case LiveMonitorEewUpdatedEvent() when eewUpdated != null:
return eewUpdated(_that.eventId,_that.serialNo);case LiveMonitorShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that.eventId,_that.serialNo);case LiveMonitorEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that.eventId,_that.trigger,_that.earthquake);case LiveMonitorEarthquakeDeletedEvent() when earthquakeDeleted != null:
return earthquakeDeleted(_that.eventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String eventId,  int serialNo)  eewStarted,required TResult Function( String eventId,  int serialNo)  eewUpdated,required TResult Function( String eventId,  int serialNo)  shakeDetected,required TResult Function( String eventId,  LiveMonitorEarthquakeTrigger trigger,  Earthquake earthquake)  earthquakeUpsert,required TResult Function( String eventId)  earthquakeDeleted,}) {final _that = this;
switch (_that) {
case LiveMonitorEewStartedEvent():
return eewStarted(_that.eventId,_that.serialNo);case LiveMonitorEewUpdatedEvent():
return eewUpdated(_that.eventId,_that.serialNo);case LiveMonitorShakeDetectedEvent():
return shakeDetected(_that.eventId,_that.serialNo);case LiveMonitorEarthquakeUpsertEvent():
return earthquakeUpsert(_that.eventId,_that.trigger,_that.earthquake);case LiveMonitorEarthquakeDeletedEvent():
return earthquakeDeleted(_that.eventId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String eventId,  int serialNo)?  eewStarted,TResult? Function( String eventId,  int serialNo)?  eewUpdated,TResult? Function( String eventId,  int serialNo)?  shakeDetected,TResult? Function( String eventId,  LiveMonitorEarthquakeTrigger trigger,  Earthquake earthquake)?  earthquakeUpsert,TResult? Function( String eventId)?  earthquakeDeleted,}) {final _that = this;
switch (_that) {
case LiveMonitorEewStartedEvent() when eewStarted != null:
return eewStarted(_that.eventId,_that.serialNo);case LiveMonitorEewUpdatedEvent() when eewUpdated != null:
return eewUpdated(_that.eventId,_that.serialNo);case LiveMonitorShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that.eventId,_that.serialNo);case LiveMonitorEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that.eventId,_that.trigger,_that.earthquake);case LiveMonitorEarthquakeDeletedEvent() when earthquakeDeleted != null:
return earthquakeDeleted(_that.eventId);case _:
  return null;

}
}

}

/// @nodoc


class LiveMonitorEewStartedEvent implements LiveMonitorDetectedEvent {
  const LiveMonitorEewStartedEvent({required this.eventId, required this.serialNo});
  

@override final  String eventId;
 final  int serialNo;

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorEewStartedEventCopyWith<LiveMonitorEewStartedEvent> get copyWith => _$LiveMonitorEewStartedEventCopyWithImpl<LiveMonitorEewStartedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorEewStartedEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo);

@override
String toString() {
  return 'LiveMonitorDetectedEvent.eewStarted(eventId: $eventId, serialNo: $serialNo)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorEewStartedEventCopyWith<$Res> implements $LiveMonitorDetectedEventCopyWith<$Res> {
  factory $LiveMonitorEewStartedEventCopyWith(LiveMonitorEewStartedEvent value, $Res Function(LiveMonitorEewStartedEvent) _then) = _$LiveMonitorEewStartedEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, int serialNo
});




}
/// @nodoc
class _$LiveMonitorEewStartedEventCopyWithImpl<$Res>
    implements $LiveMonitorEewStartedEventCopyWith<$Res> {
  _$LiveMonitorEewStartedEventCopyWithImpl(this._self, this._then);

  final LiveMonitorEewStartedEvent _self;
  final $Res Function(LiveMonitorEewStartedEvent) _then;

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? serialNo = null,}) {
  return _then(LiveMonitorEewStartedEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class LiveMonitorEewUpdatedEvent implements LiveMonitorDetectedEvent {
  const LiveMonitorEewUpdatedEvent({required this.eventId, required this.serialNo});
  

@override final  String eventId;
 final  int serialNo;

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorEewUpdatedEventCopyWith<LiveMonitorEewUpdatedEvent> get copyWith => _$LiveMonitorEewUpdatedEventCopyWithImpl<LiveMonitorEewUpdatedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorEewUpdatedEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo);

@override
String toString() {
  return 'LiveMonitorDetectedEvent.eewUpdated(eventId: $eventId, serialNo: $serialNo)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorEewUpdatedEventCopyWith<$Res> implements $LiveMonitorDetectedEventCopyWith<$Res> {
  factory $LiveMonitorEewUpdatedEventCopyWith(LiveMonitorEewUpdatedEvent value, $Res Function(LiveMonitorEewUpdatedEvent) _then) = _$LiveMonitorEewUpdatedEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, int serialNo
});




}
/// @nodoc
class _$LiveMonitorEewUpdatedEventCopyWithImpl<$Res>
    implements $LiveMonitorEewUpdatedEventCopyWith<$Res> {
  _$LiveMonitorEewUpdatedEventCopyWithImpl(this._self, this._then);

  final LiveMonitorEewUpdatedEvent _self;
  final $Res Function(LiveMonitorEewUpdatedEvent) _then;

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? serialNo = null,}) {
  return _then(LiveMonitorEewUpdatedEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class LiveMonitorShakeDetectedEvent implements LiveMonitorDetectedEvent {
  const LiveMonitorShakeDetectedEvent({required this.eventId, required this.serialNo});
  

@override final  String eventId;
 final  int serialNo;

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorShakeDetectedEventCopyWith<LiveMonitorShakeDetectedEvent> get copyWith => _$LiveMonitorShakeDetectedEventCopyWithImpl<LiveMonitorShakeDetectedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorShakeDetectedEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo);

@override
String toString() {
  return 'LiveMonitorDetectedEvent.shakeDetected(eventId: $eventId, serialNo: $serialNo)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorShakeDetectedEventCopyWith<$Res> implements $LiveMonitorDetectedEventCopyWith<$Res> {
  factory $LiveMonitorShakeDetectedEventCopyWith(LiveMonitorShakeDetectedEvent value, $Res Function(LiveMonitorShakeDetectedEvent) _then) = _$LiveMonitorShakeDetectedEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, int serialNo
});




}
/// @nodoc
class _$LiveMonitorShakeDetectedEventCopyWithImpl<$Res>
    implements $LiveMonitorShakeDetectedEventCopyWith<$Res> {
  _$LiveMonitorShakeDetectedEventCopyWithImpl(this._self, this._then);

  final LiveMonitorShakeDetectedEvent _self;
  final $Res Function(LiveMonitorShakeDetectedEvent) _then;

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? serialNo = null,}) {
  return _then(LiveMonitorShakeDetectedEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class LiveMonitorEarthquakeUpsertEvent implements LiveMonitorDetectedEvent {
  const LiveMonitorEarthquakeUpsertEvent({required this.eventId, required this.trigger, required this.earthquake});
  

@override final  String eventId;
 final  LiveMonitorEarthquakeTrigger trigger;
 final  Earthquake earthquake;

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorEarthquakeUpsertEventCopyWith<LiveMonitorEarthquakeUpsertEvent> get copyWith => _$LiveMonitorEarthquakeUpsertEventCopyWithImpl<LiveMonitorEarthquakeUpsertEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorEarthquakeUpsertEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,trigger,earthquake);

@override
String toString() {
  return 'LiveMonitorDetectedEvent.earthquakeUpsert(eventId: $eventId, trigger: $trigger, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorEarthquakeUpsertEventCopyWith<$Res> implements $LiveMonitorDetectedEventCopyWith<$Res> {
  factory $LiveMonitorEarthquakeUpsertEventCopyWith(LiveMonitorEarthquakeUpsertEvent value, $Res Function(LiveMonitorEarthquakeUpsertEvent) _then) = _$LiveMonitorEarthquakeUpsertEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, LiveMonitorEarthquakeTrigger trigger, Earthquake earthquake
});


$LiveMonitorEarthquakeTriggerCopyWith<$Res> get trigger;$EarthquakeCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$LiveMonitorEarthquakeUpsertEventCopyWithImpl<$Res>
    implements $LiveMonitorEarthquakeUpsertEventCopyWith<$Res> {
  _$LiveMonitorEarthquakeUpsertEventCopyWithImpl(this._self, this._then);

  final LiveMonitorEarthquakeUpsertEvent _self;
  final $Res Function(LiveMonitorEarthquakeUpsertEvent) _then;

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? trigger = null,Object? earthquake = null,}) {
  return _then(LiveMonitorEarthquakeUpsertEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as LiveMonitorEarthquakeTrigger,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as Earthquake,
  ));
}

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveMonitorEarthquakeTriggerCopyWith<$Res> get trigger {
  
  return $LiveMonitorEarthquakeTriggerCopyWith<$Res>(_self.trigger, (value) {
    return _then(_self.copyWith(trigger: value));
  });
}/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<$Res> get earthquake {
  
  return $EarthquakeCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

/// @nodoc


class LiveMonitorEarthquakeDeletedEvent implements LiveMonitorDetectedEvent {
  const LiveMonitorEarthquakeDeletedEvent({required this.eventId});
  

@override final  String eventId;

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorEarthquakeDeletedEventCopyWith<LiveMonitorEarthquakeDeletedEvent> get copyWith => _$LiveMonitorEarthquakeDeletedEventCopyWithImpl<LiveMonitorEarthquakeDeletedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorEarthquakeDeletedEvent&&(identical(other.eventId, eventId) || other.eventId == eventId));
}


@override
int get hashCode => Object.hash(runtimeType,eventId);

@override
String toString() {
  return 'LiveMonitorDetectedEvent.earthquakeDeleted(eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorEarthquakeDeletedEventCopyWith<$Res> implements $LiveMonitorDetectedEventCopyWith<$Res> {
  factory $LiveMonitorEarthquakeDeletedEventCopyWith(LiveMonitorEarthquakeDeletedEvent value, $Res Function(LiveMonitorEarthquakeDeletedEvent) _then) = _$LiveMonitorEarthquakeDeletedEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId
});




}
/// @nodoc
class _$LiveMonitorEarthquakeDeletedEventCopyWithImpl<$Res>
    implements $LiveMonitorEarthquakeDeletedEventCopyWith<$Res> {
  _$LiveMonitorEarthquakeDeletedEventCopyWithImpl(this._self, this._then);

  final LiveMonitorEarthquakeDeletedEvent _self;
  final $Res Function(LiveMonitorEarthquakeDeletedEvent) _then;

/// Create a copy of LiveMonitorDetectedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,}) {
  return _then(LiveMonitorEarthquakeDeletedEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LiveMonitorEventEnvelope {

 int get sequence; LiveMonitorDetectedEvent get event;
/// Create a copy of LiveMonitorEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorEventEnvelopeCopyWith<LiveMonitorEventEnvelope> get copyWith => _$LiveMonitorEventEnvelopeCopyWithImpl<LiveMonitorEventEnvelope>(this as LiveMonitorEventEnvelope, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorEventEnvelope&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode => Object.hash(runtimeType,sequence,event);

@override
String toString() {
  return 'LiveMonitorEventEnvelope(sequence: $sequence, event: $event)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorEventEnvelopeCopyWith<$Res>  {
  factory $LiveMonitorEventEnvelopeCopyWith(LiveMonitorEventEnvelope value, $Res Function(LiveMonitorEventEnvelope) _then) = _$LiveMonitorEventEnvelopeCopyWithImpl;
@useResult
$Res call({
 int sequence, LiveMonitorDetectedEvent event
});


$LiveMonitorDetectedEventCopyWith<$Res> get event;

}
/// @nodoc
class _$LiveMonitorEventEnvelopeCopyWithImpl<$Res>
    implements $LiveMonitorEventEnvelopeCopyWith<$Res> {
  _$LiveMonitorEventEnvelopeCopyWithImpl(this._self, this._then);

  final LiveMonitorEventEnvelope _self;
  final $Res Function(LiveMonitorEventEnvelope) _then;

/// Create a copy of LiveMonitorEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sequence = null,Object? event = null,}) {
  return _then(_self.copyWith(
sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as LiveMonitorDetectedEvent,
  ));
}
/// Create a copy of LiveMonitorEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveMonitorDetectedEventCopyWith<$Res> get event {
  
  return $LiveMonitorDetectedEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveMonitorEventEnvelope].
extension LiveMonitorEventEnvelopePatterns on LiveMonitorEventEnvelope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveMonitorEventEnvelope value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveMonitorEventEnvelope() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveMonitorEventEnvelope value)  $default,){
final _that = this;
switch (_that) {
case _LiveMonitorEventEnvelope():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveMonitorEventEnvelope value)?  $default,){
final _that = this;
switch (_that) {
case _LiveMonitorEventEnvelope() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sequence,  LiveMonitorDetectedEvent event)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveMonitorEventEnvelope() when $default != null:
return $default(_that.sequence,_that.event);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sequence,  LiveMonitorDetectedEvent event)  $default,) {final _that = this;
switch (_that) {
case _LiveMonitorEventEnvelope():
return $default(_that.sequence,_that.event);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sequence,  LiveMonitorDetectedEvent event)?  $default,) {final _that = this;
switch (_that) {
case _LiveMonitorEventEnvelope() when $default != null:
return $default(_that.sequence,_that.event);case _:
  return null;

}
}

}

/// @nodoc


class _LiveMonitorEventEnvelope implements LiveMonitorEventEnvelope {
  const _LiveMonitorEventEnvelope({required this.sequence, required this.event});
  

@override final  int sequence;
@override final  LiveMonitorDetectedEvent event;

/// Create a copy of LiveMonitorEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveMonitorEventEnvelopeCopyWith<_LiveMonitorEventEnvelope> get copyWith => __$LiveMonitorEventEnvelopeCopyWithImpl<_LiveMonitorEventEnvelope>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveMonitorEventEnvelope&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode => Object.hash(runtimeType,sequence,event);

@override
String toString() {
  return 'LiveMonitorEventEnvelope(sequence: $sequence, event: $event)';
}


}

/// @nodoc
abstract mixin class _$LiveMonitorEventEnvelopeCopyWith<$Res> implements $LiveMonitorEventEnvelopeCopyWith<$Res> {
  factory _$LiveMonitorEventEnvelopeCopyWith(_LiveMonitorEventEnvelope value, $Res Function(_LiveMonitorEventEnvelope) _then) = __$LiveMonitorEventEnvelopeCopyWithImpl;
@override @useResult
$Res call({
 int sequence, LiveMonitorDetectedEvent event
});


@override $LiveMonitorDetectedEventCopyWith<$Res> get event;

}
/// @nodoc
class __$LiveMonitorEventEnvelopeCopyWithImpl<$Res>
    implements _$LiveMonitorEventEnvelopeCopyWith<$Res> {
  __$LiveMonitorEventEnvelopeCopyWithImpl(this._self, this._then);

  final _LiveMonitorEventEnvelope _self;
  final $Res Function(_LiveMonitorEventEnvelope) _then;

/// Create a copy of LiveMonitorEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sequence = null,Object? event = null,}) {
  return _then(_LiveMonitorEventEnvelope(
sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as LiveMonitorDetectedEvent,
  ));
}

/// Create a copy of LiveMonitorEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveMonitorDetectedEventCopyWith<$Res> get event {
  
  return $LiveMonitorDetectedEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telemetry_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelemetryEvent {

@JsonKey(name: 'event_type') String get eventType;@JsonKey(name: 'timestamp_ms') int get timestampMs;@JsonKey(includeIfNull: true, name: 'event_id') String? get eventId;@JsonKey(includeIfNull: true) String? get payload;@JsonKey(name: 'created_at_ms') int get createdAtMs;
/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelemetryEventCopyWith<TelemetryEvent> get copyWith => _$TelemetryEventCopyWithImpl<TelemetryEvent>(this as TelemetryEvent, _$identity);

  /// Serializes this TelemetryEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelemetryEvent&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.timestampMs, timestampMs) || other.timestampMs == timestampMs)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.createdAtMs, createdAtMs) || other.createdAtMs == createdAtMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventType,timestampMs,eventId,payload,createdAtMs);

@override
String toString() {
  return 'TelemetryEvent(eventType: $eventType, timestampMs: $timestampMs, eventId: $eventId, payload: $payload, createdAtMs: $createdAtMs)';
}


}

/// @nodoc
abstract mixin class $TelemetryEventCopyWith<$Res>  {
  factory $TelemetryEventCopyWith(TelemetryEvent value, $Res Function(TelemetryEvent) _then) = _$TelemetryEventCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_type') String eventType,@JsonKey(name: 'timestamp_ms') int timestampMs,@JsonKey(includeIfNull: true, name: 'event_id') String? eventId,@JsonKey(includeIfNull: true) String? payload,@JsonKey(name: 'created_at_ms') int createdAtMs
});




}
/// @nodoc
class _$TelemetryEventCopyWithImpl<$Res>
    implements $TelemetryEventCopyWith<$Res> {
  _$TelemetryEventCopyWithImpl(this._self, this._then);

  final TelemetryEvent _self;
  final $Res Function(TelemetryEvent) _then;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventType = null,Object? timestampMs = null,Object? eventId = freezed,Object? payload = freezed,Object? createdAtMs = null,}) {
  return _then(TelemetryEvent(
eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String,timestampMs: null == timestampMs ? _self.timestampMs : timestampMs // ignore: cast_nullable_to_non_nullable
as int,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,createdAtMs: null == createdAtMs ? _self.createdAtMs : createdAtMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelemetryEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelemetryEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelemetryEvent value)  $default,){
final _that = this;
switch (_that) {
case _TelemetryEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelemetryEvent value)?  $default,){
final _that = this;
switch (_that) {
case _TelemetryEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_type')  String eventType, @JsonKey(name: 'timestamp_ms')  int timestampMs, @JsonKey(includeIfNull: true, name: 'event_id')  String? eventId, @JsonKey(includeIfNull: true)  String? payload, @JsonKey(name: 'created_at_ms')  int createdAtMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelemetryEvent() when $default != null:
return $default(_that.eventType,_that.timestampMs,_that.eventId,_that.payload,_that.createdAtMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_type')  String eventType, @JsonKey(name: 'timestamp_ms')  int timestampMs, @JsonKey(includeIfNull: true, name: 'event_id')  String? eventId, @JsonKey(includeIfNull: true)  String? payload, @JsonKey(name: 'created_at_ms')  int createdAtMs)  $default,) {final _that = this;
switch (_that) {
case _TelemetryEvent():
return $default(_that.eventType,_that.timestampMs,_that.eventId,_that.payload,_that.createdAtMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_type')  String eventType, @JsonKey(name: 'timestamp_ms')  int timestampMs, @JsonKey(includeIfNull: true, name: 'event_id')  String? eventId, @JsonKey(includeIfNull: true)  String? payload, @JsonKey(name: 'created_at_ms')  int createdAtMs)?  $default,) {final _that = this;
switch (_that) {
case _TelemetryEvent() when $default != null:
return $default(_that.eventType,_that.timestampMs,_that.eventId,_that.payload,_that.createdAtMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelemetryEvent implements TelemetryEvent {
  const _TelemetryEvent({@JsonKey(name: 'event_type') required this.eventType, @JsonKey(name: 'timestamp_ms') required this.timestampMs, @JsonKey(includeIfNull: true, name: 'event_id') required this.eventId, @JsonKey(includeIfNull: true) required this.payload, @JsonKey(name: 'created_at_ms') required this.createdAtMs});
  factory _TelemetryEvent.fromJson(Map<String, dynamic> json) => _$TelemetryEventFromJson(json);

@override@JsonKey(name: 'event_type') final  String eventType;
@override@JsonKey(name: 'timestamp_ms') final  int timestampMs;
@override@JsonKey(includeIfNull: true, name: 'event_id') final  String? eventId;
@override@JsonKey(includeIfNull: true) final  String? payload;
@override@JsonKey(name: 'created_at_ms') final  int createdAtMs;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelemetryEventCopyWith<_TelemetryEvent> get copyWith => __$TelemetryEventCopyWithImpl<_TelemetryEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelemetryEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelemetryEvent&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.timestampMs, timestampMs) || other.timestampMs == timestampMs)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.createdAtMs, createdAtMs) || other.createdAtMs == createdAtMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventType,timestampMs,eventId,payload,createdAtMs);

@override
String toString() {
  return 'TelemetryEvent(eventType: $eventType, timestampMs: $timestampMs, eventId: $eventId, payload: $payload, createdAtMs: $createdAtMs)';
}


}

/// @nodoc
abstract mixin class _$TelemetryEventCopyWith<$Res> implements $TelemetryEventCopyWith<$Res> {
  factory _$TelemetryEventCopyWith(_TelemetryEvent value, $Res Function(_TelemetryEvent) _then) = __$TelemetryEventCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_type') String eventType,@JsonKey(name: 'timestamp_ms') int timestampMs,@JsonKey(includeIfNull: true, name: 'event_id') String? eventId,@JsonKey(includeIfNull: true) String? payload,@JsonKey(name: 'created_at_ms') int createdAtMs
});




}
/// @nodoc
class __$TelemetryEventCopyWithImpl<$Res>
    implements _$TelemetryEventCopyWith<$Res> {
  __$TelemetryEventCopyWithImpl(this._self, this._then);

  final _TelemetryEvent _self;
  final $Res Function(_TelemetryEvent) _then;

/// Create a copy of TelemetryEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventType = null,Object? timestampMs = null,Object? eventId = freezed,Object? payload = freezed,Object? createdAtMs = null,}) {
  return _then(_TelemetryEvent(
eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String,timestampMs: null == timestampMs ? _self.timestampMs : timestampMs // ignore: cast_nullable_to_non_nullable
as int,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,createdAtMs: null == createdAtMs ? _self.createdAtMs : createdAtMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

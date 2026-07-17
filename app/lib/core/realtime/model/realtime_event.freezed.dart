// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
RealtimeEvent _$RealtimeEventFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'ready':
          return RealtimeReadyEvent.fromJson(
            json
          );
                case 'eewUpsert':
          return RealtimeEewUpsertEvent.fromJson(
            json
          );
                case 'earthquakeUpsert':
          return RealtimeEarthquakeUpsertEvent.fromJson(
            json
          );
                case 'earthquakeDelete':
          return RealtimeEarthquakeDeleteEvent.fromJson(
            json
          );
                case 'tsunamiUpsert':
          return RealtimeTsunamiUpsertEvent.fromJson(
            json
          );
                case 'tsunamiDelete':
          return RealtimeTsunamiDeleteEvent.fromJson(
            json
          );
                case 'shakeDetected':
          return RealtimeShakeDetectedEvent.fromJson(
            json
          );
                case 'estimatedIntensityUpsert':
          return RealtimeEstimatedIntensityUpsertEvent.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'RealtimeEvent',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$RealtimeEvent {

 RealtimeSource get source;
/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeEventCopyWith<RealtimeEvent> get copyWith => _$RealtimeEventCopyWithImpl<RealtimeEvent>(this as RealtimeEvent, _$identity);

  /// Serializes this RealtimeEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEvent&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source);

@override
String toString() {
  return 'RealtimeEvent(source: $source)';
}


}

/// @nodoc
abstract mixin class $RealtimeEventCopyWith<$Res>  {
  factory $RealtimeEventCopyWith(RealtimeEvent value, $Res Function(RealtimeEvent) _then) = _$RealtimeEventCopyWithImpl;
@useResult
$Res call({
 RealtimeSource source
});




}
/// @nodoc
class _$RealtimeEventCopyWithImpl<$Res>
    implements $RealtimeEventCopyWith<$Res> {
  _$RealtimeEventCopyWithImpl(this._self, this._then);

  final RealtimeEvent _self;
  final $Res Function(RealtimeEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,}) {
  return _then(_self.copyWith(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RealtimeSource,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeEvent].
extension RealtimeEventPatterns on RealtimeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RealtimeReadyEvent value)?  ready,TResult Function( RealtimeEewUpsertEvent value)?  eewUpsert,TResult Function( RealtimeEarthquakeUpsertEvent value)?  earthquakeUpsert,TResult Function( RealtimeEarthquakeDeleteEvent value)?  earthquakeDelete,TResult Function( RealtimeTsunamiUpsertEvent value)?  tsunamiUpsert,TResult Function( RealtimeTsunamiDeleteEvent value)?  tsunamiDelete,TResult Function( RealtimeShakeDetectedEvent value)?  shakeDetected,TResult Function( RealtimeEstimatedIntensityUpsertEvent value)?  estimatedIntensityUpsert,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RealtimeReadyEvent() when ready != null:
return ready(_that);case RealtimeEewUpsertEvent() when eewUpsert != null:
return eewUpsert(_that);case RealtimeEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that);case RealtimeEarthquakeDeleteEvent() when earthquakeDelete != null:
return earthquakeDelete(_that);case RealtimeTsunamiUpsertEvent() when tsunamiUpsert != null:
return tsunamiUpsert(_that);case RealtimeTsunamiDeleteEvent() when tsunamiDelete != null:
return tsunamiDelete(_that);case RealtimeShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that);case RealtimeEstimatedIntensityUpsertEvent() when estimatedIntensityUpsert != null:
return estimatedIntensityUpsert(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RealtimeReadyEvent value)  ready,required TResult Function( RealtimeEewUpsertEvent value)  eewUpsert,required TResult Function( RealtimeEarthquakeUpsertEvent value)  earthquakeUpsert,required TResult Function( RealtimeEarthquakeDeleteEvent value)  earthquakeDelete,required TResult Function( RealtimeTsunamiUpsertEvent value)  tsunamiUpsert,required TResult Function( RealtimeTsunamiDeleteEvent value)  tsunamiDelete,required TResult Function( RealtimeShakeDetectedEvent value)  shakeDetected,required TResult Function( RealtimeEstimatedIntensityUpsertEvent value)  estimatedIntensityUpsert,}){
final _that = this;
switch (_that) {
case RealtimeReadyEvent():
return ready(_that);case RealtimeEewUpsertEvent():
return eewUpsert(_that);case RealtimeEarthquakeUpsertEvent():
return earthquakeUpsert(_that);case RealtimeEarthquakeDeleteEvent():
return earthquakeDelete(_that);case RealtimeTsunamiUpsertEvent():
return tsunamiUpsert(_that);case RealtimeTsunamiDeleteEvent():
return tsunamiDelete(_that);case RealtimeShakeDetectedEvent():
return shakeDetected(_that);case RealtimeEstimatedIntensityUpsertEvent():
return estimatedIntensityUpsert(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RealtimeReadyEvent value)?  ready,TResult? Function( RealtimeEewUpsertEvent value)?  eewUpsert,TResult? Function( RealtimeEarthquakeUpsertEvent value)?  earthquakeUpsert,TResult? Function( RealtimeEarthquakeDeleteEvent value)?  earthquakeDelete,TResult? Function( RealtimeTsunamiUpsertEvent value)?  tsunamiUpsert,TResult? Function( RealtimeTsunamiDeleteEvent value)?  tsunamiDelete,TResult? Function( RealtimeShakeDetectedEvent value)?  shakeDetected,TResult? Function( RealtimeEstimatedIntensityUpsertEvent value)?  estimatedIntensityUpsert,}){
final _that = this;
switch (_that) {
case RealtimeReadyEvent() when ready != null:
return ready(_that);case RealtimeEewUpsertEvent() when eewUpsert != null:
return eewUpsert(_that);case RealtimeEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that);case RealtimeEarthquakeDeleteEvent() when earthquakeDelete != null:
return earthquakeDelete(_that);case RealtimeTsunamiUpsertEvent() when tsunamiUpsert != null:
return tsunamiUpsert(_that);case RealtimeTsunamiDeleteEvent() when tsunamiDelete != null:
return tsunamiDelete(_that);case RealtimeShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that);case RealtimeEstimatedIntensityUpsertEvent() when estimatedIntensityUpsert != null:
return estimatedIntensityUpsert(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( RealtimeSource source)?  ready,TResult Function( EewItemWithRelations item,  RealtimeSource source)?  eewUpsert,TResult Function( EarthquakePartial record,  RealtimeSource source)?  earthquakeUpsert,TResult Function( String eventId,  RealtimeSource source)?  earthquakeDelete,TResult Function( String eventId,  RealtimeSource source,  String? groupId)?  tsunamiUpsert,TResult Function( String eventId,  RealtimeSource source,  String? groupId)?  tsunamiDelete,TResult Function( RealtimeShakeData data,  RealtimeSource source)?  shakeDetected,TResult Function( String eventId,  String estimatedIntensityTile,  RealtimeSource source)?  estimatedIntensityUpsert,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RealtimeReadyEvent() when ready != null:
return ready(_that.source);case RealtimeEewUpsertEvent() when eewUpsert != null:
return eewUpsert(_that.item,_that.source);case RealtimeEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that.record,_that.source);case RealtimeEarthquakeDeleteEvent() when earthquakeDelete != null:
return earthquakeDelete(_that.eventId,_that.source);case RealtimeTsunamiUpsertEvent() when tsunamiUpsert != null:
return tsunamiUpsert(_that.eventId,_that.source,_that.groupId);case RealtimeTsunamiDeleteEvent() when tsunamiDelete != null:
return tsunamiDelete(_that.eventId,_that.source,_that.groupId);case RealtimeShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that.data,_that.source);case RealtimeEstimatedIntensityUpsertEvent() when estimatedIntensityUpsert != null:
return estimatedIntensityUpsert(_that.eventId,_that.estimatedIntensityTile,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RealtimeSource source)  ready,required TResult Function( EewItemWithRelations item,  RealtimeSource source)  eewUpsert,required TResult Function( EarthquakePartial record,  RealtimeSource source)  earthquakeUpsert,required TResult Function( String eventId,  RealtimeSource source)  earthquakeDelete,required TResult Function( String eventId,  RealtimeSource source,  String? groupId)  tsunamiUpsert,required TResult Function( String eventId,  RealtimeSource source,  String? groupId)  tsunamiDelete,required TResult Function( RealtimeShakeData data,  RealtimeSource source)  shakeDetected,required TResult Function( String eventId,  String estimatedIntensityTile,  RealtimeSource source)  estimatedIntensityUpsert,}) {final _that = this;
switch (_that) {
case RealtimeReadyEvent():
return ready(_that.source);case RealtimeEewUpsertEvent():
return eewUpsert(_that.item,_that.source);case RealtimeEarthquakeUpsertEvent():
return earthquakeUpsert(_that.record,_that.source);case RealtimeEarthquakeDeleteEvent():
return earthquakeDelete(_that.eventId,_that.source);case RealtimeTsunamiUpsertEvent():
return tsunamiUpsert(_that.eventId,_that.source,_that.groupId);case RealtimeTsunamiDeleteEvent():
return tsunamiDelete(_that.eventId,_that.source,_that.groupId);case RealtimeShakeDetectedEvent():
return shakeDetected(_that.data,_that.source);case RealtimeEstimatedIntensityUpsertEvent():
return estimatedIntensityUpsert(_that.eventId,_that.estimatedIntensityTile,_that.source);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RealtimeSource source)?  ready,TResult? Function( EewItemWithRelations item,  RealtimeSource source)?  eewUpsert,TResult? Function( EarthquakePartial record,  RealtimeSource source)?  earthquakeUpsert,TResult? Function( String eventId,  RealtimeSource source)?  earthquakeDelete,TResult? Function( String eventId,  RealtimeSource source,  String? groupId)?  tsunamiUpsert,TResult? Function( String eventId,  RealtimeSource source,  String? groupId)?  tsunamiDelete,TResult? Function( RealtimeShakeData data,  RealtimeSource source)?  shakeDetected,TResult? Function( String eventId,  String estimatedIntensityTile,  RealtimeSource source)?  estimatedIntensityUpsert,}) {final _that = this;
switch (_that) {
case RealtimeReadyEvent() when ready != null:
return ready(_that.source);case RealtimeEewUpsertEvent() when eewUpsert != null:
return eewUpsert(_that.item,_that.source);case RealtimeEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that.record,_that.source);case RealtimeEarthquakeDeleteEvent() when earthquakeDelete != null:
return earthquakeDelete(_that.eventId,_that.source);case RealtimeTsunamiUpsertEvent() when tsunamiUpsert != null:
return tsunamiUpsert(_that.eventId,_that.source,_that.groupId);case RealtimeTsunamiDeleteEvent() when tsunamiDelete != null:
return tsunamiDelete(_that.eventId,_that.source,_that.groupId);case RealtimeShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that.data,_that.source);case RealtimeEstimatedIntensityUpsertEvent() when estimatedIntensityUpsert != null:
return estimatedIntensityUpsert(_that.eventId,_that.estimatedIntensityTile,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class RealtimeReadyEvent implements RealtimeEvent {
  const RealtimeReadyEvent({required this.source, final  String? $type}): $type = $type ?? 'ready';
  factory RealtimeReadyEvent.fromJson(Map<String, dynamic> json) => _$RealtimeReadyEventFromJson(json);

@override final  RealtimeSource source;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeReadyEventCopyWith<RealtimeReadyEvent> get copyWith => _$RealtimeReadyEventCopyWithImpl<RealtimeReadyEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeReadyEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeReadyEvent&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source);

@override
String toString() {
  return 'RealtimeEvent.ready(source: $source)';
}


}

/// @nodoc
abstract mixin class $RealtimeReadyEventCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeReadyEventCopyWith(RealtimeReadyEvent value, $Res Function(RealtimeReadyEvent) _then) = _$RealtimeReadyEventCopyWithImpl;
@override @useResult
$Res call({
 RealtimeSource source
});




}
/// @nodoc
class _$RealtimeReadyEventCopyWithImpl<$Res>
    implements $RealtimeReadyEventCopyWith<$Res> {
  _$RealtimeReadyEventCopyWithImpl(this._self, this._then);

  final RealtimeReadyEvent _self;
  final $Res Function(RealtimeReadyEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,}) {
  return _then(RealtimeReadyEvent(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RealtimeSource,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RealtimeEewUpsertEvent implements RealtimeEvent {
  const RealtimeEewUpsertEvent({required this.item, required this.source, final  String? $type}): $type = $type ?? 'eewUpsert';
  factory RealtimeEewUpsertEvent.fromJson(Map<String, dynamic> json) => _$RealtimeEewUpsertEventFromJson(json);

 final  EewItemWithRelations item;
@override final  RealtimeSource source;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeEewUpsertEventCopyWith<RealtimeEewUpsertEvent> get copyWith => _$RealtimeEewUpsertEventCopyWithImpl<RealtimeEewUpsertEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeEewUpsertEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEewUpsertEvent&&const DeepCollectionEquality().equals(other.item, item)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(item),source);

@override
String toString() {
  return 'RealtimeEvent.eewUpsert(item: $item, source: $source)';
}


}

/// @nodoc
abstract mixin class $RealtimeEewUpsertEventCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeEewUpsertEventCopyWith(RealtimeEewUpsertEvent value, $Res Function(RealtimeEewUpsertEvent) _then) = _$RealtimeEewUpsertEventCopyWithImpl;
@override @useResult
$Res call({
 EewItemWithRelations item, RealtimeSource source
});




}
/// @nodoc
class _$RealtimeEewUpsertEventCopyWithImpl<$Res>
    implements $RealtimeEewUpsertEventCopyWith<$Res> {
  _$RealtimeEewUpsertEventCopyWithImpl(this._self, this._then);

  final RealtimeEewUpsertEvent _self;
  final $Res Function(RealtimeEewUpsertEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = freezed,Object? source = null,}) {
  return _then(RealtimeEewUpsertEvent(
item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as EewItemWithRelations,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RealtimeSource,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RealtimeEarthquakeUpsertEvent implements RealtimeEvent {
  const RealtimeEarthquakeUpsertEvent({required this.record, required this.source, final  String? $type}): $type = $type ?? 'earthquakeUpsert';
  factory RealtimeEarthquakeUpsertEvent.fromJson(Map<String, dynamic> json) => _$RealtimeEarthquakeUpsertEventFromJson(json);

 final  EarthquakePartial record;
@override final  RealtimeSource source;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeEarthquakeUpsertEventCopyWith<RealtimeEarthquakeUpsertEvent> get copyWith => _$RealtimeEarthquakeUpsertEventCopyWithImpl<RealtimeEarthquakeUpsertEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeEarthquakeUpsertEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEarthquakeUpsertEvent&&const DeepCollectionEquality().equals(other.record, record)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(record),source);

@override
String toString() {
  return 'RealtimeEvent.earthquakeUpsert(record: $record, source: $source)';
}


}

/// @nodoc
abstract mixin class $RealtimeEarthquakeUpsertEventCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeEarthquakeUpsertEventCopyWith(RealtimeEarthquakeUpsertEvent value, $Res Function(RealtimeEarthquakeUpsertEvent) _then) = _$RealtimeEarthquakeUpsertEventCopyWithImpl;
@override @useResult
$Res call({
 EarthquakePartial record, RealtimeSource source
});




}
/// @nodoc
class _$RealtimeEarthquakeUpsertEventCopyWithImpl<$Res>
    implements $RealtimeEarthquakeUpsertEventCopyWith<$Res> {
  _$RealtimeEarthquakeUpsertEventCopyWithImpl(this._self, this._then);

  final RealtimeEarthquakeUpsertEvent _self;
  final $Res Function(RealtimeEarthquakeUpsertEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? record = freezed,Object? source = null,}) {
  return _then(RealtimeEarthquakeUpsertEvent(
record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RealtimeSource,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RealtimeEarthquakeDeleteEvent implements RealtimeEvent {
  const RealtimeEarthquakeDeleteEvent({required this.eventId, required this.source, final  String? $type}): $type = $type ?? 'earthquakeDelete';
  factory RealtimeEarthquakeDeleteEvent.fromJson(Map<String, dynamic> json) => _$RealtimeEarthquakeDeleteEventFromJson(json);

 final  String eventId;
@override final  RealtimeSource source;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeEarthquakeDeleteEventCopyWith<RealtimeEarthquakeDeleteEvent> get copyWith => _$RealtimeEarthquakeDeleteEventCopyWithImpl<RealtimeEarthquakeDeleteEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeEarthquakeDeleteEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEarthquakeDeleteEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,source);

@override
String toString() {
  return 'RealtimeEvent.earthquakeDelete(eventId: $eventId, source: $source)';
}


}

/// @nodoc
abstract mixin class $RealtimeEarthquakeDeleteEventCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeEarthquakeDeleteEventCopyWith(RealtimeEarthquakeDeleteEvent value, $Res Function(RealtimeEarthquakeDeleteEvent) _then) = _$RealtimeEarthquakeDeleteEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, RealtimeSource source
});




}
/// @nodoc
class _$RealtimeEarthquakeDeleteEventCopyWithImpl<$Res>
    implements $RealtimeEarthquakeDeleteEventCopyWith<$Res> {
  _$RealtimeEarthquakeDeleteEventCopyWithImpl(this._self, this._then);

  final RealtimeEarthquakeDeleteEvent _self;
  final $Res Function(RealtimeEarthquakeDeleteEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? source = null,}) {
  return _then(RealtimeEarthquakeDeleteEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RealtimeSource,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RealtimeTsunamiUpsertEvent implements RealtimeEvent {
  const RealtimeTsunamiUpsertEvent({required this.eventId, required this.source, this.groupId, final  String? $type}): $type = $type ?? 'tsunamiUpsert';
  factory RealtimeTsunamiUpsertEvent.fromJson(Map<String, dynamic> json) => _$RealtimeTsunamiUpsertEventFromJson(json);

 final  String eventId;
@override final  RealtimeSource source;
 final  String? groupId;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTsunamiUpsertEventCopyWith<RealtimeTsunamiUpsertEvent> get copyWith => _$RealtimeTsunamiUpsertEventCopyWithImpl<RealtimeTsunamiUpsertEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeTsunamiUpsertEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTsunamiUpsertEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.source, source) || other.source == source)&&(identical(other.groupId, groupId) || other.groupId == groupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,source,groupId);

@override
String toString() {
  return 'RealtimeEvent.tsunamiUpsert(eventId: $eventId, source: $source, groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class $RealtimeTsunamiUpsertEventCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTsunamiUpsertEventCopyWith(RealtimeTsunamiUpsertEvent value, $Res Function(RealtimeTsunamiUpsertEvent) _then) = _$RealtimeTsunamiUpsertEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, RealtimeSource source, String? groupId
});




}
/// @nodoc
class _$RealtimeTsunamiUpsertEventCopyWithImpl<$Res>
    implements $RealtimeTsunamiUpsertEventCopyWith<$Res> {
  _$RealtimeTsunamiUpsertEventCopyWithImpl(this._self, this._then);

  final RealtimeTsunamiUpsertEvent _self;
  final $Res Function(RealtimeTsunamiUpsertEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? source = null,Object? groupId = freezed,}) {
  return _then(RealtimeTsunamiUpsertEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RealtimeSource,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RealtimeTsunamiDeleteEvent implements RealtimeEvent {
  const RealtimeTsunamiDeleteEvent({required this.eventId, required this.source, this.groupId, final  String? $type}): $type = $type ?? 'tsunamiDelete';
  factory RealtimeTsunamiDeleteEvent.fromJson(Map<String, dynamic> json) => _$RealtimeTsunamiDeleteEventFromJson(json);

 final  String eventId;
@override final  RealtimeSource source;
 final  String? groupId;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTsunamiDeleteEventCopyWith<RealtimeTsunamiDeleteEvent> get copyWith => _$RealtimeTsunamiDeleteEventCopyWithImpl<RealtimeTsunamiDeleteEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeTsunamiDeleteEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTsunamiDeleteEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.source, source) || other.source == source)&&(identical(other.groupId, groupId) || other.groupId == groupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,source,groupId);

@override
String toString() {
  return 'RealtimeEvent.tsunamiDelete(eventId: $eventId, source: $source, groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class $RealtimeTsunamiDeleteEventCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTsunamiDeleteEventCopyWith(RealtimeTsunamiDeleteEvent value, $Res Function(RealtimeTsunamiDeleteEvent) _then) = _$RealtimeTsunamiDeleteEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, RealtimeSource source, String? groupId
});




}
/// @nodoc
class _$RealtimeTsunamiDeleteEventCopyWithImpl<$Res>
    implements $RealtimeTsunamiDeleteEventCopyWith<$Res> {
  _$RealtimeTsunamiDeleteEventCopyWithImpl(this._self, this._then);

  final RealtimeTsunamiDeleteEvent _self;
  final $Res Function(RealtimeTsunamiDeleteEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? source = null,Object? groupId = freezed,}) {
  return _then(RealtimeTsunamiDeleteEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RealtimeSource,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RealtimeShakeDetectedEvent implements RealtimeEvent {
  const RealtimeShakeDetectedEvent({required this.data, required this.source, final  String? $type}): $type = $type ?? 'shakeDetected';
  factory RealtimeShakeDetectedEvent.fromJson(Map<String, dynamic> json) => _$RealtimeShakeDetectedEventFromJson(json);

 final  RealtimeShakeData data;
@override final  RealtimeSource source;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeShakeDetectedEventCopyWith<RealtimeShakeDetectedEvent> get copyWith => _$RealtimeShakeDetectedEventCopyWithImpl<RealtimeShakeDetectedEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeShakeDetectedEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeShakeDetectedEvent&&(identical(other.data, data) || other.data == data)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data,source);

@override
String toString() {
  return 'RealtimeEvent.shakeDetected(data: $data, source: $source)';
}


}

/// @nodoc
abstract mixin class $RealtimeShakeDetectedEventCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeShakeDetectedEventCopyWith(RealtimeShakeDetectedEvent value, $Res Function(RealtimeShakeDetectedEvent) _then) = _$RealtimeShakeDetectedEventCopyWithImpl;
@override @useResult
$Res call({
 RealtimeShakeData data, RealtimeSource source
});


$RealtimeShakeDataCopyWith<$Res> get data;

}
/// @nodoc
class _$RealtimeShakeDetectedEventCopyWithImpl<$Res>
    implements $RealtimeShakeDetectedEventCopyWith<$Res> {
  _$RealtimeShakeDetectedEventCopyWithImpl(this._self, this._then);

  final RealtimeShakeDetectedEvent _self;
  final $Res Function(RealtimeShakeDetectedEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? source = null,}) {
  return _then(RealtimeShakeDetectedEvent(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RealtimeShakeData,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RealtimeSource,
  ));
}

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RealtimeShakeDataCopyWith<$Res> get data {
  
  return $RealtimeShakeDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class RealtimeEstimatedIntensityUpsertEvent implements RealtimeEvent {
  const RealtimeEstimatedIntensityUpsertEvent({required this.eventId, required this.estimatedIntensityTile, required this.source, final  String? $type}): $type = $type ?? 'estimatedIntensityUpsert';
  factory RealtimeEstimatedIntensityUpsertEvent.fromJson(Map<String, dynamic> json) => _$RealtimeEstimatedIntensityUpsertEventFromJson(json);

 final  String eventId;
 final  String estimatedIntensityTile;
@override final  RealtimeSource source;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeEstimatedIntensityUpsertEventCopyWith<RealtimeEstimatedIntensityUpsertEvent> get copyWith => _$RealtimeEstimatedIntensityUpsertEventCopyWithImpl<RealtimeEstimatedIntensityUpsertEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeEstimatedIntensityUpsertEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEstimatedIntensityUpsertEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.estimatedIntensityTile, estimatedIntensityTile) || other.estimatedIntensityTile == estimatedIntensityTile)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,estimatedIntensityTile,source);

@override
String toString() {
  return 'RealtimeEvent.estimatedIntensityUpsert(eventId: $eventId, estimatedIntensityTile: $estimatedIntensityTile, source: $source)';
}


}

/// @nodoc
abstract mixin class $RealtimeEstimatedIntensityUpsertEventCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeEstimatedIntensityUpsertEventCopyWith(RealtimeEstimatedIntensityUpsertEvent value, $Res Function(RealtimeEstimatedIntensityUpsertEvent) _then) = _$RealtimeEstimatedIntensityUpsertEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String estimatedIntensityTile, RealtimeSource source
});




}
/// @nodoc
class _$RealtimeEstimatedIntensityUpsertEventCopyWithImpl<$Res>
    implements $RealtimeEstimatedIntensityUpsertEventCopyWith<$Res> {
  _$RealtimeEstimatedIntensityUpsertEventCopyWithImpl(this._self, this._then);

  final RealtimeEstimatedIntensityUpsertEvent _self;
  final $Res Function(RealtimeEstimatedIntensityUpsertEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? estimatedIntensityTile = null,Object? source = null,}) {
  return _then(RealtimeEstimatedIntensityUpsertEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,estimatedIntensityTile: null == estimatedIntensityTile ? _self.estimatedIntensityTile : estimatedIntensityTile // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RealtimeSource,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_event_envelope.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
RealtimeEventEnvelope _$RealtimeEventEnvelopeFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'EEW':
          return WsEewRealtimeEvent.fromJson(
            json
          );
                case 'EARTHQUAKE':
          return WsEarthquakeBroadcastEvent.fromJson(
            json
          );
                case 'earthquake':
          return WsEarthquakeRealtimeEvent.fromJson(
            json
          );
                case 'tsunami':
          return WsTsunamiRealtimeEvent.fromJson(
            json
          );
                case 'shake_detected':
          return WsShakeDetectedRealtimeEvent.fromJson(
            json
          );
                case 'ESTIMATED_INTENSITY':
          return WsEstimatedIntensityRealtimeEvent.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'RealtimeEventEnvelope',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$RealtimeEventEnvelope {



  /// Serializes this RealtimeEventEnvelope to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEventEnvelope);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RealtimeEventEnvelope()';
}


}

/// @nodoc
class $RealtimeEventEnvelopeCopyWith<$Res>  {
$RealtimeEventEnvelopeCopyWith(RealtimeEventEnvelope _, $Res Function(RealtimeEventEnvelope) __);
}


/// Adds pattern-matching-related methods to [RealtimeEventEnvelope].
extension RealtimeEventEnvelopePatterns on RealtimeEventEnvelope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WsEewRealtimeEvent value)?  eew,TResult Function( WsEarthquakeBroadcastEvent value)?  earthquakeBroadcast,TResult Function( WsEarthquakeRealtimeEvent value)?  earthquake,TResult Function( WsTsunamiRealtimeEvent value)?  tsunami,TResult Function( WsShakeDetectedRealtimeEvent value)?  shakeDetected,TResult Function( WsEstimatedIntensityRealtimeEvent value)?  estimatedIntensity,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WsEewRealtimeEvent() when eew != null:
return eew(_that);case WsEarthquakeBroadcastEvent() when earthquakeBroadcast != null:
return earthquakeBroadcast(_that);case WsEarthquakeRealtimeEvent() when earthquake != null:
return earthquake(_that);case WsTsunamiRealtimeEvent() when tsunami != null:
return tsunami(_that);case WsShakeDetectedRealtimeEvent() when shakeDetected != null:
return shakeDetected(_that);case WsEstimatedIntensityRealtimeEvent() when estimatedIntensity != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WsEewRealtimeEvent value)  eew,required TResult Function( WsEarthquakeBroadcastEvent value)  earthquakeBroadcast,required TResult Function( WsEarthquakeRealtimeEvent value)  earthquake,required TResult Function( WsTsunamiRealtimeEvent value)  tsunami,required TResult Function( WsShakeDetectedRealtimeEvent value)  shakeDetected,required TResult Function( WsEstimatedIntensityRealtimeEvent value)  estimatedIntensity,}){
final _that = this;
switch (_that) {
case WsEewRealtimeEvent():
return eew(_that);case WsEarthquakeBroadcastEvent():
return earthquakeBroadcast(_that);case WsEarthquakeRealtimeEvent():
return earthquake(_that);case WsTsunamiRealtimeEvent():
return tsunami(_that);case WsShakeDetectedRealtimeEvent():
return shakeDetected(_that);case WsEstimatedIntensityRealtimeEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WsEewRealtimeEvent value)?  eew,TResult? Function( WsEarthquakeBroadcastEvent value)?  earthquakeBroadcast,TResult? Function( WsEarthquakeRealtimeEvent value)?  earthquake,TResult? Function( WsTsunamiRealtimeEvent value)?  tsunami,TResult? Function( WsShakeDetectedRealtimeEvent value)?  shakeDetected,TResult? Function( WsEstimatedIntensityRealtimeEvent value)?  estimatedIntensity,}){
final _that = this;
switch (_that) {
case WsEewRealtimeEvent() when eew != null:
return eew(_that);case WsEarthquakeBroadcastEvent() when earthquakeBroadcast != null:
return earthquakeBroadcast(_that);case WsEarthquakeRealtimeEvent() when earthquake != null:
return earthquake(_that);case WsTsunamiRealtimeEvent() when tsunami != null:
return tsunami(_that);case WsShakeDetectedRealtimeEvent() when shakeDetected != null:
return shakeDetected(_that);case WsEstimatedIntensityRealtimeEvent() when estimatedIntensity != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( EewItemWithRelations item)?  eew,TResult Function( EarthquakePartial item)?  earthquakeBroadcast,TResult Function( String operation, @JsonKey(name: 'event_id')  String eventId,  EarthquakePartial? record)?  earthquake,TResult Function( String operation, @JsonKey(name: 'event_id')  String eventId,  Map<String, dynamic>? record)?  tsunami,TResult Function( String eventId,  DateTime createdAt,  String level,  List<String> changeReasons,  bool isReplay,  int pointCount,  WsShakeRegionPayload region)?  shakeDetected,TResult Function( WsEstimatedIntensityPayload estimatedIntensity)?  estimatedIntensity,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WsEewRealtimeEvent() when eew != null:
return eew(_that.item);case WsEarthquakeBroadcastEvent() when earthquakeBroadcast != null:
return earthquakeBroadcast(_that.item);case WsEarthquakeRealtimeEvent() when earthquake != null:
return earthquake(_that.operation,_that.eventId,_that.record);case WsTsunamiRealtimeEvent() when tsunami != null:
return tsunami(_that.operation,_that.eventId,_that.record);case WsShakeDetectedRealtimeEvent() when shakeDetected != null:
return shakeDetected(_that.eventId,_that.createdAt,_that.level,_that.changeReasons,_that.isReplay,_that.pointCount,_that.region);case WsEstimatedIntensityRealtimeEvent() when estimatedIntensity != null:
return estimatedIntensity(_that.estimatedIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( EewItemWithRelations item)  eew,required TResult Function( EarthquakePartial item)  earthquakeBroadcast,required TResult Function( String operation, @JsonKey(name: 'event_id')  String eventId,  EarthquakePartial? record)  earthquake,required TResult Function( String operation, @JsonKey(name: 'event_id')  String eventId,  Map<String, dynamic>? record)  tsunami,required TResult Function( String eventId,  DateTime createdAt,  String level,  List<String> changeReasons,  bool isReplay,  int pointCount,  WsShakeRegionPayload region)  shakeDetected,required TResult Function( WsEstimatedIntensityPayload estimatedIntensity)  estimatedIntensity,}) {final _that = this;
switch (_that) {
case WsEewRealtimeEvent():
return eew(_that.item);case WsEarthquakeBroadcastEvent():
return earthquakeBroadcast(_that.item);case WsEarthquakeRealtimeEvent():
return earthquake(_that.operation,_that.eventId,_that.record);case WsTsunamiRealtimeEvent():
return tsunami(_that.operation,_that.eventId,_that.record);case WsShakeDetectedRealtimeEvent():
return shakeDetected(_that.eventId,_that.createdAt,_that.level,_that.changeReasons,_that.isReplay,_that.pointCount,_that.region);case WsEstimatedIntensityRealtimeEvent():
return estimatedIntensity(_that.estimatedIntensity);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( EewItemWithRelations item)?  eew,TResult? Function( EarthquakePartial item)?  earthquakeBroadcast,TResult? Function( String operation, @JsonKey(name: 'event_id')  String eventId,  EarthquakePartial? record)?  earthquake,TResult? Function( String operation, @JsonKey(name: 'event_id')  String eventId,  Map<String, dynamic>? record)?  tsunami,TResult? Function( String eventId,  DateTime createdAt,  String level,  List<String> changeReasons,  bool isReplay,  int pointCount,  WsShakeRegionPayload region)?  shakeDetected,TResult? Function( WsEstimatedIntensityPayload estimatedIntensity)?  estimatedIntensity,}) {final _that = this;
switch (_that) {
case WsEewRealtimeEvent() when eew != null:
return eew(_that.item);case WsEarthquakeBroadcastEvent() when earthquakeBroadcast != null:
return earthquakeBroadcast(_that.item);case WsEarthquakeRealtimeEvent() when earthquake != null:
return earthquake(_that.operation,_that.eventId,_that.record);case WsTsunamiRealtimeEvent() when tsunami != null:
return tsunami(_that.operation,_that.eventId,_that.record);case WsShakeDetectedRealtimeEvent() when shakeDetected != null:
return shakeDetected(_that.eventId,_that.createdAt,_that.level,_that.changeReasons,_that.isReplay,_that.pointCount,_that.region);case WsEstimatedIntensityRealtimeEvent() when estimatedIntensity != null:
return estimatedIntensity(_that.estimatedIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class WsEewRealtimeEvent implements RealtimeEventEnvelope {
  const WsEewRealtimeEvent({required this.item, final  String? $type}): $type = $type ?? 'EEW';
  factory WsEewRealtimeEvent.fromJson(Map<String, dynamic> json) => _$WsEewRealtimeEventFromJson(json);

 final  EewItemWithRelations item;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsEewRealtimeEventCopyWith<WsEewRealtimeEvent> get copyWith => _$WsEewRealtimeEventCopyWithImpl<WsEewRealtimeEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsEewRealtimeEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsEewRealtimeEvent&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'RealtimeEventEnvelope.eew(item: $item)';
}


}

/// @nodoc
abstract mixin class $WsEewRealtimeEventCopyWith<$Res> implements $RealtimeEventEnvelopeCopyWith<$Res> {
  factory $WsEewRealtimeEventCopyWith(WsEewRealtimeEvent value, $Res Function(WsEewRealtimeEvent) _then) = _$WsEewRealtimeEventCopyWithImpl;
@useResult
$Res call({
 EewItemWithRelations item
});


$EewItemWithRelationsCopyWith<$Res> get item;

}
/// @nodoc
class _$WsEewRealtimeEventCopyWithImpl<$Res>
    implements $WsEewRealtimeEventCopyWith<$Res> {
  _$WsEewRealtimeEventCopyWithImpl(this._self, this._then);

  final WsEewRealtimeEvent _self;
  final $Res Function(WsEewRealtimeEvent) _then;

/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(WsEewRealtimeEvent(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as EewItemWithRelations,
  ));
}

/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewItemWithRelationsCopyWith<$Res> get item {
  
  return $EewItemWithRelationsCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class WsEarthquakeBroadcastEvent implements RealtimeEventEnvelope {
  const WsEarthquakeBroadcastEvent({required this.item, final  String? $type}): $type = $type ?? 'EARTHQUAKE';
  factory WsEarthquakeBroadcastEvent.fromJson(Map<String, dynamic> json) => _$WsEarthquakeBroadcastEventFromJson(json);

 final  EarthquakePartial item;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsEarthquakeBroadcastEventCopyWith<WsEarthquakeBroadcastEvent> get copyWith => _$WsEarthquakeBroadcastEventCopyWithImpl<WsEarthquakeBroadcastEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsEarthquakeBroadcastEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsEarthquakeBroadcastEvent&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'RealtimeEventEnvelope.earthquakeBroadcast(item: $item)';
}


}

/// @nodoc
abstract mixin class $WsEarthquakeBroadcastEventCopyWith<$Res> implements $RealtimeEventEnvelopeCopyWith<$Res> {
  factory $WsEarthquakeBroadcastEventCopyWith(WsEarthquakeBroadcastEvent value, $Res Function(WsEarthquakeBroadcastEvent) _then) = _$WsEarthquakeBroadcastEventCopyWithImpl;
@useResult
$Res call({
 EarthquakePartial item
});


$EarthquakePartialCopyWith<$Res> get item;

}
/// @nodoc
class _$WsEarthquakeBroadcastEventCopyWithImpl<$Res>
    implements $WsEarthquakeBroadcastEventCopyWith<$Res> {
  _$WsEarthquakeBroadcastEventCopyWithImpl(this._self, this._then);

  final WsEarthquakeBroadcastEvent _self;
  final $Res Function(WsEarthquakeBroadcastEvent) _then;

/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(WsEarthquakeBroadcastEvent(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get item {
  
  return $EarthquakePartialCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class WsEarthquakeRealtimeEvent implements RealtimeEventEnvelope {
  const WsEarthquakeRealtimeEvent({required this.operation, @JsonKey(name: 'event_id') required this.eventId, this.record, final  String? $type}): $type = $type ?? 'earthquake';
  factory WsEarthquakeRealtimeEvent.fromJson(Map<String, dynamic> json) => _$WsEarthquakeRealtimeEventFromJson(json);

 final  String operation;
@JsonKey(name: 'event_id') final  String eventId;
 final  EarthquakePartial? record;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsEarthquakeRealtimeEventCopyWith<WsEarthquakeRealtimeEvent> get copyWith => _$WsEarthquakeRealtimeEventCopyWithImpl<WsEarthquakeRealtimeEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsEarthquakeRealtimeEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsEarthquakeRealtimeEvent&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.record, record) || other.record == record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operation,eventId,record);

@override
String toString() {
  return 'RealtimeEventEnvelope.earthquake(operation: $operation, eventId: $eventId, record: $record)';
}


}

/// @nodoc
abstract mixin class $WsEarthquakeRealtimeEventCopyWith<$Res> implements $RealtimeEventEnvelopeCopyWith<$Res> {
  factory $WsEarthquakeRealtimeEventCopyWith(WsEarthquakeRealtimeEvent value, $Res Function(WsEarthquakeRealtimeEvent) _then) = _$WsEarthquakeRealtimeEventCopyWithImpl;
@useResult
$Res call({
 String operation,@JsonKey(name: 'event_id') String eventId, EarthquakePartial? record
});


$EarthquakePartialCopyWith<$Res>? get record;

}
/// @nodoc
class _$WsEarthquakeRealtimeEventCopyWithImpl<$Res>
    implements $WsEarthquakeRealtimeEventCopyWith<$Res> {
  _$WsEarthquakeRealtimeEventCopyWithImpl(this._self, this._then);

  final WsEarthquakeRealtimeEvent _self;
  final $Res Function(WsEarthquakeRealtimeEvent) _then;

/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? operation = null,Object? eventId = null,Object? record = freezed,}) {
  return _then(WsEarthquakeRealtimeEvent(
operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as EarthquakePartial?,
  ));
}

/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res>? get record {
    if (_self.record == null) {
    return null;
  }

  return $EarthquakePartialCopyWith<$Res>(_self.record!, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class WsTsunamiRealtimeEvent implements RealtimeEventEnvelope {
  const WsTsunamiRealtimeEvent({required this.operation, @JsonKey(name: 'event_id') required this.eventId, final  Map<String, dynamic>? record, final  String? $type}): _record = record,$type = $type ?? 'tsunami';
  factory WsTsunamiRealtimeEvent.fromJson(Map<String, dynamic> json) => _$WsTsunamiRealtimeEventFromJson(json);

 final  String operation;
@JsonKey(name: 'event_id') final  String eventId;
 final  Map<String, dynamic>? _record;
 Map<String, dynamic>? get record {
  final value = _record;
  if (value == null) return null;
  if (_record is EqualUnmodifiableMapView) return _record;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsTsunamiRealtimeEventCopyWith<WsTsunamiRealtimeEvent> get copyWith => _$WsTsunamiRealtimeEventCopyWithImpl<WsTsunamiRealtimeEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsTsunamiRealtimeEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsTsunamiRealtimeEvent&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&const DeepCollectionEquality().equals(other._record, _record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operation,eventId,const DeepCollectionEquality().hash(_record));

@override
String toString() {
  return 'RealtimeEventEnvelope.tsunami(operation: $operation, eventId: $eventId, record: $record)';
}


}

/// @nodoc
abstract mixin class $WsTsunamiRealtimeEventCopyWith<$Res> implements $RealtimeEventEnvelopeCopyWith<$Res> {
  factory $WsTsunamiRealtimeEventCopyWith(WsTsunamiRealtimeEvent value, $Res Function(WsTsunamiRealtimeEvent) _then) = _$WsTsunamiRealtimeEventCopyWithImpl;
@useResult
$Res call({
 String operation,@JsonKey(name: 'event_id') String eventId, Map<String, dynamic>? record
});




}
/// @nodoc
class _$WsTsunamiRealtimeEventCopyWithImpl<$Res>
    implements $WsTsunamiRealtimeEventCopyWith<$Res> {
  _$WsTsunamiRealtimeEventCopyWithImpl(this._self, this._then);

  final WsTsunamiRealtimeEvent _self;
  final $Res Function(WsTsunamiRealtimeEvent) _then;

/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? operation = null,Object? eventId = null,Object? record = freezed,}) {
  return _then(WsTsunamiRealtimeEvent(
operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,record: freezed == record ? _self._record : record // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class WsShakeDetectedRealtimeEvent implements RealtimeEventEnvelope {
  const WsShakeDetectedRealtimeEvent({required this.eventId, required this.createdAt, required this.level, final  List<String> changeReasons = const [], required this.isReplay, required this.pointCount, required this.region, final  String? $type}): _changeReasons = changeReasons,$type = $type ?? 'shake_detected';
  factory WsShakeDetectedRealtimeEvent.fromJson(Map<String, dynamic> json) => _$WsShakeDetectedRealtimeEventFromJson(json);

 final  String eventId;
 final  DateTime createdAt;
 final  String level;
 final  List<String> _changeReasons;
@JsonKey() List<String> get changeReasons {
  if (_changeReasons is EqualUnmodifiableListView) return _changeReasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_changeReasons);
}

 final  bool isReplay;
 final  int pointCount;
 final  WsShakeRegionPayload region;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsShakeDetectedRealtimeEventCopyWith<WsShakeDetectedRealtimeEvent> get copyWith => _$WsShakeDetectedRealtimeEventCopyWithImpl<WsShakeDetectedRealtimeEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsShakeDetectedRealtimeEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsShakeDetectedRealtimeEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other._changeReasons, _changeReasons)&&(identical(other.isReplay, isReplay) || other.isReplay == isReplay)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.region, region) || other.region == region));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,createdAt,level,const DeepCollectionEquality().hash(_changeReasons),isReplay,pointCount,region);

@override
String toString() {
  return 'RealtimeEventEnvelope.shakeDetected(eventId: $eventId, createdAt: $createdAt, level: $level, changeReasons: $changeReasons, isReplay: $isReplay, pointCount: $pointCount, region: $region)';
}


}

/// @nodoc
abstract mixin class $WsShakeDetectedRealtimeEventCopyWith<$Res> implements $RealtimeEventEnvelopeCopyWith<$Res> {
  factory $WsShakeDetectedRealtimeEventCopyWith(WsShakeDetectedRealtimeEvent value, $Res Function(WsShakeDetectedRealtimeEvent) _then) = _$WsShakeDetectedRealtimeEventCopyWithImpl;
@useResult
$Res call({
 String eventId, DateTime createdAt, String level, List<String> changeReasons, bool isReplay, int pointCount, WsShakeRegionPayload region
});


$WsShakeRegionPayloadCopyWith<$Res> get region;

}
/// @nodoc
class _$WsShakeDetectedRealtimeEventCopyWithImpl<$Res>
    implements $WsShakeDetectedRealtimeEventCopyWith<$Res> {
  _$WsShakeDetectedRealtimeEventCopyWithImpl(this._self, this._then);

  final WsShakeDetectedRealtimeEvent _self;
  final $Res Function(WsShakeDetectedRealtimeEvent) _then;

/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? createdAt = null,Object? level = null,Object? changeReasons = null,Object? isReplay = null,Object? pointCount = null,Object? region = null,}) {
  return _then(WsShakeDetectedRealtimeEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,changeReasons: null == changeReasons ? _self._changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,isReplay: null == isReplay ? _self.isReplay : isReplay // ignore: cast_nullable_to_non_nullable
as bool,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as WsShakeRegionPayload,
  ));
}

/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeRegionPayloadCopyWith<$Res> get region {
  
  return $WsShakeRegionPayloadCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class WsEstimatedIntensityRealtimeEvent implements RealtimeEventEnvelope {
  const WsEstimatedIntensityRealtimeEvent({required this.estimatedIntensity, final  String? $type}): $type = $type ?? 'ESTIMATED_INTENSITY';
  factory WsEstimatedIntensityRealtimeEvent.fromJson(Map<String, dynamic> json) => _$WsEstimatedIntensityRealtimeEventFromJson(json);

 final  WsEstimatedIntensityPayload estimatedIntensity;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsEstimatedIntensityRealtimeEventCopyWith<WsEstimatedIntensityRealtimeEvent> get copyWith => _$WsEstimatedIntensityRealtimeEventCopyWithImpl<WsEstimatedIntensityRealtimeEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsEstimatedIntensityRealtimeEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsEstimatedIntensityRealtimeEvent&&(identical(other.estimatedIntensity, estimatedIntensity) || other.estimatedIntensity == estimatedIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,estimatedIntensity);

@override
String toString() {
  return 'RealtimeEventEnvelope.estimatedIntensity(estimatedIntensity: $estimatedIntensity)';
}


}

/// @nodoc
abstract mixin class $WsEstimatedIntensityRealtimeEventCopyWith<$Res> implements $RealtimeEventEnvelopeCopyWith<$Res> {
  factory $WsEstimatedIntensityRealtimeEventCopyWith(WsEstimatedIntensityRealtimeEvent value, $Res Function(WsEstimatedIntensityRealtimeEvent) _then) = _$WsEstimatedIntensityRealtimeEventCopyWithImpl;
@useResult
$Res call({
 WsEstimatedIntensityPayload estimatedIntensity
});


$WsEstimatedIntensityPayloadCopyWith<$Res> get estimatedIntensity;

}
/// @nodoc
class _$WsEstimatedIntensityRealtimeEventCopyWithImpl<$Res>
    implements $WsEstimatedIntensityRealtimeEventCopyWith<$Res> {
  _$WsEstimatedIntensityRealtimeEventCopyWithImpl(this._self, this._then);

  final WsEstimatedIntensityRealtimeEvent _self;
  final $Res Function(WsEstimatedIntensityRealtimeEvent) _then;

/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? estimatedIntensity = null,}) {
  return _then(WsEstimatedIntensityRealtimeEvent(
estimatedIntensity: null == estimatedIntensity ? _self.estimatedIntensity : estimatedIntensity // ignore: cast_nullable_to_non_nullable
as WsEstimatedIntensityPayload,
  ));
}

/// Create a copy of RealtimeEventEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsEstimatedIntensityPayloadCopyWith<$Res> get estimatedIntensity {
  
  return $WsEstimatedIntensityPayloadCopyWith<$Res>(_self.estimatedIntensity, (value) {
    return _then(_self.copyWith(estimatedIntensity: value));
  });
}
}

// dart format on

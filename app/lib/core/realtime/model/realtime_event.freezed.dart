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
                  case 'snapshot':
          return RealtimeSnapshotEvent.fromJson(
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
                case 'shakeDetected':
          return RealtimeShakeDetectedEvent.fromJson(
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RealtimeSnapshotEvent value)?  snapshot,TResult Function( RealtimeEewUpsertEvent value)?  eewUpsert,TResult Function( RealtimeEarthquakeUpsertEvent value)?  earthquakeUpsert,TResult Function( RealtimeEarthquakeDeleteEvent value)?  earthquakeDelete,TResult Function( RealtimeShakeDetectedEvent value)?  shakeDetected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RealtimeSnapshotEvent() when snapshot != null:
return snapshot(_that);case RealtimeEewUpsertEvent() when eewUpsert != null:
return eewUpsert(_that);case RealtimeEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that);case RealtimeEarthquakeDeleteEvent() when earthquakeDelete != null:
return earthquakeDelete(_that);case RealtimeShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RealtimeSnapshotEvent value)  snapshot,required TResult Function( RealtimeEewUpsertEvent value)  eewUpsert,required TResult Function( RealtimeEarthquakeUpsertEvent value)  earthquakeUpsert,required TResult Function( RealtimeEarthquakeDeleteEvent value)  earthquakeDelete,required TResult Function( RealtimeShakeDetectedEvent value)  shakeDetected,}){
final _that = this;
switch (_that) {
case RealtimeSnapshotEvent():
return snapshot(_that);case RealtimeEewUpsertEvent():
return eewUpsert(_that);case RealtimeEarthquakeUpsertEvent():
return earthquakeUpsert(_that);case RealtimeEarthquakeDeleteEvent():
return earthquakeDelete(_that);case RealtimeShakeDetectedEvent():
return shakeDetected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RealtimeSnapshotEvent value)?  snapshot,TResult? Function( RealtimeEewUpsertEvent value)?  eewUpsert,TResult? Function( RealtimeEarthquakeUpsertEvent value)?  earthquakeUpsert,TResult? Function( RealtimeEarthquakeDeleteEvent value)?  earthquakeDelete,TResult? Function( RealtimeShakeDetectedEvent value)?  shakeDetected,}){
final _that = this;
switch (_that) {
case RealtimeSnapshotEvent() when snapshot != null:
return snapshot(_that);case RealtimeEewUpsertEvent() when eewUpsert != null:
return eewUpsert(_that);case RealtimeEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that);case RealtimeEarthquakeDeleteEvent() when earthquakeDelete != null:
return earthquakeDelete(_that);case RealtimeShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<EewItemWithRelations> eews,  List<EarthquakePartial> earthquakes,  List<RealtimeShakeData> shakes,  RealtimeSource source)?  snapshot,TResult Function( EewItemWithRelations item,  RealtimeSource source)?  eewUpsert,TResult Function( EarthquakePartial record,  RealtimeSource source)?  earthquakeUpsert,TResult Function( String eventId,  RealtimeSource source)?  earthquakeDelete,TResult Function( RealtimeShakeData data,  RealtimeSource source)?  shakeDetected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RealtimeSnapshotEvent() when snapshot != null:
return snapshot(_that.eews,_that.earthquakes,_that.shakes,_that.source);case RealtimeEewUpsertEvent() when eewUpsert != null:
return eewUpsert(_that.item,_that.source);case RealtimeEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that.record,_that.source);case RealtimeEarthquakeDeleteEvent() when earthquakeDelete != null:
return earthquakeDelete(_that.eventId,_that.source);case RealtimeShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that.data,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<EewItemWithRelations> eews,  List<EarthquakePartial> earthquakes,  List<RealtimeShakeData> shakes,  RealtimeSource source)  snapshot,required TResult Function( EewItemWithRelations item,  RealtimeSource source)  eewUpsert,required TResult Function( EarthquakePartial record,  RealtimeSource source)  earthquakeUpsert,required TResult Function( String eventId,  RealtimeSource source)  earthquakeDelete,required TResult Function( RealtimeShakeData data,  RealtimeSource source)  shakeDetected,}) {final _that = this;
switch (_that) {
case RealtimeSnapshotEvent():
return snapshot(_that.eews,_that.earthquakes,_that.shakes,_that.source);case RealtimeEewUpsertEvent():
return eewUpsert(_that.item,_that.source);case RealtimeEarthquakeUpsertEvent():
return earthquakeUpsert(_that.record,_that.source);case RealtimeEarthquakeDeleteEvent():
return earthquakeDelete(_that.eventId,_that.source);case RealtimeShakeDetectedEvent():
return shakeDetected(_that.data,_that.source);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<EewItemWithRelations> eews,  List<EarthquakePartial> earthquakes,  List<RealtimeShakeData> shakes,  RealtimeSource source)?  snapshot,TResult? Function( EewItemWithRelations item,  RealtimeSource source)?  eewUpsert,TResult? Function( EarthquakePartial record,  RealtimeSource source)?  earthquakeUpsert,TResult? Function( String eventId,  RealtimeSource source)?  earthquakeDelete,TResult? Function( RealtimeShakeData data,  RealtimeSource source)?  shakeDetected,}) {final _that = this;
switch (_that) {
case RealtimeSnapshotEvent() when snapshot != null:
return snapshot(_that.eews,_that.earthquakes,_that.shakes,_that.source);case RealtimeEewUpsertEvent() when eewUpsert != null:
return eewUpsert(_that.item,_that.source);case RealtimeEarthquakeUpsertEvent() when earthquakeUpsert != null:
return earthquakeUpsert(_that.record,_that.source);case RealtimeEarthquakeDeleteEvent() when earthquakeDelete != null:
return earthquakeDelete(_that.eventId,_that.source);case RealtimeShakeDetectedEvent() when shakeDetected != null:
return shakeDetected(_that.data,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class RealtimeSnapshotEvent implements RealtimeEvent {
  const RealtimeSnapshotEvent({required final  List<EewItemWithRelations> eews, required final  List<EarthquakePartial> earthquakes, required final  List<RealtimeShakeData> shakes, required this.source, final  String? $type}): _eews = eews,_earthquakes = earthquakes,_shakes = shakes,$type = $type ?? 'snapshot';
  factory RealtimeSnapshotEvent.fromJson(Map<String, dynamic> json) => _$RealtimeSnapshotEventFromJson(json);

 final  List<EewItemWithRelations> _eews;
 List<EewItemWithRelations> get eews {
  if (_eews is EqualUnmodifiableListView) return _eews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eews);
}

 final  List<EarthquakePartial> _earthquakes;
 List<EarthquakePartial> get earthquakes {
  if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earthquakes);
}

 final  List<RealtimeShakeData> _shakes;
 List<RealtimeShakeData> get shakes {
  if (_shakes is EqualUnmodifiableListView) return _shakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shakes);
}

@override final  RealtimeSource source;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeSnapshotEventCopyWith<RealtimeSnapshotEvent> get copyWith => _$RealtimeSnapshotEventCopyWithImpl<RealtimeSnapshotEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeSnapshotEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeSnapshotEvent&&const DeepCollectionEquality().equals(other._eews, _eews)&&const DeepCollectionEquality().equals(other._earthquakes, _earthquakes)&&const DeepCollectionEquality().equals(other._shakes, _shakes)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_eews),const DeepCollectionEquality().hash(_earthquakes),const DeepCollectionEquality().hash(_shakes),source);

@override
String toString() {
  return 'RealtimeEvent.snapshot(eews: $eews, earthquakes: $earthquakes, shakes: $shakes, source: $source)';
}


}

/// @nodoc
abstract mixin class $RealtimeSnapshotEventCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeSnapshotEventCopyWith(RealtimeSnapshotEvent value, $Res Function(RealtimeSnapshotEvent) _then) = _$RealtimeSnapshotEventCopyWithImpl;
@override @useResult
$Res call({
 List<EewItemWithRelations> eews, List<EarthquakePartial> earthquakes, List<RealtimeShakeData> shakes, RealtimeSource source
});




}
/// @nodoc
class _$RealtimeSnapshotEventCopyWithImpl<$Res>
    implements $RealtimeSnapshotEventCopyWith<$Res> {
  _$RealtimeSnapshotEventCopyWithImpl(this._self, this._then);

  final RealtimeSnapshotEvent _self;
  final $Res Function(RealtimeSnapshotEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eews = null,Object? earthquakes = null,Object? shakes = null,Object? source = null,}) {
  return _then(RealtimeSnapshotEvent(
eews: null == eews ? _self._eews : eews // ignore: cast_nullable_to_non_nullable
as List<EewItemWithRelations>,earthquakes: null == earthquakes ? _self._earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,shakes: null == shakes ? _self._shakes : shakes // ignore: cast_nullable_to_non_nullable
as List<RealtimeShakeData>,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEewUpsertEvent&&(identical(other.item, item) || other.item == item)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item,source);

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


$EewItemWithRelationsCopyWith<$Res> get item;

}
/// @nodoc
class _$RealtimeEewUpsertEventCopyWithImpl<$Res>
    implements $RealtimeEewUpsertEventCopyWith<$Res> {
  _$RealtimeEewUpsertEventCopyWithImpl(this._self, this._then);

  final RealtimeEewUpsertEvent _self;
  final $Res Function(RealtimeEewUpsertEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,Object? source = null,}) {
  return _then(RealtimeEewUpsertEvent(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as EewItemWithRelations,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RealtimeSource,
  ));
}

/// Create a copy of RealtimeEvent
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEarthquakeUpsertEvent&&(identical(other.record, record) || other.record == record)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,record,source);

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


$EarthquakePartialCopyWith<$Res> get record;

}
/// @nodoc
class _$RealtimeEarthquakeUpsertEventCopyWithImpl<$Res>
    implements $RealtimeEarthquakeUpsertEventCopyWith<$Res> {
  _$RealtimeEarthquakeUpsertEventCopyWithImpl(this._self, this._then);

  final RealtimeEarthquakeUpsertEvent _self;
  final $Res Function(RealtimeEarthquakeUpsertEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? record = null,Object? source = null,}) {
  return _then(RealtimeEarthquakeUpsertEvent(
record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as RealtimeSource,
  ));
}

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get record {
  
  return $EarthquakePartialCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
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

// dart format on

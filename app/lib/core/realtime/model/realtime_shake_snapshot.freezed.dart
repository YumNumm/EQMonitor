// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_shake_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeShakeEventData {

 String get eventId; int get serialNo; DateTime get createdAt; DateTime get updatedAt; DateTime get expiresAt; String get level; int get pointCount; double get minLat; double get maxLat; double get minLng; double get maxLng; List<String> get changeReasons; String? get correlatedEewEventId;
/// Create a copy of RealtimeShakeEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeShakeEventDataCopyWith<RealtimeShakeEventData> get copyWith => _$RealtimeShakeEventDataCopyWithImpl<RealtimeShakeEventData>(this as RealtimeShakeEventData, _$identity);

  /// Serializes this RealtimeShakeEventData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeShakeEventData&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng)&&const DeepCollectionEquality().equals(other.changeReasons, changeReasons)&&(identical(other.correlatedEewEventId, correlatedEewEventId) || other.correlatedEewEventId == correlatedEewEventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo,createdAt,updatedAt,expiresAt,level,pointCount,minLat,maxLat,minLng,maxLng,const DeepCollectionEquality().hash(changeReasons),correlatedEewEventId);

@override
String toString() {
  return 'RealtimeShakeEventData(eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, pointCount: $pointCount, minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng, changeReasons: $changeReasons, correlatedEewEventId: $correlatedEewEventId)';
}


}

/// @nodoc
abstract mixin class $RealtimeShakeEventDataCopyWith<$Res>  {
  factory $RealtimeShakeEventDataCopyWith(RealtimeShakeEventData value, $Res Function(RealtimeShakeEventData) _then) = _$RealtimeShakeEventDataCopyWithImpl;
@useResult
$Res call({
 String eventId, int serialNo, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, String level, int pointCount, double minLat, double maxLat, double minLng, double maxLng, List<String> changeReasons, String? correlatedEewEventId
});




}
/// @nodoc
class _$RealtimeShakeEventDataCopyWithImpl<$Res>
    implements $RealtimeShakeEventDataCopyWith<$Res> {
  _$RealtimeShakeEventDataCopyWithImpl(this._self, this._then);

  final RealtimeShakeEventData _self;
  final $Res Function(RealtimeShakeEventData) _then;

/// Create a copy of RealtimeShakeEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? pointCount = null,Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,Object? changeReasons = null,Object? correlatedEewEventId = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,changeReasons: null == changeReasons ? _self.changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,correlatedEewEventId: freezed == correlatedEewEventId ? _self.correlatedEewEventId : correlatedEewEventId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeShakeEventData].
extension RealtimeShakeEventDataPatterns on RealtimeShakeEventData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeShakeEventData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeShakeEventData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeShakeEventData value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeShakeEventData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeShakeEventData value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeShakeEventData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  String level,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  List<String> changeReasons,  String? correlatedEewEventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeShakeEventData() when $default != null:
return $default(_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.changeReasons,_that.correlatedEewEventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  String level,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  List<String> changeReasons,  String? correlatedEewEventId)  $default,) {final _that = this;
switch (_that) {
case _RealtimeShakeEventData():
return $default(_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.changeReasons,_that.correlatedEewEventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  String level,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  List<String> changeReasons,  String? correlatedEewEventId)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeShakeEventData() when $default != null:
return $default(_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.changeReasons,_that.correlatedEewEventId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeShakeEventData implements RealtimeShakeEventData {
  const _RealtimeShakeEventData({required this.eventId, required this.serialNo, required this.createdAt, required this.updatedAt, required this.expiresAt, required this.level, required this.pointCount, required this.minLat, required this.maxLat, required this.minLng, required this.maxLng, required final  List<String> changeReasons, this.correlatedEewEventId}): _changeReasons = changeReasons;
  factory _RealtimeShakeEventData.fromJson(Map<String, dynamic> json) => _$RealtimeShakeEventDataFromJson(json);

@override final  String eventId;
@override final  int serialNo;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime expiresAt;
@override final  String level;
@override final  int pointCount;
@override final  double minLat;
@override final  double maxLat;
@override final  double minLng;
@override final  double maxLng;
 final  List<String> _changeReasons;
@override List<String> get changeReasons {
  if (_changeReasons is EqualUnmodifiableListView) return _changeReasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_changeReasons);
}

@override final  String? correlatedEewEventId;

/// Create a copy of RealtimeShakeEventData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeShakeEventDataCopyWith<_RealtimeShakeEventData> get copyWith => __$RealtimeShakeEventDataCopyWithImpl<_RealtimeShakeEventData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeShakeEventDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeShakeEventData&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng)&&const DeepCollectionEquality().equals(other._changeReasons, _changeReasons)&&(identical(other.correlatedEewEventId, correlatedEewEventId) || other.correlatedEewEventId == correlatedEewEventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo,createdAt,updatedAt,expiresAt,level,pointCount,minLat,maxLat,minLng,maxLng,const DeepCollectionEquality().hash(_changeReasons),correlatedEewEventId);

@override
String toString() {
  return 'RealtimeShakeEventData(eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, pointCount: $pointCount, minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng, changeReasons: $changeReasons, correlatedEewEventId: $correlatedEewEventId)';
}


}

/// @nodoc
abstract mixin class _$RealtimeShakeEventDataCopyWith<$Res> implements $RealtimeShakeEventDataCopyWith<$Res> {
  factory _$RealtimeShakeEventDataCopyWith(_RealtimeShakeEventData value, $Res Function(_RealtimeShakeEventData) _then) = __$RealtimeShakeEventDataCopyWithImpl;
@override @useResult
$Res call({
 String eventId, int serialNo, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, String level, int pointCount, double minLat, double maxLat, double minLng, double maxLng, List<String> changeReasons, String? correlatedEewEventId
});




}
/// @nodoc
class __$RealtimeShakeEventDataCopyWithImpl<$Res>
    implements _$RealtimeShakeEventDataCopyWith<$Res> {
  __$RealtimeShakeEventDataCopyWithImpl(this._self, this._then);

  final _RealtimeShakeEventData _self;
  final $Res Function(_RealtimeShakeEventData) _then;

/// Create a copy of RealtimeShakeEventData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? pointCount = null,Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,Object? changeReasons = null,Object? correlatedEewEventId = freezed,}) {
  return _then(_RealtimeShakeEventData(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,changeReasons: null == changeReasons ? _self._changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,correlatedEewEventId: freezed == correlatedEewEventId ? _self.correlatedEewEventId : correlatedEewEventId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RealtimeShakeSnapshot {

 int get revision; DateTime get responseAt; List<RealtimeShakeEventData> get events;
/// Create a copy of RealtimeShakeSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeShakeSnapshotCopyWith<RealtimeShakeSnapshot> get copyWith => _$RealtimeShakeSnapshotCopyWithImpl<RealtimeShakeSnapshot>(this as RealtimeShakeSnapshot, _$identity);

  /// Serializes this RealtimeShakeSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeShakeSnapshot&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.responseAt, responseAt) || other.responseAt == responseAt)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revision,responseAt,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'RealtimeShakeSnapshot(revision: $revision, responseAt: $responseAt, events: $events)';
}


}

/// @nodoc
abstract mixin class $RealtimeShakeSnapshotCopyWith<$Res>  {
  factory $RealtimeShakeSnapshotCopyWith(RealtimeShakeSnapshot value, $Res Function(RealtimeShakeSnapshot) _then) = _$RealtimeShakeSnapshotCopyWithImpl;
@useResult
$Res call({
 int revision, DateTime responseAt, List<RealtimeShakeEventData> events
});




}
/// @nodoc
class _$RealtimeShakeSnapshotCopyWithImpl<$Res>
    implements $RealtimeShakeSnapshotCopyWith<$Res> {
  _$RealtimeShakeSnapshotCopyWithImpl(this._self, this._then);

  final RealtimeShakeSnapshot _self;
  final $Res Function(RealtimeShakeSnapshot) _then;

/// Create a copy of RealtimeShakeSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? revision = null,Object? responseAt = null,Object? events = null,}) {
  return _then(_self.copyWith(
revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,responseAt: null == responseAt ? _self.responseAt : responseAt // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<RealtimeShakeEventData>,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeShakeSnapshot].
extension RealtimeShakeSnapshotPatterns on RealtimeShakeSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeShakeSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeShakeSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeShakeSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeShakeSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeShakeSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeShakeSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int revision,  DateTime responseAt,  List<RealtimeShakeEventData> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeShakeSnapshot() when $default != null:
return $default(_that.revision,_that.responseAt,_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int revision,  DateTime responseAt,  List<RealtimeShakeEventData> events)  $default,) {final _that = this;
switch (_that) {
case _RealtimeShakeSnapshot():
return $default(_that.revision,_that.responseAt,_that.events);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int revision,  DateTime responseAt,  List<RealtimeShakeEventData> events)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeShakeSnapshot() when $default != null:
return $default(_that.revision,_that.responseAt,_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeShakeSnapshot implements RealtimeShakeSnapshot {
  const _RealtimeShakeSnapshot({required this.revision, required this.responseAt, required final  List<RealtimeShakeEventData> events}): _events = events;
  factory _RealtimeShakeSnapshot.fromJson(Map<String, dynamic> json) => _$RealtimeShakeSnapshotFromJson(json);

@override final  int revision;
@override final  DateTime responseAt;
 final  List<RealtimeShakeEventData> _events;
@override List<RealtimeShakeEventData> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of RealtimeShakeSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeShakeSnapshotCopyWith<_RealtimeShakeSnapshot> get copyWith => __$RealtimeShakeSnapshotCopyWithImpl<_RealtimeShakeSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeShakeSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeShakeSnapshot&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.responseAt, responseAt) || other.responseAt == responseAt)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revision,responseAt,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'RealtimeShakeSnapshot(revision: $revision, responseAt: $responseAt, events: $events)';
}


}

/// @nodoc
abstract mixin class _$RealtimeShakeSnapshotCopyWith<$Res> implements $RealtimeShakeSnapshotCopyWith<$Res> {
  factory _$RealtimeShakeSnapshotCopyWith(_RealtimeShakeSnapshot value, $Res Function(_RealtimeShakeSnapshot) _then) = __$RealtimeShakeSnapshotCopyWithImpl;
@override @useResult
$Res call({
 int revision, DateTime responseAt, List<RealtimeShakeEventData> events
});




}
/// @nodoc
class __$RealtimeShakeSnapshotCopyWithImpl<$Res>
    implements _$RealtimeShakeSnapshotCopyWith<$Res> {
  __$RealtimeShakeSnapshotCopyWithImpl(this._self, this._then);

  final _RealtimeShakeSnapshot _self;
  final $Res Function(_RealtimeShakeSnapshot) _then;

/// Create a copy of RealtimeShakeSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? revision = null,Object? responseAt = null,Object? events = null,}) {
  return _then(_RealtimeShakeSnapshot(
revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,responseAt: null == responseAt ? _self.responseAt : responseAt // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<RealtimeShakeEventData>,
  ));
}


}

// dart format on

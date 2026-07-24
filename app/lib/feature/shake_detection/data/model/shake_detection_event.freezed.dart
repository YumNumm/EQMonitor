// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShakeDetectionEvent {

 String get eventId; int get serialNo; DateTime get createdAt; DateTime get updatedAt; DateTime get expiresAt; ShakeDetectionLevel get level; int get pointCount; double get minLat; double get maxLat; double get minLng; double get maxLng; List<String> get changeReasons; String? get correlatedEewEventId; List<MergedEvents> get mergedEvents; List<Points> get points; CorrelatedEew? get correlatedEew;
/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionEventCopyWith<ShakeDetectionEvent> get copyWith => _$ShakeDetectionEventCopyWithImpl<ShakeDetectionEvent>(this as ShakeDetectionEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng)&&const DeepCollectionEquality().equals(other.changeReasons, changeReasons)&&(identical(other.correlatedEewEventId, correlatedEewEventId) || other.correlatedEewEventId == correlatedEewEventId)&&const DeepCollectionEquality().equals(other.mergedEvents, mergedEvents)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.correlatedEew, correlatedEew) || other.correlatedEew == correlatedEew));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo,createdAt,updatedAt,expiresAt,level,pointCount,minLat,maxLat,minLng,maxLng,const DeepCollectionEquality().hash(changeReasons),correlatedEewEventId,const DeepCollectionEquality().hash(mergedEvents),const DeepCollectionEquality().hash(points),correlatedEew);

@override
String toString() {
  return 'ShakeDetectionEvent(eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, pointCount: $pointCount, minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng, changeReasons: $changeReasons, correlatedEewEventId: $correlatedEewEventId, mergedEvents: $mergedEvents, points: $points, correlatedEew: $correlatedEew)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionEventCopyWith<$Res>  {
  factory $ShakeDetectionEventCopyWith(ShakeDetectionEvent value, $Res Function(ShakeDetectionEvent) _then) = _$ShakeDetectionEventCopyWithImpl;
@useResult
$Res call({
 String eventId, int serialNo, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, ShakeDetectionLevel level, int pointCount, double minLat, double maxLat, double minLng, double maxLng, List<String> changeReasons, String? correlatedEewEventId, List<MergedEvents> mergedEvents, List<Points> points, CorrelatedEew? correlatedEew
});


$CorrelatedEewCopyWith<$Res>? get correlatedEew;

}
/// @nodoc
class _$ShakeDetectionEventCopyWithImpl<$Res>
    implements $ShakeDetectionEventCopyWith<$Res> {
  _$ShakeDetectionEventCopyWithImpl(this._self, this._then);

  final ShakeDetectionEvent _self;
  final $Res Function(ShakeDetectionEvent) _then;

/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? pointCount = null,Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,Object? changeReasons = null,Object? correlatedEewEventId = freezed,Object? mergedEvents = null,Object? points = null,Object? correlatedEew = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,changeReasons: null == changeReasons ? _self.changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,correlatedEewEventId: freezed == correlatedEewEventId ? _self.correlatedEewEventId : correlatedEewEventId // ignore: cast_nullable_to_non_nullable
as String?,mergedEvents: null == mergedEvents ? _self.mergedEvents : mergedEvents // ignore: cast_nullable_to_non_nullable
as List<MergedEvents>,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<Points>,correlatedEew: freezed == correlatedEew ? _self.correlatedEew : correlatedEew // ignore: cast_nullable_to_non_nullable
as CorrelatedEew?,
  ));
}
/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CorrelatedEewCopyWith<$Res>? get correlatedEew {
    if (_self.correlatedEew == null) {
    return null;
  }

  return $CorrelatedEewCopyWith<$Res>(_self.correlatedEew!, (value) {
    return _then(_self.copyWith(correlatedEew: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShakeDetectionEvent].
extension ShakeDetectionEventPatterns on ShakeDetectionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionEvent value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionEvent value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  ShakeDetectionLevel level,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  List<String> changeReasons,  String? correlatedEewEventId,  List<MergedEvents> mergedEvents,  List<Points> points,  CorrelatedEew? correlatedEew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionEvent() when $default != null:
return $default(_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.changeReasons,_that.correlatedEewEventId,_that.mergedEvents,_that.points,_that.correlatedEew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  ShakeDetectionLevel level,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  List<String> changeReasons,  String? correlatedEewEventId,  List<MergedEvents> mergedEvents,  List<Points> points,  CorrelatedEew? correlatedEew)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionEvent():
return $default(_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.changeReasons,_that.correlatedEewEventId,_that.mergedEvents,_that.points,_that.correlatedEew);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  ShakeDetectionLevel level,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  List<String> changeReasons,  String? correlatedEewEventId,  List<MergedEvents> mergedEvents,  List<Points> points,  CorrelatedEew? correlatedEew)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionEvent() when $default != null:
return $default(_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.changeReasons,_that.correlatedEewEventId,_that.mergedEvents,_that.points,_that.correlatedEew);case _:
  return null;

}
}

}

/// @nodoc


class _ShakeDetectionEvent implements ShakeDetectionEvent {
  const _ShakeDetectionEvent({required this.eventId, required this.serialNo, required this.createdAt, required this.updatedAt, required this.expiresAt, required this.level, required this.pointCount, required this.minLat, required this.maxLat, required this.minLng, required this.maxLng, required final  List<String> changeReasons, this.correlatedEewEventId, final  List<MergedEvents> mergedEvents = const [], final  List<Points> points = const [], this.correlatedEew}): _changeReasons = changeReasons,_mergedEvents = mergedEvents,_points = points;
  

@override final  String eventId;
@override final  int serialNo;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime expiresAt;
@override final  ShakeDetectionLevel level;
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
 final  List<MergedEvents> _mergedEvents;
@override@JsonKey() List<MergedEvents> get mergedEvents {
  if (_mergedEvents is EqualUnmodifiableListView) return _mergedEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mergedEvents);
}

 final  List<Points> _points;
@override@JsonKey() List<Points> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override final  CorrelatedEew? correlatedEew;

/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionEventCopyWith<_ShakeDetectionEvent> get copyWith => __$ShakeDetectionEventCopyWithImpl<_ShakeDetectionEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng)&&const DeepCollectionEquality().equals(other._changeReasons, _changeReasons)&&(identical(other.correlatedEewEventId, correlatedEewEventId) || other.correlatedEewEventId == correlatedEewEventId)&&const DeepCollectionEquality().equals(other._mergedEvents, _mergedEvents)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.correlatedEew, correlatedEew) || other.correlatedEew == correlatedEew));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo,createdAt,updatedAt,expiresAt,level,pointCount,minLat,maxLat,minLng,maxLng,const DeepCollectionEquality().hash(_changeReasons),correlatedEewEventId,const DeepCollectionEquality().hash(_mergedEvents),const DeepCollectionEquality().hash(_points),correlatedEew);

@override
String toString() {
  return 'ShakeDetectionEvent(eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, pointCount: $pointCount, minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng, changeReasons: $changeReasons, correlatedEewEventId: $correlatedEewEventId, mergedEvents: $mergedEvents, points: $points, correlatedEew: $correlatedEew)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionEventCopyWith<$Res> implements $ShakeDetectionEventCopyWith<$Res> {
  factory _$ShakeDetectionEventCopyWith(_ShakeDetectionEvent value, $Res Function(_ShakeDetectionEvent) _then) = __$ShakeDetectionEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, int serialNo, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, ShakeDetectionLevel level, int pointCount, double minLat, double maxLat, double minLng, double maxLng, List<String> changeReasons, String? correlatedEewEventId, List<MergedEvents> mergedEvents, List<Points> points, CorrelatedEew? correlatedEew
});


@override $CorrelatedEewCopyWith<$Res>? get correlatedEew;

}
/// @nodoc
class __$ShakeDetectionEventCopyWithImpl<$Res>
    implements _$ShakeDetectionEventCopyWith<$Res> {
  __$ShakeDetectionEventCopyWithImpl(this._self, this._then);

  final _ShakeDetectionEvent _self;
  final $Res Function(_ShakeDetectionEvent) _then;

/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? pointCount = null,Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,Object? changeReasons = null,Object? correlatedEewEventId = freezed,Object? mergedEvents = null,Object? points = null,Object? correlatedEew = freezed,}) {
  return _then(_ShakeDetectionEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,changeReasons: null == changeReasons ? _self._changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,correlatedEewEventId: freezed == correlatedEewEventId ? _self.correlatedEewEventId : correlatedEewEventId // ignore: cast_nullable_to_non_nullable
as String?,mergedEvents: null == mergedEvents ? _self._mergedEvents : mergedEvents // ignore: cast_nullable_to_non_nullable
as List<MergedEvents>,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<Points>,correlatedEew: freezed == correlatedEew ? _self.correlatedEew : correlatedEew // ignore: cast_nullable_to_non_nullable
as CorrelatedEew?,
  ));
}

/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CorrelatedEewCopyWith<$Res>? get correlatedEew {
    if (_self.correlatedEew == null) {
    return null;
  }

  return $CorrelatedEewCopyWith<$Res>(_self.correlatedEew!, (value) {
    return _then(_self.copyWith(correlatedEew: value));
  });
}
}

// dart format on

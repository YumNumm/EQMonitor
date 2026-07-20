// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_shake_detection_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WsShakeMergedEvent {

 String get eventId; DateTime get mergedAt;
/// Create a copy of WsShakeMergedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsShakeMergedEventCopyWith<WsShakeMergedEvent> get copyWith => _$WsShakeMergedEventCopyWithImpl<WsShakeMergedEvent>(this as WsShakeMergedEvent, _$identity);

  /// Serializes this WsShakeMergedEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsShakeMergedEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.mergedAt, mergedAt) || other.mergedAt == mergedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,mergedAt);

@override
String toString() {
  return 'WsShakeMergedEvent(eventId: $eventId, mergedAt: $mergedAt)';
}


}

/// @nodoc
abstract mixin class $WsShakeMergedEventCopyWith<$Res>  {
  factory $WsShakeMergedEventCopyWith(WsShakeMergedEvent value, $Res Function(WsShakeMergedEvent) _then) = _$WsShakeMergedEventCopyWithImpl;
@useResult
$Res call({
 String eventId, DateTime mergedAt
});




}
/// @nodoc
class _$WsShakeMergedEventCopyWithImpl<$Res>
    implements $WsShakeMergedEventCopyWith<$Res> {
  _$WsShakeMergedEventCopyWithImpl(this._self, this._then);

  final WsShakeMergedEvent _self;
  final $Res Function(WsShakeMergedEvent) _then;

/// Create a copy of WsShakeMergedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? mergedAt = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,mergedAt: null == mergedAt ? _self.mergedAt : mergedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WsShakeMergedEvent].
extension WsShakeMergedEventPatterns on WsShakeMergedEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsShakeMergedEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsShakeMergedEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsShakeMergedEvent value)  $default,){
final _that = this;
switch (_that) {
case _WsShakeMergedEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsShakeMergedEvent value)?  $default,){
final _that = this;
switch (_that) {
case _WsShakeMergedEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  DateTime mergedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsShakeMergedEvent() when $default != null:
return $default(_that.eventId,_that.mergedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  DateTime mergedAt)  $default,) {final _that = this;
switch (_that) {
case _WsShakeMergedEvent():
return $default(_that.eventId,_that.mergedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  DateTime mergedAt)?  $default,) {final _that = this;
switch (_that) {
case _WsShakeMergedEvent() when $default != null:
return $default(_that.eventId,_that.mergedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsShakeMergedEvent implements WsShakeMergedEvent {
  const _WsShakeMergedEvent({required this.eventId, required this.mergedAt});
  factory _WsShakeMergedEvent.fromJson(Map<String, dynamic> json) => _$WsShakeMergedEventFromJson(json);

@override final  String eventId;
@override final  DateTime mergedAt;

/// Create a copy of WsShakeMergedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsShakeMergedEventCopyWith<_WsShakeMergedEvent> get copyWith => __$WsShakeMergedEventCopyWithImpl<_WsShakeMergedEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsShakeMergedEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsShakeMergedEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.mergedAt, mergedAt) || other.mergedAt == mergedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,mergedAt);

@override
String toString() {
  return 'WsShakeMergedEvent(eventId: $eventId, mergedAt: $mergedAt)';
}


}

/// @nodoc
abstract mixin class _$WsShakeMergedEventCopyWith<$Res> implements $WsShakeMergedEventCopyWith<$Res> {
  factory _$WsShakeMergedEventCopyWith(_WsShakeMergedEvent value, $Res Function(_WsShakeMergedEvent) _then) = __$WsShakeMergedEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime mergedAt
});




}
/// @nodoc
class __$WsShakeMergedEventCopyWithImpl<$Res>
    implements _$WsShakeMergedEventCopyWith<$Res> {
  __$WsShakeMergedEventCopyWithImpl(this._self, this._then);

  final _WsShakeMergedEvent _self;
  final $Res Function(_WsShakeMergedEvent) _then;

/// Create a copy of WsShakeMergedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? mergedAt = null,}) {
  return _then(_WsShakeMergedEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,mergedAt: null == mergedAt ? _self.mergedAt : mergedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$WsShakeCorrelatedEew {

 String get eventId; double get score;
/// Create a copy of WsShakeCorrelatedEew
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsShakeCorrelatedEewCopyWith<WsShakeCorrelatedEew> get copyWith => _$WsShakeCorrelatedEewCopyWithImpl<WsShakeCorrelatedEew>(this as WsShakeCorrelatedEew, _$identity);

  /// Serializes this WsShakeCorrelatedEew to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsShakeCorrelatedEew&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,score);

@override
String toString() {
  return 'WsShakeCorrelatedEew(eventId: $eventId, score: $score)';
}


}

/// @nodoc
abstract mixin class $WsShakeCorrelatedEewCopyWith<$Res>  {
  factory $WsShakeCorrelatedEewCopyWith(WsShakeCorrelatedEew value, $Res Function(WsShakeCorrelatedEew) _then) = _$WsShakeCorrelatedEewCopyWithImpl;
@useResult
$Res call({
 String eventId, double score
});




}
/// @nodoc
class _$WsShakeCorrelatedEewCopyWithImpl<$Res>
    implements $WsShakeCorrelatedEewCopyWith<$Res> {
  _$WsShakeCorrelatedEewCopyWithImpl(this._self, this._then);

  final WsShakeCorrelatedEew _self;
  final $Res Function(WsShakeCorrelatedEew) _then;

/// Create a copy of WsShakeCorrelatedEew
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? score = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WsShakeCorrelatedEew].
extension WsShakeCorrelatedEewPatterns on WsShakeCorrelatedEew {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsShakeCorrelatedEew value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsShakeCorrelatedEew() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsShakeCorrelatedEew value)  $default,){
final _that = this;
switch (_that) {
case _WsShakeCorrelatedEew():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsShakeCorrelatedEew value)?  $default,){
final _that = this;
switch (_that) {
case _WsShakeCorrelatedEew() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  double score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsShakeCorrelatedEew() when $default != null:
return $default(_that.eventId,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  double score)  $default,) {final _that = this;
switch (_that) {
case _WsShakeCorrelatedEew():
return $default(_that.eventId,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  double score)?  $default,) {final _that = this;
switch (_that) {
case _WsShakeCorrelatedEew() when $default != null:
return $default(_that.eventId,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsShakeCorrelatedEew implements WsShakeCorrelatedEew {
  const _WsShakeCorrelatedEew({required this.eventId, required this.score});
  factory _WsShakeCorrelatedEew.fromJson(Map<String, dynamic> json) => _$WsShakeCorrelatedEewFromJson(json);

@override final  String eventId;
@override final  double score;

/// Create a copy of WsShakeCorrelatedEew
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsShakeCorrelatedEewCopyWith<_WsShakeCorrelatedEew> get copyWith => __$WsShakeCorrelatedEewCopyWithImpl<_WsShakeCorrelatedEew>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsShakeCorrelatedEewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsShakeCorrelatedEew&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,score);

@override
String toString() {
  return 'WsShakeCorrelatedEew(eventId: $eventId, score: $score)';
}


}

/// @nodoc
abstract mixin class _$WsShakeCorrelatedEewCopyWith<$Res> implements $WsShakeCorrelatedEewCopyWith<$Res> {
  factory _$WsShakeCorrelatedEewCopyWith(_WsShakeCorrelatedEew value, $Res Function(_WsShakeCorrelatedEew) _then) = __$WsShakeCorrelatedEewCopyWithImpl;
@override @useResult
$Res call({
 String eventId, double score
});




}
/// @nodoc
class __$WsShakeCorrelatedEewCopyWithImpl<$Res>
    implements _$WsShakeCorrelatedEewCopyWith<$Res> {
  __$WsShakeCorrelatedEewCopyWithImpl(this._self, this._then);

  final _WsShakeCorrelatedEew _self;
  final $Res Function(_WsShakeCorrelatedEew) _then;

/// Create a copy of WsShakeCorrelatedEew
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? score = null,}) {
  return _then(_WsShakeCorrelatedEew(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$WsShakeDetectionEvent {

 String get type; String get eventId; int get serialNo; DateTime get createdAt; DateTime get updatedAt; DateTime get expiresAt; String get level; List<String> get changeReasons; List<WsShakeMergedEvent> get mergedEvents; int get pointCount; WsShakeRegionPayload get region; List<WsShakeObservationPoint> get points; WsShakeCorrelatedEew? get correlatedEew;
/// Create a copy of WsShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsShakeDetectionEventCopyWith<WsShakeDetectionEvent> get copyWith => _$WsShakeDetectionEventCopyWithImpl<WsShakeDetectionEvent>(this as WsShakeDetectionEvent, _$identity);

  /// Serializes this WsShakeDetectionEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsShakeDetectionEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other.changeReasons, changeReasons)&&const DeepCollectionEquality().equals(other.mergedEvents, mergedEvents)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.correlatedEew, correlatedEew) || other.correlatedEew == correlatedEew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,eventId,serialNo,createdAt,updatedAt,expiresAt,level,const DeepCollectionEquality().hash(changeReasons),const DeepCollectionEquality().hash(mergedEvents),pointCount,region,const DeepCollectionEquality().hash(points),correlatedEew);

@override
String toString() {
  return 'WsShakeDetectionEvent(type: $type, eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, changeReasons: $changeReasons, mergedEvents: $mergedEvents, pointCount: $pointCount, region: $region, points: $points, correlatedEew: $correlatedEew)';
}


}

/// @nodoc
abstract mixin class $WsShakeDetectionEventCopyWith<$Res>  {
  factory $WsShakeDetectionEventCopyWith(WsShakeDetectionEvent value, $Res Function(WsShakeDetectionEvent) _then) = _$WsShakeDetectionEventCopyWithImpl;
@useResult
$Res call({
 String type, String eventId, int serialNo, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, String level, List<String> changeReasons, List<WsShakeMergedEvent> mergedEvents, int pointCount, WsShakeRegionPayload region, List<WsShakeObservationPoint> points, WsShakeCorrelatedEew? correlatedEew
});


$WsShakeRegionPayloadCopyWith<$Res> get region;$WsShakeCorrelatedEewCopyWith<$Res>? get correlatedEew;

}
/// @nodoc
class _$WsShakeDetectionEventCopyWithImpl<$Res>
    implements $WsShakeDetectionEventCopyWith<$Res> {
  _$WsShakeDetectionEventCopyWithImpl(this._self, this._then);

  final WsShakeDetectionEvent _self;
  final $Res Function(WsShakeDetectionEvent) _then;

/// Create a copy of WsShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? changeReasons = null,Object? mergedEvents = null,Object? pointCount = null,Object? region = null,Object? points = null,Object? correlatedEew = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,changeReasons: null == changeReasons ? _self.changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,mergedEvents: null == mergedEvents ? _self.mergedEvents : mergedEvents // ignore: cast_nullable_to_non_nullable
as List<WsShakeMergedEvent>,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as WsShakeRegionPayload,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<WsShakeObservationPoint>,correlatedEew: freezed == correlatedEew ? _self.correlatedEew : correlatedEew // ignore: cast_nullable_to_non_nullable
as WsShakeCorrelatedEew?,
  ));
}
/// Create a copy of WsShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeRegionPayloadCopyWith<$Res> get region {

  return $WsShakeRegionPayloadCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of WsShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeCorrelatedEewCopyWith<$Res>? get correlatedEew {
    if (_self.correlatedEew == null) {
    return null;
  }

  return $WsShakeCorrelatedEewCopyWith<$Res>(_self.correlatedEew!, (value) {
    return _then(_self.copyWith(correlatedEew: value));
  });
}
}


/// Adds pattern-matching-related methods to [WsShakeDetectionEvent].
extension WsShakeDetectionEventPatterns on WsShakeDetectionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsShakeDetectionEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsShakeDetectionEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsShakeDetectionEvent value)  $default,){
final _that = this;
switch (_that) {
case _WsShakeDetectionEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsShakeDetectionEvent value)?  $default,){
final _that = this;
switch (_that) {
case _WsShakeDetectionEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  String level,  List<String> changeReasons,  List<WsShakeMergedEvent> mergedEvents,  int pointCount,  WsShakeRegionPayload region,  List<WsShakeObservationPoint> points,  WsShakeCorrelatedEew? correlatedEew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsShakeDetectionEvent() when $default != null:
return $default(_that.type,_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.changeReasons,_that.mergedEvents,_that.pointCount,_that.region,_that.points,_that.correlatedEew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  String level,  List<String> changeReasons,  List<WsShakeMergedEvent> mergedEvents,  int pointCount,  WsShakeRegionPayload region,  List<WsShakeObservationPoint> points,  WsShakeCorrelatedEew? correlatedEew)  $default,) {final _that = this;
switch (_that) {
case _WsShakeDetectionEvent():
return $default(_that.type,_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.changeReasons,_that.mergedEvents,_that.pointCount,_that.region,_that.points,_that.correlatedEew);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  String level,  List<String> changeReasons,  List<WsShakeMergedEvent> mergedEvents,  int pointCount,  WsShakeRegionPayload region,  List<WsShakeObservationPoint> points,  WsShakeCorrelatedEew? correlatedEew)?  $default,) {final _that = this;
switch (_that) {
case _WsShakeDetectionEvent() when $default != null:
return $default(_that.type,_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.changeReasons,_that.mergedEvents,_that.pointCount,_that.region,_that.points,_that.correlatedEew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsShakeDetectionEvent implements WsShakeDetectionEvent {
  const _WsShakeDetectionEvent({required this.type, required this.eventId, required this.serialNo, required this.createdAt, required this.updatedAt, required this.expiresAt, required this.level, required final  List<String> changeReasons, required final  List<WsShakeMergedEvent> mergedEvents, required this.pointCount, required this.region, required final  List<WsShakeObservationPoint> points, this.correlatedEew}): _changeReasons = changeReasons,_mergedEvents = mergedEvents,_points = points;
  factory _WsShakeDetectionEvent.fromJson(Map<String, dynamic> json) => _$WsShakeDetectionEventFromJson(json);

@override final  String type;
@override final  String eventId;
@override final  int serialNo;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime expiresAt;
@override final  String level;
 final  List<String> _changeReasons;
@override List<String> get changeReasons {
  if (_changeReasons is EqualUnmodifiableListView) return _changeReasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_changeReasons);
}

 final  List<WsShakeMergedEvent> _mergedEvents;
@override List<WsShakeMergedEvent> get mergedEvents {
  if (_mergedEvents is EqualUnmodifiableListView) return _mergedEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mergedEvents);
}

@override final  int pointCount;
@override final  WsShakeRegionPayload region;
 final  List<WsShakeObservationPoint> _points;
@override List<WsShakeObservationPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override final  WsShakeCorrelatedEew? correlatedEew;

/// Create a copy of WsShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsShakeDetectionEventCopyWith<_WsShakeDetectionEvent> get copyWith => __$WsShakeDetectionEventCopyWithImpl<_WsShakeDetectionEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsShakeDetectionEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsShakeDetectionEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other._changeReasons, _changeReasons)&&const DeepCollectionEquality().equals(other._mergedEvents, _mergedEvents)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.correlatedEew, correlatedEew) || other.correlatedEew == correlatedEew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,eventId,serialNo,createdAt,updatedAt,expiresAt,level,const DeepCollectionEquality().hash(_changeReasons),const DeepCollectionEquality().hash(_mergedEvents),pointCount,region,const DeepCollectionEquality().hash(_points),correlatedEew);

@override
String toString() {
  return 'WsShakeDetectionEvent(type: $type, eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, changeReasons: $changeReasons, mergedEvents: $mergedEvents, pointCount: $pointCount, region: $region, points: $points, correlatedEew: $correlatedEew)';
}


}

/// @nodoc
abstract mixin class _$WsShakeDetectionEventCopyWith<$Res> implements $WsShakeDetectionEventCopyWith<$Res> {
  factory _$WsShakeDetectionEventCopyWith(_WsShakeDetectionEvent value, $Res Function(_WsShakeDetectionEvent) _then) = __$WsShakeDetectionEventCopyWithImpl;
@override @useResult
$Res call({
 String type, String eventId, int serialNo, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, String level, List<String> changeReasons, List<WsShakeMergedEvent> mergedEvents, int pointCount, WsShakeRegionPayload region, List<WsShakeObservationPoint> points, WsShakeCorrelatedEew? correlatedEew
});


@override $WsShakeRegionPayloadCopyWith<$Res> get region;@override $WsShakeCorrelatedEewCopyWith<$Res>? get correlatedEew;

}
/// @nodoc
class __$WsShakeDetectionEventCopyWithImpl<$Res>
    implements _$WsShakeDetectionEventCopyWith<$Res> {
  __$WsShakeDetectionEventCopyWithImpl(this._self, this._then);

  final _WsShakeDetectionEvent _self;
  final $Res Function(_WsShakeDetectionEvent) _then;

/// Create a copy of WsShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? changeReasons = null,Object? mergedEvents = null,Object? pointCount = null,Object? region = null,Object? points = null,Object? correlatedEew = freezed,}) {
  return _then(_WsShakeDetectionEvent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,changeReasons: null == changeReasons ? _self._changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,mergedEvents: null == mergedEvents ? _self._mergedEvents : mergedEvents // ignore: cast_nullable_to_non_nullable
as List<WsShakeMergedEvent>,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as WsShakeRegionPayload,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<WsShakeObservationPoint>,correlatedEew: freezed == correlatedEew ? _self.correlatedEew : correlatedEew // ignore: cast_nullable_to_non_nullable
as WsShakeCorrelatedEew?,
  ));
}

/// Create a copy of WsShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeRegionPayloadCopyWith<$Res> get region {

  return $WsShakeRegionPayloadCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of WsShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeCorrelatedEewCopyWith<$Res>? get correlatedEew {
    if (_self.correlatedEew == null) {
    return null;
  }

  return $WsShakeCorrelatedEewCopyWith<$Res>(_self.correlatedEew!, (value) {
    return _then(_self.copyWith(correlatedEew: value));
  });
}
}

// dart format on

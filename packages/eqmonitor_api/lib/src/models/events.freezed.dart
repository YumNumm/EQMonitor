// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Events {

/// const: "shake_detection"
 String get type; String get eventId; int get serialNo; DateTime get createdAt; DateTime get updatedAt; DateTime get expiresAt; Level get level; List<ChangeReasons> get changeReasons; List<MergedEvents> get mergedEvents; int get pointCount; Region get region; List<Points> get points;@JsonKey(includeIfNull: false) Test? get test;@JsonKey(includeIfNull: false) CorrelatedEew? get correlatedEew;
/// Create a copy of Events
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventsCopyWith<Events> get copyWith => _$EventsCopyWithImpl<Events>(this as Events, _$identity);

  /// Serializes this Events to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Events&&(identical(other.type, type) || other.type == type)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other.changeReasons, changeReasons)&&const DeepCollectionEquality().equals(other.mergedEvents, mergedEvents)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.test, test) || other.test == test)&&(identical(other.correlatedEew, correlatedEew) || other.correlatedEew == correlatedEew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,eventId,serialNo,createdAt,updatedAt,expiresAt,level,const DeepCollectionEquality().hash(changeReasons),const DeepCollectionEquality().hash(mergedEvents),pointCount,region,const DeepCollectionEquality().hash(points),test,correlatedEew);

@override
String toString() {
  return 'Events(type: $type, eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, changeReasons: $changeReasons, mergedEvents: $mergedEvents, pointCount: $pointCount, region: $region, points: $points, test: $test, correlatedEew: $correlatedEew)';
}


}

/// @nodoc
abstract mixin class $EventsCopyWith<$Res>  {
  factory $EventsCopyWith(Events value, $Res Function(Events) _then) = _$EventsCopyWithImpl;
@useResult
$Res call({
 String type, String eventId, int serialNo, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, Level level, List<ChangeReasons> changeReasons, List<MergedEvents> mergedEvents, int pointCount, Region region, List<Points> points,@JsonKey(includeIfNull: false) Test? test,@JsonKey(includeIfNull: false) CorrelatedEew? correlatedEew
});


$RegionCopyWith<$Res> get region;$TestCopyWith<$Res>? get test;$CorrelatedEewCopyWith<$Res>? get correlatedEew;

}
/// @nodoc
class _$EventsCopyWithImpl<$Res>
    implements $EventsCopyWith<$Res> {
  _$EventsCopyWithImpl(this._self, this._then);

  final Events _self;
  final $Res Function(Events) _then;

/// Create a copy of Events
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? changeReasons = null,Object? mergedEvents = null,Object? pointCount = null,Object? region = null,Object? points = null,Object? test = freezed,Object? correlatedEew = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as Level,changeReasons: null == changeReasons ? _self.changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<ChangeReasons>,mergedEvents: null == mergedEvents ? _self.mergedEvents : mergedEvents // ignore: cast_nullable_to_non_nullable
as List<MergedEvents>,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<Points>,test: freezed == test ? _self.test : test // ignore: cast_nullable_to_non_nullable
as Test?,correlatedEew: freezed == correlatedEew ? _self.correlatedEew : correlatedEew // ignore: cast_nullable_to_non_nullable
as CorrelatedEew?,
  ));
}
/// Create a copy of Events
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionCopyWith<$Res> get region {
  
  return $RegionCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of Events
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestCopyWith<$Res>? get test {
    if (_self.test == null) {
    return null;
  }

  return $TestCopyWith<$Res>(_self.test!, (value) {
    return _then(_self.copyWith(test: value));
  });
}/// Create a copy of Events
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


/// Adds pattern-matching-related methods to [Events].
extension EventsPatterns on Events {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Events value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Events() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Events value)  $default,){
final _that = this;
switch (_that) {
case _Events():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Events value)?  $default,){
final _that = this;
switch (_that) {
case _Events() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  Level level,  List<ChangeReasons> changeReasons,  List<MergedEvents> mergedEvents,  int pointCount,  Region region,  List<Points> points, @JsonKey(includeIfNull: false)  Test? test, @JsonKey(includeIfNull: false)  CorrelatedEew? correlatedEew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Events() when $default != null:
return $default(_that.type,_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.changeReasons,_that.mergedEvents,_that.pointCount,_that.region,_that.points,_that.test,_that.correlatedEew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  Level level,  List<ChangeReasons> changeReasons,  List<MergedEvents> mergedEvents,  int pointCount,  Region region,  List<Points> points, @JsonKey(includeIfNull: false)  Test? test, @JsonKey(includeIfNull: false)  CorrelatedEew? correlatedEew)  $default,) {final _that = this;
switch (_that) {
case _Events():
return $default(_that.type,_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.changeReasons,_that.mergedEvents,_that.pointCount,_that.region,_that.points,_that.test,_that.correlatedEew);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  Level level,  List<ChangeReasons> changeReasons,  List<MergedEvents> mergedEvents,  int pointCount,  Region region,  List<Points> points, @JsonKey(includeIfNull: false)  Test? test, @JsonKey(includeIfNull: false)  CorrelatedEew? correlatedEew)?  $default,) {final _that = this;
switch (_that) {
case _Events() when $default != null:
return $default(_that.type,_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.changeReasons,_that.mergedEvents,_that.pointCount,_that.region,_that.points,_that.test,_that.correlatedEew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Events implements Events {
  const _Events({required this.type, required this.eventId, required this.serialNo, required this.createdAt, required this.updatedAt, required this.expiresAt, required this.level, required final  List<ChangeReasons> changeReasons, required final  List<MergedEvents> mergedEvents, required this.pointCount, required this.region, required final  List<Points> points, @JsonKey(includeIfNull: false) this.test, @JsonKey(includeIfNull: false) this.correlatedEew}): _changeReasons = changeReasons,_mergedEvents = mergedEvents,_points = points;
  factory _Events.fromJson(Map<String, dynamic> json) => _$EventsFromJson(json);

/// const: "shake_detection"
@override final  String type;
@override final  String eventId;
@override final  int serialNo;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime expiresAt;
@override final  Level level;
 final  List<ChangeReasons> _changeReasons;
@override List<ChangeReasons> get changeReasons {
  if (_changeReasons is EqualUnmodifiableListView) return _changeReasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_changeReasons);
}

 final  List<MergedEvents> _mergedEvents;
@override List<MergedEvents> get mergedEvents {
  if (_mergedEvents is EqualUnmodifiableListView) return _mergedEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mergedEvents);
}

@override final  int pointCount;
@override final  Region region;
 final  List<Points> _points;
@override List<Points> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override@JsonKey(includeIfNull: false) final  Test? test;
@override@JsonKey(includeIfNull: false) final  CorrelatedEew? correlatedEew;

/// Create a copy of Events
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventsCopyWith<_Events> get copyWith => __$EventsCopyWithImpl<_Events>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Events&&(identical(other.type, type) || other.type == type)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other._changeReasons, _changeReasons)&&const DeepCollectionEquality().equals(other._mergedEvents, _mergedEvents)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.test, test) || other.test == test)&&(identical(other.correlatedEew, correlatedEew) || other.correlatedEew == correlatedEew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,eventId,serialNo,createdAt,updatedAt,expiresAt,level,const DeepCollectionEquality().hash(_changeReasons),const DeepCollectionEquality().hash(_mergedEvents),pointCount,region,const DeepCollectionEquality().hash(_points),test,correlatedEew);

@override
String toString() {
  return 'Events(type: $type, eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, changeReasons: $changeReasons, mergedEvents: $mergedEvents, pointCount: $pointCount, region: $region, points: $points, test: $test, correlatedEew: $correlatedEew)';
}


}

/// @nodoc
abstract mixin class _$EventsCopyWith<$Res> implements $EventsCopyWith<$Res> {
  factory _$EventsCopyWith(_Events value, $Res Function(_Events) _then) = __$EventsCopyWithImpl;
@override @useResult
$Res call({
 String type, String eventId, int serialNo, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, Level level, List<ChangeReasons> changeReasons, List<MergedEvents> mergedEvents, int pointCount, Region region, List<Points> points,@JsonKey(includeIfNull: false) Test? test,@JsonKey(includeIfNull: false) CorrelatedEew? correlatedEew
});


@override $RegionCopyWith<$Res> get region;@override $TestCopyWith<$Res>? get test;@override $CorrelatedEewCopyWith<$Res>? get correlatedEew;

}
/// @nodoc
class __$EventsCopyWithImpl<$Res>
    implements _$EventsCopyWith<$Res> {
  __$EventsCopyWithImpl(this._self, this._then);

  final _Events _self;
  final $Res Function(_Events) _then;

/// Create a copy of Events
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? changeReasons = null,Object? mergedEvents = null,Object? pointCount = null,Object? region = null,Object? points = null,Object? test = freezed,Object? correlatedEew = freezed,}) {
  return _then(_Events(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as Level,changeReasons: null == changeReasons ? _self._changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<ChangeReasons>,mergedEvents: null == mergedEvents ? _self._mergedEvents : mergedEvents // ignore: cast_nullable_to_non_nullable
as List<MergedEvents>,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<Points>,test: freezed == test ? _self.test : test // ignore: cast_nullable_to_non_nullable
as Test?,correlatedEew: freezed == correlatedEew ? _self.correlatedEew : correlatedEew // ignore: cast_nullable_to_non_nullable
as CorrelatedEew?,
  ));
}

/// Create a copy of Events
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionCopyWith<$Res> get region {
  
  return $RegionCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of Events
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestCopyWith<$Res>? get test {
    if (_self.test == null) {
    return null;
  }

  return $TestCopyWith<$Res>(_self.test!, (value) {
    return _then(_self.copyWith(test: value));
  });
}/// Create a copy of Events
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

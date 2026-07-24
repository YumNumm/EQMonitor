// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'events3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Events3 {

 Type3 get type; String get eventId; int get serialNo; DateTime get createdAt; DateTime get updatedAt; DateTime get expiresAt; Level get level; List<ChangeReasons> get changeReasons; List<MergedEvents3> get mergedEvents; int get pointCount; Region3 get region; List<Points3> get points;@JsonKey(includeIfNull: false) Test3? get test;@JsonKey(includeIfNull: false) CorrelatedEew3? get correlatedEew;
/// Create a copy of Events3
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Events3CopyWith<Events3> get copyWith => _$Events3CopyWithImpl<Events3>(this as Events3, _$identity);

  /// Serializes this Events3 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Events3&&(identical(other.type, type) || other.type == type)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other.changeReasons, changeReasons)&&const DeepCollectionEquality().equals(other.mergedEvents, mergedEvents)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.test, test) || other.test == test)&&(identical(other.correlatedEew, correlatedEew) || other.correlatedEew == correlatedEew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,eventId,serialNo,createdAt,updatedAt,expiresAt,level,const DeepCollectionEquality().hash(changeReasons),const DeepCollectionEquality().hash(mergedEvents),pointCount,region,const DeepCollectionEquality().hash(points),test,correlatedEew);

@override
String toString() {
  return 'Events3(type: $type, eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, changeReasons: $changeReasons, mergedEvents: $mergedEvents, pointCount: $pointCount, region: $region, points: $points, test: $test, correlatedEew: $correlatedEew)';
}


}

/// @nodoc
abstract mixin class $Events3CopyWith<$Res>  {
  factory $Events3CopyWith(Events3 value, $Res Function(Events3) _then) = _$Events3CopyWithImpl;
@useResult
$Res call({
 Type3 type, String eventId, int serialNo, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, Level level, List<ChangeReasons> changeReasons, List<MergedEvents3> mergedEvents, int pointCount, Region3 region, List<Points3> points,@JsonKey(includeIfNull: false) Test3? test,@JsonKey(includeIfNull: false) CorrelatedEew3? correlatedEew
});


$Region3CopyWith<$Res> get region;$Test3CopyWith<$Res>? get test;$CorrelatedEew3CopyWith<$Res>? get correlatedEew;

}
/// @nodoc
class _$Events3CopyWithImpl<$Res>
    implements $Events3CopyWith<$Res> {
  _$Events3CopyWithImpl(this._self, this._then);

  final Events3 _self;
  final $Res Function(Events3) _then;

/// Create a copy of Events3
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? changeReasons = null,Object? mergedEvents = null,Object? pointCount = null,Object? region = null,Object? points = null,Object? test = freezed,Object? correlatedEew = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as Type3,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as Level,changeReasons: null == changeReasons ? _self.changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<ChangeReasons>,mergedEvents: null == mergedEvents ? _self.mergedEvents : mergedEvents // ignore: cast_nullable_to_non_nullable
as List<MergedEvents3>,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region3,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<Points3>,test: freezed == test ? _self.test : test // ignore: cast_nullable_to_non_nullable
as Test3?,correlatedEew: freezed == correlatedEew ? _self.correlatedEew : correlatedEew // ignore: cast_nullable_to_non_nullable
as CorrelatedEew3?,
  ));
}
/// Create a copy of Events3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Region3CopyWith<$Res> get region {

  return $Region3CopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of Events3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Test3CopyWith<$Res>? get test {
    if (_self.test == null) {
    return null;
  }

  return $Test3CopyWith<$Res>(_self.test!, (value) {
    return _then(_self.copyWith(test: value));
  });
}/// Create a copy of Events3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CorrelatedEew3CopyWith<$Res>? get correlatedEew {
    if (_self.correlatedEew == null) {
    return null;
  }

  return $CorrelatedEew3CopyWith<$Res>(_self.correlatedEew!, (value) {
    return _then(_self.copyWith(correlatedEew: value));
  });
}
}


/// Adds pattern-matching-related methods to [Events3].
extension Events3Patterns on Events3 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Events3 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Events3() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Events3 value)  $default,){
final _that = this;
switch (_that) {
case _Events3():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Events3 value)?  $default,){
final _that = this;
switch (_that) {
case _Events3() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Type3 type,  String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  Level level,  List<ChangeReasons> changeReasons,  List<MergedEvents3> mergedEvents,  int pointCount,  Region3 region,  List<Points3> points, @JsonKey(includeIfNull: false)  Test3? test, @JsonKey(includeIfNull: false)  CorrelatedEew3? correlatedEew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Events3() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Type3 type,  String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  Level level,  List<ChangeReasons> changeReasons,  List<MergedEvents3> mergedEvents,  int pointCount,  Region3 region,  List<Points3> points, @JsonKey(includeIfNull: false)  Test3? test, @JsonKey(includeIfNull: false)  CorrelatedEew3? correlatedEew)  $default,) {final _that = this;
switch (_that) {
case _Events3():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Type3 type,  String eventId,  int serialNo,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  Level level,  List<ChangeReasons> changeReasons,  List<MergedEvents3> mergedEvents,  int pointCount,  Region3 region,  List<Points3> points, @JsonKey(includeIfNull: false)  Test3? test, @JsonKey(includeIfNull: false)  CorrelatedEew3? correlatedEew)?  $default,) {final _that = this;
switch (_that) {
case _Events3() when $default != null:
return $default(_that.type,_that.eventId,_that.serialNo,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.changeReasons,_that.mergedEvents,_that.pointCount,_that.region,_that.points,_that.test,_that.correlatedEew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Events3 implements Events3 {
  const _Events3({required this.type, required this.eventId, required this.serialNo, required this.createdAt, required this.updatedAt, required this.expiresAt, required this.level, required final  List<ChangeReasons> changeReasons, required final  List<MergedEvents3> mergedEvents, required this.pointCount, required this.region, required final  List<Points3> points, @JsonKey(includeIfNull: false) this.test, @JsonKey(includeIfNull: false) this.correlatedEew}): _changeReasons = changeReasons,_mergedEvents = mergedEvents,_points = points;
  factory _Events3.fromJson(Map<String, dynamic> json) => _$Events3FromJson(json);

@override final  Type3 type;
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

 final  List<MergedEvents3> _mergedEvents;
@override List<MergedEvents3> get mergedEvents {
  if (_mergedEvents is EqualUnmodifiableListView) return _mergedEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mergedEvents);
}

@override final  int pointCount;
@override final  Region3 region;
 final  List<Points3> _points;
@override List<Points3> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override@JsonKey(includeIfNull: false) final  Test3? test;
@override@JsonKey(includeIfNull: false) final  CorrelatedEew3? correlatedEew;

/// Create a copy of Events3
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Events3CopyWith<_Events3> get copyWith => __$Events3CopyWithImpl<_Events3>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Events3ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Events3&&(identical(other.type, type) || other.type == type)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other._changeReasons, _changeReasons)&&const DeepCollectionEquality().equals(other._mergedEvents, _mergedEvents)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.test, test) || other.test == test)&&(identical(other.correlatedEew, correlatedEew) || other.correlatedEew == correlatedEew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,eventId,serialNo,createdAt,updatedAt,expiresAt,level,const DeepCollectionEquality().hash(_changeReasons),const DeepCollectionEquality().hash(_mergedEvents),pointCount,region,const DeepCollectionEquality().hash(_points),test,correlatedEew);

@override
String toString() {
  return 'Events3(type: $type, eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, changeReasons: $changeReasons, mergedEvents: $mergedEvents, pointCount: $pointCount, region: $region, points: $points, test: $test, correlatedEew: $correlatedEew)';
}


}

/// @nodoc
abstract mixin class _$Events3CopyWith<$Res> implements $Events3CopyWith<$Res> {
  factory _$Events3CopyWith(_Events3 value, $Res Function(_Events3) _then) = __$Events3CopyWithImpl;
@override @useResult
$Res call({
 Type3 type, String eventId, int serialNo, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, Level level, List<ChangeReasons> changeReasons, List<MergedEvents3> mergedEvents, int pointCount, Region3 region, List<Points3> points,@JsonKey(includeIfNull: false) Test3? test,@JsonKey(includeIfNull: false) CorrelatedEew3? correlatedEew
});


@override $Region3CopyWith<$Res> get region;@override $Test3CopyWith<$Res>? get test;@override $CorrelatedEew3CopyWith<$Res>? get correlatedEew;

}
/// @nodoc
class __$Events3CopyWithImpl<$Res>
    implements _$Events3CopyWith<$Res> {
  __$Events3CopyWithImpl(this._self, this._then);

  final _Events3 _self;
  final $Res Function(_Events3) _then;

/// Create a copy of Events3
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? changeReasons = null,Object? mergedEvents = null,Object? pointCount = null,Object? region = null,Object? points = null,Object? test = freezed,Object? correlatedEew = freezed,}) {
  return _then(_Events3(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as Type3,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as Level,changeReasons: null == changeReasons ? _self._changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<ChangeReasons>,mergedEvents: null == mergedEvents ? _self._mergedEvents : mergedEvents // ignore: cast_nullable_to_non_nullable
as List<MergedEvents3>,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region3,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<Points3>,test: freezed == test ? _self.test : test // ignore: cast_nullable_to_non_nullable
as Test3?,correlatedEew: freezed == correlatedEew ? _self.correlatedEew : correlatedEew // ignore: cast_nullable_to_non_nullable
as CorrelatedEew3?,
  ));
}

/// Create a copy of Events3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Region3CopyWith<$Res> get region {

  return $Region3CopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of Events3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Test3CopyWith<$Res>? get test {
    if (_self.test == null) {
    return null;
  }

  return $Test3CopyWith<$Res>(_self.test!, (value) {
    return _then(_self.copyWith(test: value));
  });
}/// Create a copy of Events3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CorrelatedEew3CopyWith<$Res>? get correlatedEew {
    if (_self.correlatedEew == null) {
    return null;
  }

  return $CorrelatedEew3CopyWith<$Res>(_self.correlatedEew!, (value) {
    return _then(_self.copyWith(correlatedEew: value));
  });
}
}

// dart format on

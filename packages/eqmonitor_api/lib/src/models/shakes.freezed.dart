// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shakes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Shakes {

 dynamic get type; String get eventId; String get createdAt; Level get level; List<String> get changeReasons; bool get isReplay; num get pointCount; Region get region; List<Points> get points;
/// Create a copy of Shakes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakesCopyWith<Shakes> get copyWith => _$ShakesCopyWithImpl<Shakes>(this as Shakes, _$identity);

  /// Serializes this Shakes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Shakes&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other.changeReasons, changeReasons)&&(identical(other.isReplay, isReplay) || other.isReplay == isReplay)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other.points, points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),eventId,createdAt,level,const DeepCollectionEquality().hash(changeReasons),isReplay,pointCount,region,const DeepCollectionEquality().hash(points));

@override
String toString() {
  return 'Shakes(type: $type, eventId: $eventId, createdAt: $createdAt, level: $level, changeReasons: $changeReasons, isReplay: $isReplay, pointCount: $pointCount, region: $region, points: $points)';
}


}

/// @nodoc
abstract mixin class $ShakesCopyWith<$Res>  {
  factory $ShakesCopyWith(Shakes value, $Res Function(Shakes) _then) = _$ShakesCopyWithImpl;
@useResult
$Res call({
 dynamic type, String eventId, String createdAt, Level level, List<String> changeReasons, bool isReplay, num pointCount, Region region, List<Points> points
});


$RegionCopyWith<$Res> get region;

}
/// @nodoc
class _$ShakesCopyWithImpl<$Res>
    implements $ShakesCopyWith<$Res> {
  _$ShakesCopyWithImpl(this._self, this._then);

  final Shakes _self;
  final $Res Function(Shakes) _then;

/// Create a copy of Shakes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? eventId = null,Object? createdAt = null,Object? level = null,Object? changeReasons = null,Object? isReplay = null,Object? pointCount = null,Object? region = null,Object? points = null,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as Level,changeReasons: null == changeReasons ? _self.changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,isReplay: null == isReplay ? _self.isReplay : isReplay // ignore: cast_nullable_to_non_nullable
as bool,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as num,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<Points>,
  ));
}
/// Create a copy of Shakes
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionCopyWith<$Res> get region {
  
  return $RegionCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}


/// Adds pattern-matching-related methods to [Shakes].
extension ShakesPatterns on Shakes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Shakes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Shakes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Shakes value)  $default,){
final _that = this;
switch (_that) {
case _Shakes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Shakes value)?  $default,){
final _that = this;
switch (_that) {
case _Shakes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic type,  String eventId,  String createdAt,  Level level,  List<String> changeReasons,  bool isReplay,  num pointCount,  Region region,  List<Points> points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Shakes() when $default != null:
return $default(_that.type,_that.eventId,_that.createdAt,_that.level,_that.changeReasons,_that.isReplay,_that.pointCount,_that.region,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic type,  String eventId,  String createdAt,  Level level,  List<String> changeReasons,  bool isReplay,  num pointCount,  Region region,  List<Points> points)  $default,) {final _that = this;
switch (_that) {
case _Shakes():
return $default(_that.type,_that.eventId,_that.createdAt,_that.level,_that.changeReasons,_that.isReplay,_that.pointCount,_that.region,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic type,  String eventId,  String createdAt,  Level level,  List<String> changeReasons,  bool isReplay,  num pointCount,  Region region,  List<Points> points)?  $default,) {final _that = this;
switch (_that) {
case _Shakes() when $default != null:
return $default(_that.type,_that.eventId,_that.createdAt,_that.level,_that.changeReasons,_that.isReplay,_that.pointCount,_that.region,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Shakes implements Shakes {
  const _Shakes({required this.type, required this.eventId, required this.createdAt, required this.level, required final  List<String> changeReasons, required this.isReplay, required this.pointCount, required this.region, required final  List<Points> points}): _changeReasons = changeReasons,_points = points;
  factory _Shakes.fromJson(Map<String, dynamic> json) => _$ShakesFromJson(json);

@override final  dynamic type;
@override final  String eventId;
@override final  String createdAt;
@override final  Level level;
 final  List<String> _changeReasons;
@override List<String> get changeReasons {
  if (_changeReasons is EqualUnmodifiableListView) return _changeReasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_changeReasons);
}

@override final  bool isReplay;
@override final  num pointCount;
@override final  Region region;
 final  List<Points> _points;
@override List<Points> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of Shakes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakesCopyWith<_Shakes> get copyWith => __$ShakesCopyWithImpl<_Shakes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Shakes&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other._changeReasons, _changeReasons)&&(identical(other.isReplay, isReplay) || other.isReplay == isReplay)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other._points, _points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),eventId,createdAt,level,const DeepCollectionEquality().hash(_changeReasons),isReplay,pointCount,region,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'Shakes(type: $type, eventId: $eventId, createdAt: $createdAt, level: $level, changeReasons: $changeReasons, isReplay: $isReplay, pointCount: $pointCount, region: $region, points: $points)';
}


}

/// @nodoc
abstract mixin class _$ShakesCopyWith<$Res> implements $ShakesCopyWith<$Res> {
  factory _$ShakesCopyWith(_Shakes value, $Res Function(_Shakes) _then) = __$ShakesCopyWithImpl;
@override @useResult
$Res call({
 dynamic type, String eventId, String createdAt, Level level, List<String> changeReasons, bool isReplay, num pointCount, Region region, List<Points> points
});


@override $RegionCopyWith<$Res> get region;

}
/// @nodoc
class __$ShakesCopyWithImpl<$Res>
    implements _$ShakesCopyWith<$Res> {
  __$ShakesCopyWithImpl(this._self, this._then);

  final _Shakes _self;
  final $Res Function(_Shakes) _then;

/// Create a copy of Shakes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? eventId = null,Object? createdAt = null,Object? level = null,Object? changeReasons = null,Object? isReplay = null,Object? pointCount = null,Object? region = null,Object? points = null,}) {
  return _then(_Shakes(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as Level,changeReasons: null == changeReasons ? _self._changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,isReplay: null == isReplay ? _self.isReplay : isReplay // ignore: cast_nullable_to_non_nullable
as bool,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as num,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<Points>,
  ));
}

/// Create a copy of Shakes
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionCopyWith<$Res> get region {
  
  return $RegionCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}

// dart format on

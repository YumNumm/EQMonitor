// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShakeDetectionEvent {

 String get eventId; DateTime get createdAt; DateTime get updatedAt; DateTime get expiresAt; ShakeDetectionLevel get level; int get pointCount; double get minLat; double get maxLat; double get minLng; double get maxLng; String? get correlatedEewEventId; List<ShakeDetectionPoint> get points;
/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionEventCopyWith<ShakeDetectionEvent> get copyWith => _$ShakeDetectionEventCopyWithImpl<ShakeDetectionEvent>(this as ShakeDetectionEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng)&&(identical(other.correlatedEewEventId, correlatedEewEventId) || other.correlatedEewEventId == correlatedEewEventId)&&const DeepCollectionEquality().equals(other.points, points));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,createdAt,updatedAt,expiresAt,level,pointCount,minLat,maxLat,minLng,maxLng,correlatedEewEventId,const DeepCollectionEquality().hash(points));

@override
String toString() {
  return 'ShakeDetectionEvent(eventId: $eventId, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, pointCount: $pointCount, minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng, correlatedEewEventId: $correlatedEewEventId, points: $points)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionEventCopyWith<$Res>  {
  factory $ShakeDetectionEventCopyWith(ShakeDetectionEvent value, $Res Function(ShakeDetectionEvent) _then) = _$ShakeDetectionEventCopyWithImpl;
@useResult
$Res call({
 String eventId, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, ShakeDetectionLevel level, int pointCount, double minLat, double maxLat, double minLng, double maxLng, String? correlatedEewEventId, List<ShakeDetectionPoint> points
});




}
/// @nodoc
class _$ShakeDetectionEventCopyWithImpl<$Res>
    implements $ShakeDetectionEventCopyWith<$Res> {
  _$ShakeDetectionEventCopyWithImpl(this._self, this._then);

  final ShakeDetectionEvent _self;
  final $Res Function(ShakeDetectionEvent) _then;

/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? pointCount = null,Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,Object? correlatedEewEventId = freezed,Object? points = null,}) {
  return _then(ShakeDetectionEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,correlatedEewEventId: freezed == correlatedEewEventId ? _self.correlatedEewEventId : correlatedEewEventId // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionPoint>,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  ShakeDetectionLevel level,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  String? correlatedEewEventId,  List<ShakeDetectionPoint> points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionEvent() when $default != null:
return $default(_that.eventId,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.correlatedEewEventId,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  ShakeDetectionLevel level,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  String? correlatedEewEventId,  List<ShakeDetectionPoint> points)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionEvent():
return $default(_that.eventId,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.correlatedEewEventId,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  DateTime createdAt,  DateTime updatedAt,  DateTime expiresAt,  ShakeDetectionLevel level,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  String? correlatedEewEventId,  List<ShakeDetectionPoint> points)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionEvent() when $default != null:
return $default(_that.eventId,_that.createdAt,_that.updatedAt,_that.expiresAt,_that.level,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.correlatedEewEventId,_that.points);case _:
  return null;

}
}

}

/// @nodoc


class _ShakeDetectionEvent implements ShakeDetectionEvent {
  const _ShakeDetectionEvent({required this.eventId, required this.createdAt, required this.updatedAt, required this.expiresAt, required this.level, required this.pointCount, required this.minLat, required this.maxLat, required this.minLng, required this.maxLng, this.correlatedEewEventId,  List<ShakeDetectionPoint> points = const []}): _points = points;
  

@override final  String eventId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime expiresAt;
@override final  ShakeDetectionLevel level;
@override final  int pointCount;
@override final  double minLat;
@override final  double maxLat;
@override final  double minLng;
@override final  double maxLng;
@override final  String? correlatedEewEventId;
 final  List<ShakeDetectionPoint> _points;
@override@JsonKey() List<ShakeDetectionPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionEventCopyWith<_ShakeDetectionEvent> get copyWith => __$ShakeDetectionEventCopyWithImpl<_ShakeDetectionEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng)&&(identical(other.correlatedEewEventId, correlatedEewEventId) || other.correlatedEewEventId == correlatedEewEventId)&&const DeepCollectionEquality().equals(other._points, _points));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,createdAt,updatedAt,expiresAt,level,pointCount,minLat,maxLat,minLng,maxLng,correlatedEewEventId,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'ShakeDetectionEvent(eventId: $eventId, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt, level: $level, pointCount: $pointCount, minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng, correlatedEewEventId: $correlatedEewEventId, points: $points)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionEventCopyWith<$Res> implements $ShakeDetectionEventCopyWith<$Res> {
  factory _$ShakeDetectionEventCopyWith(_ShakeDetectionEvent value, $Res Function(_ShakeDetectionEvent) _then) = __$ShakeDetectionEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime createdAt, DateTime updatedAt, DateTime expiresAt, ShakeDetectionLevel level, int pointCount, double minLat, double maxLat, double minLng, double maxLng, String? correlatedEewEventId, List<ShakeDetectionPoint> points
});




}
/// @nodoc
class __$ShakeDetectionEventCopyWithImpl<$Res>
    implements _$ShakeDetectionEventCopyWith<$Res> {
  __$ShakeDetectionEventCopyWithImpl(this._self, this._then);

  final _ShakeDetectionEvent _self;
  final $Res Function(_ShakeDetectionEvent) _then;

/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,Object? level = null,Object? pointCount = null,Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,Object? correlatedEewEventId = freezed,Object? points = null,}) {
  return _then(_ShakeDetectionEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,correlatedEewEventId: freezed == correlatedEewEventId ? _self.correlatedEewEventId : correlatedEewEventId // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionPoint>,
  ));
}


}

/// @nodoc
mixin _$ShakeDetectionPoint {

 String get code; String get name; double get latitude; double get longitude; double? get intensity; double get intensityDiff; String? get prefectureCode; String? get regionCode;
/// Create a copy of ShakeDetectionPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionPointCopyWith<ShakeDetectionPoint> get copyWith => _$ShakeDetectionPointCopyWithImpl<ShakeDetectionPoint>(this as ShakeDetectionPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionPoint&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.intensityDiff, intensityDiff) || other.intensityDiff == intensityDiff)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,latitude,longitude,intensity,intensityDiff,prefectureCode,regionCode);

@override
String toString() {
  return 'ShakeDetectionPoint(code: $code, name: $name, latitude: $latitude, longitude: $longitude, intensity: $intensity, intensityDiff: $intensityDiff, prefectureCode: $prefectureCode, regionCode: $regionCode)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionPointCopyWith<$Res>  {
  factory $ShakeDetectionPointCopyWith(ShakeDetectionPoint value, $Res Function(ShakeDetectionPoint) _then) = _$ShakeDetectionPointCopyWithImpl;
@useResult
$Res call({
 String code, String name, double latitude, double longitude, double? intensity, double intensityDiff, String? prefectureCode, String? regionCode
});




}
/// @nodoc
class _$ShakeDetectionPointCopyWithImpl<$Res>
    implements $ShakeDetectionPointCopyWith<$Res> {
  _$ShakeDetectionPointCopyWithImpl(this._self, this._then);

  final ShakeDetectionPoint _self;
  final $Res Function(ShakeDetectionPoint) _then;

/// Create a copy of ShakeDetectionPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? latitude = null,Object? longitude = null,Object? intensity = freezed,Object? intensityDiff = null,Object? prefectureCode = freezed,Object? regionCode = freezed,}) {
  return _then(ShakeDetectionPoint(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double?,intensityDiff: null == intensityDiff ? _self.intensityDiff : intensityDiff // ignore: cast_nullable_to_non_nullable
as double,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShakeDetectionPoint].
extension ShakeDetectionPointPatterns on ShakeDetectionPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionPoint value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionPoint value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  double latitude,  double longitude,  double? intensity,  double intensityDiff,  String? prefectureCode,  String? regionCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionPoint() when $default != null:
return $default(_that.code,_that.name,_that.latitude,_that.longitude,_that.intensity,_that.intensityDiff,_that.prefectureCode,_that.regionCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  double latitude,  double longitude,  double? intensity,  double intensityDiff,  String? prefectureCode,  String? regionCode)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionPoint():
return $default(_that.code,_that.name,_that.latitude,_that.longitude,_that.intensity,_that.intensityDiff,_that.prefectureCode,_that.regionCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  double latitude,  double longitude,  double? intensity,  double intensityDiff,  String? prefectureCode,  String? regionCode)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionPoint() when $default != null:
return $default(_that.code,_that.name,_that.latitude,_that.longitude,_that.intensity,_that.intensityDiff,_that.prefectureCode,_that.regionCode);case _:
  return null;

}
}

}

/// @nodoc


class _ShakeDetectionPoint implements ShakeDetectionPoint {
  const _ShakeDetectionPoint({required this.code, required this.name, required this.latitude, required this.longitude, required this.intensity, required this.intensityDiff, required this.prefectureCode, required this.regionCode});
  

@override final  String code;
@override final  String name;
@override final  double latitude;
@override final  double longitude;
@override final  double? intensity;
@override final  double intensityDiff;
@override final  String? prefectureCode;
@override final  String? regionCode;

/// Create a copy of ShakeDetectionPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionPointCopyWith<_ShakeDetectionPoint> get copyWith => __$ShakeDetectionPointCopyWithImpl<_ShakeDetectionPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionPoint&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.intensityDiff, intensityDiff) || other.intensityDiff == intensityDiff)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,latitude,longitude,intensity,intensityDiff,prefectureCode,regionCode);

@override
String toString() {
  return 'ShakeDetectionPoint(code: $code, name: $name, latitude: $latitude, longitude: $longitude, intensity: $intensity, intensityDiff: $intensityDiff, prefectureCode: $prefectureCode, regionCode: $regionCode)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionPointCopyWith<$Res> implements $ShakeDetectionPointCopyWith<$Res> {
  factory _$ShakeDetectionPointCopyWith(_ShakeDetectionPoint value, $Res Function(_ShakeDetectionPoint) _then) = __$ShakeDetectionPointCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, double latitude, double longitude, double? intensity, double intensityDiff, String? prefectureCode, String? regionCode
});




}
/// @nodoc
class __$ShakeDetectionPointCopyWithImpl<$Res>
    implements _$ShakeDetectionPointCopyWith<$Res> {
  __$ShakeDetectionPointCopyWithImpl(this._self, this._then);

  final _ShakeDetectionPoint _self;
  final $Res Function(_ShakeDetectionPoint) _then;

/// Create a copy of ShakeDetectionPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? latitude = null,Object? longitude = null,Object? intensity = freezed,Object? intensityDiff = null,Object? prefectureCode = freezed,Object? regionCode = freezed,}) {
  return _then(_ShakeDetectionPoint(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double?,intensityDiff: null == intensityDiff ? _self.intensityDiff : intensityDiff // ignore: cast_nullable_to_non_nullable
as double,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

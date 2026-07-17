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

 String get eventId; DateTime get createdAt; ShakeDetectionLevel get level; bool get isReplay; int get pointCount; double get minLat; double get maxLat; double get minLng; double get maxLng;/// 結合済み EEW の eventId。null なら未結合（表示対象）
 String? get mergedEewEventId;
/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionEventCopyWith<ShakeDetectionEvent> get copyWith => _$ShakeDetectionEventCopyWithImpl<ShakeDetectionEvent>(this as ShakeDetectionEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.level, level)&&(identical(other.isReplay, isReplay) || other.isReplay == isReplay)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng)&&(identical(other.mergedEewEventId, mergedEewEventId) || other.mergedEewEventId == mergedEewEventId));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,createdAt,const DeepCollectionEquality().hash(level),isReplay,pointCount,minLat,maxLat,minLng,maxLng,mergedEewEventId);

@override
String toString() {
  return 'ShakeDetectionEvent(eventId: $eventId, createdAt: $createdAt, level: $level, isReplay: $isReplay, pointCount: $pointCount, minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng, mergedEewEventId: $mergedEewEventId)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionEventCopyWith<$Res>  {
  factory $ShakeDetectionEventCopyWith(ShakeDetectionEvent value, $Res Function(ShakeDetectionEvent) _then) = _$ShakeDetectionEventCopyWithImpl;
@useResult
$Res call({
 String eventId, DateTime createdAt, ShakeDetectionLevel level, bool isReplay, int pointCount, double minLat, double maxLat, double minLng, double maxLng, String? mergedEewEventId
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
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? createdAt = null,Object? level = freezed,Object? isReplay = null,Object? pointCount = null,Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,Object? mergedEewEventId = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,isReplay: null == isReplay ? _self.isReplay : isReplay // ignore: cast_nullable_to_non_nullable
as bool,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,mergedEewEventId: freezed == mergedEewEventId ? _self.mergedEewEventId : mergedEewEventId // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  DateTime createdAt,  ShakeDetectionLevel level,  bool isReplay,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  String? mergedEewEventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionEvent() when $default != null:
return $default(_that.eventId,_that.createdAt,_that.level,_that.isReplay,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.mergedEewEventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  DateTime createdAt,  ShakeDetectionLevel level,  bool isReplay,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  String? mergedEewEventId)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionEvent():
return $default(_that.eventId,_that.createdAt,_that.level,_that.isReplay,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.mergedEewEventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  DateTime createdAt,  ShakeDetectionLevel level,  bool isReplay,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  String? mergedEewEventId)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionEvent() when $default != null:
return $default(_that.eventId,_that.createdAt,_that.level,_that.isReplay,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.mergedEewEventId);case _:
  return null;

}
}

}

/// @nodoc


class _ShakeDetectionEvent implements ShakeDetectionEvent {
  const _ShakeDetectionEvent({required this.eventId, required this.createdAt, required this.level, required this.isReplay, required this.pointCount, required this.minLat, required this.maxLat, required this.minLng, required this.maxLng, this.mergedEewEventId});
  

@override final  String eventId;
@override final  DateTime createdAt;
@override final  ShakeDetectionLevel level;
@override final  bool isReplay;
@override final  int pointCount;
@override final  double minLat;
@override final  double maxLat;
@override final  double minLng;
@override final  double maxLng;
/// 結合済み EEW の eventId。null なら未結合（表示対象）
@override final  String? mergedEewEventId;

/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionEventCopyWith<_ShakeDetectionEvent> get copyWith => __$ShakeDetectionEventCopyWithImpl<_ShakeDetectionEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.level, level)&&(identical(other.isReplay, isReplay) || other.isReplay == isReplay)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng)&&(identical(other.mergedEewEventId, mergedEewEventId) || other.mergedEewEventId == mergedEewEventId));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,createdAt,const DeepCollectionEquality().hash(level),isReplay,pointCount,minLat,maxLat,minLng,maxLng,mergedEewEventId);

@override
String toString() {
  return 'ShakeDetectionEvent(eventId: $eventId, createdAt: $createdAt, level: $level, isReplay: $isReplay, pointCount: $pointCount, minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng, mergedEewEventId: $mergedEewEventId)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionEventCopyWith<$Res> implements $ShakeDetectionEventCopyWith<$Res> {
  factory _$ShakeDetectionEventCopyWith(_ShakeDetectionEvent value, $Res Function(_ShakeDetectionEvent) _then) = __$ShakeDetectionEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime createdAt, ShakeDetectionLevel level, bool isReplay, int pointCount, double minLat, double maxLat, double minLng, double maxLng, String? mergedEewEventId
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
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? createdAt = null,Object? level = freezed,Object? isReplay = null,Object? pointCount = null,Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,Object? mergedEewEventId = freezed,}) {
  return _then(_ShakeDetectionEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,isReplay: null == isReplay ? _self.isReplay : isReplay // ignore: cast_nullable_to_non_nullable
as bool,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,mergedEewEventId: freezed == mergedEewEventId ? _self.mergedEewEventId : mergedEewEventId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

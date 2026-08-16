// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeismicityEvent {

/// イベントID(Hi-net由来は合成ID)
 String get eventId;/// 発生時刻
 DateTime get originTime;/// マグニチュード(不明な場合 null)
 double? get magnitude;/// 深さ(km、不明な場合 null)
 double? get depth;/// 緯度(度)
 double get latitude;/// 経度(度)
 double get longitude;/// 最大震度(Hi-net由来は null)
 String? get maxIntensity;
/// Create a copy of SeismicityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityEventCopyWith<SeismicityEvent> get copyWith => _$SeismicityEventCopyWithImpl<SeismicityEvent>(this as SeismicityEvent, _$identity);

  /// Serializes this SeismicityEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,originTime,magnitude,depth,latitude,longitude,maxIntensity);

@override
String toString() {
  return 'SeismicityEvent(eventId: $eventId, originTime: $originTime, magnitude: $magnitude, depth: $depth, latitude: $latitude, longitude: $longitude, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class $SeismicityEventCopyWith<$Res>  {
  factory $SeismicityEventCopyWith(SeismicityEvent value, $Res Function(SeismicityEvent) _then) = _$SeismicityEventCopyWithImpl;
@useResult
$Res call({
 String eventId, DateTime originTime, double? magnitude, double? depth, double latitude, double longitude, String? maxIntensity
});




}
/// @nodoc
class _$SeismicityEventCopyWithImpl<$Res>
    implements $SeismicityEventCopyWith<$Res> {
  _$SeismicityEventCopyWithImpl(this._self, this._then);

  final SeismicityEvent _self;
  final $Res Function(SeismicityEvent) _then;

/// Create a copy of SeismicityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? originTime = null,Object? magnitude = freezed,Object? depth = freezed,Object? latitude = null,Object? longitude = null,Object? maxIntensity = freezed,}) {
  return _then(SeismicityEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityEvent].
extension SeismicityEventPatterns on SeismicityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityEvent value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityEvent value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  DateTime originTime,  double? magnitude,  double? depth,  double latitude,  double longitude,  String? maxIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityEvent() when $default != null:
return $default(_that.eventId,_that.originTime,_that.magnitude,_that.depth,_that.latitude,_that.longitude,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  DateTime originTime,  double? magnitude,  double? depth,  double latitude,  double longitude,  String? maxIntensity)  $default,) {final _that = this;
switch (_that) {
case _SeismicityEvent():
return $default(_that.eventId,_that.originTime,_that.magnitude,_that.depth,_that.latitude,_that.longitude,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  DateTime originTime,  double? magnitude,  double? depth,  double latitude,  double longitude,  String? maxIntensity)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityEvent() when $default != null:
return $default(_that.eventId,_that.originTime,_that.magnitude,_that.depth,_that.latitude,_that.longitude,_that.maxIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeismicityEvent implements SeismicityEvent {
  const _SeismicityEvent({required this.eventId, required this.originTime, required this.magnitude, required this.depth, required this.latitude, required this.longitude, required this.maxIntensity});
  factory _SeismicityEvent.fromJson(Map<String, dynamic> json) => _$SeismicityEventFromJson(json);

/// イベントID(Hi-net由来は合成ID)
@override final  String eventId;
/// 発生時刻
@override final  DateTime originTime;
/// マグニチュード(不明な場合 null)
@override final  double? magnitude;
/// 深さ(km、不明な場合 null)
@override final  double? depth;
/// 緯度(度)
@override final  double latitude;
/// 経度(度)
@override final  double longitude;
/// 最大震度(Hi-net由来は null)
@override final  String? maxIntensity;

/// Create a copy of SeismicityEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityEventCopyWith<_SeismicityEvent> get copyWith => __$SeismicityEventCopyWithImpl<_SeismicityEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeismicityEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicityEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,originTime,magnitude,depth,latitude,longitude,maxIntensity);

@override
String toString() {
  return 'SeismicityEvent(eventId: $eventId, originTime: $originTime, magnitude: $magnitude, depth: $depth, latitude: $latitude, longitude: $longitude, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class _$SeismicityEventCopyWith<$Res> implements $SeismicityEventCopyWith<$Res> {
  factory _$SeismicityEventCopyWith(_SeismicityEvent value, $Res Function(_SeismicityEvent) _then) = __$SeismicityEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime originTime, double? magnitude, double? depth, double latitude, double longitude, String? maxIntensity
});




}
/// @nodoc
class __$SeismicityEventCopyWithImpl<$Res>
    implements _$SeismicityEventCopyWith<$Res> {
  __$SeismicityEventCopyWithImpl(this._self, this._then);

  final _SeismicityEvent _self;
  final $Res Function(_SeismicityEvent) _then;

/// Create a copy of SeismicityEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? originTime = null,Object? magnitude = freezed,Object? depth = freezed,Object? latitude = null,Object? longitude = null,Object? maxIntensity = freezed,}) {
  return _then(_SeismicityEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

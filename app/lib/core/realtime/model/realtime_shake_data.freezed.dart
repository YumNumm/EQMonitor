// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_shake_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeShakeData {

 String get eventId; DateTime get createdAt; String get level; bool get isReplay; int get pointCount; double get minLat; double get maxLat; double get minLng; double get maxLng; List<String> get changeReasons;
/// Create a copy of RealtimeShakeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeShakeDataCopyWith<RealtimeShakeData> get copyWith => _$RealtimeShakeDataCopyWithImpl<RealtimeShakeData>(this as RealtimeShakeData, _$identity);

  /// Serializes this RealtimeShakeData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeShakeData&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.isReplay, isReplay) || other.isReplay == isReplay)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng)&&const DeepCollectionEquality().equals(other.changeReasons, changeReasons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,createdAt,level,isReplay,pointCount,minLat,maxLat,minLng,maxLng,const DeepCollectionEquality().hash(changeReasons));

@override
String toString() {
  return 'RealtimeShakeData(eventId: $eventId, createdAt: $createdAt, level: $level, isReplay: $isReplay, pointCount: $pointCount, minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng, changeReasons: $changeReasons)';
}


}

/// @nodoc
abstract mixin class $RealtimeShakeDataCopyWith<$Res>  {
  factory $RealtimeShakeDataCopyWith(RealtimeShakeData value, $Res Function(RealtimeShakeData) _then) = _$RealtimeShakeDataCopyWithImpl;
@useResult
$Res call({
 String eventId, DateTime createdAt, String level, bool isReplay, int pointCount, double minLat, double maxLat, double minLng, double maxLng, List<String> changeReasons
});




}
/// @nodoc
class _$RealtimeShakeDataCopyWithImpl<$Res>
    implements $RealtimeShakeDataCopyWith<$Res> {
  _$RealtimeShakeDataCopyWithImpl(this._self, this._then);

  final RealtimeShakeData _self;
  final $Res Function(RealtimeShakeData) _then;

/// Create a copy of RealtimeShakeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? createdAt = null,Object? level = null,Object? isReplay = null,Object? pointCount = null,Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,Object? changeReasons = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,isReplay: null == isReplay ? _self.isReplay : isReplay // ignore: cast_nullable_to_non_nullable
as bool,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,changeReasons: null == changeReasons ? _self.changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeShakeData].
extension RealtimeShakeDataPatterns on RealtimeShakeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeShakeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeShakeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeShakeData value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeShakeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeShakeData value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeShakeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  DateTime createdAt,  String level,  bool isReplay,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  List<String> changeReasons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeShakeData() when $default != null:
return $default(_that.eventId,_that.createdAt,_that.level,_that.isReplay,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.changeReasons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  DateTime createdAt,  String level,  bool isReplay,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  List<String> changeReasons)  $default,) {final _that = this;
switch (_that) {
case _RealtimeShakeData():
return $default(_that.eventId,_that.createdAt,_that.level,_that.isReplay,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.changeReasons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  DateTime createdAt,  String level,  bool isReplay,  int pointCount,  double minLat,  double maxLat,  double minLng,  double maxLng,  List<String> changeReasons)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeShakeData() when $default != null:
return $default(_that.eventId,_that.createdAt,_that.level,_that.isReplay,_that.pointCount,_that.minLat,_that.maxLat,_that.minLng,_that.maxLng,_that.changeReasons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeShakeData implements RealtimeShakeData {
  const _RealtimeShakeData({required this.eventId, required this.createdAt, required this.level, required this.isReplay, required this.pointCount, required this.minLat, required this.maxLat, required this.minLng, required this.maxLng, final  List<String> changeReasons = const []}): _changeReasons = changeReasons;
  factory _RealtimeShakeData.fromJson(Map<String, dynamic> json) => _$RealtimeShakeDataFromJson(json);

@override final  String eventId;
@override final  DateTime createdAt;
@override final  String level;
@override final  bool isReplay;
@override final  int pointCount;
@override final  double minLat;
@override final  double maxLat;
@override final  double minLng;
@override final  double maxLng;
 final  List<String> _changeReasons;
@override@JsonKey() List<String> get changeReasons {
  if (_changeReasons is EqualUnmodifiableListView) return _changeReasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_changeReasons);
}


/// Create a copy of RealtimeShakeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeShakeDataCopyWith<_RealtimeShakeData> get copyWith => __$RealtimeShakeDataCopyWithImpl<_RealtimeShakeData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeShakeDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeShakeData&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.isReplay, isReplay) || other.isReplay == isReplay)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount)&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng)&&const DeepCollectionEquality().equals(other._changeReasons, _changeReasons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,createdAt,level,isReplay,pointCount,minLat,maxLat,minLng,maxLng,const DeepCollectionEquality().hash(_changeReasons));

@override
String toString() {
  return 'RealtimeShakeData(eventId: $eventId, createdAt: $createdAt, level: $level, isReplay: $isReplay, pointCount: $pointCount, minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng, changeReasons: $changeReasons)';
}


}

/// @nodoc
abstract mixin class _$RealtimeShakeDataCopyWith<$Res> implements $RealtimeShakeDataCopyWith<$Res> {
  factory _$RealtimeShakeDataCopyWith(_RealtimeShakeData value, $Res Function(_RealtimeShakeData) _then) = __$RealtimeShakeDataCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime createdAt, String level, bool isReplay, int pointCount, double minLat, double maxLat, double minLng, double maxLng, List<String> changeReasons
});




}
/// @nodoc
class __$RealtimeShakeDataCopyWithImpl<$Res>
    implements _$RealtimeShakeDataCopyWith<$Res> {
  __$RealtimeShakeDataCopyWithImpl(this._self, this._then);

  final _RealtimeShakeData _self;
  final $Res Function(_RealtimeShakeData) _then;

/// Create a copy of RealtimeShakeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? createdAt = null,Object? level = null,Object? isReplay = null,Object? pointCount = null,Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,Object? changeReasons = null,}) {
  return _then(_RealtimeShakeData(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,isReplay: null == isReplay ? _self.isReplay : isReplay // ignore: cast_nullable_to_non_nullable
as bool,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,changeReasons: null == changeReasons ? _self._changeReasons : changeReasons // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

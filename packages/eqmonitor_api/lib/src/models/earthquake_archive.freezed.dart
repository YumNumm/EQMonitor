// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_archive.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeArchive {

 String get eventId; EarthquakeArchiveType get type; String get objectKey; String get originTime; String get startTime; String get endTime;@JsonKey(includeIfNull: true) num? get magnitude;@JsonKey(includeIfNull: true) String? get hypocenterName; num get fileSizeBytes; EarthquakeArchiveWaveformStatus get waveformStatus;@JsonKey(includeIfNull: true) String? get waveformCheckedAt; String get createdAt; String get updatedAt; List<EarthquakeArchiveFrame> get frames;
/// Create a copy of EarthquakeArchive
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeArchiveCopyWith<EarthquakeArchive> get copyWith => _$EarthquakeArchiveCopyWithImpl<EarthquakeArchive>(this as EarthquakeArchive, _$identity);

  /// Serializes this EarthquakeArchive to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeArchive&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.hypocenterName, hypocenterName) || other.hypocenterName == hypocenterName)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.waveformStatus, waveformStatus) || other.waveformStatus == waveformStatus)&&(identical(other.waveformCheckedAt, waveformCheckedAt) || other.waveformCheckedAt == waveformCheckedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.frames, frames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,type,objectKey,originTime,startTime,endTime,magnitude,hypocenterName,fileSizeBytes,waveformStatus,waveformCheckedAt,createdAt,updatedAt,const DeepCollectionEquality().hash(frames));

@override
String toString() {
  return 'EarthquakeArchive(eventId: $eventId, type: $type, objectKey: $objectKey, originTime: $originTime, startTime: $startTime, endTime: $endTime, magnitude: $magnitude, hypocenterName: $hypocenterName, fileSizeBytes: $fileSizeBytes, waveformStatus: $waveformStatus, waveformCheckedAt: $waveformCheckedAt, createdAt: $createdAt, updatedAt: $updatedAt, frames: $frames)';
}


}

/// @nodoc
abstract mixin class $EarthquakeArchiveCopyWith<$Res>  {
  factory $EarthquakeArchiveCopyWith(EarthquakeArchive value, $Res Function(EarthquakeArchive) _then) = _$EarthquakeArchiveCopyWithImpl;
@useResult
$Res call({
 String eventId, EarthquakeArchiveType type, String objectKey, String originTime, String startTime, String endTime,@JsonKey(includeIfNull: true) num? magnitude,@JsonKey(includeIfNull: true) String? hypocenterName, num fileSizeBytes, EarthquakeArchiveWaveformStatus waveformStatus,@JsonKey(includeIfNull: true) String? waveformCheckedAt, String createdAt, String updatedAt, List<EarthquakeArchiveFrame> frames
});




}
/// @nodoc
class _$EarthquakeArchiveCopyWithImpl<$Res>
    implements $EarthquakeArchiveCopyWith<$Res> {
  _$EarthquakeArchiveCopyWithImpl(this._self, this._then);

  final EarthquakeArchive _self;
  final $Res Function(EarthquakeArchive) _then;

/// Create a copy of EarthquakeArchive
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? type = null,Object? objectKey = null,Object? originTime = null,Object? startTime = null,Object? endTime = null,Object? magnitude = freezed,Object? hypocenterName = freezed,Object? fileSizeBytes = null,Object? waveformStatus = null,Object? waveformCheckedAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? frames = null,}) {
  return _then(EarthquakeArchive(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeArchiveType,objectKey: null == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as num?,hypocenterName: freezed == hypocenterName ? _self.hypocenterName : hypocenterName // ignore: cast_nullable_to_non_nullable
as String?,fileSizeBytes: null == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as num,waveformStatus: null == waveformStatus ? _self.waveformStatus : waveformStatus // ignore: cast_nullable_to_non_nullable
as EarthquakeArchiveWaveformStatus,waveformCheckedAt: freezed == waveformCheckedAt ? _self.waveformCheckedAt : waveformCheckedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,frames: null == frames ? _self.frames : frames // ignore: cast_nullable_to_non_nullable
as List<EarthquakeArchiveFrame>,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeArchive].
extension EarthquakeArchivePatterns on EarthquakeArchive {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeArchive value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeArchive() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeArchive value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeArchive():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeArchive value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeArchive() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  EarthquakeArchiveType type,  String objectKey,  String originTime,  String startTime,  String endTime, @JsonKey(includeIfNull: true)  num? magnitude, @JsonKey(includeIfNull: true)  String? hypocenterName,  num fileSizeBytes,  EarthquakeArchiveWaveformStatus waveformStatus, @JsonKey(includeIfNull: true)  String? waveformCheckedAt,  String createdAt,  String updatedAt,  List<EarthquakeArchiveFrame> frames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeArchive() when $default != null:
return $default(_that.eventId,_that.type,_that.objectKey,_that.originTime,_that.startTime,_that.endTime,_that.magnitude,_that.hypocenterName,_that.fileSizeBytes,_that.waveformStatus,_that.waveformCheckedAt,_that.createdAt,_that.updatedAt,_that.frames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  EarthquakeArchiveType type,  String objectKey,  String originTime,  String startTime,  String endTime, @JsonKey(includeIfNull: true)  num? magnitude, @JsonKey(includeIfNull: true)  String? hypocenterName,  num fileSizeBytes,  EarthquakeArchiveWaveformStatus waveformStatus, @JsonKey(includeIfNull: true)  String? waveformCheckedAt,  String createdAt,  String updatedAt,  List<EarthquakeArchiveFrame> frames)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeArchive():
return $default(_that.eventId,_that.type,_that.objectKey,_that.originTime,_that.startTime,_that.endTime,_that.magnitude,_that.hypocenterName,_that.fileSizeBytes,_that.waveformStatus,_that.waveformCheckedAt,_that.createdAt,_that.updatedAt,_that.frames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  EarthquakeArchiveType type,  String objectKey,  String originTime,  String startTime,  String endTime, @JsonKey(includeIfNull: true)  num? magnitude, @JsonKey(includeIfNull: true)  String? hypocenterName,  num fileSizeBytes,  EarthquakeArchiveWaveformStatus waveformStatus, @JsonKey(includeIfNull: true)  String? waveformCheckedAt,  String createdAt,  String updatedAt,  List<EarthquakeArchiveFrame> frames)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeArchive() when $default != null:
return $default(_that.eventId,_that.type,_that.objectKey,_that.originTime,_that.startTime,_that.endTime,_that.magnitude,_that.hypocenterName,_that.fileSizeBytes,_that.waveformStatus,_that.waveformCheckedAt,_that.createdAt,_that.updatedAt,_that.frames);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeArchive implements EarthquakeArchive {
  const _EarthquakeArchive({required this.eventId, required this.type, required this.objectKey, required this.originTime, required this.startTime, required this.endTime, @JsonKey(includeIfNull: true) required this.magnitude, @JsonKey(includeIfNull: true) required this.hypocenterName, required this.fileSizeBytes, required this.waveformStatus, @JsonKey(includeIfNull: true) required this.waveformCheckedAt, required this.createdAt, required this.updatedAt, required  List<EarthquakeArchiveFrame> frames}): _frames = frames;
  factory _EarthquakeArchive.fromJson(Map<String, dynamic> json) => _$EarthquakeArchiveFromJson(json);

@override final  String eventId;
@override final  EarthquakeArchiveType type;
@override final  String objectKey;
@override final  String originTime;
@override final  String startTime;
@override final  String endTime;
@override@JsonKey(includeIfNull: true) final  num? magnitude;
@override@JsonKey(includeIfNull: true) final  String? hypocenterName;
@override final  num fileSizeBytes;
@override final  EarthquakeArchiveWaveformStatus waveformStatus;
@override@JsonKey(includeIfNull: true) final  String? waveformCheckedAt;
@override final  String createdAt;
@override final  String updatedAt;
 final  List<EarthquakeArchiveFrame> _frames;
@override List<EarthquakeArchiveFrame> get frames {
  if (_frames is EqualUnmodifiableListView) return _frames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_frames);
}


/// Create a copy of EarthquakeArchive
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeArchiveCopyWith<_EarthquakeArchive> get copyWith => __$EarthquakeArchiveCopyWithImpl<_EarthquakeArchive>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeArchiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeArchive&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.hypocenterName, hypocenterName) || other.hypocenterName == hypocenterName)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.waveformStatus, waveformStatus) || other.waveformStatus == waveformStatus)&&(identical(other.waveformCheckedAt, waveformCheckedAt) || other.waveformCheckedAt == waveformCheckedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._frames, _frames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,type,objectKey,originTime,startTime,endTime,magnitude,hypocenterName,fileSizeBytes,waveformStatus,waveformCheckedAt,createdAt,updatedAt,const DeepCollectionEquality().hash(_frames));

@override
String toString() {
  return 'EarthquakeArchive(eventId: $eventId, type: $type, objectKey: $objectKey, originTime: $originTime, startTime: $startTime, endTime: $endTime, magnitude: $magnitude, hypocenterName: $hypocenterName, fileSizeBytes: $fileSizeBytes, waveformStatus: $waveformStatus, waveformCheckedAt: $waveformCheckedAt, createdAt: $createdAt, updatedAt: $updatedAt, frames: $frames)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeArchiveCopyWith<$Res> implements $EarthquakeArchiveCopyWith<$Res> {
  factory _$EarthquakeArchiveCopyWith(_EarthquakeArchive value, $Res Function(_EarthquakeArchive) _then) = __$EarthquakeArchiveCopyWithImpl;
@override @useResult
$Res call({
 String eventId, EarthquakeArchiveType type, String objectKey, String originTime, String startTime, String endTime,@JsonKey(includeIfNull: true) num? magnitude,@JsonKey(includeIfNull: true) String? hypocenterName, num fileSizeBytes, EarthquakeArchiveWaveformStatus waveformStatus,@JsonKey(includeIfNull: true) String? waveformCheckedAt, String createdAt, String updatedAt, List<EarthquakeArchiveFrame> frames
});




}
/// @nodoc
class __$EarthquakeArchiveCopyWithImpl<$Res>
    implements _$EarthquakeArchiveCopyWith<$Res> {
  __$EarthquakeArchiveCopyWithImpl(this._self, this._then);

  final _EarthquakeArchive _self;
  final $Res Function(_EarthquakeArchive) _then;

/// Create a copy of EarthquakeArchive
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? type = null,Object? objectKey = null,Object? originTime = null,Object? startTime = null,Object? endTime = null,Object? magnitude = freezed,Object? hypocenterName = freezed,Object? fileSizeBytes = null,Object? waveformStatus = null,Object? waveformCheckedAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? frames = null,}) {
  return _then(_EarthquakeArchive(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeArchiveType,objectKey: null == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as num?,hypocenterName: freezed == hypocenterName ? _self.hypocenterName : hypocenterName // ignore: cast_nullable_to_non_nullable
as String?,fileSizeBytes: null == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as num,waveformStatus: null == waveformStatus ? _self.waveformStatus : waveformStatus // ignore: cast_nullable_to_non_nullable
as EarthquakeArchiveWaveformStatus,waveformCheckedAt: freezed == waveformCheckedAt ? _self.waveformCheckedAt : waveformCheckedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,frames: null == frames ? _self._frames : frames // ignore: cast_nullable_to_non_nullable
as List<EarthquakeArchiveFrame>,
  ));
}


}

// dart format on

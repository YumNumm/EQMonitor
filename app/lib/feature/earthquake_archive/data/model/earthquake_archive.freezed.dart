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
mixin _$EarthquakeArchiveFrame {

 EarthquakeArchiveFrameKind get kind; int get frameType; int get frameCount; int get totalBytes; DateTime get firstTime; DateTime get lastTime;
/// Create a copy of EarthquakeArchiveFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeArchiveFrameCopyWith<EarthquakeArchiveFrame> get copyWith => _$EarthquakeArchiveFrameCopyWithImpl<EarthquakeArchiveFrame>(this as EarthquakeArchiveFrame, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeArchiveFrame&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.frameType, frameType) || other.frameType == frameType)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount)&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes)&&(identical(other.firstTime, firstTime) || other.firstTime == firstTime)&&(identical(other.lastTime, lastTime) || other.lastTime == lastTime));
}


@override
int get hashCode => Object.hash(runtimeType,kind,frameType,frameCount,totalBytes,firstTime,lastTime);

@override
String toString() {
  return 'EarthquakeArchiveFrame(kind: $kind, frameType: $frameType, frameCount: $frameCount, totalBytes: $totalBytes, firstTime: $firstTime, lastTime: $lastTime)';
}


}

/// @nodoc
abstract mixin class $EarthquakeArchiveFrameCopyWith<$Res>  {
  factory $EarthquakeArchiveFrameCopyWith(EarthquakeArchiveFrame value, $Res Function(EarthquakeArchiveFrame) _then) = _$EarthquakeArchiveFrameCopyWithImpl;
@useResult
$Res call({
 EarthquakeArchiveFrameKind kind, int frameType, int frameCount, int totalBytes, DateTime firstTime, DateTime lastTime
});




}
/// @nodoc
class _$EarthquakeArchiveFrameCopyWithImpl<$Res>
    implements $EarthquakeArchiveFrameCopyWith<$Res> {
  _$EarthquakeArchiveFrameCopyWithImpl(this._self, this._then);

  final EarthquakeArchiveFrame _self;
  final $Res Function(EarthquakeArchiveFrame) _then;

/// Create a copy of EarthquakeArchiveFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? frameType = null,Object? frameCount = null,Object? totalBytes = null,Object? firstTime = null,Object? lastTime = null,}) {
  return _then(EarthquakeArchiveFrame(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as EarthquakeArchiveFrameKind,frameType: null == frameType ? _self.frameType : frameType // ignore: cast_nullable_to_non_nullable
as int,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,totalBytes: null == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int,firstTime: null == firstTime ? _self.firstTime : firstTime // ignore: cast_nullable_to_non_nullable
as DateTime,lastTime: null == lastTime ? _self.lastTime : lastTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeArchiveFrame].
extension EarthquakeArchiveFramePatterns on EarthquakeArchiveFrame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeArchiveFrame value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeArchiveFrame() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeArchiveFrame value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeArchiveFrame():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeArchiveFrame value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeArchiveFrame() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeArchiveFrameKind kind,  int frameType,  int frameCount,  int totalBytes,  DateTime firstTime,  DateTime lastTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeArchiveFrame() when $default != null:
return $default(_that.kind,_that.frameType,_that.frameCount,_that.totalBytes,_that.firstTime,_that.lastTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeArchiveFrameKind kind,  int frameType,  int frameCount,  int totalBytes,  DateTime firstTime,  DateTime lastTime)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeArchiveFrame():
return $default(_that.kind,_that.frameType,_that.frameCount,_that.totalBytes,_that.firstTime,_that.lastTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeArchiveFrameKind kind,  int frameType,  int frameCount,  int totalBytes,  DateTime firstTime,  DateTime lastTime)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeArchiveFrame() when $default != null:
return $default(_that.kind,_that.frameType,_that.frameCount,_that.totalBytes,_that.firstTime,_that.lastTime);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeArchiveFrame extends EarthquakeArchiveFrame {
  const _EarthquakeArchiveFrame({required this.kind, required this.frameType, required this.frameCount, required this.totalBytes, required this.firstTime, required this.lastTime}): super._();
  

@override final  EarthquakeArchiveFrameKind kind;
@override final  int frameType;
@override final  int frameCount;
@override final  int totalBytes;
@override final  DateTime firstTime;
@override final  DateTime lastTime;

/// Create a copy of EarthquakeArchiveFrame
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeArchiveFrameCopyWith<_EarthquakeArchiveFrame> get copyWith => __$EarthquakeArchiveFrameCopyWithImpl<_EarthquakeArchiveFrame>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeArchiveFrame&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.frameType, frameType) || other.frameType == frameType)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount)&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes)&&(identical(other.firstTime, firstTime) || other.firstTime == firstTime)&&(identical(other.lastTime, lastTime) || other.lastTime == lastTime));
}


@override
int get hashCode => Object.hash(runtimeType,kind,frameType,frameCount,totalBytes,firstTime,lastTime);

@override
String toString() {
  return 'EarthquakeArchiveFrame(kind: $kind, frameType: $frameType, frameCount: $frameCount, totalBytes: $totalBytes, firstTime: $firstTime, lastTime: $lastTime)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeArchiveFrameCopyWith<$Res> implements $EarthquakeArchiveFrameCopyWith<$Res> {
  factory _$EarthquakeArchiveFrameCopyWith(_EarthquakeArchiveFrame value, $Res Function(_EarthquakeArchiveFrame) _then) = __$EarthquakeArchiveFrameCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeArchiveFrameKind kind, int frameType, int frameCount, int totalBytes, DateTime firstTime, DateTime lastTime
});




}
/// @nodoc
class __$EarthquakeArchiveFrameCopyWithImpl<$Res>
    implements _$EarthquakeArchiveFrameCopyWith<$Res> {
  __$EarthquakeArchiveFrameCopyWithImpl(this._self, this._then);

  final _EarthquakeArchiveFrame _self;
  final $Res Function(_EarthquakeArchiveFrame) _then;

/// Create a copy of EarthquakeArchiveFrame
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? frameType = null,Object? frameCount = null,Object? totalBytes = null,Object? firstTime = null,Object? lastTime = null,}) {
  return _then(_EarthquakeArchiveFrame(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as EarthquakeArchiveFrameKind,frameType: null == frameType ? _self.frameType : frameType // ignore: cast_nullable_to_non_nullable
as int,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,totalBytes: null == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int,firstTime: null == firstTime ? _self.firstTime : firstTime // ignore: cast_nullable_to_non_nullable
as DateTime,lastTime: null == lastTime ? _self.lastTime : lastTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$EarthquakeArchive {

 String get eventId; EarthquakeArchiveType get type; String get objectKey; DateTime get originTime; DateTime get startTime; DateTime get endTime; double? get magnitude; String? get hypocenterName; int get fileSizeBytes; EarthquakeArchiveWaveformStatus get waveformStatus; List<EarthquakeArchiveFrame> get frames;
/// Create a copy of EarthquakeArchive
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeArchiveCopyWith<EarthquakeArchive> get copyWith => _$EarthquakeArchiveCopyWithImpl<EarthquakeArchive>(this as EarthquakeArchive, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeArchive&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.hypocenterName, hypocenterName) || other.hypocenterName == hypocenterName)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.waveformStatus, waveformStatus) || other.waveformStatus == waveformStatus)&&const DeepCollectionEquality().equals(other.frames, frames));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,type,objectKey,originTime,startTime,endTime,magnitude,hypocenterName,fileSizeBytes,waveformStatus,const DeepCollectionEquality().hash(frames));

@override
String toString() {
  return 'EarthquakeArchive(eventId: $eventId, type: $type, objectKey: $objectKey, originTime: $originTime, startTime: $startTime, endTime: $endTime, magnitude: $magnitude, hypocenterName: $hypocenterName, fileSizeBytes: $fileSizeBytes, waveformStatus: $waveformStatus, frames: $frames)';
}


}

/// @nodoc
abstract mixin class $EarthquakeArchiveCopyWith<$Res>  {
  factory $EarthquakeArchiveCopyWith(EarthquakeArchive value, $Res Function(EarthquakeArchive) _then) = _$EarthquakeArchiveCopyWithImpl;
@useResult
$Res call({
 String eventId, EarthquakeArchiveType type, String objectKey, DateTime originTime, DateTime startTime, DateTime endTime, double? magnitude, String? hypocenterName, int fileSizeBytes, EarthquakeArchiveWaveformStatus waveformStatus, List<EarthquakeArchiveFrame> frames
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
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? type = null,Object? objectKey = null,Object? originTime = null,Object? startTime = null,Object? endTime = null,Object? magnitude = freezed,Object? hypocenterName = freezed,Object? fileSizeBytes = null,Object? waveformStatus = null,Object? frames = null,}) {
  return _then(EarthquakeArchive(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeArchiveType,objectKey: null == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,hypocenterName: freezed == hypocenterName ? _self.hypocenterName : hypocenterName // ignore: cast_nullable_to_non_nullable
as String?,fileSizeBytes: null == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as int,waveformStatus: null == waveformStatus ? _self.waveformStatus : waveformStatus // ignore: cast_nullable_to_non_nullable
as EarthquakeArchiveWaveformStatus,frames: null == frames ? _self.frames : frames // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  EarthquakeArchiveType type,  String objectKey,  DateTime originTime,  DateTime startTime,  DateTime endTime,  double? magnitude,  String? hypocenterName,  int fileSizeBytes,  EarthquakeArchiveWaveformStatus waveformStatus,  List<EarthquakeArchiveFrame> frames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeArchive() when $default != null:
return $default(_that.eventId,_that.type,_that.objectKey,_that.originTime,_that.startTime,_that.endTime,_that.magnitude,_that.hypocenterName,_that.fileSizeBytes,_that.waveformStatus,_that.frames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  EarthquakeArchiveType type,  String objectKey,  DateTime originTime,  DateTime startTime,  DateTime endTime,  double? magnitude,  String? hypocenterName,  int fileSizeBytes,  EarthquakeArchiveWaveformStatus waveformStatus,  List<EarthquakeArchiveFrame> frames)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeArchive():
return $default(_that.eventId,_that.type,_that.objectKey,_that.originTime,_that.startTime,_that.endTime,_that.magnitude,_that.hypocenterName,_that.fileSizeBytes,_that.waveformStatus,_that.frames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  EarthquakeArchiveType type,  String objectKey,  DateTime originTime,  DateTime startTime,  DateTime endTime,  double? magnitude,  String? hypocenterName,  int fileSizeBytes,  EarthquakeArchiveWaveformStatus waveformStatus,  List<EarthquakeArchiveFrame> frames)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeArchive() when $default != null:
return $default(_that.eventId,_that.type,_that.objectKey,_that.originTime,_that.startTime,_that.endTime,_that.magnitude,_that.hypocenterName,_that.fileSizeBytes,_that.waveformStatus,_that.frames);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeArchive extends EarthquakeArchive {
  const _EarthquakeArchive({required this.eventId, required this.type, required this.objectKey, required this.originTime, required this.startTime, required this.endTime, required this.magnitude, required this.hypocenterName, required this.fileSizeBytes, required this.waveformStatus, required  List<EarthquakeArchiveFrame> frames}): _frames = frames,super._();
  

@override final  String eventId;
@override final  EarthquakeArchiveType type;
@override final  String objectKey;
@override final  DateTime originTime;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  double? magnitude;
@override final  String? hypocenterName;
@override final  int fileSizeBytes;
@override final  EarthquakeArchiveWaveformStatus waveformStatus;
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
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeArchive&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.hypocenterName, hypocenterName) || other.hypocenterName == hypocenterName)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.waveformStatus, waveformStatus) || other.waveformStatus == waveformStatus)&&const DeepCollectionEquality().equals(other._frames, _frames));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,type,objectKey,originTime,startTime,endTime,magnitude,hypocenterName,fileSizeBytes,waveformStatus,const DeepCollectionEquality().hash(_frames));

@override
String toString() {
  return 'EarthquakeArchive(eventId: $eventId, type: $type, objectKey: $objectKey, originTime: $originTime, startTime: $startTime, endTime: $endTime, magnitude: $magnitude, hypocenterName: $hypocenterName, fileSizeBytes: $fileSizeBytes, waveformStatus: $waveformStatus, frames: $frames)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeArchiveCopyWith<$Res> implements $EarthquakeArchiveCopyWith<$Res> {
  factory _$EarthquakeArchiveCopyWith(_EarthquakeArchive value, $Res Function(_EarthquakeArchive) _then) = __$EarthquakeArchiveCopyWithImpl;
@override @useResult
$Res call({
 String eventId, EarthquakeArchiveType type, String objectKey, DateTime originTime, DateTime startTime, DateTime endTime, double? magnitude, String? hypocenterName, int fileSizeBytes, EarthquakeArchiveWaveformStatus waveformStatus, List<EarthquakeArchiveFrame> frames
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
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? type = null,Object? objectKey = null,Object? originTime = null,Object? startTime = null,Object? endTime = null,Object? magnitude = freezed,Object? hypocenterName = freezed,Object? fileSizeBytes = null,Object? waveformStatus = null,Object? frames = null,}) {
  return _then(_EarthquakeArchive(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeArchiveType,objectKey: null == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,hypocenterName: freezed == hypocenterName ? _self.hypocenterName : hypocenterName // ignore: cast_nullable_to_non_nullable
as String?,fileSizeBytes: null == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as int,waveformStatus: null == waveformStatus ? _self.waveformStatus : waveformStatus // ignore: cast_nullable_to_non_nullable
as EarthquakeArchiveWaveformStatus,frames: null == frames ? _self._frames : frames // ignore: cast_nullable_to_non_nullable
as List<EarthquakeArchiveFrame>,
  ));
}


}

/// @nodoc
mixin _$EarthquakeArchivePage {

 List<EarthquakeArchive> get items; String? get nextCursor;
/// Create a copy of EarthquakeArchivePage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeArchivePageCopyWith<EarthquakeArchivePage> get copyWith => _$EarthquakeArchivePageCopyWithImpl<EarthquakeArchivePage>(this as EarthquakeArchivePage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeArchivePage&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextCursor);

@override
String toString() {
  return 'EarthquakeArchivePage(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class $EarthquakeArchivePageCopyWith<$Res>  {
  factory $EarthquakeArchivePageCopyWith(EarthquakeArchivePage value, $Res Function(EarthquakeArchivePage) _then) = _$EarthquakeArchivePageCopyWithImpl;
@useResult
$Res call({
 List<EarthquakeArchive> items, String? nextCursor
});




}
/// @nodoc
class _$EarthquakeArchivePageCopyWithImpl<$Res>
    implements $EarthquakeArchivePageCopyWith<$Res> {
  _$EarthquakeArchivePageCopyWithImpl(this._self, this._then);

  final EarthquakeArchivePage _self;
  final $Res Function(EarthquakeArchivePage) _then;

/// Create a copy of EarthquakeArchivePage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(EarthquakeArchivePage(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<EarthquakeArchive>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeArchivePage].
extension EarthquakeArchivePagePatterns on EarthquakeArchivePage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeArchivePage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeArchivePage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeArchivePage value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeArchivePage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeArchivePage value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeArchivePage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EarthquakeArchive> items,  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeArchivePage() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EarthquakeArchive> items,  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeArchivePage():
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EarthquakeArchive> items,  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeArchivePage() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeArchivePage extends EarthquakeArchivePage {
  const _EarthquakeArchivePage({required  List<EarthquakeArchive> items, required this.nextCursor}): _items = items,super._();
  

 final  List<EarthquakeArchive> _items;
@override List<EarthquakeArchive> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;

/// Create a copy of EarthquakeArchivePage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeArchivePageCopyWith<_EarthquakeArchivePage> get copyWith => __$EarthquakeArchivePageCopyWithImpl<_EarthquakeArchivePage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeArchivePage&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor);

@override
String toString() {
  return 'EarthquakeArchivePage(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeArchivePageCopyWith<$Res> implements $EarthquakeArchivePageCopyWith<$Res> {
  factory _$EarthquakeArchivePageCopyWith(_EarthquakeArchivePage value, $Res Function(_EarthquakeArchivePage) _then) = __$EarthquakeArchivePageCopyWithImpl;
@override @useResult
$Res call({
 List<EarthquakeArchive> items, String? nextCursor
});




}
/// @nodoc
class __$EarthquakeArchivePageCopyWithImpl<$Res>
    implements _$EarthquakeArchivePageCopyWith<$Res> {
  __$EarthquakeArchivePageCopyWithImpl(this._self, this._then);

  final _EarthquakeArchivePage _self;
  final $Res Function(_EarthquakeArchivePage) _then;

/// Create a copy of EarthquakeArchivePage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_EarthquakeArchivePage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<EarthquakeArchive>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

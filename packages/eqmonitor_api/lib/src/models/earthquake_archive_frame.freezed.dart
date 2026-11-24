// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_archive_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeArchiveFrame {

 num get frameType; String get frameTypeName; num get frameCount; num get totalBytes; String get firstTime; String get lastTime;
/// Create a copy of EarthquakeArchiveFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeArchiveFrameCopyWith<EarthquakeArchiveFrame> get copyWith => _$EarthquakeArchiveFrameCopyWithImpl<EarthquakeArchiveFrame>(this as EarthquakeArchiveFrame, _$identity);

  /// Serializes this EarthquakeArchiveFrame to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeArchiveFrame&&(identical(other.frameType, frameType) || other.frameType == frameType)&&(identical(other.frameTypeName, frameTypeName) || other.frameTypeName == frameTypeName)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount)&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes)&&(identical(other.firstTime, firstTime) || other.firstTime == firstTime)&&(identical(other.lastTime, lastTime) || other.lastTime == lastTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,frameType,frameTypeName,frameCount,totalBytes,firstTime,lastTime);

@override
String toString() {
  return 'EarthquakeArchiveFrame(frameType: $frameType, frameTypeName: $frameTypeName, frameCount: $frameCount, totalBytes: $totalBytes, firstTime: $firstTime, lastTime: $lastTime)';
}


}

/// @nodoc
abstract mixin class $EarthquakeArchiveFrameCopyWith<$Res>  {
  factory $EarthquakeArchiveFrameCopyWith(EarthquakeArchiveFrame value, $Res Function(EarthquakeArchiveFrame) _then) = _$EarthquakeArchiveFrameCopyWithImpl;
@useResult
$Res call({
 num frameType, String frameTypeName, num frameCount, num totalBytes, String firstTime, String lastTime
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
@pragma('vm:prefer-inline') @override $Res call({Object? frameType = null,Object? frameTypeName = null,Object? frameCount = null,Object? totalBytes = null,Object? firstTime = null,Object? lastTime = null,}) {
  return _then(EarthquakeArchiveFrame(
frameType: null == frameType ? _self.frameType : frameType // ignore: cast_nullable_to_non_nullable
as num,frameTypeName: null == frameTypeName ? _self.frameTypeName : frameTypeName // ignore: cast_nullable_to_non_nullable
as String,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as num,totalBytes: null == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as num,firstTime: null == firstTime ? _self.firstTime : firstTime // ignore: cast_nullable_to_non_nullable
as String,lastTime: null == lastTime ? _self.lastTime : lastTime // ignore: cast_nullable_to_non_nullable
as String,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num frameType,  String frameTypeName,  num frameCount,  num totalBytes,  String firstTime,  String lastTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeArchiveFrame() when $default != null:
return $default(_that.frameType,_that.frameTypeName,_that.frameCount,_that.totalBytes,_that.firstTime,_that.lastTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num frameType,  String frameTypeName,  num frameCount,  num totalBytes,  String firstTime,  String lastTime)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeArchiveFrame():
return $default(_that.frameType,_that.frameTypeName,_that.frameCount,_that.totalBytes,_that.firstTime,_that.lastTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num frameType,  String frameTypeName,  num frameCount,  num totalBytes,  String firstTime,  String lastTime)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeArchiveFrame() when $default != null:
return $default(_that.frameType,_that.frameTypeName,_that.frameCount,_that.totalBytes,_that.firstTime,_that.lastTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeArchiveFrame implements EarthquakeArchiveFrame {
  const _EarthquakeArchiveFrame({required this.frameType, required this.frameTypeName, required this.frameCount, required this.totalBytes, required this.firstTime, required this.lastTime});
  factory _EarthquakeArchiveFrame.fromJson(Map<String, dynamic> json) => _$EarthquakeArchiveFrameFromJson(json);

@override final  num frameType;
@override final  String frameTypeName;
@override final  num frameCount;
@override final  num totalBytes;
@override final  String firstTime;
@override final  String lastTime;

/// Create a copy of EarthquakeArchiveFrame
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeArchiveFrameCopyWith<_EarthquakeArchiveFrame> get copyWith => __$EarthquakeArchiveFrameCopyWithImpl<_EarthquakeArchiveFrame>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeArchiveFrameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeArchiveFrame&&(identical(other.frameType, frameType) || other.frameType == frameType)&&(identical(other.frameTypeName, frameTypeName) || other.frameTypeName == frameTypeName)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount)&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes)&&(identical(other.firstTime, firstTime) || other.firstTime == firstTime)&&(identical(other.lastTime, lastTime) || other.lastTime == lastTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,frameType,frameTypeName,frameCount,totalBytes,firstTime,lastTime);

@override
String toString() {
  return 'EarthquakeArchiveFrame(frameType: $frameType, frameTypeName: $frameTypeName, frameCount: $frameCount, totalBytes: $totalBytes, firstTime: $firstTime, lastTime: $lastTime)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeArchiveFrameCopyWith<$Res> implements $EarthquakeArchiveFrameCopyWith<$Res> {
  factory _$EarthquakeArchiveFrameCopyWith(_EarthquakeArchiveFrame value, $Res Function(_EarthquakeArchiveFrame) _then) = __$EarthquakeArchiveFrameCopyWithImpl;
@override @useResult
$Res call({
 num frameType, String frameTypeName, num frameCount, num totalBytes, String firstTime, String lastTime
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
@override @pragma('vm:prefer-inline') $Res call({Object? frameType = null,Object? frameTypeName = null,Object? frameCount = null,Object? totalBytes = null,Object? firstTime = null,Object? lastTime = null,}) {
  return _then(_EarthquakeArchiveFrame(
frameType: null == frameType ? _self.frameType : frameType // ignore: cast_nullable_to_non_nullable
as num,frameTypeName: null == frameTypeName ? _self.frameTypeName : frameTypeName // ignore: cast_nullable_to_non_nullable
as String,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as num,totalBytes: null == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as num,firstTime: null == firstTime ? _self.firstTime : firstTime // ignore: cast_nullable_to_non_nullable
as String,lastTime: null == lastTime ? _self.lastTime : lastTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

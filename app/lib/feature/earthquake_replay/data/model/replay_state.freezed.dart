// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReplayState {

 ReplaySource get source;/// [currentTime] までに通過した [frames] の数。
 int get passedFrameCount; DateTime get currentTime; bool get isPlaying; double get playbackSpeed;
/// Create a copy of ReplayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayStateCopyWith<ReplayState> get copyWith => _$ReplayStateCopyWithImpl<ReplayState>(this as ReplayState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayState&&(identical(other.source, source) || other.source == source)&&(identical(other.passedFrameCount, passedFrameCount) || other.passedFrameCount == passedFrameCount)&&(identical(other.currentTime, currentTime) || other.currentTime == currentTime)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.playbackSpeed, playbackSpeed) || other.playbackSpeed == playbackSpeed));
}


@override
int get hashCode => Object.hash(runtimeType,source,passedFrameCount,currentTime,isPlaying,playbackSpeed);

@override
String toString() {
  return 'ReplayState(source: $source, passedFrameCount: $passedFrameCount, currentTime: $currentTime, isPlaying: $isPlaying, playbackSpeed: $playbackSpeed)';
}


}

/// @nodoc
abstract mixin class $ReplayStateCopyWith<$Res>  {
  factory $ReplayStateCopyWith(ReplayState value, $Res Function(ReplayState) _then) = _$ReplayStateCopyWithImpl;
@useResult
$Res call({
 ReplaySource source, int passedFrameCount, DateTime currentTime, bool isPlaying, double playbackSpeed
});


$ReplaySourceCopyWith<$Res> get source;

}
/// @nodoc
class _$ReplayStateCopyWithImpl<$Res>
    implements $ReplayStateCopyWith<$Res> {
  _$ReplayStateCopyWithImpl(this._self, this._then);

  final ReplayState _self;
  final $Res Function(ReplayState) _then;

/// Create a copy of ReplayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? passedFrameCount = null,Object? currentTime = null,Object? isPlaying = null,Object? playbackSpeed = null,}) {
  return _then(ReplayState(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ReplaySource,passedFrameCount: null == passedFrameCount ? _self.passedFrameCount : passedFrameCount // ignore: cast_nullable_to_non_nullable
as int,currentTime: null == currentTime ? _self.currentTime : currentTime // ignore: cast_nullable_to_non_nullable
as DateTime,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,playbackSpeed: null == playbackSpeed ? _self.playbackSpeed : playbackSpeed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of ReplayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplaySourceCopyWith<$Res> get source {
  
  return $ReplaySourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReplayState].
extension ReplayStatePatterns on ReplayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayState value)  $default,){
final _that = this;
switch (_that) {
case _ReplayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayState value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReplaySource source,  int passedFrameCount,  DateTime currentTime,  bool isPlaying,  double playbackSpeed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplayState() when $default != null:
return $default(_that.source,_that.passedFrameCount,_that.currentTime,_that.isPlaying,_that.playbackSpeed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReplaySource source,  int passedFrameCount,  DateTime currentTime,  bool isPlaying,  double playbackSpeed)  $default,) {final _that = this;
switch (_that) {
case _ReplayState():
return $default(_that.source,_that.passedFrameCount,_that.currentTime,_that.isPlaying,_that.playbackSpeed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReplaySource source,  int passedFrameCount,  DateTime currentTime,  bool isPlaying,  double playbackSpeed)?  $default,) {final _that = this;
switch (_that) {
case _ReplayState() when $default != null:
return $default(_that.source,_that.passedFrameCount,_that.currentTime,_that.isPlaying,_that.playbackSpeed);case _:
  return null;

}
}

}

/// @nodoc


class _ReplayState extends ReplayState {
  const _ReplayState({required this.source, required this.passedFrameCount, required this.currentTime, required this.isPlaying, required this.playbackSpeed}): super._();
  

@override final  ReplaySource source;
/// [currentTime] までに通過した [frames] の数。
@override final  int passedFrameCount;
@override final  DateTime currentTime;
@override final  bool isPlaying;
@override final  double playbackSpeed;

/// Create a copy of ReplayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayStateCopyWith<_ReplayState> get copyWith => __$ReplayStateCopyWithImpl<_ReplayState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayState&&(identical(other.source, source) || other.source == source)&&(identical(other.passedFrameCount, passedFrameCount) || other.passedFrameCount == passedFrameCount)&&(identical(other.currentTime, currentTime) || other.currentTime == currentTime)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.playbackSpeed, playbackSpeed) || other.playbackSpeed == playbackSpeed));
}


@override
int get hashCode => Object.hash(runtimeType,source,passedFrameCount,currentTime,isPlaying,playbackSpeed);

@override
String toString() {
  return 'ReplayState(source: $source, passedFrameCount: $passedFrameCount, currentTime: $currentTime, isPlaying: $isPlaying, playbackSpeed: $playbackSpeed)';
}


}

/// @nodoc
abstract mixin class _$ReplayStateCopyWith<$Res> implements $ReplayStateCopyWith<$Res> {
  factory _$ReplayStateCopyWith(_ReplayState value, $Res Function(_ReplayState) _then) = __$ReplayStateCopyWithImpl;
@override @useResult
$Res call({
 ReplaySource source, int passedFrameCount, DateTime currentTime, bool isPlaying, double playbackSpeed
});


@override $ReplaySourceCopyWith<$Res> get source;

}
/// @nodoc
class __$ReplayStateCopyWithImpl<$Res>
    implements _$ReplayStateCopyWith<$Res> {
  __$ReplayStateCopyWithImpl(this._self, this._then);

  final _ReplayState _self;
  final $Res Function(_ReplayState) _then;

/// Create a copy of ReplayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? passedFrameCount = null,Object? currentTime = null,Object? isPlaying = null,Object? playbackSpeed = null,}) {
  return _then(_ReplayState(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ReplaySource,passedFrameCount: null == passedFrameCount ? _self.passedFrameCount : passedFrameCount // ignore: cast_nullable_to_non_nullable
as int,currentTime: null == currentTime ? _self.currentTime : currentTime // ignore: cast_nullable_to_non_nullable
as DateTime,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,playbackSpeed: null == playbackSpeed ? _self.playbackSpeed : playbackSpeed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of ReplayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplaySourceCopyWith<$Res> get source {
  
  return $ReplaySourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}

// dart format on

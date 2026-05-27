// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_mode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimeMode {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeMode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimeMode()';
}


}

/// @nodoc
class $TimeModeCopyWith<$Res>  {
$TimeModeCopyWith(TimeMode _, $Res Function(TimeMode) __);
}


/// Adds pattern-matching-related methods to [TimeMode].
extension TimeModePatterns on TimeMode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RealtimeTimeMode value)?  realtime,TResult Function( TimeShiftTimeMode value)?  timeShift,TResult Function( ReplayTimeMode value)?  replay,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RealtimeTimeMode() when realtime != null:
return realtime(_that);case TimeShiftTimeMode() when timeShift != null:
return timeShift(_that);case ReplayTimeMode() when replay != null:
return replay(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RealtimeTimeMode value)  realtime,required TResult Function( TimeShiftTimeMode value)  timeShift,required TResult Function( ReplayTimeMode value)  replay,}){
final _that = this;
switch (_that) {
case RealtimeTimeMode():
return realtime(_that);case TimeShiftTimeMode():
return timeShift(_that);case ReplayTimeMode():
return replay(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RealtimeTimeMode value)?  realtime,TResult? Function( TimeShiftTimeMode value)?  timeShift,TResult? Function( ReplayTimeMode value)?  replay,}){
final _that = this;
switch (_that) {
case RealtimeTimeMode() when realtime != null:
return realtime(_that);case TimeShiftTimeMode() when timeShift != null:
return timeShift(_that);case ReplayTimeMode() when replay != null:
return replay(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  realtime,TResult Function( Duration offset)?  timeShift,TResult Function( DateTime currentTime)?  replay,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RealtimeTimeMode() when realtime != null:
return realtime();case TimeShiftTimeMode() when timeShift != null:
return timeShift(_that.offset);case ReplayTimeMode() when replay != null:
return replay(_that.currentTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  realtime,required TResult Function( Duration offset)  timeShift,required TResult Function( DateTime currentTime)  replay,}) {final _that = this;
switch (_that) {
case RealtimeTimeMode():
return realtime();case TimeShiftTimeMode():
return timeShift(_that.offset);case ReplayTimeMode():
return replay(_that.currentTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  realtime,TResult? Function( Duration offset)?  timeShift,TResult? Function( DateTime currentTime)?  replay,}) {final _that = this;
switch (_that) {
case RealtimeTimeMode() when realtime != null:
return realtime();case TimeShiftTimeMode() when timeShift != null:
return timeShift(_that.offset);case ReplayTimeMode() when replay != null:
return replay(_that.currentTime);case _:
  return null;

}
}

}

/// @nodoc


class RealtimeTimeMode implements TimeMode {
  const RealtimeTimeMode();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTimeMode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimeMode.realtime()';
}


}




/// @nodoc


class TimeShiftTimeMode implements TimeMode {
  const TimeShiftTimeMode({required this.offset});
  

 final  Duration offset;

/// Create a copy of TimeMode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeShiftTimeModeCopyWith<TimeShiftTimeMode> get copyWith => _$TimeShiftTimeModeCopyWithImpl<TimeShiftTimeMode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeShiftTimeMode&&(identical(other.offset, offset) || other.offset == offset));
}


@override
int get hashCode => Object.hash(runtimeType,offset);

@override
String toString() {
  return 'TimeMode.timeShift(offset: $offset)';
}


}

/// @nodoc
abstract mixin class $TimeShiftTimeModeCopyWith<$Res> implements $TimeModeCopyWith<$Res> {
  factory $TimeShiftTimeModeCopyWith(TimeShiftTimeMode value, $Res Function(TimeShiftTimeMode) _then) = _$TimeShiftTimeModeCopyWithImpl;
@useResult
$Res call({
 Duration offset
});




}
/// @nodoc
class _$TimeShiftTimeModeCopyWithImpl<$Res>
    implements $TimeShiftTimeModeCopyWith<$Res> {
  _$TimeShiftTimeModeCopyWithImpl(this._self, this._then);

  final TimeShiftTimeMode _self;
  final $Res Function(TimeShiftTimeMode) _then;

/// Create a copy of TimeMode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? offset = null,}) {
  return _then(TimeShiftTimeMode(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc


class ReplayTimeMode implements TimeMode {
  const ReplayTimeMode({required this.currentTime});
  

 final  DateTime currentTime;

/// Create a copy of TimeMode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayTimeModeCopyWith<ReplayTimeMode> get copyWith => _$ReplayTimeModeCopyWithImpl<ReplayTimeMode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayTimeMode&&(identical(other.currentTime, currentTime) || other.currentTime == currentTime));
}


@override
int get hashCode => Object.hash(runtimeType,currentTime);

@override
String toString() {
  return 'TimeMode.replay(currentTime: $currentTime)';
}


}

/// @nodoc
abstract mixin class $ReplayTimeModeCopyWith<$Res> implements $TimeModeCopyWith<$Res> {
  factory $ReplayTimeModeCopyWith(ReplayTimeMode value, $Res Function(ReplayTimeMode) _then) = _$ReplayTimeModeCopyWithImpl;
@useResult
$Res call({
 DateTime currentTime
});




}
/// @nodoc
class _$ReplayTimeModeCopyWithImpl<$Res>
    implements $ReplayTimeModeCopyWith<$Res> {
  _$ReplayTimeModeCopyWithImpl(this._self, this._then);

  final ReplayTimeMode _self;
  final $Res Function(ReplayTimeMode) _then;

/// Create a copy of TimeMode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? currentTime = null,}) {
  return _then(ReplayTimeMode(
currentTime: null == currentTime ? _self.currentTime : currentTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

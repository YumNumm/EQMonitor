// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_earthquake_count_target_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedEarthquakeCountTargetTime {

 String get start; String get end;
/// Create a copy of FeedEarthquakeCountTargetTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEarthquakeCountTargetTimeCopyWith<FeedEarthquakeCountTargetTime> get copyWith => _$FeedEarthquakeCountTargetTimeCopyWithImpl<FeedEarthquakeCountTargetTime>(this as FeedEarthquakeCountTargetTime, _$identity);

  /// Serializes this FeedEarthquakeCountTargetTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEarthquakeCountTargetTime&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'FeedEarthquakeCountTargetTime(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $FeedEarthquakeCountTargetTimeCopyWith<$Res>  {
  factory $FeedEarthquakeCountTargetTimeCopyWith(FeedEarthquakeCountTargetTime value, $Res Function(FeedEarthquakeCountTargetTime) _then) = _$FeedEarthquakeCountTargetTimeCopyWithImpl;
@useResult
$Res call({
 String start, String end
});




}
/// @nodoc
class _$FeedEarthquakeCountTargetTimeCopyWithImpl<$Res>
    implements $FeedEarthquakeCountTargetTimeCopyWith<$Res> {
  _$FeedEarthquakeCountTargetTimeCopyWithImpl(this._self, this._then);

  final FeedEarthquakeCountTargetTime _self;
  final $Res Function(FeedEarthquakeCountTargetTime) _then;

/// Create a copy of FeedEarthquakeCountTargetTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedEarthquakeCountTargetTime].
extension FeedEarthquakeCountTargetTimePatterns on FeedEarthquakeCountTargetTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEarthquakeCountTargetTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEarthquakeCountTargetTime value)  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEarthquakeCountTargetTime value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String start,  String end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime() when $default != null:
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String start,  String end)  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime():
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String start,  String end)?  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedEarthquakeCountTargetTime implements FeedEarthquakeCountTargetTime {
  const _FeedEarthquakeCountTargetTime({required this.start, required this.end});
  factory _FeedEarthquakeCountTargetTime.fromJson(Map<String, dynamic> json) => _$FeedEarthquakeCountTargetTimeFromJson(json);

@override final  String start;
@override final  String end;

/// Create a copy of FeedEarthquakeCountTargetTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEarthquakeCountTargetTimeCopyWith<_FeedEarthquakeCountTargetTime> get copyWith => __$FeedEarthquakeCountTargetTimeCopyWithImpl<_FeedEarthquakeCountTargetTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedEarthquakeCountTargetTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEarthquakeCountTargetTime&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'FeedEarthquakeCountTargetTime(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$FeedEarthquakeCountTargetTimeCopyWith<$Res> implements $FeedEarthquakeCountTargetTimeCopyWith<$Res> {
  factory _$FeedEarthquakeCountTargetTimeCopyWith(_FeedEarthquakeCountTargetTime value, $Res Function(_FeedEarthquakeCountTargetTime) _then) = __$FeedEarthquakeCountTargetTimeCopyWithImpl;
@override @useResult
$Res call({
 String start, String end
});




}
/// @nodoc
class __$FeedEarthquakeCountTargetTimeCopyWithImpl<$Res>
    implements _$FeedEarthquakeCountTargetTimeCopyWith<$Res> {
  __$FeedEarthquakeCountTargetTimeCopyWithImpl(this._self, this._then);

  final _FeedEarthquakeCountTargetTime _self;
  final $Res Function(_FeedEarthquakeCountTargetTime) _then;

/// Create a copy of FeedEarthquakeCountTargetTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_FeedEarthquakeCountTargetTime(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

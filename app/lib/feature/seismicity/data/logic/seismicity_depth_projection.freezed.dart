// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_depth_projection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeismicityDepthPoint {

/// 投影軸の値(緯度 or 経度)
 double get axisValue; double get depth; double? get magnitude; String get eventId;
/// Create a copy of SeismicityDepthPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityDepthPointCopyWith<SeismicityDepthPoint> get copyWith => _$SeismicityDepthPointCopyWithImpl<SeismicityDepthPoint>(this as SeismicityDepthPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityDepthPoint&&(identical(other.axisValue, axisValue) || other.axisValue == axisValue)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}


@override
int get hashCode => Object.hash(runtimeType,axisValue,depth,magnitude,eventId);

@override
String toString() {
  return 'SeismicityDepthPoint(axisValue: $axisValue, depth: $depth, magnitude: $magnitude, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $SeismicityDepthPointCopyWith<$Res>  {
  factory $SeismicityDepthPointCopyWith(SeismicityDepthPoint value, $Res Function(SeismicityDepthPoint) _then) = _$SeismicityDepthPointCopyWithImpl;
@useResult
$Res call({
 double axisValue, double depth, double? magnitude, String eventId
});




}
/// @nodoc
class _$SeismicityDepthPointCopyWithImpl<$Res>
    implements $SeismicityDepthPointCopyWith<$Res> {
  _$SeismicityDepthPointCopyWithImpl(this._self, this._then);

  final SeismicityDepthPoint _self;
  final $Res Function(SeismicityDepthPoint) _then;

/// Create a copy of SeismicityDepthPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? axisValue = null,Object? depth = null,Object? magnitude = freezed,Object? eventId = null,}) {
  return _then(_self.copyWith(
axisValue: null == axisValue ? _self.axisValue : axisValue // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityDepthPoint].
extension SeismicityDepthPointPatterns on SeismicityDepthPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityDepthPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityDepthPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityDepthPoint value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityDepthPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityDepthPoint value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityDepthPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double axisValue,  double depth,  double? magnitude,  String eventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityDepthPoint() when $default != null:
return $default(_that.axisValue,_that.depth,_that.magnitude,_that.eventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double axisValue,  double depth,  double? magnitude,  String eventId)  $default,) {final _that = this;
switch (_that) {
case _SeismicityDepthPoint():
return $default(_that.axisValue,_that.depth,_that.magnitude,_that.eventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double axisValue,  double depth,  double? magnitude,  String eventId)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityDepthPoint() when $default != null:
return $default(_that.axisValue,_that.depth,_that.magnitude,_that.eventId);case _:
  return null;

}
}

}

/// @nodoc


class _SeismicityDepthPoint implements SeismicityDepthPoint {
  const _SeismicityDepthPoint({required this.axisValue, required this.depth, required this.magnitude, required this.eventId});
  

/// 投影軸の値(緯度 or 経度)
@override final  double axisValue;
@override final  double depth;
@override final  double? magnitude;
@override final  String eventId;

/// Create a copy of SeismicityDepthPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityDepthPointCopyWith<_SeismicityDepthPoint> get copyWith => __$SeismicityDepthPointCopyWithImpl<_SeismicityDepthPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicityDepthPoint&&(identical(other.axisValue, axisValue) || other.axisValue == axisValue)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}


@override
int get hashCode => Object.hash(runtimeType,axisValue,depth,magnitude,eventId);

@override
String toString() {
  return 'SeismicityDepthPoint(axisValue: $axisValue, depth: $depth, magnitude: $magnitude, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class _$SeismicityDepthPointCopyWith<$Res> implements $SeismicityDepthPointCopyWith<$Res> {
  factory _$SeismicityDepthPointCopyWith(_SeismicityDepthPoint value, $Res Function(_SeismicityDepthPoint) _then) = __$SeismicityDepthPointCopyWithImpl;
@override @useResult
$Res call({
 double axisValue, double depth, double? magnitude, String eventId
});




}
/// @nodoc
class __$SeismicityDepthPointCopyWithImpl<$Res>
    implements _$SeismicityDepthPointCopyWith<$Res> {
  __$SeismicityDepthPointCopyWithImpl(this._self, this._then);

  final _SeismicityDepthPoint _self;
  final $Res Function(_SeismicityDepthPoint) _then;

/// Create a copy of SeismicityDepthPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? axisValue = null,Object? depth = null,Object? magnitude = freezed,Object? eventId = null,}) {
  return _then(_SeismicityDepthPoint(
axisValue: null == axisValue ? _self.axisValue : axisValue // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

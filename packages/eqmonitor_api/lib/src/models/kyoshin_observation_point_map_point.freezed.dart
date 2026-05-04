// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_observation_point_map_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinObservationPointMapPoint {

 ParameterPoint get center; ParameterPoint get offset;
/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinObservationPointMapPointCopyWith<KyoshinObservationPointMapPoint> get copyWith => _$KyoshinObservationPointMapPointCopyWithImpl<KyoshinObservationPointMapPoint>(this as KyoshinObservationPointMapPoint, _$identity);

  /// Serializes this KyoshinObservationPointMapPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinObservationPointMapPoint&&(identical(other.center, center) || other.center == center)&&(identical(other.offset, offset) || other.offset == offset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,center,offset);

@override
String toString() {
  return 'KyoshinObservationPointMapPoint(center: $center, offset: $offset)';
}


}

/// @nodoc
abstract mixin class $KyoshinObservationPointMapPointCopyWith<$Res>  {
  factory $KyoshinObservationPointMapPointCopyWith(KyoshinObservationPointMapPoint value, $Res Function(KyoshinObservationPointMapPoint) _then) = _$KyoshinObservationPointMapPointCopyWithImpl;
@useResult
$Res call({
 ParameterPoint center, ParameterPoint offset
});


$ParameterPointCopyWith<$Res> get center;$ParameterPointCopyWith<$Res> get offset;

}
/// @nodoc
class _$KyoshinObservationPointMapPointCopyWithImpl<$Res>
    implements $KyoshinObservationPointMapPointCopyWith<$Res> {
  _$KyoshinObservationPointMapPointCopyWithImpl(this._self, this._then);

  final KyoshinObservationPointMapPoint _self;
  final $Res Function(KyoshinObservationPointMapPoint) _then;

/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? center = null,Object? offset = null,}) {
  return _then(_self.copyWith(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as ParameterPoint,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as ParameterPoint,
  ));
}
/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterPointCopyWith<$Res> get center {
  
  return $ParameterPointCopyWith<$Res>(_self.center, (value) {
    return _then(_self.copyWith(center: value));
  });
}/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterPointCopyWith<$Res> get offset {
  
  return $ParameterPointCopyWith<$Res>(_self.offset, (value) {
    return _then(_self.copyWith(offset: value));
  });
}
}


/// Adds pattern-matching-related methods to [KyoshinObservationPointMapPoint].
extension KyoshinObservationPointMapPointPatterns on KyoshinObservationPointMapPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinObservationPointMapPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinObservationPointMapPoint value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinObservationPointMapPoint value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ParameterPoint center,  ParameterPoint offset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint() when $default != null:
return $default(_that.center,_that.offset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ParameterPoint center,  ParameterPoint offset)  $default,) {final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint():
return $default(_that.center,_that.offset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ParameterPoint center,  ParameterPoint offset)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinObservationPointMapPoint() when $default != null:
return $default(_that.center,_that.offset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KyoshinObservationPointMapPoint implements KyoshinObservationPointMapPoint {
  const _KyoshinObservationPointMapPoint({required this.center, required this.offset});
  factory _KyoshinObservationPointMapPoint.fromJson(Map<String, dynamic> json) => _$KyoshinObservationPointMapPointFromJson(json);

@override final  ParameterPoint center;
@override final  ParameterPoint offset;

/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinObservationPointMapPointCopyWith<_KyoshinObservationPointMapPoint> get copyWith => __$KyoshinObservationPointMapPointCopyWithImpl<_KyoshinObservationPointMapPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinObservationPointMapPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinObservationPointMapPoint&&(identical(other.center, center) || other.center == center)&&(identical(other.offset, offset) || other.offset == offset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,center,offset);

@override
String toString() {
  return 'KyoshinObservationPointMapPoint(center: $center, offset: $offset)';
}


}

/// @nodoc
abstract mixin class _$KyoshinObservationPointMapPointCopyWith<$Res> implements $KyoshinObservationPointMapPointCopyWith<$Res> {
  factory _$KyoshinObservationPointMapPointCopyWith(_KyoshinObservationPointMapPoint value, $Res Function(_KyoshinObservationPointMapPoint) _then) = __$KyoshinObservationPointMapPointCopyWithImpl;
@override @useResult
$Res call({
 ParameterPoint center, ParameterPoint offset
});


@override $ParameterPointCopyWith<$Res> get center;@override $ParameterPointCopyWith<$Res> get offset;

}
/// @nodoc
class __$KyoshinObservationPointMapPointCopyWithImpl<$Res>
    implements _$KyoshinObservationPointMapPointCopyWith<$Res> {
  __$KyoshinObservationPointMapPointCopyWithImpl(this._self, this._then);

  final _KyoshinObservationPointMapPoint _self;
  final $Res Function(_KyoshinObservationPointMapPoint) _then;

/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? center = null,Object? offset = null,}) {
  return _then(_KyoshinObservationPointMapPoint(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as ParameterPoint,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as ParameterPoint,
  ));
}

/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterPointCopyWith<$Res> get center {
  
  return $ParameterPointCopyWith<$Res>(_self.center, (value) {
    return _then(_self.copyWith(center: value));
  });
}/// Create a copy of KyoshinObservationPointMapPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterPointCopyWith<$Res> get offset {
  
  return $ParameterPointCopyWith<$Res>(_self.offset, (value) {
    return _then(_self.copyWith(offset: value));
  });
}
}

// dart format on

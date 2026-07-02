// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimated_intensity_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EstimatedIntensityPoint {

 String get regionCode; double get intensity;
/// Create a copy of EstimatedIntensityPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimatedIntensityPointCopyWith<EstimatedIntensityPoint> get copyWith => _$EstimatedIntensityPointCopyWithImpl<EstimatedIntensityPoint>(this as EstimatedIntensityPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimatedIntensityPoint&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,regionCode,intensity);

@override
String toString() {
  return 'EstimatedIntensityPoint(regionCode: $regionCode, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $EstimatedIntensityPointCopyWith<$Res>  {
  factory $EstimatedIntensityPointCopyWith(EstimatedIntensityPoint value, $Res Function(EstimatedIntensityPoint) _then) = _$EstimatedIntensityPointCopyWithImpl;
@useResult
$Res call({
 String regionCode, double intensity
});




}
/// @nodoc
class _$EstimatedIntensityPointCopyWithImpl<$Res>
    implements $EstimatedIntensityPointCopyWith<$Res> {
  _$EstimatedIntensityPointCopyWithImpl(this._self, this._then);

  final EstimatedIntensityPoint _self;
  final $Res Function(EstimatedIntensityPoint) _then;

/// Create a copy of EstimatedIntensityPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionCode = null,Object? intensity = null,}) {
  return _then(_self.copyWith(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EstimatedIntensityPoint].
extension EstimatedIntensityPointPatterns on EstimatedIntensityPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimatedIntensityPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimatedIntensityPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimatedIntensityPoint value)  $default,){
final _that = this;
switch (_that) {
case _EstimatedIntensityPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimatedIntensityPoint value)?  $default,){
final _that = this;
switch (_that) {
case _EstimatedIntensityPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String regionCode,  double intensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimatedIntensityPoint() when $default != null:
return $default(_that.regionCode,_that.intensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String regionCode,  double intensity)  $default,) {final _that = this;
switch (_that) {
case _EstimatedIntensityPoint():
return $default(_that.regionCode,_that.intensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String regionCode,  double intensity)?  $default,) {final _that = this;
switch (_that) {
case _EstimatedIntensityPoint() when $default != null:
return $default(_that.regionCode,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc


class _EstimatedIntensityPoint implements EstimatedIntensityPoint {
  const _EstimatedIntensityPoint({required this.regionCode, required this.intensity});
  

@override final  String regionCode;
@override final  double intensity;

/// Create a copy of EstimatedIntensityPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimatedIntensityPointCopyWith<_EstimatedIntensityPoint> get copyWith => __$EstimatedIntensityPointCopyWithImpl<_EstimatedIntensityPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimatedIntensityPoint&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,regionCode,intensity);

@override
String toString() {
  return 'EstimatedIntensityPoint(regionCode: $regionCode, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$EstimatedIntensityPointCopyWith<$Res> implements $EstimatedIntensityPointCopyWith<$Res> {
  factory _$EstimatedIntensityPointCopyWith(_EstimatedIntensityPoint value, $Res Function(_EstimatedIntensityPoint) _then) = __$EstimatedIntensityPointCopyWithImpl;
@override @useResult
$Res call({
 String regionCode, double intensity
});




}
/// @nodoc
class __$EstimatedIntensityPointCopyWithImpl<$Res>
    implements _$EstimatedIntensityPointCopyWith<$Res> {
  __$EstimatedIntensityPointCopyWithImpl(this._self, this._then);

  final _EstimatedIntensityPoint _self;
  final $Res Function(_EstimatedIntensityPoint) _then;

/// Create a copy of EstimatedIntensityPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionCode = null,Object? intensity = null,}) {
  return _then(_EstimatedIntensityPoint(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

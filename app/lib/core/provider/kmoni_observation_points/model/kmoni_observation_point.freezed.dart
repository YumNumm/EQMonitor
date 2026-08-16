// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kmoni_observation_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AnalyzedKmoniObservationPoint {

 KyoshinObservationPoint get point; double? get intensityValue;@ColorJsonConverter() Color? get intensityColor; double? get pga;@ColorJsonConverter() Color? get pgaColor;
/// Create a copy of AnalyzedKmoniObservationPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyzedKmoniObservationPointCopyWith<AnalyzedKmoniObservationPoint> get copyWith => _$AnalyzedKmoniObservationPointCopyWithImpl<AnalyzedKmoniObservationPoint>(this as AnalyzedKmoniObservationPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyzedKmoniObservationPoint&&(identical(other.point, point) || other.point == point)&&(identical(other.intensityValue, intensityValue) || other.intensityValue == intensityValue)&&(identical(other.intensityColor, intensityColor) || other.intensityColor == intensityColor)&&(identical(other.pga, pga) || other.pga == pga)&&(identical(other.pgaColor, pgaColor) || other.pgaColor == pgaColor));
}


@override
int get hashCode => Object.hash(runtimeType,point,intensityValue,intensityColor,pga,pgaColor);

@override
String toString() {
  return 'AnalyzedKmoniObservationPoint(point: $point, intensityValue: $intensityValue, intensityColor: $intensityColor, pga: $pga, pgaColor: $pgaColor)';
}


}

/// @nodoc
abstract mixin class $AnalyzedKmoniObservationPointCopyWith<$Res>  {
  factory $AnalyzedKmoniObservationPointCopyWith(AnalyzedKmoniObservationPoint value, $Res Function(AnalyzedKmoniObservationPoint) _then) = _$AnalyzedKmoniObservationPointCopyWithImpl;
@useResult
$Res call({
 KyoshinObservationPoint point, double? intensityValue,@ColorJsonConverter() Color? intensityColor, double? pga,@ColorJsonConverter() Color? pgaColor
});


$KyoshinObservationPointCopyWith<$Res> get point;

}
/// @nodoc
class _$AnalyzedKmoniObservationPointCopyWithImpl<$Res>
    implements $AnalyzedKmoniObservationPointCopyWith<$Res> {
  _$AnalyzedKmoniObservationPointCopyWithImpl(this._self, this._then);

  final AnalyzedKmoniObservationPoint _self;
  final $Res Function(AnalyzedKmoniObservationPoint) _then;

/// Create a copy of AnalyzedKmoniObservationPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? point = null,Object? intensityValue = freezed,Object? intensityColor = freezed,Object? pga = freezed,Object? pgaColor = freezed,}) {
  return _then(AnalyzedKmoniObservationPoint(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPoint,intensityValue: freezed == intensityValue ? _self.intensityValue : intensityValue // ignore: cast_nullable_to_non_nullable
as double?,intensityColor: freezed == intensityColor ? _self.intensityColor : intensityColor // ignore: cast_nullable_to_non_nullable
as Color?,pga: freezed == pga ? _self.pga : pga // ignore: cast_nullable_to_non_nullable
as double?,pgaColor: freezed == pgaColor ? _self.pgaColor : pgaColor // ignore: cast_nullable_to_non_nullable
as Color?,
  ));
}
/// Create a copy of AnalyzedKmoniObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinObservationPointCopyWith<$Res> get point {
  
  return $KyoshinObservationPointCopyWith<$Res>(_self.point, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}


/// Adds pattern-matching-related methods to [AnalyzedKmoniObservationPoint].
extension AnalyzedKmoniObservationPointPatterns on AnalyzedKmoniObservationPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnalyzedKmoniObservationPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnalyzedKmoniObservationPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnalyzedKmoniObservationPoint value)  $default,){
final _that = this;
switch (_that) {
case _AnalyzedKmoniObservationPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnalyzedKmoniObservationPoint value)?  $default,){
final _that = this;
switch (_that) {
case _AnalyzedKmoniObservationPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KyoshinObservationPoint point,  double? intensityValue, @ColorJsonConverter()  Color? intensityColor,  double? pga, @ColorJsonConverter()  Color? pgaColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnalyzedKmoniObservationPoint() when $default != null:
return $default(_that.point,_that.intensityValue,_that.intensityColor,_that.pga,_that.pgaColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KyoshinObservationPoint point,  double? intensityValue, @ColorJsonConverter()  Color? intensityColor,  double? pga, @ColorJsonConverter()  Color? pgaColor)  $default,) {final _that = this;
switch (_that) {
case _AnalyzedKmoniObservationPoint():
return $default(_that.point,_that.intensityValue,_that.intensityColor,_that.pga,_that.pgaColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KyoshinObservationPoint point,  double? intensityValue, @ColorJsonConverter()  Color? intensityColor,  double? pga, @ColorJsonConverter()  Color? pgaColor)?  $default,) {final _that = this;
switch (_that) {
case _AnalyzedKmoniObservationPoint() when $default != null:
return $default(_that.point,_that.intensityValue,_that.intensityColor,_that.pga,_that.pgaColor);case _:
  return null;

}
}

}

/// @nodoc


class _AnalyzedKmoniObservationPoint implements AnalyzedKmoniObservationPoint {
  const _AnalyzedKmoniObservationPoint({required this.point, this.intensityValue, @ColorJsonConverter() this.intensityColor, this.pga, @ColorJsonConverter() this.pgaColor});
  

@override final  KyoshinObservationPoint point;
@override final  double? intensityValue;
@override@ColorJsonConverter() final  Color? intensityColor;
@override final  double? pga;
@override@ColorJsonConverter() final  Color? pgaColor;

/// Create a copy of AnalyzedKmoniObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalyzedKmoniObservationPointCopyWith<_AnalyzedKmoniObservationPoint> get copyWith => __$AnalyzedKmoniObservationPointCopyWithImpl<_AnalyzedKmoniObservationPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnalyzedKmoniObservationPoint&&(identical(other.point, point) || other.point == point)&&(identical(other.intensityValue, intensityValue) || other.intensityValue == intensityValue)&&(identical(other.intensityColor, intensityColor) || other.intensityColor == intensityColor)&&(identical(other.pga, pga) || other.pga == pga)&&(identical(other.pgaColor, pgaColor) || other.pgaColor == pgaColor));
}


@override
int get hashCode => Object.hash(runtimeType,point,intensityValue,intensityColor,pga,pgaColor);

@override
String toString() {
  return 'AnalyzedKmoniObservationPoint(point: $point, intensityValue: $intensityValue, intensityColor: $intensityColor, pga: $pga, pgaColor: $pgaColor)';
}


}

/// @nodoc
abstract mixin class _$AnalyzedKmoniObservationPointCopyWith<$Res> implements $AnalyzedKmoniObservationPointCopyWith<$Res> {
  factory _$AnalyzedKmoniObservationPointCopyWith(_AnalyzedKmoniObservationPoint value, $Res Function(_AnalyzedKmoniObservationPoint) _then) = __$AnalyzedKmoniObservationPointCopyWithImpl;
@override @useResult
$Res call({
 KyoshinObservationPoint point, double? intensityValue,@ColorJsonConverter() Color? intensityColor, double? pga,@ColorJsonConverter() Color? pgaColor
});


@override $KyoshinObservationPointCopyWith<$Res> get point;

}
/// @nodoc
class __$AnalyzedKmoniObservationPointCopyWithImpl<$Res>
    implements _$AnalyzedKmoniObservationPointCopyWith<$Res> {
  __$AnalyzedKmoniObservationPointCopyWithImpl(this._self, this._then);

  final _AnalyzedKmoniObservationPoint _self;
  final $Res Function(_AnalyzedKmoniObservationPoint) _then;

/// Create a copy of AnalyzedKmoniObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? point = null,Object? intensityValue = freezed,Object? intensityColor = freezed,Object? pga = freezed,Object? pgaColor = freezed,}) {
  return _then(_AnalyzedKmoniObservationPoint(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPoint,intensityValue: freezed == intensityValue ? _self.intensityValue : intensityValue // ignore: cast_nullable_to_non_nullable
as double?,intensityColor: freezed == intensityColor ? _self.intensityColor : intensityColor // ignore: cast_nullable_to_non_nullable
as Color?,pga: freezed == pga ? _self.pga : pga // ignore: cast_nullable_to_non_nullable
as double?,pgaColor: freezed == pgaColor ? _self.pgaColor : pgaColor // ignore: cast_nullable_to_non_nullable
as Color?,
  ));
}

/// Create a copy of AnalyzedKmoniObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinObservationPointCopyWith<$Res> get point {
  
  return $KyoshinObservationPointCopyWith<$Res>(_self.point, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}

// dart format on

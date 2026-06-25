// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_telegram_body_accuracy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewTelegramBodyAccuracy {

 List<num> get epicenters; num get depth; num get magnitudeCalculation; num get numberOfMagnitudeCalculation;
/// Create a copy of EewTelegramBodyAccuracy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewTelegramBodyAccuracyCopyWith<EewTelegramBodyAccuracy> get copyWith => _$EewTelegramBodyAccuracyCopyWithImpl<EewTelegramBodyAccuracy>(this as EewTelegramBodyAccuracy, _$identity);

  /// Serializes this EewTelegramBodyAccuracy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewTelegramBodyAccuracy&&const DeepCollectionEquality().equals(other.epicenters, epicenters)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitudeCalculation, magnitudeCalculation) || other.magnitudeCalculation == magnitudeCalculation)&&(identical(other.numberOfMagnitudeCalculation, numberOfMagnitudeCalculation) || other.numberOfMagnitudeCalculation == numberOfMagnitudeCalculation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(epicenters),depth,magnitudeCalculation,numberOfMagnitudeCalculation);

@override
String toString() {
  return 'EewTelegramBodyAccuracy(epicenters: $epicenters, depth: $depth, magnitudeCalculation: $magnitudeCalculation, numberOfMagnitudeCalculation: $numberOfMagnitudeCalculation)';
}


}

/// @nodoc
abstract mixin class $EewTelegramBodyAccuracyCopyWith<$Res>  {
  factory $EewTelegramBodyAccuracyCopyWith(EewTelegramBodyAccuracy value, $Res Function(EewTelegramBodyAccuracy) _then) = _$EewTelegramBodyAccuracyCopyWithImpl;
@useResult
$Res call({
 List<num> epicenters, num depth, num magnitudeCalculation, num numberOfMagnitudeCalculation
});




}
/// @nodoc
class _$EewTelegramBodyAccuracyCopyWithImpl<$Res>
    implements $EewTelegramBodyAccuracyCopyWith<$Res> {
  _$EewTelegramBodyAccuracyCopyWithImpl(this._self, this._then);

  final EewTelegramBodyAccuracy _self;
  final $Res Function(EewTelegramBodyAccuracy) _then;

/// Create a copy of EewTelegramBodyAccuracy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? epicenters = null,Object? depth = null,Object? magnitudeCalculation = null,Object? numberOfMagnitudeCalculation = null,}) {
  return _then(_self.copyWith(
epicenters: null == epicenters ? _self.epicenters : epicenters // ignore: cast_nullable_to_non_nullable
as List<num>,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as num,magnitudeCalculation: null == magnitudeCalculation ? _self.magnitudeCalculation : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
as num,numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation ? _self.numberOfMagnitudeCalculation : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [EewTelegramBodyAccuracy].
extension EewTelegramBodyAccuracyPatterns on EewTelegramBodyAccuracy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewTelegramBodyAccuracy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewTelegramBodyAccuracy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewTelegramBodyAccuracy value)  $default,){
final _that = this;
switch (_that) {
case _EewTelegramBodyAccuracy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewTelegramBodyAccuracy value)?  $default,){
final _that = this;
switch (_that) {
case _EewTelegramBodyAccuracy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<num> epicenters,  num depth,  num magnitudeCalculation,  num numberOfMagnitudeCalculation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewTelegramBodyAccuracy() when $default != null:
return $default(_that.epicenters,_that.depth,_that.magnitudeCalculation,_that.numberOfMagnitudeCalculation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<num> epicenters,  num depth,  num magnitudeCalculation,  num numberOfMagnitudeCalculation)  $default,) {final _that = this;
switch (_that) {
case _EewTelegramBodyAccuracy():
return $default(_that.epicenters,_that.depth,_that.magnitudeCalculation,_that.numberOfMagnitudeCalculation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<num> epicenters,  num depth,  num magnitudeCalculation,  num numberOfMagnitudeCalculation)?  $default,) {final _that = this;
switch (_that) {
case _EewTelegramBodyAccuracy() when $default != null:
return $default(_that.epicenters,_that.depth,_that.magnitudeCalculation,_that.numberOfMagnitudeCalculation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewTelegramBodyAccuracy implements EewTelegramBodyAccuracy {
  const _EewTelegramBodyAccuracy({required final  List<num> epicenters, required this.depth, required this.magnitudeCalculation, required this.numberOfMagnitudeCalculation}): _epicenters = epicenters;
  factory _EewTelegramBodyAccuracy.fromJson(Map<String, dynamic> json) => _$EewTelegramBodyAccuracyFromJson(json);

 final  List<num> _epicenters;
@override List<num> get epicenters {
  if (_epicenters is EqualUnmodifiableListView) return _epicenters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_epicenters);
}

@override final  num depth;
@override final  num magnitudeCalculation;
@override final  num numberOfMagnitudeCalculation;

/// Create a copy of EewTelegramBodyAccuracy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewTelegramBodyAccuracyCopyWith<_EewTelegramBodyAccuracy> get copyWith => __$EewTelegramBodyAccuracyCopyWithImpl<_EewTelegramBodyAccuracy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewTelegramBodyAccuracyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewTelegramBodyAccuracy&&const DeepCollectionEquality().equals(other._epicenters, _epicenters)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitudeCalculation, magnitudeCalculation) || other.magnitudeCalculation == magnitudeCalculation)&&(identical(other.numberOfMagnitudeCalculation, numberOfMagnitudeCalculation) || other.numberOfMagnitudeCalculation == numberOfMagnitudeCalculation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_epicenters),depth,magnitudeCalculation,numberOfMagnitudeCalculation);

@override
String toString() {
  return 'EewTelegramBodyAccuracy(epicenters: $epicenters, depth: $depth, magnitudeCalculation: $magnitudeCalculation, numberOfMagnitudeCalculation: $numberOfMagnitudeCalculation)';
}


}

/// @nodoc
abstract mixin class _$EewTelegramBodyAccuracyCopyWith<$Res> implements $EewTelegramBodyAccuracyCopyWith<$Res> {
  factory _$EewTelegramBodyAccuracyCopyWith(_EewTelegramBodyAccuracy value, $Res Function(_EewTelegramBodyAccuracy) _then) = __$EewTelegramBodyAccuracyCopyWithImpl;
@override @useResult
$Res call({
 List<num> epicenters, num depth, num magnitudeCalculation, num numberOfMagnitudeCalculation
});




}
/// @nodoc
class __$EewTelegramBodyAccuracyCopyWithImpl<$Res>
    implements _$EewTelegramBodyAccuracyCopyWith<$Res> {
  __$EewTelegramBodyAccuracyCopyWithImpl(this._self, this._then);

  final _EewTelegramBodyAccuracy _self;
  final $Res Function(_EewTelegramBodyAccuracy) _then;

/// Create a copy of EewTelegramBodyAccuracy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? epicenters = null,Object? depth = null,Object? magnitudeCalculation = null,Object? numberOfMagnitudeCalculation = null,}) {
  return _then(_EewTelegramBodyAccuracy(
epicenters: null == epicenters ? _self._epicenters : epicenters // ignore: cast_nullable_to_non_nullable
as List<num>,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as num,magnitudeCalculation: null == magnitudeCalculation ? _self.magnitudeCalculation : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
as num,numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation ? _self.numberOfMagnitudeCalculation : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on

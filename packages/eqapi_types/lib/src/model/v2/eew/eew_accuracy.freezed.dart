// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_accuracy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewAccuracy {

 List<int> get epicenters; int get depth; int get magnitudeCalculation; int get numberOfMagnitudeCalculation;
/// Create a copy of EewAccuracy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewAccuracyCopyWith<EewAccuracy> get copyWith => _$EewAccuracyCopyWithImpl<EewAccuracy>(this as EewAccuracy, _$identity);

  /// Serializes this EewAccuracy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewAccuracy&&const DeepCollectionEquality().equals(other.epicenters, epicenters)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitudeCalculation, magnitudeCalculation) || other.magnitudeCalculation == magnitudeCalculation)&&(identical(other.numberOfMagnitudeCalculation, numberOfMagnitudeCalculation) || other.numberOfMagnitudeCalculation == numberOfMagnitudeCalculation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(epicenters),depth,magnitudeCalculation,numberOfMagnitudeCalculation);

@override
String toString() {
  return 'EewAccuracy(epicenters: $epicenters, depth: $depth, magnitudeCalculation: $magnitudeCalculation, numberOfMagnitudeCalculation: $numberOfMagnitudeCalculation)';
}


}

/// @nodoc
abstract mixin class $EewAccuracyCopyWith<$Res>  {
  factory $EewAccuracyCopyWith(EewAccuracy value, $Res Function(EewAccuracy) _then) = _$EewAccuracyCopyWithImpl;
@useResult
$Res call({
 List<int> epicenters, int depth, int magnitudeCalculation, int numberOfMagnitudeCalculation
});




}
/// @nodoc
class _$EewAccuracyCopyWithImpl<$Res>
    implements $EewAccuracyCopyWith<$Res> {
  _$EewAccuracyCopyWithImpl(this._self, this._then);

  final EewAccuracy _self;
  final $Res Function(EewAccuracy) _then;

/// Create a copy of EewAccuracy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? epicenters = null,Object? depth = null,Object? magnitudeCalculation = null,Object? numberOfMagnitudeCalculation = null,}) {
  return _then(_self.copyWith(
epicenters: null == epicenters ? _self.epicenters : epicenters // ignore: cast_nullable_to_non_nullable
as List<int>,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,magnitudeCalculation: null == magnitudeCalculation ? _self.magnitudeCalculation : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation ? _self.numberOfMagnitudeCalculation : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EewAccuracy].
extension EewAccuracyPatterns on EewAccuracy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewAccuracy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewAccuracy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewAccuracy value)  $default,){
final _that = this;
switch (_that) {
case _EewAccuracy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewAccuracy value)?  $default,){
final _that = this;
switch (_that) {
case _EewAccuracy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int> epicenters,  int depth,  int magnitudeCalculation,  int numberOfMagnitudeCalculation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewAccuracy() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int> epicenters,  int depth,  int magnitudeCalculation,  int numberOfMagnitudeCalculation)  $default,) {final _that = this;
switch (_that) {
case _EewAccuracy():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int> epicenters,  int depth,  int magnitudeCalculation,  int numberOfMagnitudeCalculation)?  $default,) {final _that = this;
switch (_that) {
case _EewAccuracy() when $default != null:
return $default(_that.epicenters,_that.depth,_that.magnitudeCalculation,_that.numberOfMagnitudeCalculation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewAccuracy implements EewAccuracy {
  const _EewAccuracy({required final  List<int> epicenters, required this.depth, required this.magnitudeCalculation, required this.numberOfMagnitudeCalculation}): _epicenters = epicenters;
  factory _EewAccuracy.fromJson(Map<String, dynamic> json) => _$EewAccuracyFromJson(json);

 final  List<int> _epicenters;
@override List<int> get epicenters {
  if (_epicenters is EqualUnmodifiableListView) return _epicenters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_epicenters);
}

@override final  int depth;
@override final  int magnitudeCalculation;
@override final  int numberOfMagnitudeCalculation;

/// Create a copy of EewAccuracy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewAccuracyCopyWith<_EewAccuracy> get copyWith => __$EewAccuracyCopyWithImpl<_EewAccuracy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewAccuracyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewAccuracy&&const DeepCollectionEquality().equals(other._epicenters, _epicenters)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitudeCalculation, magnitudeCalculation) || other.magnitudeCalculation == magnitudeCalculation)&&(identical(other.numberOfMagnitudeCalculation, numberOfMagnitudeCalculation) || other.numberOfMagnitudeCalculation == numberOfMagnitudeCalculation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_epicenters),depth,magnitudeCalculation,numberOfMagnitudeCalculation);

@override
String toString() {
  return 'EewAccuracy(epicenters: $epicenters, depth: $depth, magnitudeCalculation: $magnitudeCalculation, numberOfMagnitudeCalculation: $numberOfMagnitudeCalculation)';
}


}

/// @nodoc
abstract mixin class _$EewAccuracyCopyWith<$Res> implements $EewAccuracyCopyWith<$Res> {
  factory _$EewAccuracyCopyWith(_EewAccuracy value, $Res Function(_EewAccuracy) _then) = __$EewAccuracyCopyWithImpl;
@override @useResult
$Res call({
 List<int> epicenters, int depth, int magnitudeCalculation, int numberOfMagnitudeCalculation
});




}
/// @nodoc
class __$EewAccuracyCopyWithImpl<$Res>
    implements _$EewAccuracyCopyWith<$Res> {
  __$EewAccuracyCopyWithImpl(this._self, this._then);

  final _EewAccuracy _self;
  final $Res Function(_EewAccuracy) _then;

/// Create a copy of EewAccuracy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? epicenters = null,Object? depth = null,Object? magnitudeCalculation = null,Object? numberOfMagnitudeCalculation = null,}) {
  return _then(_EewAccuracy(
epicenters: null == epicenters ? _self._epicenters : epicenters // ignore: cast_nullable_to_non_nullable
as List<int>,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,magnitudeCalculation: null == magnitudeCalculation ? _self.magnitudeCalculation : magnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,numberOfMagnitudeCalculation: null == numberOfMagnitudeCalculation ? _self.numberOfMagnitudeCalculation : numberOfMagnitudeCalculation // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_coverage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HypocenterCoverage {

 DateTime get from; DateTime get to;
/// Create a copy of HypocenterCoverage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterCoverageCopyWith<HypocenterCoverage> get copyWith => _$HypocenterCoverageCopyWithImpl<HypocenterCoverage>(this as HypocenterCoverage, _$identity);

  /// Serializes this HypocenterCoverage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterCoverage&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'HypocenterCoverage(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $HypocenterCoverageCopyWith<$Res>  {
  factory $HypocenterCoverageCopyWith(HypocenterCoverage value, $Res Function(HypocenterCoverage) _then) = _$HypocenterCoverageCopyWithImpl;
@useResult
$Res call({
 DateTime from, DateTime to
});




}
/// @nodoc
class _$HypocenterCoverageCopyWithImpl<$Res>
    implements $HypocenterCoverageCopyWith<$Res> {
  _$HypocenterCoverageCopyWithImpl(this._self, this._then);

  final HypocenterCoverage _self;
  final $Res Function(HypocenterCoverage) _then;

/// Create a copy of HypocenterCoverage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HypocenterCoverage].
extension HypocenterCoveragePatterns on HypocenterCoverage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterCoverage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterCoverage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterCoverage value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterCoverage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterCoverage value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterCoverage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime from,  DateTime to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterCoverage() when $default != null:
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime from,  DateTime to)  $default,) {final _that = this;
switch (_that) {
case _HypocenterCoverage():
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime from,  DateTime to)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterCoverage() when $default != null:
return $default(_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HypocenterCoverage implements HypocenterCoverage {
  const _HypocenterCoverage({required this.from, required this.to});
  factory _HypocenterCoverage.fromJson(Map<String, dynamic> json) => _$HypocenterCoverageFromJson(json);

@override final  DateTime from;
@override final  DateTime to;

/// Create a copy of HypocenterCoverage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterCoverageCopyWith<_HypocenterCoverage> get copyWith => __$HypocenterCoverageCopyWithImpl<_HypocenterCoverage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HypocenterCoverageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterCoverage&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'HypocenterCoverage(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$HypocenterCoverageCopyWith<$Res> implements $HypocenterCoverageCopyWith<$Res> {
  factory _$HypocenterCoverageCopyWith(_HypocenterCoverage value, $Res Function(_HypocenterCoverage) _then) = __$HypocenterCoverageCopyWithImpl;
@override @useResult
$Res call({
 DateTime from, DateTime to
});




}
/// @nodoc
class __$HypocenterCoverageCopyWithImpl<$Res>
    implements _$HypocenterCoverageCopyWith<$Res> {
  __$HypocenterCoverageCopyWithImpl(this._self, this._then);

  final _HypocenterCoverage _self;
  final $Res Function(_HypocenterCoverage) _then;

/// Create a copy of HypocenterCoverage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,}) {
  return _then(_HypocenterCoverage(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

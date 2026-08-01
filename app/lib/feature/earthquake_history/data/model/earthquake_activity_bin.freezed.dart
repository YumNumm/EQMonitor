// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_activity_bin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeActivityBin {

 DateTime get start; DateTime get end; Map<EarthquakeActivityIntensityCategory, int> get counts;
/// Create a copy of EarthquakeActivityBin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeActivityBinCopyWith<EarthquakeActivityBin> get copyWith => _$EarthquakeActivityBinCopyWithImpl<EarthquakeActivityBin>(this as EarthquakeActivityBin, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeActivityBin&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&const DeepCollectionEquality().equals(other.counts, counts));
}


@override
int get hashCode => Object.hash(runtimeType,start,end,const DeepCollectionEquality().hash(counts));

@override
String toString() {
  return 'EarthquakeActivityBin(start: $start, end: $end, counts: $counts)';
}


}

/// @nodoc
abstract mixin class $EarthquakeActivityBinCopyWith<$Res>  {
  factory $EarthquakeActivityBinCopyWith(EarthquakeActivityBin value, $Res Function(EarthquakeActivityBin) _then) = _$EarthquakeActivityBinCopyWithImpl;
@useResult
$Res call({
 DateTime start, DateTime end, Map<EarthquakeActivityIntensityCategory, int> counts
});




}
/// @nodoc
class _$EarthquakeActivityBinCopyWithImpl<$Res>
    implements $EarthquakeActivityBinCopyWith<$Res> {
  _$EarthquakeActivityBinCopyWithImpl(this._self, this._then);

  final EarthquakeActivityBin _self;
  final $Res Function(EarthquakeActivityBin) _then;

/// Create a copy of EarthquakeActivityBin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,Object? counts = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as Map<EarthquakeActivityIntensityCategory, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeActivityBin].
extension EarthquakeActivityBinPatterns on EarthquakeActivityBin {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeActivityBin value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeActivityBin() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeActivityBin value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeActivityBin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeActivityBin value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeActivityBin() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime start,  DateTime end,  Map<EarthquakeActivityIntensityCategory, int> counts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeActivityBin() when $default != null:
return $default(_that.start,_that.end,_that.counts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime start,  DateTime end,  Map<EarthquakeActivityIntensityCategory, int> counts)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeActivityBin():
return $default(_that.start,_that.end,_that.counts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime start,  DateTime end,  Map<EarthquakeActivityIntensityCategory, int> counts)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeActivityBin() when $default != null:
return $default(_that.start,_that.end,_that.counts);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeActivityBin extends EarthquakeActivityBin {
  const _EarthquakeActivityBin({required this.start, required this.end, required final  Map<EarthquakeActivityIntensityCategory, int> counts}): _counts = counts,super._();


@override final  DateTime start;
@override final  DateTime end;
 final  Map<EarthquakeActivityIntensityCategory, int> _counts;
@override Map<EarthquakeActivityIntensityCategory, int> get counts {
  if (_counts is EqualUnmodifiableMapView) return _counts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_counts);
}


/// Create a copy of EarthquakeActivityBin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeActivityBinCopyWith<_EarthquakeActivityBin> get copyWith => __$EarthquakeActivityBinCopyWithImpl<_EarthquakeActivityBin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeActivityBin&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&const DeepCollectionEquality().equals(other._counts, _counts));
}


@override
int get hashCode => Object.hash(runtimeType,start,end,const DeepCollectionEquality().hash(_counts));

@override
String toString() {
  return 'EarthquakeActivityBin(start: $start, end: $end, counts: $counts)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeActivityBinCopyWith<$Res> implements $EarthquakeActivityBinCopyWith<$Res> {
  factory _$EarthquakeActivityBinCopyWith(_EarthquakeActivityBin value, $Res Function(_EarthquakeActivityBin) _then) = __$EarthquakeActivityBinCopyWithImpl;
@override @useResult
$Res call({
 DateTime start, DateTime end, Map<EarthquakeActivityIntensityCategory, int> counts
});




}
/// @nodoc
class __$EarthquakeActivityBinCopyWithImpl<$Res>
    implements _$EarthquakeActivityBinCopyWith<$Res> {
  __$EarthquakeActivityBinCopyWithImpl(this._self, this._then);

  final _EarthquakeActivityBin _self;
  final $Res Function(_EarthquakeActivityBin) _then;

/// Create a copy of EarthquakeActivityBin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? counts = null,}) {
  return _then(_EarthquakeActivityBin(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,counts: null == counts ? _self._counts : counts // ignore: cast_nullable_to_non_nullable
as Map<EarthquakeActivityIntensityCategory, int>,
  ));
}


}

// dart format on

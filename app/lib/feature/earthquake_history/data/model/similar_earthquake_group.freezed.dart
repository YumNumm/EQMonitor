// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'similar_earthquake_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SimilarEarthquakeGroup {

 EarthquakePartial get representative; num get score; List<EarthquakePartial> get groupedEarthquakes;
/// Create a copy of SimilarEarthquakeGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimilarEarthquakeGroupCopyWith<SimilarEarthquakeGroup> get copyWith => _$SimilarEarthquakeGroupCopyWithImpl<SimilarEarthquakeGroup>(this as SimilarEarthquakeGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimilarEarthquakeGroup&&(identical(other.representative, representative) || other.representative == representative)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.groupedEarthquakes, groupedEarthquakes));
}


@override
int get hashCode => Object.hash(runtimeType,representative,score,const DeepCollectionEquality().hash(groupedEarthquakes));

@override
String toString() {
  return 'SimilarEarthquakeGroup(representative: $representative, score: $score, groupedEarthquakes: $groupedEarthquakes)';
}


}

/// @nodoc
abstract mixin class $SimilarEarthquakeGroupCopyWith<$Res>  {
  factory $SimilarEarthquakeGroupCopyWith(SimilarEarthquakeGroup value, $Res Function(SimilarEarthquakeGroup) _then) = _$SimilarEarthquakeGroupCopyWithImpl;
@useResult
$Res call({
 EarthquakePartial representative, num score, List<EarthquakePartial> groupedEarthquakes
});


$EarthquakePartialCopyWith<$Res> get representative;

}
/// @nodoc
class _$SimilarEarthquakeGroupCopyWithImpl<$Res>
    implements $SimilarEarthquakeGroupCopyWith<$Res> {
  _$SimilarEarthquakeGroupCopyWithImpl(this._self, this._then);

  final SimilarEarthquakeGroup _self;
  final $Res Function(SimilarEarthquakeGroup) _then;

/// Create a copy of SimilarEarthquakeGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? representative = null,Object? score = null,Object? groupedEarthquakes = null,}) {
  return _then(_self.copyWith(
representative: null == representative ? _self.representative : representative // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num,groupedEarthquakes: null == groupedEarthquakes ? _self.groupedEarthquakes : groupedEarthquakes // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,
  ));
}
/// Create a copy of SimilarEarthquakeGroup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get representative {
  
  return $EarthquakePartialCopyWith<$Res>(_self.representative, (value) {
    return _then(_self.copyWith(representative: value));
  });
}
}


/// Adds pattern-matching-related methods to [SimilarEarthquakeGroup].
extension SimilarEarthquakeGroupPatterns on SimilarEarthquakeGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimilarEarthquakeGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimilarEarthquakeGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimilarEarthquakeGroup value)  $default,){
final _that = this;
switch (_that) {
case _SimilarEarthquakeGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimilarEarthquakeGroup value)?  $default,){
final _that = this;
switch (_that) {
case _SimilarEarthquakeGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakePartial representative,  num score,  List<EarthquakePartial> groupedEarthquakes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimilarEarthquakeGroup() when $default != null:
return $default(_that.representative,_that.score,_that.groupedEarthquakes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakePartial representative,  num score,  List<EarthquakePartial> groupedEarthquakes)  $default,) {final _that = this;
switch (_that) {
case _SimilarEarthquakeGroup():
return $default(_that.representative,_that.score,_that.groupedEarthquakes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakePartial representative,  num score,  List<EarthquakePartial> groupedEarthquakes)?  $default,) {final _that = this;
switch (_that) {
case _SimilarEarthquakeGroup() when $default != null:
return $default(_that.representative,_that.score,_that.groupedEarthquakes);case _:
  return null;

}
}

}

/// @nodoc


class _SimilarEarthquakeGroup extends SimilarEarthquakeGroup {
  const _SimilarEarthquakeGroup({required this.representative, required this.score, required final  List<EarthquakePartial> groupedEarthquakes}): _groupedEarthquakes = groupedEarthquakes,super._();
  

@override final  EarthquakePartial representative;
@override final  num score;
 final  List<EarthquakePartial> _groupedEarthquakes;
@override List<EarthquakePartial> get groupedEarthquakes {
  if (_groupedEarthquakes is EqualUnmodifiableListView) return _groupedEarthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groupedEarthquakes);
}


/// Create a copy of SimilarEarthquakeGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimilarEarthquakeGroupCopyWith<_SimilarEarthquakeGroup> get copyWith => __$SimilarEarthquakeGroupCopyWithImpl<_SimilarEarthquakeGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimilarEarthquakeGroup&&(identical(other.representative, representative) || other.representative == representative)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._groupedEarthquakes, _groupedEarthquakes));
}


@override
int get hashCode => Object.hash(runtimeType,representative,score,const DeepCollectionEquality().hash(_groupedEarthquakes));

@override
String toString() {
  return 'SimilarEarthquakeGroup(representative: $representative, score: $score, groupedEarthquakes: $groupedEarthquakes)';
}


}

/// @nodoc
abstract mixin class _$SimilarEarthquakeGroupCopyWith<$Res> implements $SimilarEarthquakeGroupCopyWith<$Res> {
  factory _$SimilarEarthquakeGroupCopyWith(_SimilarEarthquakeGroup value, $Res Function(_SimilarEarthquakeGroup) _then) = __$SimilarEarthquakeGroupCopyWithImpl;
@override @useResult
$Res call({
 EarthquakePartial representative, num score, List<EarthquakePartial> groupedEarthquakes
});


@override $EarthquakePartialCopyWith<$Res> get representative;

}
/// @nodoc
class __$SimilarEarthquakeGroupCopyWithImpl<$Res>
    implements _$SimilarEarthquakeGroupCopyWith<$Res> {
  __$SimilarEarthquakeGroupCopyWithImpl(this._self, this._then);

  final _SimilarEarthquakeGroup _self;
  final $Res Function(_SimilarEarthquakeGroup) _then;

/// Create a copy of SimilarEarthquakeGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? representative = null,Object? score = null,Object? groupedEarthquakes = null,}) {
  return _then(_SimilarEarthquakeGroup(
representative: null == representative ? _self.representative : representative // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num,groupedEarthquakes: null == groupedEarthquakes ? _self._groupedEarthquakes : groupedEarthquakes // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,
  ));
}

/// Create a copy of SimilarEarthquakeGroup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get representative {
  
  return $EarthquakePartialCopyWith<$Res>(_self.representative, (value) {
    return _then(_self.copyWith(representative: value));
  });
}
}

// dart format on

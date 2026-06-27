// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'similar_earthquake_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SimilarEarthquakeItem {

 EarthquakePartial get earthquake; double get score; SimilarityLevel get level; List<EarthquakePartial> get groupedEarthquakes;
/// Create a copy of SimilarEarthquakeItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimilarEarthquakeItemCopyWith<SimilarEarthquakeItem> get copyWith => _$SimilarEarthquakeItemCopyWithImpl<SimilarEarthquakeItem>(this as SimilarEarthquakeItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimilarEarthquakeItem&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake)&&(identical(other.score, score) || other.score == score)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other.groupedEarthquakes, groupedEarthquakes));
}


@override
int get hashCode => Object.hash(runtimeType,earthquake,score,level,const DeepCollectionEquality().hash(groupedEarthquakes));

@override
String toString() {
  return 'SimilarEarthquakeItem(earthquake: $earthquake, score: $score, level: $level, groupedEarthquakes: $groupedEarthquakes)';
}


}

/// @nodoc
abstract mixin class $SimilarEarthquakeItemCopyWith<$Res>  {
  factory $SimilarEarthquakeItemCopyWith(SimilarEarthquakeItem value, $Res Function(SimilarEarthquakeItem) _then) = _$SimilarEarthquakeItemCopyWithImpl;
@useResult
$Res call({
 EarthquakePartial earthquake, double score, SimilarityLevel level, List<EarthquakePartial> groupedEarthquakes
});


$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$SimilarEarthquakeItemCopyWithImpl<$Res>
    implements $SimilarEarthquakeItemCopyWith<$Res> {
  _$SimilarEarthquakeItemCopyWithImpl(this._self, this._then);

  final SimilarEarthquakeItem _self;
  final $Res Function(SimilarEarthquakeItem) _then;

/// Create a copy of SimilarEarthquakeItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? earthquake = null,Object? score = null,Object? level = null,Object? groupedEarthquakes = null,}) {
  return _then(_self.copyWith(
earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as SimilarityLevel,groupedEarthquakes: null == groupedEarthquakes ? _self.groupedEarthquakes : groupedEarthquakes // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,
  ));
}
/// Create a copy of SimilarEarthquakeItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [SimilarEarthquakeItem].
extension SimilarEarthquakeItemPatterns on SimilarEarthquakeItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimilarEarthquakeItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimilarEarthquakeItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimilarEarthquakeItem value)  $default,){
final _that = this;
switch (_that) {
case _SimilarEarthquakeItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimilarEarthquakeItem value)?  $default,){
final _that = this;
switch (_that) {
case _SimilarEarthquakeItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakePartial earthquake,  double score,  SimilarityLevel level,  List<EarthquakePartial> groupedEarthquakes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimilarEarthquakeItem() when $default != null:
return $default(_that.earthquake,_that.score,_that.level,_that.groupedEarthquakes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakePartial earthquake,  double score,  SimilarityLevel level,  List<EarthquakePartial> groupedEarthquakes)  $default,) {final _that = this;
switch (_that) {
case _SimilarEarthquakeItem():
return $default(_that.earthquake,_that.score,_that.level,_that.groupedEarthquakes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakePartial earthquake,  double score,  SimilarityLevel level,  List<EarthquakePartial> groupedEarthquakes)?  $default,) {final _that = this;
switch (_that) {
case _SimilarEarthquakeItem() when $default != null:
return $default(_that.earthquake,_that.score,_that.level,_that.groupedEarthquakes);case _:
  return null;

}
}

}

/// @nodoc


class _SimilarEarthquakeItem implements SimilarEarthquakeItem {
  const _SimilarEarthquakeItem({required this.earthquake, required this.score, required this.level, required final  List<EarthquakePartial> groupedEarthquakes}): _groupedEarthquakes = groupedEarthquakes;
  

@override final  EarthquakePartial earthquake;
@override final  double score;
@override final  SimilarityLevel level;
 final  List<EarthquakePartial> _groupedEarthquakes;
@override List<EarthquakePartial> get groupedEarthquakes {
  if (_groupedEarthquakes is EqualUnmodifiableListView) return _groupedEarthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groupedEarthquakes);
}


/// Create a copy of SimilarEarthquakeItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimilarEarthquakeItemCopyWith<_SimilarEarthquakeItem> get copyWith => __$SimilarEarthquakeItemCopyWithImpl<_SimilarEarthquakeItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimilarEarthquakeItem&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake)&&(identical(other.score, score) || other.score == score)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other._groupedEarthquakes, _groupedEarthquakes));
}


@override
int get hashCode => Object.hash(runtimeType,earthquake,score,level,const DeepCollectionEquality().hash(_groupedEarthquakes));

@override
String toString() {
  return 'SimilarEarthquakeItem(earthquake: $earthquake, score: $score, level: $level, groupedEarthquakes: $groupedEarthquakes)';
}


}

/// @nodoc
abstract mixin class _$SimilarEarthquakeItemCopyWith<$Res> implements $SimilarEarthquakeItemCopyWith<$Res> {
  factory _$SimilarEarthquakeItemCopyWith(_SimilarEarthquakeItem value, $Res Function(_SimilarEarthquakeItem) _then) = __$SimilarEarthquakeItemCopyWithImpl;
@override @useResult
$Res call({
 EarthquakePartial earthquake, double score, SimilarityLevel level, List<EarthquakePartial> groupedEarthquakes
});


@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$SimilarEarthquakeItemCopyWithImpl<$Res>
    implements _$SimilarEarthquakeItemCopyWith<$Res> {
  __$SimilarEarthquakeItemCopyWithImpl(this._self, this._then);

  final _SimilarEarthquakeItem _self;
  final $Res Function(_SimilarEarthquakeItem) _then;

/// Create a copy of SimilarEarthquakeItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? earthquake = null,Object? score = null,Object? level = null,Object? groupedEarthquakes = null,}) {
  return _then(_SimilarEarthquakeItem(
earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as SimilarityLevel,groupedEarthquakes: null == groupedEarthquakes ? _self._groupedEarthquakes : groupedEarthquakes // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,
  ));
}

/// Create a copy of SimilarEarthquakeItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

// dart format on

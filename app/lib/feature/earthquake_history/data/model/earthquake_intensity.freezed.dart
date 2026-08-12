// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_intensity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeIntensity {

 JmaIntensity get maxIntensity; JmaLpgmIntensity? get maxLpgmIntensity; Map<JmaIntensity, List<IntensityRegion>> get regions; Map<JmaIntensity, List<PrefectureIntensityNode>> get intensityTree; Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> get lpgmIntensityTree;
/// Create a copy of EarthquakeIntensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeIntensityCopyWith<EarthquakeIntensity> get copyWith => _$EarthquakeIntensityCopyWithImpl<EarthquakeIntensity>(this as EarthquakeIntensity, _$identity);

  /// Serializes this EarthquakeIntensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeIntensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.intensityTree, intensityTree)&&const DeepCollectionEquality().equals(other.lpgmIntensityTree, lpgmIntensityTree));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(intensityTree),const DeepCollectionEquality().hash(lpgmIntensityTree));

@override
String toString() {
  return 'EarthquakeIntensity(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, regions: $regions, intensityTree: $intensityTree, lpgmIntensityTree: $lpgmIntensityTree)';
}


}

/// @nodoc
abstract mixin class $EarthquakeIntensityCopyWith<$Res>  {
  factory $EarthquakeIntensityCopyWith(EarthquakeIntensity value, $Res Function(EarthquakeIntensity) _then) = _$EarthquakeIntensityCopyWithImpl;
@useResult
$Res call({
 JmaIntensity maxIntensity, JmaLpgmIntensity? maxLpgmIntensity, Map<JmaIntensity, List<IntensityRegion>> regions, Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree, Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree
});




}
/// @nodoc
class _$EarthquakeIntensityCopyWithImpl<$Res>
    implements $EarthquakeIntensityCopyWith<$Res> {
  _$EarthquakeIntensityCopyWithImpl(this._self, this._then);

  final EarthquakeIntensity _self;
  final $Res Function(EarthquakeIntensity) _then;

/// Create a copy of EarthquakeIntensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? regions = null,Object? intensityTree = null,Object? lpgmIntensityTree = null,}) {
  return _then(EarthquakeIntensity(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<IntensityRegion>>,intensityTree: null == intensityTree ? _self.intensityTree : intensityTree // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<PrefectureIntensityNode>>,lpgmIntensityTree: null == lpgmIntensityTree ? _self.lpgmIntensityTree : lpgmIntensityTree // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeIntensity].
extension EarthquakeIntensityPatterns on EarthquakeIntensity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeIntensity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeIntensity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeIntensity value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeIntensity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeIntensity value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeIntensity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaIntensity maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeIntensity() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.regions,_that.intensityTree,_that.lpgmIntensityTree);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaIntensity maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeIntensity():
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.regions,_that.intensityTree,_that.lpgmIntensityTree);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaIntensity maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeIntensity() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.regions,_that.intensityTree,_that.lpgmIntensityTree);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeIntensity implements EarthquakeIntensity {
  const _EarthquakeIntensity({required this.maxIntensity, required this.maxLpgmIntensity, required  Map<JmaIntensity, List<IntensityRegion>> regions, required  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree, required  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree}): _regions = regions,_intensityTree = intensityTree,_lpgmIntensityTree = lpgmIntensityTree;
  factory _EarthquakeIntensity.fromJson(Map<String, dynamic> json) => _$EarthquakeIntensityFromJson(json);

@override final  JmaIntensity maxIntensity;
@override final  JmaLpgmIntensity? maxLpgmIntensity;
 final  Map<JmaIntensity, List<IntensityRegion>> _regions;
@override Map<JmaIntensity, List<IntensityRegion>> get regions {
  if (_regions is EqualUnmodifiableMapView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_regions);
}

 final  Map<JmaIntensity, List<PrefectureIntensityNode>> _intensityTree;
@override Map<JmaIntensity, List<PrefectureIntensityNode>> get intensityTree {
  if (_intensityTree is EqualUnmodifiableMapView) return _intensityTree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_intensityTree);
}

 final  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> _lpgmIntensityTree;
@override Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> get lpgmIntensityTree {
  if (_lpgmIntensityTree is EqualUnmodifiableMapView) return _lpgmIntensityTree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lpgmIntensityTree);
}


/// Create a copy of EarthquakeIntensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeIntensityCopyWith<_EarthquakeIntensity> get copyWith => __$EarthquakeIntensityCopyWithImpl<_EarthquakeIntensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeIntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeIntensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._intensityTree, _intensityTree)&&const DeepCollectionEquality().equals(other._lpgmIntensityTree, _lpgmIntensityTree));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_intensityTree),const DeepCollectionEquality().hash(_lpgmIntensityTree));

@override
String toString() {
  return 'EarthquakeIntensity(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, regions: $regions, intensityTree: $intensityTree, lpgmIntensityTree: $lpgmIntensityTree)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeIntensityCopyWith<$Res> implements $EarthquakeIntensityCopyWith<$Res> {
  factory _$EarthquakeIntensityCopyWith(_EarthquakeIntensity value, $Res Function(_EarthquakeIntensity) _then) = __$EarthquakeIntensityCopyWithImpl;
@override @useResult
$Res call({
 JmaIntensity maxIntensity, JmaLpgmIntensity? maxLpgmIntensity, Map<JmaIntensity, List<IntensityRegion>> regions, Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree, Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree
});




}
/// @nodoc
class __$EarthquakeIntensityCopyWithImpl<$Res>
    implements _$EarthquakeIntensityCopyWith<$Res> {
  __$EarthquakeIntensityCopyWithImpl(this._self, this._then);

  final _EarthquakeIntensity _self;
  final $Res Function(_EarthquakeIntensity) _then;

/// Create a copy of EarthquakeIntensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? regions = null,Object? intensityTree = null,Object? lpgmIntensityTree = null,}) {
  return _then(_EarthquakeIntensity(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<IntensityRegion>>,intensityTree: null == intensityTree ? _self._intensityTree : intensityTree // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<PrefectureIntensityNode>>,lpgmIntensityTree: null == lpgmIntensityTree ? _self._lpgmIntensityTree : lpgmIntensityTree // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>,
  ));
}


}

// dart format on

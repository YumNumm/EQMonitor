// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_intensity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeIntensity {

 JmaIntensity get maxIntensity; JmaLpgmIntensity? get maxLpgmIntensity; Map<JmaIntensity, List<RegionIntensityNode>> get intensityTree; List<IntensityRegion> get regions; Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> get lpgmIntensityTree; List<LpgmIntensityRegion> get lpgmRegions;
/// Create a copy of EarthquakeIntensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeIntensityCopyWith<EarthquakeIntensity> get copyWith => _$EarthquakeIntensityCopyWithImpl<EarthquakeIntensity>(this as EarthquakeIntensity, _$identity);

  /// Serializes this EarthquakeIntensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeIntensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other.intensityTree, intensityTree)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.lpgmIntensityTree, lpgmIntensityTree)&&const DeepCollectionEquality().equals(other.lpgmRegions, lpgmRegions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,const DeepCollectionEquality().hash(intensityTree),const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(lpgmIntensityTree),const DeepCollectionEquality().hash(lpgmRegions));

@override
String toString() {
  return 'EarthquakeIntensity(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, intensityTree: $intensityTree, regions: $regions, lpgmIntensityTree: $lpgmIntensityTree, lpgmRegions: $lpgmRegions)';
}


}

/// @nodoc
abstract mixin class $EarthquakeIntensityCopyWith<$Res>  {
  factory $EarthquakeIntensityCopyWith(EarthquakeIntensity value, $Res Function(EarthquakeIntensity) _then) = _$EarthquakeIntensityCopyWithImpl;
@useResult
$Res call({
 JmaIntensity maxIntensity, JmaLpgmIntensity? maxLpgmIntensity, Map<JmaIntensity, List<RegionIntensityNode>> intensityTree, List<IntensityRegion> regions, Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> lpgmIntensityTree, List<LpgmIntensityRegion> lpgmRegions
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
@pragma('vm:prefer-inline') @override $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? intensityTree = null,Object? regions = null,Object? lpgmIntensityTree = null,Object? lpgmRegions = null,}) {
  return _then(_self.copyWith(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,intensityTree: null == intensityTree ? _self.intensityTree : intensityTree // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<RegionIntensityNode>>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<IntensityRegion>,lpgmIntensityTree: null == lpgmIntensityTree ? _self.lpgmIntensityTree : lpgmIntensityTree // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>>,lpgmRegions: null == lpgmRegions ? _self.lpgmRegions : lpgmRegions // ignore: cast_nullable_to_non_nullable
as List<LpgmIntensityRegion>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaIntensity maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity,  Map<JmaIntensity, List<RegionIntensityNode>> intensityTree,  List<IntensityRegion> regions,  Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> lpgmIntensityTree,  List<LpgmIntensityRegion> lpgmRegions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeIntensity() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.intensityTree,_that.regions,_that.lpgmIntensityTree,_that.lpgmRegions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaIntensity maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity,  Map<JmaIntensity, List<RegionIntensityNode>> intensityTree,  List<IntensityRegion> regions,  Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> lpgmIntensityTree,  List<LpgmIntensityRegion> lpgmRegions)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeIntensity():
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.intensityTree,_that.regions,_that.lpgmIntensityTree,_that.lpgmRegions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaIntensity maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity,  Map<JmaIntensity, List<RegionIntensityNode>> intensityTree,  List<IntensityRegion> regions,  Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> lpgmIntensityTree,  List<LpgmIntensityRegion> lpgmRegions)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeIntensity() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.intensityTree,_that.regions,_that.lpgmIntensityTree,_that.lpgmRegions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeIntensity implements EarthquakeIntensity {
  const _EarthquakeIntensity({required this.maxIntensity, required this.maxLpgmIntensity, required final  Map<JmaIntensity, List<RegionIntensityNode>> intensityTree, required final  List<IntensityRegion> regions, required final  Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> lpgmIntensityTree, required final  List<LpgmIntensityRegion> lpgmRegions}): _intensityTree = intensityTree,_regions = regions,_lpgmIntensityTree = lpgmIntensityTree,_lpgmRegions = lpgmRegions;
  factory _EarthquakeIntensity.fromJson(Map<String, dynamic> json) => _$EarthquakeIntensityFromJson(json);

@override final  JmaIntensity maxIntensity;
@override final  JmaLpgmIntensity? maxLpgmIntensity;
 final  Map<JmaIntensity, List<RegionIntensityNode>> _intensityTree;
@override Map<JmaIntensity, List<RegionIntensityNode>> get intensityTree {
  if (_intensityTree is EqualUnmodifiableMapView) return _intensityTree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_intensityTree);
}

 final  List<IntensityRegion> _regions;
@override List<IntensityRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> _lpgmIntensityTree;
@override Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> get lpgmIntensityTree {
  if (_lpgmIntensityTree is EqualUnmodifiableMapView) return _lpgmIntensityTree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lpgmIntensityTree);
}

 final  List<LpgmIntensityRegion> _lpgmRegions;
@override List<LpgmIntensityRegion> get lpgmRegions {
  if (_lpgmRegions is EqualUnmodifiableListView) return _lpgmRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lpgmRegions);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeIntensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other._intensityTree, _intensityTree)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._lpgmIntensityTree, _lpgmIntensityTree)&&const DeepCollectionEquality().equals(other._lpgmRegions, _lpgmRegions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,const DeepCollectionEquality().hash(_intensityTree),const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_lpgmIntensityTree),const DeepCollectionEquality().hash(_lpgmRegions));

@override
String toString() {
  return 'EarthquakeIntensity(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, intensityTree: $intensityTree, regions: $regions, lpgmIntensityTree: $lpgmIntensityTree, lpgmRegions: $lpgmRegions)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeIntensityCopyWith<$Res> implements $EarthquakeIntensityCopyWith<$Res> {
  factory _$EarthquakeIntensityCopyWith(_EarthquakeIntensity value, $Res Function(_EarthquakeIntensity) _then) = __$EarthquakeIntensityCopyWithImpl;
@override @useResult
$Res call({
 JmaIntensity maxIntensity, JmaLpgmIntensity? maxLpgmIntensity, Map<JmaIntensity, List<RegionIntensityNode>> intensityTree, List<IntensityRegion> regions, Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> lpgmIntensityTree, List<LpgmIntensityRegion> lpgmRegions
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
@override @pragma('vm:prefer-inline') $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? intensityTree = null,Object? regions = null,Object? lpgmIntensityTree = null,Object? lpgmRegions = null,}) {
  return _then(_EarthquakeIntensity(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,intensityTree: null == intensityTree ? _self._intensityTree : intensityTree // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<RegionIntensityNode>>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<IntensityRegion>,lpgmIntensityTree: null == lpgmIntensityTree ? _self._lpgmIntensityTree : lpgmIntensityTree // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>>,lpgmRegions: null == lpgmRegions ? _self._lpgmRegions : lpgmRegions // ignore: cast_nullable_to_non_nullable
as List<LpgmIntensityRegion>,
  ));
}


}

// dart format on

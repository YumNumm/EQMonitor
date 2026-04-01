// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lpgm_intensity_tree.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegionLpgmIntensityNode {

@EarthquakeParameterRegionItemConverter() EarthquakeParameterRegionItem get region; JmaLpgmIntensity? get maxLpgmIntensity; List<CityLpgmIntensityNode> get cities;
/// Create a copy of RegionLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionLpgmIntensityNodeCopyWith<RegionLpgmIntensityNode> get copyWith => _$RegionLpgmIntensityNodeCopyWithImpl<RegionLpgmIntensityNode>(this as RegionLpgmIntensityNode, _$identity);

  /// Serializes this RegionLpgmIntensityNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionLpgmIntensityNode&&(identical(other.region, region) || other.region == region)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other.cities, cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,maxLpgmIntensity,const DeepCollectionEquality().hash(cities));

@override
String toString() {
  return 'RegionLpgmIntensityNode(region: $region, maxLpgmIntensity: $maxLpgmIntensity, cities: $cities)';
}


}

/// @nodoc
abstract mixin class $RegionLpgmIntensityNodeCopyWith<$Res>  {
  factory $RegionLpgmIntensityNodeCopyWith(RegionLpgmIntensityNode value, $Res Function(RegionLpgmIntensityNode) _then) = _$RegionLpgmIntensityNodeCopyWithImpl;
@useResult
$Res call({
@EarthquakeParameterRegionItemConverter() EarthquakeParameterRegionItem region, JmaLpgmIntensity? maxLpgmIntensity, List<CityLpgmIntensityNode> cities
});




}
/// @nodoc
class _$RegionLpgmIntensityNodeCopyWithImpl<$Res>
    implements $RegionLpgmIntensityNodeCopyWith<$Res> {
  _$RegionLpgmIntensityNodeCopyWithImpl(this._self, this._then);

  final RegionLpgmIntensityNode _self;
  final $Res Function(RegionLpgmIntensityNode) _then;

/// Create a copy of RegionLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? region = null,Object? maxLpgmIntensity = freezed,Object? cities = null,}) {
  return _then(_self.copyWith(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterRegionItem,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<CityLpgmIntensityNode>,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionLpgmIntensityNode].
extension RegionLpgmIntensityNodePatterns on RegionLpgmIntensityNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionLpgmIntensityNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionLpgmIntensityNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionLpgmIntensityNode value)  $default,){
final _that = this;
switch (_that) {
case _RegionLpgmIntensityNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionLpgmIntensityNode value)?  $default,){
final _that = this;
switch (_that) {
case _RegionLpgmIntensityNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@EarthquakeParameterRegionItemConverter()  EarthquakeParameterRegionItem region,  JmaLpgmIntensity? maxLpgmIntensity,  List<CityLpgmIntensityNode> cities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionLpgmIntensityNode() when $default != null:
return $default(_that.region,_that.maxLpgmIntensity,_that.cities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@EarthquakeParameterRegionItemConverter()  EarthquakeParameterRegionItem region,  JmaLpgmIntensity? maxLpgmIntensity,  List<CityLpgmIntensityNode> cities)  $default,) {final _that = this;
switch (_that) {
case _RegionLpgmIntensityNode():
return $default(_that.region,_that.maxLpgmIntensity,_that.cities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@EarthquakeParameterRegionItemConverter()  EarthquakeParameterRegionItem region,  JmaLpgmIntensity? maxLpgmIntensity,  List<CityLpgmIntensityNode> cities)?  $default,) {final _that = this;
switch (_that) {
case _RegionLpgmIntensityNode() when $default != null:
return $default(_that.region,_that.maxLpgmIntensity,_that.cities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionLpgmIntensityNode implements RegionLpgmIntensityNode {
  const _RegionLpgmIntensityNode({@EarthquakeParameterRegionItemConverter() required this.region, required this.maxLpgmIntensity, required final  List<CityLpgmIntensityNode> cities}): _cities = cities;
  factory _RegionLpgmIntensityNode.fromJson(Map<String, dynamic> json) => _$RegionLpgmIntensityNodeFromJson(json);

@override@EarthquakeParameterRegionItemConverter() final  EarthquakeParameterRegionItem region;
@override final  JmaLpgmIntensity? maxLpgmIntensity;
 final  List<CityLpgmIntensityNode> _cities;
@override List<CityLpgmIntensityNode> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}


/// Create a copy of RegionLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionLpgmIntensityNodeCopyWith<_RegionLpgmIntensityNode> get copyWith => __$RegionLpgmIntensityNodeCopyWithImpl<_RegionLpgmIntensityNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionLpgmIntensityNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionLpgmIntensityNode&&(identical(other.region, region) || other.region == region)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other._cities, _cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,maxLpgmIntensity,const DeepCollectionEquality().hash(_cities));

@override
String toString() {
  return 'RegionLpgmIntensityNode(region: $region, maxLpgmIntensity: $maxLpgmIntensity, cities: $cities)';
}


}

/// @nodoc
abstract mixin class _$RegionLpgmIntensityNodeCopyWith<$Res> implements $RegionLpgmIntensityNodeCopyWith<$Res> {
  factory _$RegionLpgmIntensityNodeCopyWith(_RegionLpgmIntensityNode value, $Res Function(_RegionLpgmIntensityNode) _then) = __$RegionLpgmIntensityNodeCopyWithImpl;
@override @useResult
$Res call({
@EarthquakeParameterRegionItemConverter() EarthquakeParameterRegionItem region, JmaLpgmIntensity? maxLpgmIntensity, List<CityLpgmIntensityNode> cities
});




}
/// @nodoc
class __$RegionLpgmIntensityNodeCopyWithImpl<$Res>
    implements _$RegionLpgmIntensityNodeCopyWith<$Res> {
  __$RegionLpgmIntensityNodeCopyWithImpl(this._self, this._then);

  final _RegionLpgmIntensityNode _self;
  final $Res Function(_RegionLpgmIntensityNode) _then;

/// Create a copy of RegionLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? region = null,Object? maxLpgmIntensity = freezed,Object? cities = null,}) {
  return _then(_RegionLpgmIntensityNode(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterRegionItem,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<CityLpgmIntensityNode>,
  ));
}


}


/// @nodoc
mixin _$LpgmIntensityRegion {

@EarthquakeParameterRegionItemConverter() EarthquakeParameterRegionItem get region; JmaLpgmIntensity? get maxLpgmIntensity;
/// Create a copy of LpgmIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LpgmIntensityRegionCopyWith<LpgmIntensityRegion> get copyWith => _$LpgmIntensityRegionCopyWithImpl<LpgmIntensityRegion>(this as LpgmIntensityRegion, _$identity);

  /// Serializes this LpgmIntensityRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LpgmIntensityRegion&&(identical(other.region, region) || other.region == region)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,maxLpgmIntensity);

@override
String toString() {
  return 'LpgmIntensityRegion(region: $region, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $LpgmIntensityRegionCopyWith<$Res>  {
  factory $LpgmIntensityRegionCopyWith(LpgmIntensityRegion value, $Res Function(LpgmIntensityRegion) _then) = _$LpgmIntensityRegionCopyWithImpl;
@useResult
$Res call({
@EarthquakeParameterRegionItemConverter() EarthquakeParameterRegionItem region, JmaLpgmIntensity? maxLpgmIntensity
});




}
/// @nodoc
class _$LpgmIntensityRegionCopyWithImpl<$Res>
    implements $LpgmIntensityRegionCopyWith<$Res> {
  _$LpgmIntensityRegionCopyWithImpl(this._self, this._then);

  final LpgmIntensityRegion _self;
  final $Res Function(LpgmIntensityRegion) _then;

/// Create a copy of LpgmIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? region = null,Object? maxLpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterRegionItem,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [LpgmIntensityRegion].
extension LpgmIntensityRegionPatterns on LpgmIntensityRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LpgmIntensityRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LpgmIntensityRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LpgmIntensityRegion value)  $default,){
final _that = this;
switch (_that) {
case _LpgmIntensityRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LpgmIntensityRegion value)?  $default,){
final _that = this;
switch (_that) {
case _LpgmIntensityRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@EarthquakeParameterRegionItemConverter()  EarthquakeParameterRegionItem region,  JmaLpgmIntensity? maxLpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LpgmIntensityRegion() when $default != null:
return $default(_that.region,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@EarthquakeParameterRegionItemConverter()  EarthquakeParameterRegionItem region,  JmaLpgmIntensity? maxLpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _LpgmIntensityRegion():
return $default(_that.region,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@EarthquakeParameterRegionItemConverter()  EarthquakeParameterRegionItem region,  JmaLpgmIntensity? maxLpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _LpgmIntensityRegion() when $default != null:
return $default(_that.region,_that.maxLpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LpgmIntensityRegion implements LpgmIntensityRegion {
  const _LpgmIntensityRegion({@EarthquakeParameterRegionItemConverter() required this.region, required this.maxLpgmIntensity});
  factory _LpgmIntensityRegion.fromJson(Map<String, dynamic> json) => _$LpgmIntensityRegionFromJson(json);

@override@EarthquakeParameterRegionItemConverter() final  EarthquakeParameterRegionItem region;
@override final  JmaLpgmIntensity? maxLpgmIntensity;

/// Create a copy of LpgmIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LpgmIntensityRegionCopyWith<_LpgmIntensityRegion> get copyWith => __$LpgmIntensityRegionCopyWithImpl<_LpgmIntensityRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LpgmIntensityRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LpgmIntensityRegion&&(identical(other.region, region) || other.region == region)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,maxLpgmIntensity);

@override
String toString() {
  return 'LpgmIntensityRegion(region: $region, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$LpgmIntensityRegionCopyWith<$Res> implements $LpgmIntensityRegionCopyWith<$Res> {
  factory _$LpgmIntensityRegionCopyWith(_LpgmIntensityRegion value, $Res Function(_LpgmIntensityRegion) _then) = __$LpgmIntensityRegionCopyWithImpl;
@override @useResult
$Res call({
@EarthquakeParameterRegionItemConverter() EarthquakeParameterRegionItem region, JmaLpgmIntensity? maxLpgmIntensity
});




}
/// @nodoc
class __$LpgmIntensityRegionCopyWithImpl<$Res>
    implements _$LpgmIntensityRegionCopyWith<$Res> {
  __$LpgmIntensityRegionCopyWithImpl(this._self, this._then);

  final _LpgmIntensityRegion _self;
  final $Res Function(_LpgmIntensityRegion) _then;

/// Create a copy of LpgmIntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? region = null,Object? maxLpgmIntensity = freezed,}) {
  return _then(_LpgmIntensityRegion(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterRegionItem,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}


}


/// @nodoc
mixin _$CityLpgmIntensityNode {

@EarthquakeParameterCityItemConverter() EarthquakeParameterCityItem get city; JmaLpgmIntensity? get maxLpgmIntensity; List<StationLpgmIntensityNode> get stations;
/// Create a copy of CityLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityLpgmIntensityNodeCopyWith<CityLpgmIntensityNode> get copyWith => _$CityLpgmIntensityNodeCopyWithImpl<CityLpgmIntensityNode>(this as CityLpgmIntensityNode, _$identity);

  /// Serializes this CityLpgmIntensityNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityLpgmIntensityNode&&(identical(other.city, city) || other.city == city)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,maxLpgmIntensity,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'CityLpgmIntensityNode(city: $city, maxLpgmIntensity: $maxLpgmIntensity, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $CityLpgmIntensityNodeCopyWith<$Res>  {
  factory $CityLpgmIntensityNodeCopyWith(CityLpgmIntensityNode value, $Res Function(CityLpgmIntensityNode) _then) = _$CityLpgmIntensityNodeCopyWithImpl;
@useResult
$Res call({
@EarthquakeParameterCityItemConverter() EarthquakeParameterCityItem city, JmaLpgmIntensity? maxLpgmIntensity, List<StationLpgmIntensityNode> stations
});




}
/// @nodoc
class _$CityLpgmIntensityNodeCopyWithImpl<$Res>
    implements $CityLpgmIntensityNodeCopyWith<$Res> {
  _$CityLpgmIntensityNodeCopyWithImpl(this._self, this._then);

  final CityLpgmIntensityNode _self;
  final $Res Function(CityLpgmIntensityNode) _then;

/// Create a copy of CityLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? maxLpgmIntensity = freezed,Object? stations = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterCityItem,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<StationLpgmIntensityNode>,
  ));
}

}


/// Adds pattern-matching-related methods to [CityLpgmIntensityNode].
extension CityLpgmIntensityNodePatterns on CityLpgmIntensityNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityLpgmIntensityNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityLpgmIntensityNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityLpgmIntensityNode value)  $default,){
final _that = this;
switch (_that) {
case _CityLpgmIntensityNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityLpgmIntensityNode value)?  $default,){
final _that = this;
switch (_that) {
case _CityLpgmIntensityNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@EarthquakeParameterCityItemConverter()  EarthquakeParameterCityItem city,  JmaLpgmIntensity? maxLpgmIntensity,  List<StationLpgmIntensityNode> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityLpgmIntensityNode() when $default != null:
return $default(_that.city,_that.maxLpgmIntensity,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@EarthquakeParameterCityItemConverter()  EarthquakeParameterCityItem city,  JmaLpgmIntensity? maxLpgmIntensity,  List<StationLpgmIntensityNode> stations)  $default,) {final _that = this;
switch (_that) {
case _CityLpgmIntensityNode():
return $default(_that.city,_that.maxLpgmIntensity,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@EarthquakeParameterCityItemConverter()  EarthquakeParameterCityItem city,  JmaLpgmIntensity? maxLpgmIntensity,  List<StationLpgmIntensityNode> stations)?  $default,) {final _that = this;
switch (_that) {
case _CityLpgmIntensityNode() when $default != null:
return $default(_that.city,_that.maxLpgmIntensity,_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CityLpgmIntensityNode implements CityLpgmIntensityNode {
  const _CityLpgmIntensityNode({@EarthquakeParameterCityItemConverter() required this.city, required this.maxLpgmIntensity, required final  List<StationLpgmIntensityNode> stations}): _stations = stations;
  factory _CityLpgmIntensityNode.fromJson(Map<String, dynamic> json) => _$CityLpgmIntensityNodeFromJson(json);

@override@EarthquakeParameterCityItemConverter() final  EarthquakeParameterCityItem city;
@override final  JmaLpgmIntensity? maxLpgmIntensity;
 final  List<StationLpgmIntensityNode> _stations;
@override List<StationLpgmIntensityNode> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of CityLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityLpgmIntensityNodeCopyWith<_CityLpgmIntensityNode> get copyWith => __$CityLpgmIntensityNodeCopyWithImpl<_CityLpgmIntensityNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityLpgmIntensityNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityLpgmIntensityNode&&(identical(other.city, city) || other.city == city)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,maxLpgmIntensity,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'CityLpgmIntensityNode(city: $city, maxLpgmIntensity: $maxLpgmIntensity, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$CityLpgmIntensityNodeCopyWith<$Res> implements $CityLpgmIntensityNodeCopyWith<$Res> {
  factory _$CityLpgmIntensityNodeCopyWith(_CityLpgmIntensityNode value, $Res Function(_CityLpgmIntensityNode) _then) = __$CityLpgmIntensityNodeCopyWithImpl;
@override @useResult
$Res call({
@EarthquakeParameterCityItemConverter() EarthquakeParameterCityItem city, JmaLpgmIntensity? maxLpgmIntensity, List<StationLpgmIntensityNode> stations
});




}
/// @nodoc
class __$CityLpgmIntensityNodeCopyWithImpl<$Res>
    implements _$CityLpgmIntensityNodeCopyWith<$Res> {
  __$CityLpgmIntensityNodeCopyWithImpl(this._self, this._then);

  final _CityLpgmIntensityNode _self;
  final $Res Function(_CityLpgmIntensityNode) _then;

/// Create a copy of CityLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? maxLpgmIntensity = freezed,Object? stations = null,}) {
  return _then(_CityLpgmIntensityNode(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterCityItem,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<StationLpgmIntensityNode>,
  ));
}


}


/// @nodoc
mixin _$StationLpgmIntensityNode {

@EarthquakeParameterStationItemConverter() EarthquakeParameterStationItem get station; IntensityStation? get intensity;
/// Create a copy of StationLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationLpgmIntensityNodeCopyWith<StationLpgmIntensityNode> get copyWith => _$StationLpgmIntensityNodeCopyWithImpl<StationLpgmIntensityNode>(this as StationLpgmIntensityNode, _$identity);

  /// Serializes this StationLpgmIntensityNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationLpgmIntensityNode&&(identical(other.station, station) || other.station == station)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,station,intensity);

@override
String toString() {
  return 'StationLpgmIntensityNode(station: $station, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $StationLpgmIntensityNodeCopyWith<$Res>  {
  factory $StationLpgmIntensityNodeCopyWith(StationLpgmIntensityNode value, $Res Function(StationLpgmIntensityNode) _then) = _$StationLpgmIntensityNodeCopyWithImpl;
@useResult
$Res call({
@EarthquakeParameterStationItemConverter() EarthquakeParameterStationItem station, IntensityStation? intensity
});


$IntensityStationCopyWith<$Res>? get intensity;

}
/// @nodoc
class _$StationLpgmIntensityNodeCopyWithImpl<$Res>
    implements $StationLpgmIntensityNodeCopyWith<$Res> {
  _$StationLpgmIntensityNodeCopyWithImpl(this._self, this._then);

  final StationLpgmIntensityNode _self;
  final $Res Function(StationLpgmIntensityNode) _then;

/// Create a copy of StationLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? station = null,Object? intensity = freezed,}) {
  return _then(_self.copyWith(
station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterStationItem,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityStation?,
  ));
}
/// Create a copy of StationLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityStationCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityStationCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [StationLpgmIntensityNode].
extension StationLpgmIntensityNodePatterns on StationLpgmIntensityNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationLpgmIntensityNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationLpgmIntensityNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationLpgmIntensityNode value)  $default,){
final _that = this;
switch (_that) {
case _StationLpgmIntensityNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationLpgmIntensityNode value)?  $default,){
final _that = this;
switch (_that) {
case _StationLpgmIntensityNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@EarthquakeParameterStationItemConverter()  EarthquakeParameterStationItem station,  IntensityStation? intensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationLpgmIntensityNode() when $default != null:
return $default(_that.station,_that.intensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@EarthquakeParameterStationItemConverter()  EarthquakeParameterStationItem station,  IntensityStation? intensity)  $default,) {final _that = this;
switch (_that) {
case _StationLpgmIntensityNode():
return $default(_that.station,_that.intensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@EarthquakeParameterStationItemConverter()  EarthquakeParameterStationItem station,  IntensityStation? intensity)?  $default,) {final _that = this;
switch (_that) {
case _StationLpgmIntensityNode() when $default != null:
return $default(_that.station,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StationLpgmIntensityNode implements StationLpgmIntensityNode {
  const _StationLpgmIntensityNode({@EarthquakeParameterStationItemConverter() required this.station, required this.intensity});
  factory _StationLpgmIntensityNode.fromJson(Map<String, dynamic> json) => _$StationLpgmIntensityNodeFromJson(json);

@override@EarthquakeParameterStationItemConverter() final  EarthquakeParameterStationItem station;
@override final  IntensityStation? intensity;

/// Create a copy of StationLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationLpgmIntensityNodeCopyWith<_StationLpgmIntensityNode> get copyWith => __$StationLpgmIntensityNodeCopyWithImpl<_StationLpgmIntensityNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StationLpgmIntensityNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationLpgmIntensityNode&&(identical(other.station, station) || other.station == station)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,station,intensity);

@override
String toString() {
  return 'StationLpgmIntensityNode(station: $station, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$StationLpgmIntensityNodeCopyWith<$Res> implements $StationLpgmIntensityNodeCopyWith<$Res> {
  factory _$StationLpgmIntensityNodeCopyWith(_StationLpgmIntensityNode value, $Res Function(_StationLpgmIntensityNode) _then) = __$StationLpgmIntensityNodeCopyWithImpl;
@override @useResult
$Res call({
@EarthquakeParameterStationItemConverter() EarthquakeParameterStationItem station, IntensityStation? intensity
});


@override $IntensityStationCopyWith<$Res>? get intensity;

}
/// @nodoc
class __$StationLpgmIntensityNodeCopyWithImpl<$Res>
    implements _$StationLpgmIntensityNodeCopyWith<$Res> {
  __$StationLpgmIntensityNodeCopyWithImpl(this._self, this._then);

  final _StationLpgmIntensityNode _self;
  final $Res Function(_StationLpgmIntensityNode) _then;

/// Create a copy of StationLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? station = null,Object? intensity = freezed,}) {
  return _then(_StationLpgmIntensityNode(
station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterStationItem,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityStation?,
  ));
}

/// Create a copy of StationLpgmIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityStationCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityStationCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}

// dart format on

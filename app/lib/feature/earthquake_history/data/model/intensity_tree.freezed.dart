// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_tree.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IntensityTree {

 Map<IntensityValue, List<RegionIntensityNode>> get byIntensity;
/// Create a copy of IntensityTree
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityTreeCopyWith<IntensityTree> get copyWith => _$IntensityTreeCopyWithImpl<IntensityTree>(this as IntensityTree, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityTree&&const DeepCollectionEquality().equals(other.byIntensity, byIntensity));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(byIntensity));

@override
String toString() {
  return 'IntensityTree(byIntensity: $byIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityTreeCopyWith<$Res>  {
  factory $IntensityTreeCopyWith(IntensityTree value, $Res Function(IntensityTree) _then) = _$IntensityTreeCopyWithImpl;
@useResult
$Res call({
 Map<IntensityValue, List<RegionIntensityNode>> byIntensity
});




}
/// @nodoc
class _$IntensityTreeCopyWithImpl<$Res>
    implements $IntensityTreeCopyWith<$Res> {
  _$IntensityTreeCopyWithImpl(this._self, this._then);

  final IntensityTree _self;
  final $Res Function(IntensityTree) _then;

/// Create a copy of IntensityTree
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? byIntensity = null,}) {
  return _then(_self.copyWith(
byIntensity: null == byIntensity ? _self.byIntensity : byIntensity // ignore: cast_nullable_to_non_nullable
as Map<IntensityValue, List<RegionIntensityNode>>,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityTree].
extension IntensityTreePatterns on IntensityTree {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityTree value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityTree() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityTree value)  $default,){
final _that = this;
switch (_that) {
case _IntensityTree():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityTree value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityTree() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<IntensityValue, List<RegionIntensityNode>> byIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityTree() when $default != null:
return $default(_that.byIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<IntensityValue, List<RegionIntensityNode>> byIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityTree():
return $default(_that.byIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<IntensityValue, List<RegionIntensityNode>> byIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityTree() when $default != null:
return $default(_that.byIntensity);case _:
  return null;

}
}

}

/// @nodoc


class _IntensityTree implements IntensityTree {
  const _IntensityTree({required final  Map<IntensityValue, List<RegionIntensityNode>> byIntensity}): _byIntensity = byIntensity;
  

 final  Map<IntensityValue, List<RegionIntensityNode>> _byIntensity;
@override Map<IntensityValue, List<RegionIntensityNode>> get byIntensity {
  if (_byIntensity is EqualUnmodifiableMapView) return _byIntensity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byIntensity);
}


/// Create a copy of IntensityTree
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityTreeCopyWith<_IntensityTree> get copyWith => __$IntensityTreeCopyWithImpl<_IntensityTree>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityTree&&const DeepCollectionEquality().equals(other._byIntensity, _byIntensity));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_byIntensity));

@override
String toString() {
  return 'IntensityTree(byIntensity: $byIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityTreeCopyWith<$Res> implements $IntensityTreeCopyWith<$Res> {
  factory _$IntensityTreeCopyWith(_IntensityTree value, $Res Function(_IntensityTree) _then) = __$IntensityTreeCopyWithImpl;
@override @useResult
$Res call({
 Map<IntensityValue, List<RegionIntensityNode>> byIntensity
});




}
/// @nodoc
class __$IntensityTreeCopyWithImpl<$Res>
    implements _$IntensityTreeCopyWith<$Res> {
  __$IntensityTreeCopyWithImpl(this._self, this._then);

  final _IntensityTree _self;
  final $Res Function(_IntensityTree) _then;

/// Create a copy of IntensityTree
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? byIntensity = null,}) {
  return _then(_IntensityTree(
byIntensity: null == byIntensity ? _self._byIntensity : byIntensity // ignore: cast_nullable_to_non_nullable
as Map<IntensityValue, List<RegionIntensityNode>>,
  ));
}


}

/// @nodoc
mixin _$RegionIntensityNode {

 EarthquakeParameterRegionItem get region; IntensityValue? get maxIntensity; List<CityIntensityNode> get cities;
/// Create a copy of RegionIntensityNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionIntensityNodeCopyWith<RegionIntensityNode> get copyWith => _$RegionIntensityNodeCopyWithImpl<RegionIntensityNode>(this as RegionIntensityNode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionIntensityNode&&(identical(other.region, region) || other.region == region)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other.cities, cities));
}


@override
int get hashCode => Object.hash(runtimeType,region,maxIntensity,const DeepCollectionEquality().hash(cities));

@override
String toString() {
  return 'RegionIntensityNode(region: $region, maxIntensity: $maxIntensity, cities: $cities)';
}


}

/// @nodoc
abstract mixin class $RegionIntensityNodeCopyWith<$Res>  {
  factory $RegionIntensityNodeCopyWith(RegionIntensityNode value, $Res Function(RegionIntensityNode) _then) = _$RegionIntensityNodeCopyWithImpl;
@useResult
$Res call({
 EarthquakeParameterRegionItem region, IntensityValue? maxIntensity, List<CityIntensityNode> cities
});




}
/// @nodoc
class _$RegionIntensityNodeCopyWithImpl<$Res>
    implements $RegionIntensityNodeCopyWith<$Res> {
  _$RegionIntensityNodeCopyWithImpl(this._self, this._then);

  final RegionIntensityNode _self;
  final $Res Function(RegionIntensityNode) _then;

/// Create a copy of RegionIntensityNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? region = null,Object? maxIntensity = freezed,Object? cities = null,}) {
  return _then(_self.copyWith(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterRegionItem,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<CityIntensityNode>,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionIntensityNode].
extension RegionIntensityNodePatterns on RegionIntensityNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionIntensityNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionIntensityNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionIntensityNode value)  $default,){
final _that = this;
switch (_that) {
case _RegionIntensityNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionIntensityNode value)?  $default,){
final _that = this;
switch (_that) {
case _RegionIntensityNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeParameterRegionItem region,  IntensityValue? maxIntensity,  List<CityIntensityNode> cities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionIntensityNode() when $default != null:
return $default(_that.region,_that.maxIntensity,_that.cities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeParameterRegionItem region,  IntensityValue? maxIntensity,  List<CityIntensityNode> cities)  $default,) {final _that = this;
switch (_that) {
case _RegionIntensityNode():
return $default(_that.region,_that.maxIntensity,_that.cities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeParameterRegionItem region,  IntensityValue? maxIntensity,  List<CityIntensityNode> cities)?  $default,) {final _that = this;
switch (_that) {
case _RegionIntensityNode() when $default != null:
return $default(_that.region,_that.maxIntensity,_that.cities);case _:
  return null;

}
}

}

/// @nodoc


class _RegionIntensityNode implements RegionIntensityNode {
  const _RegionIntensityNode({required this.region, required this.maxIntensity, required final  List<CityIntensityNode> cities}): _cities = cities;
  

@override final  EarthquakeParameterRegionItem region;
@override final  IntensityValue? maxIntensity;
 final  List<CityIntensityNode> _cities;
@override List<CityIntensityNode> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}


/// Create a copy of RegionIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionIntensityNodeCopyWith<_RegionIntensityNode> get copyWith => __$RegionIntensityNodeCopyWithImpl<_RegionIntensityNode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionIntensityNode&&(identical(other.region, region) || other.region == region)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._cities, _cities));
}


@override
int get hashCode => Object.hash(runtimeType,region,maxIntensity,const DeepCollectionEquality().hash(_cities));

@override
String toString() {
  return 'RegionIntensityNode(region: $region, maxIntensity: $maxIntensity, cities: $cities)';
}


}

/// @nodoc
abstract mixin class _$RegionIntensityNodeCopyWith<$Res> implements $RegionIntensityNodeCopyWith<$Res> {
  factory _$RegionIntensityNodeCopyWith(_RegionIntensityNode value, $Res Function(_RegionIntensityNode) _then) = __$RegionIntensityNodeCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeParameterRegionItem region, IntensityValue? maxIntensity, List<CityIntensityNode> cities
});




}
/// @nodoc
class __$RegionIntensityNodeCopyWithImpl<$Res>
    implements _$RegionIntensityNodeCopyWith<$Res> {
  __$RegionIntensityNodeCopyWithImpl(this._self, this._then);

  final _RegionIntensityNode _self;
  final $Res Function(_RegionIntensityNode) _then;

/// Create a copy of RegionIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? region = null,Object? maxIntensity = freezed,Object? cities = null,}) {
  return _then(_RegionIntensityNode(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterRegionItem,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<CityIntensityNode>,
  ));
}


}

/// @nodoc
mixin _$CityIntensityNode {

 EarthquakeParameterCityItem get city; IntensityValue? get maxIntensity; List<StationIntensityNode> get stations;
/// Create a copy of CityIntensityNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityIntensityNodeCopyWith<CityIntensityNode> get copyWith => _$CityIntensityNodeCopyWithImpl<CityIntensityNode>(this as CityIntensityNode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityIntensityNode&&(identical(other.city, city) || other.city == city)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other.stations, stations));
}


@override
int get hashCode => Object.hash(runtimeType,city,maxIntensity,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'CityIntensityNode(city: $city, maxIntensity: $maxIntensity, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $CityIntensityNodeCopyWith<$Res>  {
  factory $CityIntensityNodeCopyWith(CityIntensityNode value, $Res Function(CityIntensityNode) _then) = _$CityIntensityNodeCopyWithImpl;
@useResult
$Res call({
 EarthquakeParameterCityItem city, IntensityValue? maxIntensity, List<StationIntensityNode> stations
});




}
/// @nodoc
class _$CityIntensityNodeCopyWithImpl<$Res>
    implements $CityIntensityNodeCopyWith<$Res> {
  _$CityIntensityNodeCopyWithImpl(this._self, this._then);

  final CityIntensityNode _self;
  final $Res Function(CityIntensityNode) _then;

/// Create a copy of CityIntensityNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? maxIntensity = freezed,Object? stations = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterCityItem,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<StationIntensityNode>,
  ));
}

}


/// Adds pattern-matching-related methods to [CityIntensityNode].
extension CityIntensityNodePatterns on CityIntensityNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityIntensityNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityIntensityNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityIntensityNode value)  $default,){
final _that = this;
switch (_that) {
case _CityIntensityNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityIntensityNode value)?  $default,){
final _that = this;
switch (_that) {
case _CityIntensityNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeParameterCityItem city,  IntensityValue? maxIntensity,  List<StationIntensityNode> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityIntensityNode() when $default != null:
return $default(_that.city,_that.maxIntensity,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeParameterCityItem city,  IntensityValue? maxIntensity,  List<StationIntensityNode> stations)  $default,) {final _that = this;
switch (_that) {
case _CityIntensityNode():
return $default(_that.city,_that.maxIntensity,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeParameterCityItem city,  IntensityValue? maxIntensity,  List<StationIntensityNode> stations)?  $default,) {final _that = this;
switch (_that) {
case _CityIntensityNode() when $default != null:
return $default(_that.city,_that.maxIntensity,_that.stations);case _:
  return null;

}
}

}

/// @nodoc


class _CityIntensityNode implements CityIntensityNode {
  const _CityIntensityNode({required this.city, required this.maxIntensity, required final  List<StationIntensityNode> stations}): _stations = stations;
  

@override final  EarthquakeParameterCityItem city;
@override final  IntensityValue? maxIntensity;
 final  List<StationIntensityNode> _stations;
@override List<StationIntensityNode> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of CityIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityIntensityNodeCopyWith<_CityIntensityNode> get copyWith => __$CityIntensityNodeCopyWithImpl<_CityIntensityNode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityIntensityNode&&(identical(other.city, city) || other.city == city)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._stations, _stations));
}


@override
int get hashCode => Object.hash(runtimeType,city,maxIntensity,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'CityIntensityNode(city: $city, maxIntensity: $maxIntensity, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$CityIntensityNodeCopyWith<$Res> implements $CityIntensityNodeCopyWith<$Res> {
  factory _$CityIntensityNodeCopyWith(_CityIntensityNode value, $Res Function(_CityIntensityNode) _then) = __$CityIntensityNodeCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeParameterCityItem city, IntensityValue? maxIntensity, List<StationIntensityNode> stations
});




}
/// @nodoc
class __$CityIntensityNodeCopyWithImpl<$Res>
    implements _$CityIntensityNodeCopyWith<$Res> {
  __$CityIntensityNodeCopyWithImpl(this._self, this._then);

  final _CityIntensityNode _self;
  final $Res Function(_CityIntensityNode) _then;

/// Create a copy of CityIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? maxIntensity = freezed,Object? stations = null,}) {
  return _then(_CityIntensityNode(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterCityItem,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<StationIntensityNode>,
  ));
}


}

/// @nodoc
mixin _$StationIntensityNode {

 EarthquakeParameterStationItem get station; IntensityStationItem? get intensity;
/// Create a copy of StationIntensityNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationIntensityNodeCopyWith<StationIntensityNode> get copyWith => _$StationIntensityNodeCopyWithImpl<StationIntensityNode>(this as StationIntensityNode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationIntensityNode&&(identical(other.station, station) || other.station == station)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,station,intensity);

@override
String toString() {
  return 'StationIntensityNode(station: $station, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $StationIntensityNodeCopyWith<$Res>  {
  factory $StationIntensityNodeCopyWith(StationIntensityNode value, $Res Function(StationIntensityNode) _then) = _$StationIntensityNodeCopyWithImpl;
@useResult
$Res call({
 EarthquakeParameterStationItem station, IntensityStationItem? intensity
});


$IntensityStationItemCopyWith<$Res>? get intensity;

}
/// @nodoc
class _$StationIntensityNodeCopyWithImpl<$Res>
    implements $StationIntensityNodeCopyWith<$Res> {
  _$StationIntensityNodeCopyWithImpl(this._self, this._then);

  final StationIntensityNode _self;
  final $Res Function(StationIntensityNode) _then;

/// Create a copy of StationIntensityNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? station = null,Object? intensity = freezed,}) {
  return _then(_self.copyWith(
station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterStationItem,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityStationItem?,
  ));
}
/// Create a copy of StationIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityStationItemCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityStationItemCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [StationIntensityNode].
extension StationIntensityNodePatterns on StationIntensityNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationIntensityNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationIntensityNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationIntensityNode value)  $default,){
final _that = this;
switch (_that) {
case _StationIntensityNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationIntensityNode value)?  $default,){
final _that = this;
switch (_that) {
case _StationIntensityNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeParameterStationItem station,  IntensityStationItem? intensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationIntensityNode() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeParameterStationItem station,  IntensityStationItem? intensity)  $default,) {final _that = this;
switch (_that) {
case _StationIntensityNode():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeParameterStationItem station,  IntensityStationItem? intensity)?  $default,) {final _that = this;
switch (_that) {
case _StationIntensityNode() when $default != null:
return $default(_that.station,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc


class _StationIntensityNode implements StationIntensityNode {
  const _StationIntensityNode({required this.station, required this.intensity});
  

@override final  EarthquakeParameterStationItem station;
@override final  IntensityStationItem? intensity;

/// Create a copy of StationIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationIntensityNodeCopyWith<_StationIntensityNode> get copyWith => __$StationIntensityNodeCopyWithImpl<_StationIntensityNode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationIntensityNode&&(identical(other.station, station) || other.station == station)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,station,intensity);

@override
String toString() {
  return 'StationIntensityNode(station: $station, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$StationIntensityNodeCopyWith<$Res> implements $StationIntensityNodeCopyWith<$Res> {
  factory _$StationIntensityNodeCopyWith(_StationIntensityNode value, $Res Function(_StationIntensityNode) _then) = __$StationIntensityNodeCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeParameterStationItem station, IntensityStationItem? intensity
});


@override $IntensityStationItemCopyWith<$Res>? get intensity;

}
/// @nodoc
class __$StationIntensityNodeCopyWithImpl<$Res>
    implements _$StationIntensityNodeCopyWith<$Res> {
  __$StationIntensityNodeCopyWithImpl(this._self, this._then);

  final _StationIntensityNode _self;
  final $Res Function(_StationIntensityNode) _then;

/// Create a copy of StationIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? station = null,Object? intensity = freezed,}) {
  return _then(_StationIntensityNode(
station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterStationItem,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityStationItem?,
  ));
}

/// Create a copy of StationIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityStationItemCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityStationItemCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}

// dart format on

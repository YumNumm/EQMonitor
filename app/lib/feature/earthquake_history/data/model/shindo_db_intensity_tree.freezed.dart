// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shindo_db_intensity_tree.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShindoDbIntensityTree {

 Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> get tree; Map<ShindoDbIntensityClass, List<ShindoDbStationNode>> get unresolvedStations; int get totalStationCount;
/// Create a copy of ShindoDbIntensityTree
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShindoDbIntensityTreeCopyWith<ShindoDbIntensityTree> get copyWith => _$ShindoDbIntensityTreeCopyWithImpl<ShindoDbIntensityTree>(this as ShindoDbIntensityTree, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShindoDbIntensityTree&&const DeepCollectionEquality().equals(other.tree, tree)&&const DeepCollectionEquality().equals(other.unresolvedStations, unresolvedStations)&&(identical(other.totalStationCount, totalStationCount) || other.totalStationCount == totalStationCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tree),const DeepCollectionEquality().hash(unresolvedStations),totalStationCount);

@override
String toString() {
  return 'ShindoDbIntensityTree(tree: $tree, unresolvedStations: $unresolvedStations, totalStationCount: $totalStationCount)';
}


}

/// @nodoc
abstract mixin class $ShindoDbIntensityTreeCopyWith<$Res>  {
  factory $ShindoDbIntensityTreeCopyWith(ShindoDbIntensityTree value, $Res Function(ShindoDbIntensityTree) _then) = _$ShindoDbIntensityTreeCopyWithImpl;
@useResult
$Res call({
 Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> tree, Map<ShindoDbIntensityClass, List<ShindoDbStationNode>> unresolvedStations, int totalStationCount
});




}
/// @nodoc
class _$ShindoDbIntensityTreeCopyWithImpl<$Res>
    implements $ShindoDbIntensityTreeCopyWith<$Res> {
  _$ShindoDbIntensityTreeCopyWithImpl(this._self, this._then);

  final ShindoDbIntensityTree _self;
  final $Res Function(ShindoDbIntensityTree) _then;

/// Create a copy of ShindoDbIntensityTree
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tree = null,Object? unresolvedStations = null,Object? totalStationCount = null,}) {
  return _then(_self.copyWith(
tree: null == tree ? _self.tree : tree // ignore: cast_nullable_to_non_nullable
as Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>>,unresolvedStations: null == unresolvedStations ? _self.unresolvedStations : unresolvedStations // ignore: cast_nullable_to_non_nullable
as Map<ShindoDbIntensityClass, List<ShindoDbStationNode>>,totalStationCount: null == totalStationCount ? _self.totalStationCount : totalStationCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShindoDbIntensityTree].
extension ShindoDbIntensityTreePatterns on ShindoDbIntensityTree {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShindoDbIntensityTree value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShindoDbIntensityTree() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShindoDbIntensityTree value)  $default,){
final _that = this;
switch (_that) {
case _ShindoDbIntensityTree():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShindoDbIntensityTree value)?  $default,){
final _that = this;
switch (_that) {
case _ShindoDbIntensityTree() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> tree,  Map<ShindoDbIntensityClass, List<ShindoDbStationNode>> unresolvedStations,  int totalStationCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShindoDbIntensityTree() when $default != null:
return $default(_that.tree,_that.unresolvedStations,_that.totalStationCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> tree,  Map<ShindoDbIntensityClass, List<ShindoDbStationNode>> unresolvedStations,  int totalStationCount)  $default,) {final _that = this;
switch (_that) {
case _ShindoDbIntensityTree():
return $default(_that.tree,_that.unresolvedStations,_that.totalStationCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> tree,  Map<ShindoDbIntensityClass, List<ShindoDbStationNode>> unresolvedStations,  int totalStationCount)?  $default,) {final _that = this;
switch (_that) {
case _ShindoDbIntensityTree() when $default != null:
return $default(_that.tree,_that.unresolvedStations,_that.totalStationCount);case _:
  return null;

}
}

}

/// @nodoc


class _ShindoDbIntensityTree implements ShindoDbIntensityTree {
  const _ShindoDbIntensityTree({required final  Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> tree, required final  Map<ShindoDbIntensityClass, List<ShindoDbStationNode>> unresolvedStations, required this.totalStationCount}): _tree = tree,_unresolvedStations = unresolvedStations;
  

 final  Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> _tree;
@override Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> get tree {
  if (_tree is EqualUnmodifiableMapView) return _tree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tree);
}

 final  Map<ShindoDbIntensityClass, List<ShindoDbStationNode>> _unresolvedStations;
@override Map<ShindoDbIntensityClass, List<ShindoDbStationNode>> get unresolvedStations {
  if (_unresolvedStations is EqualUnmodifiableMapView) return _unresolvedStations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_unresolvedStations);
}

@override final  int totalStationCount;

/// Create a copy of ShindoDbIntensityTree
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShindoDbIntensityTreeCopyWith<_ShindoDbIntensityTree> get copyWith => __$ShindoDbIntensityTreeCopyWithImpl<_ShindoDbIntensityTree>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShindoDbIntensityTree&&const DeepCollectionEquality().equals(other._tree, _tree)&&const DeepCollectionEquality().equals(other._unresolvedStations, _unresolvedStations)&&(identical(other.totalStationCount, totalStationCount) || other.totalStationCount == totalStationCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tree),const DeepCollectionEquality().hash(_unresolvedStations),totalStationCount);

@override
String toString() {
  return 'ShindoDbIntensityTree(tree: $tree, unresolvedStations: $unresolvedStations, totalStationCount: $totalStationCount)';
}


}

/// @nodoc
abstract mixin class _$ShindoDbIntensityTreeCopyWith<$Res> implements $ShindoDbIntensityTreeCopyWith<$Res> {
  factory _$ShindoDbIntensityTreeCopyWith(_ShindoDbIntensityTree value, $Res Function(_ShindoDbIntensityTree) _then) = __$ShindoDbIntensityTreeCopyWithImpl;
@override @useResult
$Res call({
 Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> tree, Map<ShindoDbIntensityClass, List<ShindoDbStationNode>> unresolvedStations, int totalStationCount
});




}
/// @nodoc
class __$ShindoDbIntensityTreeCopyWithImpl<$Res>
    implements _$ShindoDbIntensityTreeCopyWith<$Res> {
  __$ShindoDbIntensityTreeCopyWithImpl(this._self, this._then);

  final _ShindoDbIntensityTree _self;
  final $Res Function(_ShindoDbIntensityTree) _then;

/// Create a copy of ShindoDbIntensityTree
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tree = null,Object? unresolvedStations = null,Object? totalStationCount = null,}) {
  return _then(_ShindoDbIntensityTree(
tree: null == tree ? _self._tree : tree // ignore: cast_nullable_to_non_nullable
as Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>>,unresolvedStations: null == unresolvedStations ? _self._unresolvedStations : unresolvedStations // ignore: cast_nullable_to_non_nullable
as Map<ShindoDbIntensityClass, List<ShindoDbStationNode>>,totalStationCount: null == totalStationCount ? _self.totalStationCount : totalStationCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ShindoDbPrefectureNode {

 EarthquakeParameterPrefectureItem get prefecture; List<ShindoDbCityNode> get cities;
/// Create a copy of ShindoDbPrefectureNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShindoDbPrefectureNodeCopyWith<ShindoDbPrefectureNode> get copyWith => _$ShindoDbPrefectureNodeCopyWithImpl<ShindoDbPrefectureNode>(this as ShindoDbPrefectureNode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShindoDbPrefectureNode&&(identical(other.prefecture, prefecture) || other.prefecture == prefecture)&&const DeepCollectionEquality().equals(other.cities, cities));
}


@override
int get hashCode => Object.hash(runtimeType,prefecture,const DeepCollectionEquality().hash(cities));

@override
String toString() {
  return 'ShindoDbPrefectureNode(prefecture: $prefecture, cities: $cities)';
}


}

/// @nodoc
abstract mixin class $ShindoDbPrefectureNodeCopyWith<$Res>  {
  factory $ShindoDbPrefectureNodeCopyWith(ShindoDbPrefectureNode value, $Res Function(ShindoDbPrefectureNode) _then) = _$ShindoDbPrefectureNodeCopyWithImpl;
@useResult
$Res call({
 EarthquakeParameterPrefectureItem prefecture, List<ShindoDbCityNode> cities
});


$EarthquakeParameterPrefectureItemCopyWith<$Res> get prefecture;

}
/// @nodoc
class _$ShindoDbPrefectureNodeCopyWithImpl<$Res>
    implements $ShindoDbPrefectureNodeCopyWith<$Res> {
  _$ShindoDbPrefectureNodeCopyWithImpl(this._self, this._then);

  final ShindoDbPrefectureNode _self;
  final $Res Function(ShindoDbPrefectureNode) _then;

/// Create a copy of ShindoDbPrefectureNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prefecture = null,Object? cities = null,}) {
  return _then(_self.copyWith(
prefecture: null == prefecture ? _self.prefecture : prefecture // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterPrefectureItem,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<ShindoDbCityNode>,
  ));
}
/// Create a copy of ShindoDbPrefectureNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterPrefectureItemCopyWith<$Res> get prefecture {
  
  return $EarthquakeParameterPrefectureItemCopyWith<$Res>(_self.prefecture, (value) {
    return _then(_self.copyWith(prefecture: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShindoDbPrefectureNode].
extension ShindoDbPrefectureNodePatterns on ShindoDbPrefectureNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShindoDbPrefectureNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShindoDbPrefectureNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShindoDbPrefectureNode value)  $default,){
final _that = this;
switch (_that) {
case _ShindoDbPrefectureNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShindoDbPrefectureNode value)?  $default,){
final _that = this;
switch (_that) {
case _ShindoDbPrefectureNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeParameterPrefectureItem prefecture,  List<ShindoDbCityNode> cities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShindoDbPrefectureNode() when $default != null:
return $default(_that.prefecture,_that.cities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeParameterPrefectureItem prefecture,  List<ShindoDbCityNode> cities)  $default,) {final _that = this;
switch (_that) {
case _ShindoDbPrefectureNode():
return $default(_that.prefecture,_that.cities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeParameterPrefectureItem prefecture,  List<ShindoDbCityNode> cities)?  $default,) {final _that = this;
switch (_that) {
case _ShindoDbPrefectureNode() when $default != null:
return $default(_that.prefecture,_that.cities);case _:
  return null;

}
}

}

/// @nodoc


class _ShindoDbPrefectureNode implements ShindoDbPrefectureNode {
  const _ShindoDbPrefectureNode({required this.prefecture, required final  List<ShindoDbCityNode> cities}): _cities = cities;
  

@override final  EarthquakeParameterPrefectureItem prefecture;
 final  List<ShindoDbCityNode> _cities;
@override List<ShindoDbCityNode> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}


/// Create a copy of ShindoDbPrefectureNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShindoDbPrefectureNodeCopyWith<_ShindoDbPrefectureNode> get copyWith => __$ShindoDbPrefectureNodeCopyWithImpl<_ShindoDbPrefectureNode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShindoDbPrefectureNode&&(identical(other.prefecture, prefecture) || other.prefecture == prefecture)&&const DeepCollectionEquality().equals(other._cities, _cities));
}


@override
int get hashCode => Object.hash(runtimeType,prefecture,const DeepCollectionEquality().hash(_cities));

@override
String toString() {
  return 'ShindoDbPrefectureNode(prefecture: $prefecture, cities: $cities)';
}


}

/// @nodoc
abstract mixin class _$ShindoDbPrefectureNodeCopyWith<$Res> implements $ShindoDbPrefectureNodeCopyWith<$Res> {
  factory _$ShindoDbPrefectureNodeCopyWith(_ShindoDbPrefectureNode value, $Res Function(_ShindoDbPrefectureNode) _then) = __$ShindoDbPrefectureNodeCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeParameterPrefectureItem prefecture, List<ShindoDbCityNode> cities
});


@override $EarthquakeParameterPrefectureItemCopyWith<$Res> get prefecture;

}
/// @nodoc
class __$ShindoDbPrefectureNodeCopyWithImpl<$Res>
    implements _$ShindoDbPrefectureNodeCopyWith<$Res> {
  __$ShindoDbPrefectureNodeCopyWithImpl(this._self, this._then);

  final _ShindoDbPrefectureNode _self;
  final $Res Function(_ShindoDbPrefectureNode) _then;

/// Create a copy of ShindoDbPrefectureNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prefecture = null,Object? cities = null,}) {
  return _then(_ShindoDbPrefectureNode(
prefecture: null == prefecture ? _self.prefecture : prefecture // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterPrefectureItem,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<ShindoDbCityNode>,
  ));
}

/// Create a copy of ShindoDbPrefectureNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterPrefectureItemCopyWith<$Res> get prefecture {
  
  return $EarthquakeParameterPrefectureItemCopyWith<$Res>(_self.prefecture, (value) {
    return _then(_self.copyWith(prefecture: value));
  });
}
}

/// @nodoc
mixin _$ShindoDbCityNode {

 EarthquakeParameterCityItem get city; EarthquakeParameterRegionItem get region; List<ShindoDbStationNode> get stations;
/// Create a copy of ShindoDbCityNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShindoDbCityNodeCopyWith<ShindoDbCityNode> get copyWith => _$ShindoDbCityNodeCopyWithImpl<ShindoDbCityNode>(this as ShindoDbCityNode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShindoDbCityNode&&(identical(other.city, city) || other.city == city)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other.stations, stations));
}


@override
int get hashCode => Object.hash(runtimeType,city,region,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'ShindoDbCityNode(city: $city, region: $region, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $ShindoDbCityNodeCopyWith<$Res>  {
  factory $ShindoDbCityNodeCopyWith(ShindoDbCityNode value, $Res Function(ShindoDbCityNode) _then) = _$ShindoDbCityNodeCopyWithImpl;
@useResult
$Res call({
 EarthquakeParameterCityItem city, EarthquakeParameterRegionItem region, List<ShindoDbStationNode> stations
});


$EarthquakeParameterCityItemCopyWith<$Res> get city;$EarthquakeParameterRegionItemCopyWith<$Res> get region;

}
/// @nodoc
class _$ShindoDbCityNodeCopyWithImpl<$Res>
    implements $ShindoDbCityNodeCopyWith<$Res> {
  _$ShindoDbCityNodeCopyWithImpl(this._self, this._then);

  final ShindoDbCityNode _self;
  final $Res Function(ShindoDbCityNode) _then;

/// Create a copy of ShindoDbCityNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? region = null,Object? stations = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterCityItem,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterRegionItem,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<ShindoDbStationNode>,
  ));
}
/// Create a copy of ShindoDbCityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterCityItemCopyWith<$Res> get city {
  
  return $EarthquakeParameterCityItemCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of ShindoDbCityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterRegionItemCopyWith<$Res> get region {
  
  return $EarthquakeParameterRegionItemCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShindoDbCityNode].
extension ShindoDbCityNodePatterns on ShindoDbCityNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShindoDbCityNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShindoDbCityNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShindoDbCityNode value)  $default,){
final _that = this;
switch (_that) {
case _ShindoDbCityNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShindoDbCityNode value)?  $default,){
final _that = this;
switch (_that) {
case _ShindoDbCityNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeParameterCityItem city,  EarthquakeParameterRegionItem region,  List<ShindoDbStationNode> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShindoDbCityNode() when $default != null:
return $default(_that.city,_that.region,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeParameterCityItem city,  EarthquakeParameterRegionItem region,  List<ShindoDbStationNode> stations)  $default,) {final _that = this;
switch (_that) {
case _ShindoDbCityNode():
return $default(_that.city,_that.region,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeParameterCityItem city,  EarthquakeParameterRegionItem region,  List<ShindoDbStationNode> stations)?  $default,) {final _that = this;
switch (_that) {
case _ShindoDbCityNode() when $default != null:
return $default(_that.city,_that.region,_that.stations);case _:
  return null;

}
}

}

/// @nodoc


class _ShindoDbCityNode implements ShindoDbCityNode {
  const _ShindoDbCityNode({required this.city, required this.region, required final  List<ShindoDbStationNode> stations}): _stations = stations;
  

@override final  EarthquakeParameterCityItem city;
@override final  EarthquakeParameterRegionItem region;
 final  List<ShindoDbStationNode> _stations;
@override List<ShindoDbStationNode> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of ShindoDbCityNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShindoDbCityNodeCopyWith<_ShindoDbCityNode> get copyWith => __$ShindoDbCityNodeCopyWithImpl<_ShindoDbCityNode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShindoDbCityNode&&(identical(other.city, city) || other.city == city)&&(identical(other.region, region) || other.region == region)&&const DeepCollectionEquality().equals(other._stations, _stations));
}


@override
int get hashCode => Object.hash(runtimeType,city,region,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'ShindoDbCityNode(city: $city, region: $region, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$ShindoDbCityNodeCopyWith<$Res> implements $ShindoDbCityNodeCopyWith<$Res> {
  factory _$ShindoDbCityNodeCopyWith(_ShindoDbCityNode value, $Res Function(_ShindoDbCityNode) _then) = __$ShindoDbCityNodeCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeParameterCityItem city, EarthquakeParameterRegionItem region, List<ShindoDbStationNode> stations
});


@override $EarthquakeParameterCityItemCopyWith<$Res> get city;@override $EarthquakeParameterRegionItemCopyWith<$Res> get region;

}
/// @nodoc
class __$ShindoDbCityNodeCopyWithImpl<$Res>
    implements _$ShindoDbCityNodeCopyWith<$Res> {
  __$ShindoDbCityNodeCopyWithImpl(this._self, this._then);

  final _ShindoDbCityNode _self;
  final $Res Function(_ShindoDbCityNode) _then;

/// Create a copy of ShindoDbCityNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? region = null,Object? stations = null,}) {
  return _then(_ShindoDbCityNode(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterCityItem,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterRegionItem,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<ShindoDbStationNode>,
  ));
}

/// Create a copy of ShindoDbCityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterCityItemCopyWith<$Res> get city {
  
  return $EarthquakeParameterCityItemCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of ShindoDbCityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterRegionItemCopyWith<$Res> get region {
  
  return $EarthquakeParameterRegionItemCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}

/// @nodoc
mixin _$ShindoDbStationNode {

 EarthquakeCatalogStationRecord get record; String get name; LatLng? get location;
/// Create a copy of ShindoDbStationNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShindoDbStationNodeCopyWith<ShindoDbStationNode> get copyWith => _$ShindoDbStationNodeCopyWithImpl<ShindoDbStationNode>(this as ShindoDbStationNode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShindoDbStationNode&&(identical(other.record, record) || other.record == record)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,record,name,location);

@override
String toString() {
  return 'ShindoDbStationNode(record: $record, name: $name, location: $location)';
}


}

/// @nodoc
abstract mixin class $ShindoDbStationNodeCopyWith<$Res>  {
  factory $ShindoDbStationNodeCopyWith(ShindoDbStationNode value, $Res Function(ShindoDbStationNode) _then) = _$ShindoDbStationNodeCopyWithImpl;
@useResult
$Res call({
 EarthquakeCatalogStationRecord record, String name, LatLng? location
});


$EarthquakeCatalogStationRecordCopyWith<$Res> get record;

}
/// @nodoc
class _$ShindoDbStationNodeCopyWithImpl<$Res>
    implements $ShindoDbStationNodeCopyWith<$Res> {
  _$ShindoDbStationNodeCopyWithImpl(this._self, this._then);

  final ShindoDbStationNode _self;
  final $Res Function(ShindoDbStationNode) _then;

/// Create a copy of ShindoDbStationNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? record = null,Object? name = null,Object? location = freezed,}) {
  return _then(_self.copyWith(
record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogStationRecord,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng?,
  ));
}
/// Create a copy of ShindoDbStationNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogStationRecordCopyWith<$Res> get record {
  
  return $EarthquakeCatalogStationRecordCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShindoDbStationNode].
extension ShindoDbStationNodePatterns on ShindoDbStationNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShindoDbStationNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShindoDbStationNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShindoDbStationNode value)  $default,){
final _that = this;
switch (_that) {
case _ShindoDbStationNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShindoDbStationNode value)?  $default,){
final _that = this;
switch (_that) {
case _ShindoDbStationNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeCatalogStationRecord record,  String name,  LatLng? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShindoDbStationNode() when $default != null:
return $default(_that.record,_that.name,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeCatalogStationRecord record,  String name,  LatLng? location)  $default,) {final _that = this;
switch (_that) {
case _ShindoDbStationNode():
return $default(_that.record,_that.name,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeCatalogStationRecord record,  String name,  LatLng? location)?  $default,) {final _that = this;
switch (_that) {
case _ShindoDbStationNode() when $default != null:
return $default(_that.record,_that.name,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _ShindoDbStationNode implements ShindoDbStationNode {
  const _ShindoDbStationNode({required this.record, required this.name, required this.location});
  

@override final  EarthquakeCatalogStationRecord record;
@override final  String name;
@override final  LatLng? location;

/// Create a copy of ShindoDbStationNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShindoDbStationNodeCopyWith<_ShindoDbStationNode> get copyWith => __$ShindoDbStationNodeCopyWithImpl<_ShindoDbStationNode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShindoDbStationNode&&(identical(other.record, record) || other.record == record)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,record,name,location);

@override
String toString() {
  return 'ShindoDbStationNode(record: $record, name: $name, location: $location)';
}


}

/// @nodoc
abstract mixin class _$ShindoDbStationNodeCopyWith<$Res> implements $ShindoDbStationNodeCopyWith<$Res> {
  factory _$ShindoDbStationNodeCopyWith(_ShindoDbStationNode value, $Res Function(_ShindoDbStationNode) _then) = __$ShindoDbStationNodeCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeCatalogStationRecord record, String name, LatLng? location
});


@override $EarthquakeCatalogStationRecordCopyWith<$Res> get record;

}
/// @nodoc
class __$ShindoDbStationNodeCopyWithImpl<$Res>
    implements _$ShindoDbStationNodeCopyWith<$Res> {
  __$ShindoDbStationNodeCopyWithImpl(this._self, this._then);

  final _ShindoDbStationNode _self;
  final $Res Function(_ShindoDbStationNode) _then;

/// Create a copy of ShindoDbStationNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? record = null,Object? name = null,Object? location = freezed,}) {
  return _then(_ShindoDbStationNode(
record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as EarthquakeCatalogStationRecord,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng?,
  ));
}

/// Create a copy of ShindoDbStationNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCatalogStationRecordCopyWith<$Res> get record {
  
  return $EarthquakeCatalogStationRecordCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}

// dart format on

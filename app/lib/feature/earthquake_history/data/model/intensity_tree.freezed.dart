// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_tree.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrefectureIntensityNode {

 IntensityPrefecture get prefecture; List<CityIntensityNode> get cities;
/// Create a copy of PrefectureIntensityNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrefectureIntensityNodeCopyWith<PrefectureIntensityNode> get copyWith => _$PrefectureIntensityNodeCopyWithImpl<PrefectureIntensityNode>(this as PrefectureIntensityNode, _$identity);

  /// Serializes this PrefectureIntensityNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrefectureIntensityNode&&(identical(other.prefecture, prefecture) || other.prefecture == prefecture)&&const DeepCollectionEquality().equals(other.cities, cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prefecture,const DeepCollectionEquality().hash(cities));

@override
String toString() {
  return 'PrefectureIntensityNode(prefecture: $prefecture, cities: $cities)';
}


}

/// @nodoc
abstract mixin class $PrefectureIntensityNodeCopyWith<$Res>  {
  factory $PrefectureIntensityNodeCopyWith(PrefectureIntensityNode value, $Res Function(PrefectureIntensityNode) _then) = _$PrefectureIntensityNodeCopyWithImpl;
@useResult
$Res call({
 IntensityPrefecture prefecture, List<CityIntensityNode> cities
});


$IntensityPrefectureCopyWith<$Res> get prefecture;

}
/// @nodoc
class _$PrefectureIntensityNodeCopyWithImpl<$Res>
    implements $PrefectureIntensityNodeCopyWith<$Res> {
  _$PrefectureIntensityNodeCopyWithImpl(this._self, this._then);

  final PrefectureIntensityNode _self;
  final $Res Function(PrefectureIntensityNode) _then;

/// Create a copy of PrefectureIntensityNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prefecture = null,Object? cities = null,}) {
  return _then(PrefectureIntensityNode(
prefecture: null == prefecture ? _self.prefecture : prefecture // ignore: cast_nullable_to_non_nullable
as IntensityPrefecture,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<CityIntensityNode>,
  ));
}
/// Create a copy of PrefectureIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityPrefectureCopyWith<$Res> get prefecture {
  
  return $IntensityPrefectureCopyWith<$Res>(_self.prefecture, (value) {
    return _then(_self.copyWith(prefecture: value));
  });
}
}


/// Adds pattern-matching-related methods to [PrefectureIntensityNode].
extension PrefectureIntensityNodePatterns on PrefectureIntensityNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrefectureIntensityNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrefectureIntensityNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrefectureIntensityNode value)  $default,){
final _that = this;
switch (_that) {
case _PrefectureIntensityNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrefectureIntensityNode value)?  $default,){
final _that = this;
switch (_that) {
case _PrefectureIntensityNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IntensityPrefecture prefecture,  List<CityIntensityNode> cities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrefectureIntensityNode() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IntensityPrefecture prefecture,  List<CityIntensityNode> cities)  $default,) {final _that = this;
switch (_that) {
case _PrefectureIntensityNode():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IntensityPrefecture prefecture,  List<CityIntensityNode> cities)?  $default,) {final _that = this;
switch (_that) {
case _PrefectureIntensityNode() when $default != null:
return $default(_that.prefecture,_that.cities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrefectureIntensityNode implements PrefectureIntensityNode {
  const _PrefectureIntensityNode({required this.prefecture, required  List<CityIntensityNode> cities}): _cities = cities;
  factory _PrefectureIntensityNode.fromJson(Map<String, dynamic> json) => _$PrefectureIntensityNodeFromJson(json);

@override final  IntensityPrefecture prefecture;
 final  List<CityIntensityNode> _cities;
@override List<CityIntensityNode> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}


/// Create a copy of PrefectureIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrefectureIntensityNodeCopyWith<_PrefectureIntensityNode> get copyWith => __$PrefectureIntensityNodeCopyWithImpl<_PrefectureIntensityNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrefectureIntensityNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrefectureIntensityNode&&(identical(other.prefecture, prefecture) || other.prefecture == prefecture)&&const DeepCollectionEquality().equals(other._cities, _cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prefecture,const DeepCollectionEquality().hash(_cities));

@override
String toString() {
  return 'PrefectureIntensityNode(prefecture: $prefecture, cities: $cities)';
}


}

/// @nodoc
abstract mixin class _$PrefectureIntensityNodeCopyWith<$Res> implements $PrefectureIntensityNodeCopyWith<$Res> {
  factory _$PrefectureIntensityNodeCopyWith(_PrefectureIntensityNode value, $Res Function(_PrefectureIntensityNode) _then) = __$PrefectureIntensityNodeCopyWithImpl;
@override @useResult
$Res call({
 IntensityPrefecture prefecture, List<CityIntensityNode> cities
});


@override $IntensityPrefectureCopyWith<$Res> get prefecture;

}
/// @nodoc
class __$PrefectureIntensityNodeCopyWithImpl<$Res>
    implements _$PrefectureIntensityNodeCopyWith<$Res> {
  __$PrefectureIntensityNodeCopyWithImpl(this._self, this._then);

  final _PrefectureIntensityNode _self;
  final $Res Function(_PrefectureIntensityNode) _then;

/// Create a copy of PrefectureIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prefecture = null,Object? cities = null,}) {
  return _then(_PrefectureIntensityNode(
prefecture: null == prefecture ? _self.prefecture : prefecture // ignore: cast_nullable_to_non_nullable
as IntensityPrefecture,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<CityIntensityNode>,
  ));
}

/// Create a copy of PrefectureIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityPrefectureCopyWith<$Res> get prefecture {
  
  return $IntensityPrefectureCopyWith<$Res>(_self.prefecture, (value) {
    return _then(_self.copyWith(prefecture: value));
  });
}
}


/// @nodoc
mixin _$IntensityPrefecture {

@EarthquakeParameterPrefectureItemJsonConverter() EarthquakeParameterPrefectureItem get prefecture; JmaIntensity? get maxIntensity;
/// Create a copy of IntensityPrefecture
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityPrefectureCopyWith<IntensityPrefecture> get copyWith => _$IntensityPrefectureCopyWithImpl<IntensityPrefecture>(this as IntensityPrefecture, _$identity);

  /// Serializes this IntensityPrefecture to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityPrefecture&&(identical(other.prefecture, prefecture) || other.prefecture == prefecture)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prefecture,maxIntensity);

@override
String toString() {
  return 'IntensityPrefecture(prefecture: $prefecture, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityPrefectureCopyWith<$Res>  {
  factory $IntensityPrefectureCopyWith(IntensityPrefecture value, $Res Function(IntensityPrefecture) _then) = _$IntensityPrefectureCopyWithImpl;
@useResult
$Res call({
@EarthquakeParameterPrefectureItemJsonConverter() EarthquakeParameterPrefectureItem prefecture, JmaIntensity? maxIntensity
});


$EarthquakeParameterPrefectureItemCopyWith<$Res> get prefecture;

}
/// @nodoc
class _$IntensityPrefectureCopyWithImpl<$Res>
    implements $IntensityPrefectureCopyWith<$Res> {
  _$IntensityPrefectureCopyWithImpl(this._self, this._then);

  final IntensityPrefecture _self;
  final $Res Function(IntensityPrefecture) _then;

/// Create a copy of IntensityPrefecture
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prefecture = null,Object? maxIntensity = freezed,}) {
  return _then(IntensityPrefecture(
prefecture: null == prefecture ? _self.prefecture : prefecture // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterPrefectureItem,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}
/// Create a copy of IntensityPrefecture
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterPrefectureItemCopyWith<$Res> get prefecture {
  
  return $EarthquakeParameterPrefectureItemCopyWith<$Res>(_self.prefecture, (value) {
    return _then(_self.copyWith(prefecture: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityPrefecture].
extension IntensityPrefecturePatterns on IntensityPrefecture {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityPrefecture value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityPrefecture() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityPrefecture value)  $default,){
final _that = this;
switch (_that) {
case _IntensityPrefecture():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityPrefecture value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityPrefecture() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@EarthquakeParameterPrefectureItemJsonConverter()  EarthquakeParameterPrefectureItem prefecture,  JmaIntensity? maxIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityPrefecture() when $default != null:
return $default(_that.prefecture,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@EarthquakeParameterPrefectureItemJsonConverter()  EarthquakeParameterPrefectureItem prefecture,  JmaIntensity? maxIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityPrefecture():
return $default(_that.prefecture,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@EarthquakeParameterPrefectureItemJsonConverter()  EarthquakeParameterPrefectureItem prefecture,  JmaIntensity? maxIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityPrefecture() when $default != null:
return $default(_that.prefecture,_that.maxIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityPrefecture implements IntensityPrefecture {
  const _IntensityPrefecture({@EarthquakeParameterPrefectureItemJsonConverter() required this.prefecture, required this.maxIntensity});
  factory _IntensityPrefecture.fromJson(Map<String, dynamic> json) => _$IntensityPrefectureFromJson(json);

@override@EarthquakeParameterPrefectureItemJsonConverter() final  EarthquakeParameterPrefectureItem prefecture;
@override final  JmaIntensity? maxIntensity;

/// Create a copy of IntensityPrefecture
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityPrefectureCopyWith<_IntensityPrefecture> get copyWith => __$IntensityPrefectureCopyWithImpl<_IntensityPrefecture>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityPrefectureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityPrefecture&&(identical(other.prefecture, prefecture) || other.prefecture == prefecture)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prefecture,maxIntensity);

@override
String toString() {
  return 'IntensityPrefecture(prefecture: $prefecture, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityPrefectureCopyWith<$Res> implements $IntensityPrefectureCopyWith<$Res> {
  factory _$IntensityPrefectureCopyWith(_IntensityPrefecture value, $Res Function(_IntensityPrefecture) _then) = __$IntensityPrefectureCopyWithImpl;
@override @useResult
$Res call({
@EarthquakeParameterPrefectureItemJsonConverter() EarthquakeParameterPrefectureItem prefecture, JmaIntensity? maxIntensity
});


@override $EarthquakeParameterPrefectureItemCopyWith<$Res> get prefecture;

}
/// @nodoc
class __$IntensityPrefectureCopyWithImpl<$Res>
    implements _$IntensityPrefectureCopyWith<$Res> {
  __$IntensityPrefectureCopyWithImpl(this._self, this._then);

  final _IntensityPrefecture _self;
  final $Res Function(_IntensityPrefecture) _then;

/// Create a copy of IntensityPrefecture
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prefecture = null,Object? maxIntensity = freezed,}) {
  return _then(_IntensityPrefecture(
prefecture: null == prefecture ? _self.prefecture : prefecture // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterPrefectureItem,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}

/// Create a copy of IntensityPrefecture
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
mixin _$IntensityRegion {

@EarthquakeParameterRegionItemJsonConverter() EarthquakeParameterRegionItem get region; JmaIntensity? get maxIntensity;
/// Create a copy of IntensityRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityRegionCopyWith<IntensityRegion> get copyWith => _$IntensityRegionCopyWithImpl<IntensityRegion>(this as IntensityRegion, _$identity);

  /// Serializes this IntensityRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityRegion&&(identical(other.region, region) || other.region == region)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,maxIntensity);

@override
String toString() {
  return 'IntensityRegion(region: $region, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityRegionCopyWith<$Res>  {
  factory $IntensityRegionCopyWith(IntensityRegion value, $Res Function(IntensityRegion) _then) = _$IntensityRegionCopyWithImpl;
@useResult
$Res call({
@EarthquakeParameterRegionItemJsonConverter() EarthquakeParameterRegionItem region, JmaIntensity? maxIntensity
});


$EarthquakeParameterRegionItemCopyWith<$Res> get region;

}
/// @nodoc
class _$IntensityRegionCopyWithImpl<$Res>
    implements $IntensityRegionCopyWith<$Res> {
  _$IntensityRegionCopyWithImpl(this._self, this._then);

  final IntensityRegion _self;
  final $Res Function(IntensityRegion) _then;

/// Create a copy of IntensityRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? region = null,Object? maxIntensity = freezed,}) {
  return _then(IntensityRegion(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterRegionItem,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}
/// Create a copy of IntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterRegionItemCopyWith<$Res> get region {
  
  return $EarthquakeParameterRegionItemCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityRegion].
extension IntensityRegionPatterns on IntensityRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityRegion value)  $default,){
final _that = this;
switch (_that) {
case _IntensityRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityRegion value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@EarthquakeParameterRegionItemJsonConverter()  EarthquakeParameterRegionItem region,  JmaIntensity? maxIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityRegion() when $default != null:
return $default(_that.region,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@EarthquakeParameterRegionItemJsonConverter()  EarthquakeParameterRegionItem region,  JmaIntensity? maxIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityRegion():
return $default(_that.region,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@EarthquakeParameterRegionItemJsonConverter()  EarthquakeParameterRegionItem region,  JmaIntensity? maxIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityRegion() when $default != null:
return $default(_that.region,_that.maxIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityRegion implements IntensityRegion {
  const _IntensityRegion({@EarthquakeParameterRegionItemJsonConverter() required this.region, required this.maxIntensity});
  factory _IntensityRegion.fromJson(Map<String, dynamic> json) => _$IntensityRegionFromJson(json);

@override@EarthquakeParameterRegionItemJsonConverter() final  EarthquakeParameterRegionItem region;
@override final  JmaIntensity? maxIntensity;

/// Create a copy of IntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityRegionCopyWith<_IntensityRegion> get copyWith => __$IntensityRegionCopyWithImpl<_IntensityRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityRegion&&(identical(other.region, region) || other.region == region)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,maxIntensity);

@override
String toString() {
  return 'IntensityRegion(region: $region, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityRegionCopyWith<$Res> implements $IntensityRegionCopyWith<$Res> {
  factory _$IntensityRegionCopyWith(_IntensityRegion value, $Res Function(_IntensityRegion) _then) = __$IntensityRegionCopyWithImpl;
@override @useResult
$Res call({
@EarthquakeParameterRegionItemJsonConverter() EarthquakeParameterRegionItem region, JmaIntensity? maxIntensity
});


@override $EarthquakeParameterRegionItemCopyWith<$Res> get region;

}
/// @nodoc
class __$IntensityRegionCopyWithImpl<$Res>
    implements _$IntensityRegionCopyWith<$Res> {
  __$IntensityRegionCopyWithImpl(this._self, this._then);

  final _IntensityRegion _self;
  final $Res Function(_IntensityRegion) _then;

/// Create a copy of IntensityRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? region = null,Object? maxIntensity = freezed,}) {
  return _then(_IntensityRegion(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterRegionItem,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}

/// Create a copy of IntensityRegion
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
mixin _$CityIntensityNode {

@EarthquakeParameterCityItemJsonConverter() EarthquakeParameterCityItem get city; JmaIntensity? get maxIntensity; List<StationIntensityNode> get stations; JmaLpgmIntensity? get maxLpgmIntensity;
/// Create a copy of CityIntensityNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityIntensityNodeCopyWith<CityIntensityNode> get copyWith => _$CityIntensityNodeCopyWithImpl<CityIntensityNode>(this as CityIntensityNode, _$identity);

  /// Serializes this CityIntensityNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityIntensityNode&&(identical(other.city, city) || other.city == city)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other.stations, stations)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,maxIntensity,const DeepCollectionEquality().hash(stations),maxLpgmIntensity);

@override
String toString() {
  return 'CityIntensityNode(city: $city, maxIntensity: $maxIntensity, stations: $stations, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $CityIntensityNodeCopyWith<$Res>  {
  factory $CityIntensityNodeCopyWith(CityIntensityNode value, $Res Function(CityIntensityNode) _then) = _$CityIntensityNodeCopyWithImpl;
@useResult
$Res call({
@EarthquakeParameterCityItemJsonConverter() EarthquakeParameterCityItem city, JmaIntensity? maxIntensity, List<StationIntensityNode> stations, JmaLpgmIntensity? maxLpgmIntensity
});


$EarthquakeParameterCityItemCopyWith<$Res> get city;

}
/// @nodoc
class _$CityIntensityNodeCopyWithImpl<$Res>
    implements $CityIntensityNodeCopyWith<$Res> {
  _$CityIntensityNodeCopyWithImpl(this._self, this._then);

  final CityIntensityNode _self;
  final $Res Function(CityIntensityNode) _then;

/// Create a copy of CityIntensityNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? maxIntensity = freezed,Object? stations = null,Object? maxLpgmIntensity = freezed,}) {
  return _then(CityIntensityNode(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterCityItem,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<StationIntensityNode>,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}
/// Create a copy of CityIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterCityItemCopyWith<$Res> get city {
  
  return $EarthquakeParameterCityItemCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@EarthquakeParameterCityItemJsonConverter()  EarthquakeParameterCityItem city,  JmaIntensity? maxIntensity,  List<StationIntensityNode> stations,  JmaLpgmIntensity? maxLpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityIntensityNode() when $default != null:
return $default(_that.city,_that.maxIntensity,_that.stations,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@EarthquakeParameterCityItemJsonConverter()  EarthquakeParameterCityItem city,  JmaIntensity? maxIntensity,  List<StationIntensityNode> stations,  JmaLpgmIntensity? maxLpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _CityIntensityNode():
return $default(_that.city,_that.maxIntensity,_that.stations,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@EarthquakeParameterCityItemJsonConverter()  EarthquakeParameterCityItem city,  JmaIntensity? maxIntensity,  List<StationIntensityNode> stations,  JmaLpgmIntensity? maxLpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _CityIntensityNode() when $default != null:
return $default(_that.city,_that.maxIntensity,_that.stations,_that.maxLpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CityIntensityNode implements CityIntensityNode {
  const _CityIntensityNode({@EarthquakeParameterCityItemJsonConverter() required this.city, required this.maxIntensity, required  List<StationIntensityNode> stations, this.maxLpgmIntensity}): _stations = stations;
  factory _CityIntensityNode.fromJson(Map<String, dynamic> json) => _$CityIntensityNodeFromJson(json);

@override@EarthquakeParameterCityItemJsonConverter() final  EarthquakeParameterCityItem city;
@override final  JmaIntensity? maxIntensity;
 final  List<StationIntensityNode> _stations;
@override List<StationIntensityNode> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}

@override final  JmaLpgmIntensity? maxLpgmIntensity;

/// Create a copy of CityIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityIntensityNodeCopyWith<_CityIntensityNode> get copyWith => __$CityIntensityNodeCopyWithImpl<_CityIntensityNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityIntensityNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityIntensityNode&&(identical(other.city, city) || other.city == city)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._stations, _stations)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,maxIntensity,const DeepCollectionEquality().hash(_stations),maxLpgmIntensity);

@override
String toString() {
  return 'CityIntensityNode(city: $city, maxIntensity: $maxIntensity, stations: $stations, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$CityIntensityNodeCopyWith<$Res> implements $CityIntensityNodeCopyWith<$Res> {
  factory _$CityIntensityNodeCopyWith(_CityIntensityNode value, $Res Function(_CityIntensityNode) _then) = __$CityIntensityNodeCopyWithImpl;
@override @useResult
$Res call({
@EarthquakeParameterCityItemJsonConverter() EarthquakeParameterCityItem city, JmaIntensity? maxIntensity, List<StationIntensityNode> stations, JmaLpgmIntensity? maxLpgmIntensity
});


@override $EarthquakeParameterCityItemCopyWith<$Res> get city;

}
/// @nodoc
class __$CityIntensityNodeCopyWithImpl<$Res>
    implements _$CityIntensityNodeCopyWith<$Res> {
  __$CityIntensityNodeCopyWithImpl(this._self, this._then);

  final _CityIntensityNode _self;
  final $Res Function(_CityIntensityNode) _then;

/// Create a copy of CityIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? maxIntensity = freezed,Object? stations = null,Object? maxLpgmIntensity = freezed,}) {
  return _then(_CityIntensityNode(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterCityItem,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<StationIntensityNode>,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}

/// Create a copy of CityIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterCityItemCopyWith<$Res> get city {
  
  return $EarthquakeParameterCityItemCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}
}


/// @nodoc
mixin _$StationIntensityNode {

@EarthquakeParameterStationItemJsonConverter() EarthquakeParameterStationItem get station; IntensityStation? get intensity;
/// Create a copy of StationIntensityNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationIntensityNodeCopyWith<StationIntensityNode> get copyWith => _$StationIntensityNodeCopyWithImpl<StationIntensityNode>(this as StationIntensityNode, _$identity);

  /// Serializes this StationIntensityNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationIntensityNode&&(identical(other.station, station) || other.station == station)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
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
@EarthquakeParameterStationItemJsonConverter() EarthquakeParameterStationItem station, IntensityStation? intensity
});


$EarthquakeParameterStationItemCopyWith<$Res> get station;$IntensityStationCopyWith<$Res>? get intensity;

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
  return _then(StationIntensityNode(
station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterStationItem,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityStation?,
  ));
}
/// Create a copy of StationIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterStationItemCopyWith<$Res> get station {
  
  return $EarthquakeParameterStationItemCopyWith<$Res>(_self.station, (value) {
    return _then(_self.copyWith(station: value));
  });
}/// Create a copy of StationIntensityNode
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@EarthquakeParameterStationItemJsonConverter()  EarthquakeParameterStationItem station,  IntensityStation? intensity)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@EarthquakeParameterStationItemJsonConverter()  EarthquakeParameterStationItem station,  IntensityStation? intensity)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@EarthquakeParameterStationItemJsonConverter()  EarthquakeParameterStationItem station,  IntensityStation? intensity)?  $default,) {final _that = this;
switch (_that) {
case _StationIntensityNode() when $default != null:
return $default(_that.station,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StationIntensityNode implements StationIntensityNode {
  const _StationIntensityNode({@EarthquakeParameterStationItemJsonConverter() required this.station, required this.intensity});
  factory _StationIntensityNode.fromJson(Map<String, dynamic> json) => _$StationIntensityNodeFromJson(json);

@override@EarthquakeParameterStationItemJsonConverter() final  EarthquakeParameterStationItem station;
@override final  IntensityStation? intensity;

/// Create a copy of StationIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationIntensityNodeCopyWith<_StationIntensityNode> get copyWith => __$StationIntensityNodeCopyWithImpl<_StationIntensityNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StationIntensityNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationIntensityNode&&(identical(other.station, station) || other.station == station)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
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
@EarthquakeParameterStationItemJsonConverter() EarthquakeParameterStationItem station, IntensityStation? intensity
});


@override $EarthquakeParameterStationItemCopyWith<$Res> get station;@override $IntensityStationCopyWith<$Res>? get intensity;

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
as IntensityStation?,
  ));
}

/// Create a copy of StationIntensityNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeParameterStationItemCopyWith<$Res> get station {
  
  return $EarthquakeParameterStationItemCopyWith<$Res>(_self.station, (value) {
    return _then(_self.copyWith(station: value));
  });
}/// Create a copy of StationIntensityNode
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

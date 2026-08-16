// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lpgm_intensity_tree.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LpgmIntensityTree {

@JsonKey(name: 'lpgm_intensity') JmaLpgmIntensity get lpgmIntensity; List<LpgmIntensityTreeRegionId> get regions; List<IntensityStationItem> get stations;
/// Create a copy of LpgmIntensityTree
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LpgmIntensityTreeCopyWith<LpgmIntensityTree> get copyWith => _$LpgmIntensityTreeCopyWithImpl<LpgmIntensityTree>(this as LpgmIntensityTree, _$identity);

  /// Serializes this LpgmIntensityTree to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LpgmIntensityTree&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lpgmIntensity,const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'LpgmIntensityTree(lpgmIntensity: $lpgmIntensity, regions: $regions, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $LpgmIntensityTreeCopyWith<$Res>  {
  factory $LpgmIntensityTreeCopyWith(LpgmIntensityTree value, $Res Function(LpgmIntensityTree) _then) = _$LpgmIntensityTreeCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'lpgm_intensity') JmaLpgmIntensity lpgmIntensity, List<LpgmIntensityTreeRegionId> regions, List<IntensityStationItem> stations
});




}
/// @nodoc
class _$LpgmIntensityTreeCopyWithImpl<$Res>
    implements $LpgmIntensityTreeCopyWith<$Res> {
  _$LpgmIntensityTreeCopyWithImpl(this._self, this._then);

  final LpgmIntensityTree _self;
  final $Res Function(LpgmIntensityTree) _then;

/// Create a copy of LpgmIntensityTree
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lpgmIntensity = null,Object? regions = null,Object? stations = null,}) {
  return _then(LpgmIntensityTree(
lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<LpgmIntensityTreeRegionId>,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<IntensityStationItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [LpgmIntensityTree].
extension LpgmIntensityTreePatterns on LpgmIntensityTree {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LpgmIntensityTree value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LpgmIntensityTree() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LpgmIntensityTree value)  $default,){
final _that = this;
switch (_that) {
case _LpgmIntensityTree():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LpgmIntensityTree value)?  $default,){
final _that = this;
switch (_that) {
case _LpgmIntensityTree() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'lpgm_intensity')  JmaLpgmIntensity lpgmIntensity,  List<LpgmIntensityTreeRegionId> regions,  List<IntensityStationItem> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LpgmIntensityTree() when $default != null:
return $default(_that.lpgmIntensity,_that.regions,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'lpgm_intensity')  JmaLpgmIntensity lpgmIntensity,  List<LpgmIntensityTreeRegionId> regions,  List<IntensityStationItem> stations)  $default,) {final _that = this;
switch (_that) {
case _LpgmIntensityTree():
return $default(_that.lpgmIntensity,_that.regions,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'lpgm_intensity')  JmaLpgmIntensity lpgmIntensity,  List<LpgmIntensityTreeRegionId> regions,  List<IntensityStationItem> stations)?  $default,) {final _that = this;
switch (_that) {
case _LpgmIntensityTree() when $default != null:
return $default(_that.lpgmIntensity,_that.regions,_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LpgmIntensityTree implements LpgmIntensityTree {
  const _LpgmIntensityTree({@JsonKey(name: 'lpgm_intensity') required this.lpgmIntensity, required  List<LpgmIntensityTreeRegionId> regions, required  List<IntensityStationItem> stations}): _regions = regions,_stations = stations;
  factory _LpgmIntensityTree.fromJson(Map<String, dynamic> json) => _$LpgmIntensityTreeFromJson(json);

@override@JsonKey(name: 'lpgm_intensity') final  JmaLpgmIntensity lpgmIntensity;
 final  List<LpgmIntensityTreeRegionId> _regions;
@override List<LpgmIntensityTreeRegionId> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<IntensityStationItem> _stations;
@override List<IntensityStationItem> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of LpgmIntensityTree
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LpgmIntensityTreeCopyWith<_LpgmIntensityTree> get copyWith => __$LpgmIntensityTreeCopyWithImpl<_LpgmIntensityTree>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LpgmIntensityTreeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LpgmIntensityTree&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lpgmIntensity,const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'LpgmIntensityTree(lpgmIntensity: $lpgmIntensity, regions: $regions, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$LpgmIntensityTreeCopyWith<$Res> implements $LpgmIntensityTreeCopyWith<$Res> {
  factory _$LpgmIntensityTreeCopyWith(_LpgmIntensityTree value, $Res Function(_LpgmIntensityTree) _then) = __$LpgmIntensityTreeCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'lpgm_intensity') JmaLpgmIntensity lpgmIntensity, List<LpgmIntensityTreeRegionId> regions, List<IntensityStationItem> stations
});




}
/// @nodoc
class __$LpgmIntensityTreeCopyWithImpl<$Res>
    implements _$LpgmIntensityTreeCopyWith<$Res> {
  __$LpgmIntensityTreeCopyWithImpl(this._self, this._then);

  final _LpgmIntensityTree _self;
  final $Res Function(_LpgmIntensityTree) _then;

/// Create a copy of LpgmIntensityTree
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lpgmIntensity = null,Object? regions = null,Object? stations = null,}) {
  return _then(_LpgmIntensityTree(
lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<LpgmIntensityTreeRegionId>,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<IntensityStationItem>,
  ));
}


}

// dart format on

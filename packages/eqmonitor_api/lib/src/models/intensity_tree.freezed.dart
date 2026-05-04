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

 JmaIntensity get intensity; List<IntensityTreeRegionId> get regions;@JsonKey(includeIfNull: false) List<IntensityTreeStationId>? get stations;
/// Create a copy of IntensityTree
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityTreeCopyWith<IntensityTree> get copyWith => _$IntensityTreeCopyWithImpl<IntensityTree>(this as IntensityTree, _$identity);

  /// Serializes this IntensityTree to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityTree&&(identical(other.intensity, intensity) || other.intensity == intensity)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'IntensityTree(intensity: $intensity, regions: $regions, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $IntensityTreeCopyWith<$Res>  {
  factory $IntensityTreeCopyWith(IntensityTree value, $Res Function(IntensityTree) _then) = _$IntensityTreeCopyWithImpl;
@useResult
$Res call({
 JmaIntensity intensity, List<IntensityTreeRegionId> regions,@JsonKey(includeIfNull: false) List<IntensityTreeStationId>? stations
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
@pragma('vm:prefer-inline') @override $Res call({Object? intensity = null,Object? regions = null,Object? stations = freezed,}) {
  return _then(_self.copyWith(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<IntensityTreeRegionId>,stations: freezed == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<IntensityTreeStationId>?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaIntensity intensity,  List<IntensityTreeRegionId> regions, @JsonKey(includeIfNull: false)  List<IntensityTreeStationId>? stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityTree() when $default != null:
return $default(_that.intensity,_that.regions,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaIntensity intensity,  List<IntensityTreeRegionId> regions, @JsonKey(includeIfNull: false)  List<IntensityTreeStationId>? stations)  $default,) {final _that = this;
switch (_that) {
case _IntensityTree():
return $default(_that.intensity,_that.regions,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaIntensity intensity,  List<IntensityTreeRegionId> regions, @JsonKey(includeIfNull: false)  List<IntensityTreeStationId>? stations)?  $default,) {final _that = this;
switch (_that) {
case _IntensityTree() when $default != null:
return $default(_that.intensity,_that.regions,_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityTree implements IntensityTree {
  const _IntensityTree({required this.intensity, required final  List<IntensityTreeRegionId> regions, @JsonKey(includeIfNull: false) final  List<IntensityTreeStationId>? stations}): _regions = regions,_stations = stations;
  factory _IntensityTree.fromJson(Map<String, dynamic> json) => _$IntensityTreeFromJson(json);

@override final  JmaIntensity intensity;
 final  List<IntensityTreeRegionId> _regions;
@override List<IntensityTreeRegionId> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<IntensityTreeStationId>? _stations;
@override@JsonKey(includeIfNull: false) List<IntensityTreeStationId>? get stations {
  final value = _stations;
  if (value == null) return null;
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of IntensityTree
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityTreeCopyWith<_IntensityTree> get copyWith => __$IntensityTreeCopyWithImpl<_IntensityTree>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityTreeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityTree&&(identical(other.intensity, intensity) || other.intensity == intensity)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'IntensityTree(intensity: $intensity, regions: $regions, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$IntensityTreeCopyWith<$Res> implements $IntensityTreeCopyWith<$Res> {
  factory _$IntensityTreeCopyWith(_IntensityTree value, $Res Function(_IntensityTree) _then) = __$IntensityTreeCopyWithImpl;
@override @useResult
$Res call({
 JmaIntensity intensity, List<IntensityTreeRegionId> regions,@JsonKey(includeIfNull: false) List<IntensityTreeStationId>? stations
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
@override @pragma('vm:prefer-inline') $Res call({Object? intensity = null,Object? regions = null,Object? stations = freezed,}) {
  return _then(_IntensityTree(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<IntensityTreeRegionId>,stations: freezed == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<IntensityTreeStationId>?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_region_catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShakeDetectionRegionCatalog {

 List<KyoshinObservationPoint> get stations; Map<String, String> get prefectureNames; Map<String, String> get regionNames;
/// Create a copy of ShakeDetectionRegionCatalog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionRegionCatalogCopyWith<ShakeDetectionRegionCatalog> get copyWith => _$ShakeDetectionRegionCatalogCopyWithImpl<ShakeDetectionRegionCatalog>(this as ShakeDetectionRegionCatalog, _$identity);

  /// Serializes this ShakeDetectionRegionCatalog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionRegionCatalog&&const DeepCollectionEquality().equals(other.stations, stations)&&const DeepCollectionEquality().equals(other.prefectureNames, prefectureNames)&&const DeepCollectionEquality().equals(other.regionNames, regionNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(stations),const DeepCollectionEquality().hash(prefectureNames),const DeepCollectionEquality().hash(regionNames));

@override
String toString() {
  return 'ShakeDetectionRegionCatalog(stations: $stations, prefectureNames: $prefectureNames, regionNames: $regionNames)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionRegionCatalogCopyWith<$Res>  {
  factory $ShakeDetectionRegionCatalogCopyWith(ShakeDetectionRegionCatalog value, $Res Function(ShakeDetectionRegionCatalog) _then) = _$ShakeDetectionRegionCatalogCopyWithImpl;
@useResult
$Res call({
 List<KyoshinObservationPoint> stations, Map<String, String> prefectureNames, Map<String, String> regionNames
});




}
/// @nodoc
class _$ShakeDetectionRegionCatalogCopyWithImpl<$Res>
    implements $ShakeDetectionRegionCatalogCopyWith<$Res> {
  _$ShakeDetectionRegionCatalogCopyWithImpl(this._self, this._then);

  final ShakeDetectionRegionCatalog _self;
  final $Res Function(ShakeDetectionRegionCatalog) _then;

/// Create a copy of ShakeDetectionRegionCatalog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stations = null,Object? prefectureNames = null,Object? regionNames = null,}) {
  return _then(ShakeDetectionRegionCatalog(
stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<KyoshinObservationPoint>,prefectureNames: null == prefectureNames ? _self.prefectureNames : prefectureNames // ignore: cast_nullable_to_non_nullable
as Map<String, String>,regionNames: null == regionNames ? _self.regionNames : regionNames // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ShakeDetectionRegionCatalog].
extension ShakeDetectionRegionCatalogPatterns on ShakeDetectionRegionCatalog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionRegionCatalog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionRegionCatalog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionRegionCatalog value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionRegionCatalog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionRegionCatalog value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionRegionCatalog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<KyoshinObservationPoint> stations,  Map<String, String> prefectureNames,  Map<String, String> regionNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionRegionCatalog() when $default != null:
return $default(_that.stations,_that.prefectureNames,_that.regionNames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<KyoshinObservationPoint> stations,  Map<String, String> prefectureNames,  Map<String, String> regionNames)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionRegionCatalog():
return $default(_that.stations,_that.prefectureNames,_that.regionNames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<KyoshinObservationPoint> stations,  Map<String, String> prefectureNames,  Map<String, String> regionNames)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionRegionCatalog() when $default != null:
return $default(_that.stations,_that.prefectureNames,_that.regionNames);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ShakeDetectionRegionCatalog implements ShakeDetectionRegionCatalog {
  const _ShakeDetectionRegionCatalog({required  List<KyoshinObservationPoint> stations, required  Map<String, String> prefectureNames, required  Map<String, String> regionNames}): _stations = stations,_prefectureNames = prefectureNames,_regionNames = regionNames;
  factory _ShakeDetectionRegionCatalog.fromJson(Map<String, dynamic> json) => _$ShakeDetectionRegionCatalogFromJson(json);

 final  List<KyoshinObservationPoint> _stations;
@override List<KyoshinObservationPoint> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}

 final  Map<String, String> _prefectureNames;
@override Map<String, String> get prefectureNames {
  if (_prefectureNames is EqualUnmodifiableMapView) return _prefectureNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_prefectureNames);
}

 final  Map<String, String> _regionNames;
@override Map<String, String> get regionNames {
  if (_regionNames is EqualUnmodifiableMapView) return _regionNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_regionNames);
}


/// Create a copy of ShakeDetectionRegionCatalog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionRegionCatalogCopyWith<_ShakeDetectionRegionCatalog> get copyWith => __$ShakeDetectionRegionCatalogCopyWithImpl<_ShakeDetectionRegionCatalog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionRegionCatalogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionRegionCatalog&&const DeepCollectionEquality().equals(other._stations, _stations)&&const DeepCollectionEquality().equals(other._prefectureNames, _prefectureNames)&&const DeepCollectionEquality().equals(other._regionNames, _regionNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stations),const DeepCollectionEquality().hash(_prefectureNames),const DeepCollectionEquality().hash(_regionNames));

@override
String toString() {
  return 'ShakeDetectionRegionCatalog(stations: $stations, prefectureNames: $prefectureNames, regionNames: $regionNames)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionRegionCatalogCopyWith<$Res> implements $ShakeDetectionRegionCatalogCopyWith<$Res> {
  factory _$ShakeDetectionRegionCatalogCopyWith(_ShakeDetectionRegionCatalog value, $Res Function(_ShakeDetectionRegionCatalog) _then) = __$ShakeDetectionRegionCatalogCopyWithImpl;
@override @useResult
$Res call({
 List<KyoshinObservationPoint> stations, Map<String, String> prefectureNames, Map<String, String> regionNames
});




}
/// @nodoc
class __$ShakeDetectionRegionCatalogCopyWithImpl<$Res>
    implements _$ShakeDetectionRegionCatalogCopyWith<$Res> {
  __$ShakeDetectionRegionCatalogCopyWithImpl(this._self, this._then);

  final _ShakeDetectionRegionCatalog _self;
  final $Res Function(_ShakeDetectionRegionCatalog) _then;

/// Create a copy of ShakeDetectionRegionCatalog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stations = null,Object? prefectureNames = null,Object? regionNames = null,}) {
  return _then(_ShakeDetectionRegionCatalog(
stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<KyoshinObservationPoint>,prefectureNames: null == prefectureNames ? _self._prefectureNames : prefectureNames // ignore: cast_nullable_to_non_nullable
as Map<String, String>,regionNames: null == regionNames ? _self._regionNames : regionNames // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on

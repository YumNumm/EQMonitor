// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_earthquake_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NearbyEarthquakeQuery {

 String get excludeEventId; double get latitude; double get longitude; int? get depth; NearbyEarthquakeParameter get parameter; EarthquakeSortBy get sortBy; SortOrder get sortOrder;
/// Create a copy of NearbyEarthquakeQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbyEarthquakeQueryCopyWith<NearbyEarthquakeQuery> get copyWith => _$NearbyEarthquakeQueryCopyWithImpl<NearbyEarthquakeQuery>(this as NearbyEarthquakeQuery, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbyEarthquakeQuery&&(identical(other.excludeEventId, excludeEventId) || other.excludeEventId == excludeEventId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.parameter, parameter) || other.parameter == parameter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,excludeEventId,latitude,longitude,depth,parameter,sortBy,sortOrder);

@override
String toString() {
  return 'NearbyEarthquakeQuery(excludeEventId: $excludeEventId, latitude: $latitude, longitude: $longitude, depth: $depth, parameter: $parameter, sortBy: $sortBy, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $NearbyEarthquakeQueryCopyWith<$Res>  {
  factory $NearbyEarthquakeQueryCopyWith(NearbyEarthquakeQuery value, $Res Function(NearbyEarthquakeQuery) _then) = _$NearbyEarthquakeQueryCopyWithImpl;
@useResult
$Res call({
 String excludeEventId, double latitude, double longitude, int? depth, NearbyEarthquakeParameter parameter, EarthquakeSortBy sortBy, SortOrder sortOrder
});


$NearbyEarthquakeParameterCopyWith<$Res> get parameter;

}
/// @nodoc
class _$NearbyEarthquakeQueryCopyWithImpl<$Res>
    implements $NearbyEarthquakeQueryCopyWith<$Res> {
  _$NearbyEarthquakeQueryCopyWithImpl(this._self, this._then);

  final NearbyEarthquakeQuery _self;
  final $Res Function(NearbyEarthquakeQuery) _then;

/// Create a copy of NearbyEarthquakeQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? excludeEventId = null,Object? latitude = null,Object? longitude = null,Object? depth = freezed,Object? parameter = null,Object? sortBy = null,Object? sortOrder = null,}) {
  return _then(NearbyEarthquakeQuery(
excludeEventId: null == excludeEventId ? _self.excludeEventId : excludeEventId // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,parameter: null == parameter ? _self.parameter : parameter // ignore: cast_nullable_to_non_nullable
as NearbyEarthquakeParameter,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as EarthquakeSortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,
  ));
}
/// Create a copy of NearbyEarthquakeQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NearbyEarthquakeParameterCopyWith<$Res> get parameter {
  
  return $NearbyEarthquakeParameterCopyWith<$Res>(_self.parameter, (value) {
    return _then(_self.copyWith(parameter: value));
  });
}
}


/// Adds pattern-matching-related methods to [NearbyEarthquakeQuery].
extension NearbyEarthquakeQueryPatterns on NearbyEarthquakeQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbyEarthquakeQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbyEarthquakeQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbyEarthquakeQuery value)  $default,){
final _that = this;
switch (_that) {
case _NearbyEarthquakeQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbyEarthquakeQuery value)?  $default,){
final _that = this;
switch (_that) {
case _NearbyEarthquakeQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String excludeEventId,  double latitude,  double longitude,  int? depth,  NearbyEarthquakeParameter parameter,  EarthquakeSortBy sortBy,  SortOrder sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbyEarthquakeQuery() when $default != null:
return $default(_that.excludeEventId,_that.latitude,_that.longitude,_that.depth,_that.parameter,_that.sortBy,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String excludeEventId,  double latitude,  double longitude,  int? depth,  NearbyEarthquakeParameter parameter,  EarthquakeSortBy sortBy,  SortOrder sortOrder)  $default,) {final _that = this;
switch (_that) {
case _NearbyEarthquakeQuery():
return $default(_that.excludeEventId,_that.latitude,_that.longitude,_that.depth,_that.parameter,_that.sortBy,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String excludeEventId,  double latitude,  double longitude,  int? depth,  NearbyEarthquakeParameter parameter,  EarthquakeSortBy sortBy,  SortOrder sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _NearbyEarthquakeQuery() when $default != null:
return $default(_that.excludeEventId,_that.latitude,_that.longitude,_that.depth,_that.parameter,_that.sortBy,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _NearbyEarthquakeQuery extends NearbyEarthquakeQuery {
  const _NearbyEarthquakeQuery({required this.excludeEventId, required this.latitude, required this.longitude, required this.depth, required this.parameter, required this.sortBy, required this.sortOrder}): super._();
  

@override final  String excludeEventId;
@override final  double latitude;
@override final  double longitude;
@override final  int? depth;
@override final  NearbyEarthquakeParameter parameter;
@override final  EarthquakeSortBy sortBy;
@override final  SortOrder sortOrder;

/// Create a copy of NearbyEarthquakeQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbyEarthquakeQueryCopyWith<_NearbyEarthquakeQuery> get copyWith => __$NearbyEarthquakeQueryCopyWithImpl<_NearbyEarthquakeQuery>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbyEarthquakeQuery&&(identical(other.excludeEventId, excludeEventId) || other.excludeEventId == excludeEventId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.parameter, parameter) || other.parameter == parameter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,excludeEventId,latitude,longitude,depth,parameter,sortBy,sortOrder);

@override
String toString() {
  return 'NearbyEarthquakeQuery(excludeEventId: $excludeEventId, latitude: $latitude, longitude: $longitude, depth: $depth, parameter: $parameter, sortBy: $sortBy, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$NearbyEarthquakeQueryCopyWith<$Res> implements $NearbyEarthquakeQueryCopyWith<$Res> {
  factory _$NearbyEarthquakeQueryCopyWith(_NearbyEarthquakeQuery value, $Res Function(_NearbyEarthquakeQuery) _then) = __$NearbyEarthquakeQueryCopyWithImpl;
@override @useResult
$Res call({
 String excludeEventId, double latitude, double longitude, int? depth, NearbyEarthquakeParameter parameter, EarthquakeSortBy sortBy, SortOrder sortOrder
});


@override $NearbyEarthquakeParameterCopyWith<$Res> get parameter;

}
/// @nodoc
class __$NearbyEarthquakeQueryCopyWithImpl<$Res>
    implements _$NearbyEarthquakeQueryCopyWith<$Res> {
  __$NearbyEarthquakeQueryCopyWithImpl(this._self, this._then);

  final _NearbyEarthquakeQuery _self;
  final $Res Function(_NearbyEarthquakeQuery) _then;

/// Create a copy of NearbyEarthquakeQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? excludeEventId = null,Object? latitude = null,Object? longitude = null,Object? depth = freezed,Object? parameter = null,Object? sortBy = null,Object? sortOrder = null,}) {
  return _then(_NearbyEarthquakeQuery(
excludeEventId: null == excludeEventId ? _self.excludeEventId : excludeEventId // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,parameter: null == parameter ? _self.parameter : parameter // ignore: cast_nullable_to_non_nullable
as NearbyEarthquakeParameter,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as EarthquakeSortBy,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,
  ));
}

/// Create a copy of NearbyEarthquakeQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NearbyEarthquakeParameterCopyWith<$Res> get parameter {
  
  return $NearbyEarthquakeParameterCopyWith<$Res>(_self.parameter, (value) {
    return _then(_self.copyWith(parameter: value));
  });
}
}

// dart format on

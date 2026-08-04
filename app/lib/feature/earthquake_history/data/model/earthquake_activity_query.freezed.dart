// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_activity_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeActivityQuery {

 String get baseEventId; DateTime get baseOriginTime; double get latitude; double get longitude; int? get depth; int get beforeDays; int get afterDays; int get radiusKm; int? get depthOffsetKm;
/// Create a copy of EarthquakeActivityQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeActivityQueryCopyWith<EarthquakeActivityQuery> get copyWith => _$EarthquakeActivityQueryCopyWithImpl<EarthquakeActivityQuery>(this as EarthquakeActivityQuery, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeActivityQuery&&(identical(other.baseEventId, baseEventId) || other.baseEventId == baseEventId)&&(identical(other.baseOriginTime, baseOriginTime) || other.baseOriginTime == baseOriginTime)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.beforeDays, beforeDays) || other.beforeDays == beforeDays)&&(identical(other.afterDays, afterDays) || other.afterDays == afterDays)&&(identical(other.radiusKm, radiusKm) || other.radiusKm == radiusKm)&&(identical(other.depthOffsetKm, depthOffsetKm) || other.depthOffsetKm == depthOffsetKm));
}


@override
int get hashCode => Object.hash(runtimeType,baseEventId,baseOriginTime,latitude,longitude,depth,beforeDays,afterDays,radiusKm,depthOffsetKm);

@override
String toString() {
  return 'EarthquakeActivityQuery(baseEventId: $baseEventId, baseOriginTime: $baseOriginTime, latitude: $latitude, longitude: $longitude, depth: $depth, beforeDays: $beforeDays, afterDays: $afterDays, radiusKm: $radiusKm, depthOffsetKm: $depthOffsetKm)';
}


}

/// @nodoc
abstract mixin class $EarthquakeActivityQueryCopyWith<$Res>  {
  factory $EarthquakeActivityQueryCopyWith(EarthquakeActivityQuery value, $Res Function(EarthquakeActivityQuery) _then) = _$EarthquakeActivityQueryCopyWithImpl;
@useResult
$Res call({
 String baseEventId, DateTime baseOriginTime, double latitude, double longitude, int? depth, int beforeDays, int afterDays, int radiusKm, int? depthOffsetKm
});




}
/// @nodoc
class _$EarthquakeActivityQueryCopyWithImpl<$Res>
    implements $EarthquakeActivityQueryCopyWith<$Res> {
  _$EarthquakeActivityQueryCopyWithImpl(this._self, this._then);

  final EarthquakeActivityQuery _self;
  final $Res Function(EarthquakeActivityQuery) _then;

/// Create a copy of EarthquakeActivityQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseEventId = null,Object? baseOriginTime = null,Object? latitude = null,Object? longitude = null,Object? depth = freezed,Object? beforeDays = null,Object? afterDays = null,Object? radiusKm = null,Object? depthOffsetKm = freezed,}) {
  return _then(_self.copyWith(
baseEventId: null == baseEventId ? _self.baseEventId : baseEventId // ignore: cast_nullable_to_non_nullable
as String,baseOriginTime: null == baseOriginTime ? _self.baseOriginTime : baseOriginTime // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,beforeDays: null == beforeDays ? _self.beforeDays : beforeDays // ignore: cast_nullable_to_non_nullable
as int,afterDays: null == afterDays ? _self.afterDays : afterDays // ignore: cast_nullable_to_non_nullable
as int,radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as int,depthOffsetKm: freezed == depthOffsetKm ? _self.depthOffsetKm : depthOffsetKm // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeActivityQuery].
extension EarthquakeActivityQueryPatterns on EarthquakeActivityQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeActivityQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeActivityQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeActivityQuery value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeActivityQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeActivityQuery value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeActivityQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String baseEventId,  DateTime baseOriginTime,  double latitude,  double longitude,  int? depth,  int beforeDays,  int afterDays,  int radiusKm,  int? depthOffsetKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeActivityQuery() when $default != null:
return $default(_that.baseEventId,_that.baseOriginTime,_that.latitude,_that.longitude,_that.depth,_that.beforeDays,_that.afterDays,_that.radiusKm,_that.depthOffsetKm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String baseEventId,  DateTime baseOriginTime,  double latitude,  double longitude,  int? depth,  int beforeDays,  int afterDays,  int radiusKm,  int? depthOffsetKm)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeActivityQuery():
return $default(_that.baseEventId,_that.baseOriginTime,_that.latitude,_that.longitude,_that.depth,_that.beforeDays,_that.afterDays,_that.radiusKm,_that.depthOffsetKm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String baseEventId,  DateTime baseOriginTime,  double latitude,  double longitude,  int? depth,  int beforeDays,  int afterDays,  int radiusKm,  int? depthOffsetKm)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeActivityQuery() when $default != null:
return $default(_that.baseEventId,_that.baseOriginTime,_that.latitude,_that.longitude,_that.depth,_that.beforeDays,_that.afterDays,_that.radiusKm,_that.depthOffsetKm);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeActivityQuery extends EarthquakeActivityQuery {
  const _EarthquakeActivityQuery({required this.baseEventId, required this.baseOriginTime, required this.latitude, required this.longitude, required this.depth, required this.beforeDays, required this.afterDays, required this.radiusKm, required this.depthOffsetKm}): super._();
  

@override final  String baseEventId;
@override final  DateTime baseOriginTime;
@override final  double latitude;
@override final  double longitude;
@override final  int? depth;
@override final  int beforeDays;
@override final  int afterDays;
@override final  int radiusKm;
@override final  int? depthOffsetKm;

/// Create a copy of EarthquakeActivityQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeActivityQueryCopyWith<_EarthquakeActivityQuery> get copyWith => __$EarthquakeActivityQueryCopyWithImpl<_EarthquakeActivityQuery>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeActivityQuery&&(identical(other.baseEventId, baseEventId) || other.baseEventId == baseEventId)&&(identical(other.baseOriginTime, baseOriginTime) || other.baseOriginTime == baseOriginTime)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.beforeDays, beforeDays) || other.beforeDays == beforeDays)&&(identical(other.afterDays, afterDays) || other.afterDays == afterDays)&&(identical(other.radiusKm, radiusKm) || other.radiusKm == radiusKm)&&(identical(other.depthOffsetKm, depthOffsetKm) || other.depthOffsetKm == depthOffsetKm));
}


@override
int get hashCode => Object.hash(runtimeType,baseEventId,baseOriginTime,latitude,longitude,depth,beforeDays,afterDays,radiusKm,depthOffsetKm);

@override
String toString() {
  return 'EarthquakeActivityQuery(baseEventId: $baseEventId, baseOriginTime: $baseOriginTime, latitude: $latitude, longitude: $longitude, depth: $depth, beforeDays: $beforeDays, afterDays: $afterDays, radiusKm: $radiusKm, depthOffsetKm: $depthOffsetKm)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeActivityQueryCopyWith<$Res> implements $EarthquakeActivityQueryCopyWith<$Res> {
  factory _$EarthquakeActivityQueryCopyWith(_EarthquakeActivityQuery value, $Res Function(_EarthquakeActivityQuery) _then) = __$EarthquakeActivityQueryCopyWithImpl;
@override @useResult
$Res call({
 String baseEventId, DateTime baseOriginTime, double latitude, double longitude, int? depth, int beforeDays, int afterDays, int radiusKm, int? depthOffsetKm
});




}
/// @nodoc
class __$EarthquakeActivityQueryCopyWithImpl<$Res>
    implements _$EarthquakeActivityQueryCopyWith<$Res> {
  __$EarthquakeActivityQueryCopyWithImpl(this._self, this._then);

  final _EarthquakeActivityQuery _self;
  final $Res Function(_EarthquakeActivityQuery) _then;

/// Create a copy of EarthquakeActivityQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseEventId = null,Object? baseOriginTime = null,Object? latitude = null,Object? longitude = null,Object? depth = freezed,Object? beforeDays = null,Object? afterDays = null,Object? radiusKm = null,Object? depthOffsetKm = freezed,}) {
  return _then(_EarthquakeActivityQuery(
baseEventId: null == baseEventId ? _self.baseEventId : baseEventId // ignore: cast_nullable_to_non_nullable
as String,baseOriginTime: null == baseOriginTime ? _self.baseOriginTime : baseOriginTime // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,beforeDays: null == beforeDays ? _self.beforeDays : beforeDays // ignore: cast_nullable_to_non_nullable
as int,afterDays: null == afterDays ? _self.afterDays : afterDays // ignore: cast_nullable_to_non_nullable
as int,radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as int,depthOffsetKm: freezed == depthOffsetKm ? _self.depthOffsetKm : depthOffsetKm // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on

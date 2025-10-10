// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_early.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeEarly {

 String get id; int? get depth; double? get latitude; double? get longitude; double? get magnitude; JmaForecastIntensity? get maxIntensity; bool get maxIntensityIsEarly; String get name; DateTime get originTime; OriginTimePrecision get originTimePrecision;
/// Create a copy of EarthquakeEarly
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeEarlyCopyWith<EarthquakeEarly> get copyWith => _$EarthquakeEarlyCopyWithImpl<EarthquakeEarly>(this as EarthquakeEarly, _$identity);

  /// Serializes this EarthquakeEarly to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeEarly&&(identical(other.id, id) || other.id == id)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxIntensityIsEarly, maxIntensityIsEarly) || other.maxIntensityIsEarly == maxIntensityIsEarly)&&(identical(other.name, name) || other.name == name)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,depth,latitude,longitude,magnitude,maxIntensity,maxIntensityIsEarly,name,originTime,originTimePrecision);

@override
String toString() {
  return 'EarthquakeEarly(id: $id, depth: $depth, latitude: $latitude, longitude: $longitude, magnitude: $magnitude, maxIntensity: $maxIntensity, maxIntensityIsEarly: $maxIntensityIsEarly, name: $name, originTime: $originTime, originTimePrecision: $originTimePrecision)';
}


}

/// @nodoc
abstract mixin class $EarthquakeEarlyCopyWith<$Res>  {
  factory $EarthquakeEarlyCopyWith(EarthquakeEarly value, $Res Function(EarthquakeEarly) _then) = _$EarthquakeEarlyCopyWithImpl;
@useResult
$Res call({
 String id, int? depth, double? latitude, double? longitude, double? magnitude, JmaForecastIntensity? maxIntensity, bool maxIntensityIsEarly, String name, DateTime originTime, OriginTimePrecision originTimePrecision
});




}
/// @nodoc
class _$EarthquakeEarlyCopyWithImpl<$Res>
    implements $EarthquakeEarlyCopyWith<$Res> {
  _$EarthquakeEarlyCopyWithImpl(this._self, this._then);

  final EarthquakeEarly _self;
  final $Res Function(EarthquakeEarly) _then;

/// Create a copy of EarthquakeEarly
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? depth = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? magnitude = freezed,Object? maxIntensity = freezed,Object? maxIntensityIsEarly = null,Object? name = null,Object? originTime = null,Object? originTimePrecision = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity?,maxIntensityIsEarly: null == maxIntensityIsEarly ? _self.maxIntensityIsEarly : maxIntensityIsEarly // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeEarly].
extension EarthquakeEarlyPatterns on EarthquakeEarly {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeEarly value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeEarly() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeEarly value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeEarly():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeEarly value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeEarly() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int? depth,  double? latitude,  double? longitude,  double? magnitude,  JmaForecastIntensity? maxIntensity,  bool maxIntensityIsEarly,  String name,  DateTime originTime,  OriginTimePrecision originTimePrecision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeEarly() when $default != null:
return $default(_that.id,_that.depth,_that.latitude,_that.longitude,_that.magnitude,_that.maxIntensity,_that.maxIntensityIsEarly,_that.name,_that.originTime,_that.originTimePrecision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int? depth,  double? latitude,  double? longitude,  double? magnitude,  JmaForecastIntensity? maxIntensity,  bool maxIntensityIsEarly,  String name,  DateTime originTime,  OriginTimePrecision originTimePrecision)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeEarly():
return $default(_that.id,_that.depth,_that.latitude,_that.longitude,_that.magnitude,_that.maxIntensity,_that.maxIntensityIsEarly,_that.name,_that.originTime,_that.originTimePrecision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int? depth,  double? latitude,  double? longitude,  double? magnitude,  JmaForecastIntensity? maxIntensity,  bool maxIntensityIsEarly,  String name,  DateTime originTime,  OriginTimePrecision originTimePrecision)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeEarly() when $default != null:
return $default(_that.id,_that.depth,_that.latitude,_that.longitude,_that.magnitude,_that.maxIntensity,_that.maxIntensityIsEarly,_that.name,_that.originTime,_that.originTimePrecision);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeEarly implements EarthquakeEarly {
  const _EarthquakeEarly({required this.id, required this.depth, required this.latitude, required this.longitude, required this.magnitude, required this.maxIntensity, required this.maxIntensityIsEarly, required this.name, required this.originTime, required this.originTimePrecision});
  factory _EarthquakeEarly.fromJson(Map<String, dynamic> json) => _$EarthquakeEarlyFromJson(json);

@override final  String id;
@override final  int? depth;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? magnitude;
@override final  JmaForecastIntensity? maxIntensity;
@override final  bool maxIntensityIsEarly;
@override final  String name;
@override final  DateTime originTime;
@override final  OriginTimePrecision originTimePrecision;

/// Create a copy of EarthquakeEarly
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeEarlyCopyWith<_EarthquakeEarly> get copyWith => __$EarthquakeEarlyCopyWithImpl<_EarthquakeEarly>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeEarlyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeEarly&&(identical(other.id, id) || other.id == id)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxIntensityIsEarly, maxIntensityIsEarly) || other.maxIntensityIsEarly == maxIntensityIsEarly)&&(identical(other.name, name) || other.name == name)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,depth,latitude,longitude,magnitude,maxIntensity,maxIntensityIsEarly,name,originTime,originTimePrecision);

@override
String toString() {
  return 'EarthquakeEarly(id: $id, depth: $depth, latitude: $latitude, longitude: $longitude, magnitude: $magnitude, maxIntensity: $maxIntensity, maxIntensityIsEarly: $maxIntensityIsEarly, name: $name, originTime: $originTime, originTimePrecision: $originTimePrecision)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeEarlyCopyWith<$Res> implements $EarthquakeEarlyCopyWith<$Res> {
  factory _$EarthquakeEarlyCopyWith(_EarthquakeEarly value, $Res Function(_EarthquakeEarly) _then) = __$EarthquakeEarlyCopyWithImpl;
@override @useResult
$Res call({
 String id, int? depth, double? latitude, double? longitude, double? magnitude, JmaForecastIntensity? maxIntensity, bool maxIntensityIsEarly, String name, DateTime originTime, OriginTimePrecision originTimePrecision
});




}
/// @nodoc
class __$EarthquakeEarlyCopyWithImpl<$Res>
    implements _$EarthquakeEarlyCopyWith<$Res> {
  __$EarthquakeEarlyCopyWithImpl(this._self, this._then);

  final _EarthquakeEarly _self;
  final $Res Function(_EarthquakeEarly) _then;

/// Create a copy of EarthquakeEarly
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? depth = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? magnitude = freezed,Object? maxIntensity = freezed,Object? maxIntensityIsEarly = null,Object? name = null,Object? originTime = null,Object? originTimePrecision = null,}) {
  return _then(_EarthquakeEarly(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity?,maxIntensityIsEarly: null == maxIntensityIsEarly ? _self.maxIntensityIsEarly : maxIntensityIsEarly // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,
  ));
}


}

// dart format on

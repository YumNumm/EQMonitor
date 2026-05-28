// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_shake_observation_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WsShakeObservationPoint {

 String get code; String get name; String get region; String get type; WsShakeObservationLocation get location; double get intensityDiff; double? get intensity;
/// Create a copy of WsShakeObservationPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsShakeObservationPointCopyWith<WsShakeObservationPoint> get copyWith => _$WsShakeObservationPointCopyWithImpl<WsShakeObservationPoint>(this as WsShakeObservationPoint, _$identity);

  /// Serializes this WsShakeObservationPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsShakeObservationPoint&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.intensityDiff, intensityDiff) || other.intensityDiff == intensityDiff)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,region,type,location,intensityDiff,intensity);

@override
String toString() {
  return 'WsShakeObservationPoint(code: $code, name: $name, region: $region, type: $type, location: $location, intensityDiff: $intensityDiff, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $WsShakeObservationPointCopyWith<$Res>  {
  factory $WsShakeObservationPointCopyWith(WsShakeObservationPoint value, $Res Function(WsShakeObservationPoint) _then) = _$WsShakeObservationPointCopyWithImpl;
@useResult
$Res call({
 String code, String name, String region, String type, WsShakeObservationLocation location, double intensityDiff, double? intensity
});


$WsShakeObservationLocationCopyWith<$Res> get location;

}
/// @nodoc
class _$WsShakeObservationPointCopyWithImpl<$Res>
    implements $WsShakeObservationPointCopyWith<$Res> {
  _$WsShakeObservationPointCopyWithImpl(this._self, this._then);

  final WsShakeObservationPoint _self;
  final $Res Function(WsShakeObservationPoint) _then;

/// Create a copy of WsShakeObservationPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? region = null,Object? type = null,Object? location = null,Object? intensityDiff = null,Object? intensity = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as WsShakeObservationLocation,intensityDiff: null == intensityDiff ? _self.intensityDiff : intensityDiff // ignore: cast_nullable_to_non_nullable
as double,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of WsShakeObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeObservationLocationCopyWith<$Res> get location {
  
  return $WsShakeObservationLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [WsShakeObservationPoint].
extension WsShakeObservationPointPatterns on WsShakeObservationPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsShakeObservationPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsShakeObservationPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsShakeObservationPoint value)  $default,){
final _that = this;
switch (_that) {
case _WsShakeObservationPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsShakeObservationPoint value)?  $default,){
final _that = this;
switch (_that) {
case _WsShakeObservationPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String region,  String type,  WsShakeObservationLocation location,  double intensityDiff,  double? intensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsShakeObservationPoint() when $default != null:
return $default(_that.code,_that.name,_that.region,_that.type,_that.location,_that.intensityDiff,_that.intensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String region,  String type,  WsShakeObservationLocation location,  double intensityDiff,  double? intensity)  $default,) {final _that = this;
switch (_that) {
case _WsShakeObservationPoint():
return $default(_that.code,_that.name,_that.region,_that.type,_that.location,_that.intensityDiff,_that.intensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String region,  String type,  WsShakeObservationLocation location,  double intensityDiff,  double? intensity)?  $default,) {final _that = this;
switch (_that) {
case _WsShakeObservationPoint() when $default != null:
return $default(_that.code,_that.name,_that.region,_that.type,_that.location,_that.intensityDiff,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsShakeObservationPoint implements WsShakeObservationPoint {
  const _WsShakeObservationPoint({required this.code, required this.name, required this.region, required this.type, required this.location, required this.intensityDiff, this.intensity});
  factory _WsShakeObservationPoint.fromJson(Map<String, dynamic> json) => _$WsShakeObservationPointFromJson(json);

@override final  String code;
@override final  String name;
@override final  String region;
@override final  String type;
@override final  WsShakeObservationLocation location;
@override final  double intensityDiff;
@override final  double? intensity;

/// Create a copy of WsShakeObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsShakeObservationPointCopyWith<_WsShakeObservationPoint> get copyWith => __$WsShakeObservationPointCopyWithImpl<_WsShakeObservationPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsShakeObservationPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsShakeObservationPoint&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.intensityDiff, intensityDiff) || other.intensityDiff == intensityDiff)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,region,type,location,intensityDiff,intensity);

@override
String toString() {
  return 'WsShakeObservationPoint(code: $code, name: $name, region: $region, type: $type, location: $location, intensityDiff: $intensityDiff, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$WsShakeObservationPointCopyWith<$Res> implements $WsShakeObservationPointCopyWith<$Res> {
  factory _$WsShakeObservationPointCopyWith(_WsShakeObservationPoint value, $Res Function(_WsShakeObservationPoint) _then) = __$WsShakeObservationPointCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String region, String type, WsShakeObservationLocation location, double intensityDiff, double? intensity
});


@override $WsShakeObservationLocationCopyWith<$Res> get location;

}
/// @nodoc
class __$WsShakeObservationPointCopyWithImpl<$Res>
    implements _$WsShakeObservationPointCopyWith<$Res> {
  __$WsShakeObservationPointCopyWithImpl(this._self, this._then);

  final _WsShakeObservationPoint _self;
  final $Res Function(_WsShakeObservationPoint) _then;

/// Create a copy of WsShakeObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? region = null,Object? type = null,Object? location = null,Object? intensityDiff = null,Object? intensity = freezed,}) {
  return _then(_WsShakeObservationPoint(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as WsShakeObservationLocation,intensityDiff: null == intensityDiff ? _self.intensityDiff : intensityDiff // ignore: cast_nullable_to_non_nullable
as double,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of WsShakeObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsShakeObservationLocationCopyWith<$Res> get location {
  
  return $WsShakeObservationLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$WsShakeObservationLocation {

 double get latitude; double get longitude;
/// Create a copy of WsShakeObservationLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsShakeObservationLocationCopyWith<WsShakeObservationLocation> get copyWith => _$WsShakeObservationLocationCopyWithImpl<WsShakeObservationLocation>(this as WsShakeObservationLocation, _$identity);

  /// Serializes this WsShakeObservationLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsShakeObservationLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'WsShakeObservationLocation(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $WsShakeObservationLocationCopyWith<$Res>  {
  factory $WsShakeObservationLocationCopyWith(WsShakeObservationLocation value, $Res Function(WsShakeObservationLocation) _then) = _$WsShakeObservationLocationCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$WsShakeObservationLocationCopyWithImpl<$Res>
    implements $WsShakeObservationLocationCopyWith<$Res> {
  _$WsShakeObservationLocationCopyWithImpl(this._self, this._then);

  final WsShakeObservationLocation _self;
  final $Res Function(WsShakeObservationLocation) _then;

/// Create a copy of WsShakeObservationLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WsShakeObservationLocation].
extension WsShakeObservationLocationPatterns on WsShakeObservationLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsShakeObservationLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsShakeObservationLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsShakeObservationLocation value)  $default,){
final _that = this;
switch (_that) {
case _WsShakeObservationLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsShakeObservationLocation value)?  $default,){
final _that = this;
switch (_that) {
case _WsShakeObservationLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsShakeObservationLocation() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude)  $default,) {final _that = this;
switch (_that) {
case _WsShakeObservationLocation():
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude)?  $default,) {final _that = this;
switch (_that) {
case _WsShakeObservationLocation() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsShakeObservationLocation implements WsShakeObservationLocation {
  const _WsShakeObservationLocation({required this.latitude, required this.longitude});
  factory _WsShakeObservationLocation.fromJson(Map<String, dynamic> json) => _$WsShakeObservationLocationFromJson(json);

@override final  double latitude;
@override final  double longitude;

/// Create a copy of WsShakeObservationLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsShakeObservationLocationCopyWith<_WsShakeObservationLocation> get copyWith => __$WsShakeObservationLocationCopyWithImpl<_WsShakeObservationLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsShakeObservationLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsShakeObservationLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'WsShakeObservationLocation(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$WsShakeObservationLocationCopyWith<$Res> implements $WsShakeObservationLocationCopyWith<$Res> {
  factory _$WsShakeObservationLocationCopyWith(_WsShakeObservationLocation value, $Res Function(_WsShakeObservationLocation) _then) = __$WsShakeObservationLocationCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class __$WsShakeObservationLocationCopyWithImpl<$Res>
    implements _$WsShakeObservationLocationCopyWith<$Res> {
  __$WsShakeObservationLocationCopyWithImpl(this._self, this._then);

  final _WsShakeObservationLocation _self;
  final $Res Function(_WsShakeObservationLocation) _then;

/// Create a copy of WsShakeObservationLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_WsShakeObservationLocation(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

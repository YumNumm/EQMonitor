// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_camera.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapCamera {

 double get centerLongitude; double get centerLatitude; double get zoom;
/// Create a copy of MapCamera
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapCameraCopyWith<MapCamera> get copyWith => _$MapCameraCopyWithImpl<MapCamera>(this as MapCamera, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapCamera&&(identical(other.centerLongitude, centerLongitude) || other.centerLongitude == centerLongitude)&&(identical(other.centerLatitude, centerLatitude) || other.centerLatitude == centerLatitude)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}


@override
int get hashCode => Object.hash(runtimeType,centerLongitude,centerLatitude,zoom);

@override
String toString() {
  return 'MapCamera(centerLongitude: $centerLongitude, centerLatitude: $centerLatitude, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class $MapCameraCopyWith<$Res>  {
  factory $MapCameraCopyWith(MapCamera value, $Res Function(MapCamera) _then) = _$MapCameraCopyWithImpl;
@useResult
$Res call({
 double centerLongitude, double centerLatitude, double zoom
});




}
/// @nodoc
class _$MapCameraCopyWithImpl<$Res>
    implements $MapCameraCopyWith<$Res> {
  _$MapCameraCopyWithImpl(this._self, this._then);

  final MapCamera _self;
  final $Res Function(MapCamera) _then;

/// Create a copy of MapCamera
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? centerLongitude = null,Object? centerLatitude = null,Object? zoom = null,}) {
  return _then(_self.copyWith(
centerLongitude: null == centerLongitude ? _self.centerLongitude : centerLongitude // ignore: cast_nullable_to_non_nullable
as double,centerLatitude: null == centerLatitude ? _self.centerLatitude : centerLatitude // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MapCamera].
extension MapCameraPatterns on MapCamera {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapCamera value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapCamera() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapCamera value)  $default,){
final _that = this;
switch (_that) {
case _MapCamera():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapCamera value)?  $default,){
final _that = this;
switch (_that) {
case _MapCamera() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double centerLongitude,  double centerLatitude,  double zoom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapCamera() when $default != null:
return $default(_that.centerLongitude,_that.centerLatitude,_that.zoom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double centerLongitude,  double centerLatitude,  double zoom)  $default,) {final _that = this;
switch (_that) {
case _MapCamera():
return $default(_that.centerLongitude,_that.centerLatitude,_that.zoom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double centerLongitude,  double centerLatitude,  double zoom)?  $default,) {final _that = this;
switch (_that) {
case _MapCamera() when $default != null:
return $default(_that.centerLongitude,_that.centerLatitude,_that.zoom);case _:
  return null;

}
}

}

/// @nodoc


class _MapCamera extends MapCamera {
  const _MapCamera({required this.centerLongitude, required this.centerLatitude, required this.zoom}): super._();
  

@override final  double centerLongitude;
@override final  double centerLatitude;
@override final  double zoom;

/// Create a copy of MapCamera
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapCameraCopyWith<_MapCamera> get copyWith => __$MapCameraCopyWithImpl<_MapCamera>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapCamera&&(identical(other.centerLongitude, centerLongitude) || other.centerLongitude == centerLongitude)&&(identical(other.centerLatitude, centerLatitude) || other.centerLatitude == centerLatitude)&&(identical(other.zoom, zoom) || other.zoom == zoom));
}


@override
int get hashCode => Object.hash(runtimeType,centerLongitude,centerLatitude,zoom);

@override
String toString() {
  return 'MapCamera(centerLongitude: $centerLongitude, centerLatitude: $centerLatitude, zoom: $zoom)';
}


}

/// @nodoc
abstract mixin class _$MapCameraCopyWith<$Res> implements $MapCameraCopyWith<$Res> {
  factory _$MapCameraCopyWith(_MapCamera value, $Res Function(_MapCamera) _then) = __$MapCameraCopyWithImpl;
@override @useResult
$Res call({
 double centerLongitude, double centerLatitude, double zoom
});




}
/// @nodoc
class __$MapCameraCopyWithImpl<$Res>
    implements _$MapCameraCopyWith<$Res> {
  __$MapCameraCopyWithImpl(this._self, this._then);

  final _MapCamera _self;
  final $Res Function(_MapCamera) _then;

/// Create a copy of MapCamera
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? centerLongitude = null,Object? centerLatitude = null,Object? zoom = null,}) {
  return _then(_MapCamera(
centerLongitude: null == centerLongitude ? _self.centerLongitude : centerLongitude // ignore: cast_nullable_to_non_nullable
as double,centerLatitude: null == centerLatitude ? _self.centerLatitude : centerLatitude // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

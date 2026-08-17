// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_camera_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapCameraState {

 Geographic get center; double get zoom; double get bearing; double get pitch; bool get isAtHome;
/// Create a copy of MapCameraState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapCameraStateCopyWith<MapCameraState> get copyWith => _$MapCameraStateCopyWithImpl<MapCameraState>(this as MapCameraState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapCameraState&&(identical(other.center, center) || other.center == center)&&(identical(other.zoom, zoom) || other.zoom == zoom)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.pitch, pitch) || other.pitch == pitch)&&(identical(other.isAtHome, isAtHome) || other.isAtHome == isAtHome));
}


@override
int get hashCode => Object.hash(runtimeType,center,zoom,bearing,pitch,isAtHome);

@override
String toString() {
  return 'MapCameraState(center: $center, zoom: $zoom, bearing: $bearing, pitch: $pitch, isAtHome: $isAtHome)';
}


}

/// @nodoc
abstract mixin class $MapCameraStateCopyWith<$Res>  {
  factory $MapCameraStateCopyWith(MapCameraState value, $Res Function(MapCameraState) _then) = _$MapCameraStateCopyWithImpl;
@useResult
$Res call({
 Geographic center, double zoom, double bearing, double pitch, bool isAtHome
});




}
/// @nodoc
class _$MapCameraStateCopyWithImpl<$Res>
    implements $MapCameraStateCopyWith<$Res> {
  _$MapCameraStateCopyWithImpl(this._self, this._then);

  final MapCameraState _self;
  final $Res Function(MapCameraState) _then;

/// Create a copy of MapCameraState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? center = null,Object? zoom = null,Object? bearing = null,Object? pitch = null,Object? isAtHome = null,}) {
  return _then(MapCameraState(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Geographic,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,bearing: null == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double,pitch: null == pitch ? _self.pitch : pitch // ignore: cast_nullable_to_non_nullable
as double,isAtHome: null == isAtHome ? _self.isAtHome : isAtHome // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MapCameraState].
extension MapCameraStatePatterns on MapCameraState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapCameraState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapCameraState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapCameraState value)  $default,){
final _that = this;
switch (_that) {
case _MapCameraState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapCameraState value)?  $default,){
final _that = this;
switch (_that) {
case _MapCameraState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Geographic center,  double zoom,  double bearing,  double pitch,  bool isAtHome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapCameraState() when $default != null:
return $default(_that.center,_that.zoom,_that.bearing,_that.pitch,_that.isAtHome);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Geographic center,  double zoom,  double bearing,  double pitch,  bool isAtHome)  $default,) {final _that = this;
switch (_that) {
case _MapCameraState():
return $default(_that.center,_that.zoom,_that.bearing,_that.pitch,_that.isAtHome);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Geographic center,  double zoom,  double bearing,  double pitch,  bool isAtHome)?  $default,) {final _that = this;
switch (_that) {
case _MapCameraState() when $default != null:
return $default(_that.center,_that.zoom,_that.bearing,_that.pitch,_that.isAtHome);case _:
  return null;

}
}

}

/// @nodoc


class _MapCameraState implements MapCameraState {
  const _MapCameraState({required this.center, required this.zoom, this.bearing = 0.0, this.pitch = 0.0, this.isAtHome = true});
  

@override final  Geographic center;
@override final  double zoom;
@override@JsonKey() final  double bearing;
@override@JsonKey() final  double pitch;
@override@JsonKey() final  bool isAtHome;

/// Create a copy of MapCameraState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapCameraStateCopyWith<_MapCameraState> get copyWith => __$MapCameraStateCopyWithImpl<_MapCameraState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapCameraState&&(identical(other.center, center) || other.center == center)&&(identical(other.zoom, zoom) || other.zoom == zoom)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.pitch, pitch) || other.pitch == pitch)&&(identical(other.isAtHome, isAtHome) || other.isAtHome == isAtHome));
}


@override
int get hashCode => Object.hash(runtimeType,center,zoom,bearing,pitch,isAtHome);

@override
String toString() {
  return 'MapCameraState(center: $center, zoom: $zoom, bearing: $bearing, pitch: $pitch, isAtHome: $isAtHome)';
}


}

/// @nodoc
abstract mixin class _$MapCameraStateCopyWith<$Res> implements $MapCameraStateCopyWith<$Res> {
  factory _$MapCameraStateCopyWith(_MapCameraState value, $Res Function(_MapCameraState) _then) = __$MapCameraStateCopyWithImpl;
@override @useResult
$Res call({
 Geographic center, double zoom, double bearing, double pitch, bool isAtHome
});




}
/// @nodoc
class __$MapCameraStateCopyWithImpl<$Res>
    implements _$MapCameraStateCopyWith<$Res> {
  __$MapCameraStateCopyWithImpl(this._self, this._then);

  final _MapCameraState _self;
  final $Res Function(_MapCameraState) _then;

/// Create a copy of MapCameraState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? center = null,Object? zoom = null,Object? bearing = null,Object? pitch = null,Object? isAtHome = null,}) {
  return _then(_MapCameraState(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Geographic,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,bearing: null == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double,pitch: null == pitch ? _self.pitch : pitch // ignore: cast_nullable_to_non_nullable
as double,isAtHome: null == isAtHome ? _self.isAtHome : isAtHome // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

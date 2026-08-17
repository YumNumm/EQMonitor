// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_earthquake_hypocenter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiEarthquakeHypocenter {

 MagnitudeType get magnitudeType; num? get magnitudeValue; DepthType get depthType; num? get depthValue; String? get name; double? get latitude; double? get longitude;
/// Create a copy of TsunamiEarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiEarthquakeHypocenterCopyWith<TsunamiEarthquakeHypocenter> get copyWith => _$TsunamiEarthquakeHypocenterCopyWithImpl<TsunamiEarthquakeHypocenter>(this as TsunamiEarthquakeHypocenter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiEarthquakeHypocenter&&(identical(other.magnitudeType, magnitudeType) || other.magnitudeType == magnitudeType)&&(identical(other.magnitudeValue, magnitudeValue) || other.magnitudeValue == magnitudeValue)&&(identical(other.depthType, depthType) || other.depthType == depthType)&&(identical(other.depthValue, depthValue) || other.depthValue == depthValue)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,magnitudeType,magnitudeValue,depthType,depthValue,name,latitude,longitude);

@override
String toString() {
  return 'TsunamiEarthquakeHypocenter(magnitudeType: $magnitudeType, magnitudeValue: $magnitudeValue, depthType: $depthType, depthValue: $depthValue, name: $name, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $TsunamiEarthquakeHypocenterCopyWith<$Res>  {
  factory $TsunamiEarthquakeHypocenterCopyWith(TsunamiEarthquakeHypocenter value, $Res Function(TsunamiEarthquakeHypocenter) _then) = _$TsunamiEarthquakeHypocenterCopyWithImpl;
@useResult
$Res call({
 MagnitudeType magnitudeType, num? magnitudeValue, DepthType depthType, num? depthValue, String? name, double? latitude, double? longitude
});




}
/// @nodoc
class _$TsunamiEarthquakeHypocenterCopyWithImpl<$Res>
    implements $TsunamiEarthquakeHypocenterCopyWith<$Res> {
  _$TsunamiEarthquakeHypocenterCopyWithImpl(this._self, this._then);

  final TsunamiEarthquakeHypocenter _self;
  final $Res Function(TsunamiEarthquakeHypocenter) _then;

/// Create a copy of TsunamiEarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? magnitudeType = null,Object? magnitudeValue = freezed,Object? depthType = null,Object? depthValue = freezed,Object? name = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(TsunamiEarthquakeHypocenter(
magnitudeType: null == magnitudeType ? _self.magnitudeType : magnitudeType // ignore: cast_nullable_to_non_nullable
as MagnitudeType,magnitudeValue: freezed == magnitudeValue ? _self.magnitudeValue : magnitudeValue // ignore: cast_nullable_to_non_nullable
as num?,depthType: null == depthType ? _self.depthType : depthType // ignore: cast_nullable_to_non_nullable
as DepthType,depthValue: freezed == depthValue ? _self.depthValue : depthValue // ignore: cast_nullable_to_non_nullable
as num?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiEarthquakeHypocenter].
extension TsunamiEarthquakeHypocenterPatterns on TsunamiEarthquakeHypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiEarthquakeHypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiEarthquakeHypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiEarthquakeHypocenter value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiEarthquakeHypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiEarthquakeHypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiEarthquakeHypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MagnitudeType magnitudeType,  num? magnitudeValue,  DepthType depthType,  num? depthValue,  String? name,  double? latitude,  double? longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiEarthquakeHypocenter() when $default != null:
return $default(_that.magnitudeType,_that.magnitudeValue,_that.depthType,_that.depthValue,_that.name,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MagnitudeType magnitudeType,  num? magnitudeValue,  DepthType depthType,  num? depthValue,  String? name,  double? latitude,  double? longitude)  $default,) {final _that = this;
switch (_that) {
case _TsunamiEarthquakeHypocenter():
return $default(_that.magnitudeType,_that.magnitudeValue,_that.depthType,_that.depthValue,_that.name,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MagnitudeType magnitudeType,  num? magnitudeValue,  DepthType depthType,  num? depthValue,  String? name,  double? latitude,  double? longitude)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiEarthquakeHypocenter() when $default != null:
return $default(_that.magnitudeType,_that.magnitudeValue,_that.depthType,_that.depthValue,_that.name,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiEarthquakeHypocenter implements TsunamiEarthquakeHypocenter {
  const _TsunamiEarthquakeHypocenter({required this.magnitudeType, this.magnitudeValue, required this.depthType, this.depthValue, this.name, this.latitude, this.longitude});
  

@override final  MagnitudeType magnitudeType;
@override final  num? magnitudeValue;
@override final  DepthType depthType;
@override final  num? depthValue;
@override final  String? name;
@override final  double? latitude;
@override final  double? longitude;

/// Create a copy of TsunamiEarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiEarthquakeHypocenterCopyWith<_TsunamiEarthquakeHypocenter> get copyWith => __$TsunamiEarthquakeHypocenterCopyWithImpl<_TsunamiEarthquakeHypocenter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiEarthquakeHypocenter&&(identical(other.magnitudeType, magnitudeType) || other.magnitudeType == magnitudeType)&&(identical(other.magnitudeValue, magnitudeValue) || other.magnitudeValue == magnitudeValue)&&(identical(other.depthType, depthType) || other.depthType == depthType)&&(identical(other.depthValue, depthValue) || other.depthValue == depthValue)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,magnitudeType,magnitudeValue,depthType,depthValue,name,latitude,longitude);

@override
String toString() {
  return 'TsunamiEarthquakeHypocenter(magnitudeType: $magnitudeType, magnitudeValue: $magnitudeValue, depthType: $depthType, depthValue: $depthValue, name: $name, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$TsunamiEarthquakeHypocenterCopyWith<$Res> implements $TsunamiEarthquakeHypocenterCopyWith<$Res> {
  factory _$TsunamiEarthquakeHypocenterCopyWith(_TsunamiEarthquakeHypocenter value, $Res Function(_TsunamiEarthquakeHypocenter) _then) = __$TsunamiEarthquakeHypocenterCopyWithImpl;
@override @useResult
$Res call({
 MagnitudeType magnitudeType, num? magnitudeValue, DepthType depthType, num? depthValue, String? name, double? latitude, double? longitude
});




}
/// @nodoc
class __$TsunamiEarthquakeHypocenterCopyWithImpl<$Res>
    implements _$TsunamiEarthquakeHypocenterCopyWith<$Res> {
  __$TsunamiEarthquakeHypocenterCopyWithImpl(this._self, this._then);

  final _TsunamiEarthquakeHypocenter _self;
  final $Res Function(_TsunamiEarthquakeHypocenter) _then;

/// Create a copy of TsunamiEarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? magnitudeType = null,Object? magnitudeValue = freezed,Object? depthType = null,Object? depthValue = freezed,Object? name = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_TsunamiEarthquakeHypocenter(
magnitudeType: null == magnitudeType ? _self.magnitudeType : magnitudeType // ignore: cast_nullable_to_non_nullable
as MagnitudeType,magnitudeValue: freezed == magnitudeValue ? _self.magnitudeValue : magnitudeValue // ignore: cast_nullable_to_non_nullable
as num?,depthType: null == depthType ? _self.depthType : depthType // ignore: cast_nullable_to_non_nullable
as DepthType,depthValue: freezed == depthValue ? _self.depthValue : depthValue // ignore: cast_nullable_to_non_nullable
as num?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on

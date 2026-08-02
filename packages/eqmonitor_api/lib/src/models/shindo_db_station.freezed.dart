// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shindo_db_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShindoDbStation {

 String get code; String get name; num get latitude; num get longitude;@JsonKey(includeIfNull: true, name: 'city_code') String? get cityCode;
/// Create a copy of ShindoDbStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShindoDbStationCopyWith<ShindoDbStation> get copyWith => _$ShindoDbStationCopyWithImpl<ShindoDbStation>(this as ShindoDbStation, _$identity);

  /// Serializes this ShindoDbStation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShindoDbStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,latitude,longitude,cityCode);

@override
String toString() {
  return 'ShindoDbStation(code: $code, name: $name, latitude: $latitude, longitude: $longitude, cityCode: $cityCode)';
}


}

/// @nodoc
abstract mixin class $ShindoDbStationCopyWith<$Res>  {
  factory $ShindoDbStationCopyWith(ShindoDbStation value, $Res Function(ShindoDbStation) _then) = _$ShindoDbStationCopyWithImpl;
@useResult
$Res call({
 String code, String name, num latitude, num longitude,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode
});




}
/// @nodoc
class _$ShindoDbStationCopyWithImpl<$Res>
    implements $ShindoDbStationCopyWith<$Res> {
  _$ShindoDbStationCopyWithImpl(this._self, this._then);

  final ShindoDbStation _self;
  final $Res Function(ShindoDbStation) _then;

/// Create a copy of ShindoDbStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? latitude = null,Object? longitude = null,Object? cityCode = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShindoDbStation].
extension ShindoDbStationPatterns on ShindoDbStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShindoDbStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShindoDbStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShindoDbStation value)  $default,){
final _that = this;
switch (_that) {
case _ShindoDbStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShindoDbStation value)?  $default,){
final _that = this;
switch (_that) {
case _ShindoDbStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  num latitude,  num longitude, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShindoDbStation() when $default != null:
return $default(_that.code,_that.name,_that.latitude,_that.longitude,_that.cityCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  num latitude,  num longitude, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode)  $default,) {final _that = this;
switch (_that) {
case _ShindoDbStation():
return $default(_that.code,_that.name,_that.latitude,_that.longitude,_that.cityCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  num latitude,  num longitude, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode)?  $default,) {final _that = this;
switch (_that) {
case _ShindoDbStation() when $default != null:
return $default(_that.code,_that.name,_that.latitude,_that.longitude,_that.cityCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShindoDbStation implements ShindoDbStation {
  const _ShindoDbStation({required this.code, required this.name, required this.latitude, required this.longitude, @JsonKey(includeIfNull: true, name: 'city_code') required this.cityCode});
  factory _ShindoDbStation.fromJson(Map<String, dynamic> json) => _$ShindoDbStationFromJson(json);

@override final  String code;
@override final  String name;
@override final  num latitude;
@override final  num longitude;
@override@JsonKey(includeIfNull: true, name: 'city_code') final  String? cityCode;

/// Create a copy of ShindoDbStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShindoDbStationCopyWith<_ShindoDbStation> get copyWith => __$ShindoDbStationCopyWithImpl<_ShindoDbStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShindoDbStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShindoDbStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,latitude,longitude,cityCode);

@override
String toString() {
  return 'ShindoDbStation(code: $code, name: $name, latitude: $latitude, longitude: $longitude, cityCode: $cityCode)';
}


}

/// @nodoc
abstract mixin class _$ShindoDbStationCopyWith<$Res> implements $ShindoDbStationCopyWith<$Res> {
  factory _$ShindoDbStationCopyWith(_ShindoDbStation value, $Res Function(_ShindoDbStation) _then) = __$ShindoDbStationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, num latitude, num longitude,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode
});




}
/// @nodoc
class __$ShindoDbStationCopyWithImpl<$Res>
    implements _$ShindoDbStationCopyWith<$Res> {
  __$ShindoDbStationCopyWithImpl(this._self, this._then);

  final _ShindoDbStation _self;
  final $Res Function(_ShindoDbStation) _then;

/// Create a copy of ShindoDbStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? latitude = null,Object? longitude = null,Object? cityCode = freezed,}) {
  return _then(_ShindoDbStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

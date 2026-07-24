// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Points2 {

 String get code; String get name; String get region; String get type; Location2 get location;@JsonKey(includeIfNull: true) num? get intensity; num get intensityDiff;
/// Create a copy of Points2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Points2CopyWith<Points2> get copyWith => _$Points2CopyWithImpl<Points2>(this as Points2, _$identity);

  /// Serializes this Points2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Points2&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.intensityDiff, intensityDiff) || other.intensityDiff == intensityDiff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,region,type,location,intensity,intensityDiff);

@override
String toString() {
  return 'Points2(code: $code, name: $name, region: $region, type: $type, location: $location, intensity: $intensity, intensityDiff: $intensityDiff)';
}


}

/// @nodoc
abstract mixin class $Points2CopyWith<$Res>  {
  factory $Points2CopyWith(Points2 value, $Res Function(Points2) _then) = _$Points2CopyWithImpl;
@useResult
$Res call({
 String code, String name, String region, String type, Location2 location,@JsonKey(includeIfNull: true) num? intensity, num intensityDiff
});


$Location2CopyWith<$Res> get location;

}
/// @nodoc
class _$Points2CopyWithImpl<$Res>
    implements $Points2CopyWith<$Res> {
  _$Points2CopyWithImpl(this._self, this._then);

  final Points2 _self;
  final $Res Function(Points2) _then;

/// Create a copy of Points2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? region = null,Object? type = null,Object? location = null,Object? intensity = freezed,Object? intensityDiff = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Location2,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as num?,intensityDiff: null == intensityDiff ? _self.intensityDiff : intensityDiff // ignore: cast_nullable_to_non_nullable
as num,
  ));
}
/// Create a copy of Points2
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Location2CopyWith<$Res> get location {

  return $Location2CopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [Points2].
extension Points2Patterns on Points2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Points2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Points2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Points2 value)  $default,){
final _that = this;
switch (_that) {
case _Points2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Points2 value)?  $default,){
final _that = this;
switch (_that) {
case _Points2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String region,  String type,  Location2 location, @JsonKey(includeIfNull: true)  num? intensity,  num intensityDiff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Points2() when $default != null:
return $default(_that.code,_that.name,_that.region,_that.type,_that.location,_that.intensity,_that.intensityDiff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String region,  String type,  Location2 location, @JsonKey(includeIfNull: true)  num? intensity,  num intensityDiff)  $default,) {final _that = this;
switch (_that) {
case _Points2():
return $default(_that.code,_that.name,_that.region,_that.type,_that.location,_that.intensity,_that.intensityDiff);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String region,  String type,  Location2 location, @JsonKey(includeIfNull: true)  num? intensity,  num intensityDiff)?  $default,) {final _that = this;
switch (_that) {
case _Points2() when $default != null:
return $default(_that.code,_that.name,_that.region,_that.type,_that.location,_that.intensity,_that.intensityDiff);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Points2 implements Points2 {
  const _Points2({required this.code, required this.name, required this.region, required this.type, required this.location, @JsonKey(includeIfNull: true) required this.intensity, this.intensityDiff = 0});
  factory _Points2.fromJson(Map<String, dynamic> json) => _$Points2FromJson(json);

@override final  String code;
@override final  String name;
@override final  String region;
@override final  String type;
@override final  Location2 location;
@override@JsonKey(includeIfNull: true) final  num? intensity;
@override@JsonKey() final  num intensityDiff;

/// Create a copy of Points2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Points2CopyWith<_Points2> get copyWith => __$Points2CopyWithImpl<_Points2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Points2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Points2&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.intensityDiff, intensityDiff) || other.intensityDiff == intensityDiff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,region,type,location,intensity,intensityDiff);

@override
String toString() {
  return 'Points2(code: $code, name: $name, region: $region, type: $type, location: $location, intensity: $intensity, intensityDiff: $intensityDiff)';
}


}

/// @nodoc
abstract mixin class _$Points2CopyWith<$Res> implements $Points2CopyWith<$Res> {
  factory _$Points2CopyWith(_Points2 value, $Res Function(_Points2) _then) = __$Points2CopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String region, String type, Location2 location,@JsonKey(includeIfNull: true) num? intensity, num intensityDiff
});


@override $Location2CopyWith<$Res> get location;

}
/// @nodoc
class __$Points2CopyWithImpl<$Res>
    implements _$Points2CopyWith<$Res> {
  __$Points2CopyWithImpl(this._self, this._then);

  final _Points2 _self;
  final $Res Function(_Points2) _then;

/// Create a copy of Points2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? region = null,Object? type = null,Object? location = null,Object? intensity = freezed,Object? intensityDiff = null,}) {
  return _then(_Points2(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Location2,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as num?,intensityDiff: null == intensityDiff ? _self.intensityDiff : intensityDiff // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

/// Create a copy of Points2
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Location2CopyWith<$Res> get location {

  return $Location2CopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on

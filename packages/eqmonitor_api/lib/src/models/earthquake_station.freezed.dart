// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeStation {

 String get code;@JsonKey(name: 'no_code') String get noCode; LocalizedName get name;@JsonKey(includeIfNull: true) String? get kana; EarthquakeStationStatus get status;@JsonKey(name: 'source_status') String get sourceStatus; String get owner; ParameterLocation get location;@JsonKey(includeIfNull: true, name: 'arv_400') num? get arv400;
/// Create a copy of EarthquakeStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeStationCopyWith<EarthquakeStation> get copyWith => _$EarthquakeStationCopyWithImpl<EarthquakeStation>(this as EarthquakeStation, _$identity);

  /// Serializes this EarthquakeStation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeStation&&(identical(other.code, code) || other.code == code)&&(identical(other.noCode, noCode) || other.noCode == noCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.status, status) || other.status == status)&&(identical(other.sourceStatus, sourceStatus) || other.sourceStatus == sourceStatus)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.location, location) || other.location == location)&&(identical(other.arv400, arv400) || other.arv400 == arv400));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,noCode,name,kana,status,sourceStatus,owner,location,arv400);

@override
String toString() {
  return 'EarthquakeStation(code: $code, noCode: $noCode, name: $name, kana: $kana, status: $status, sourceStatus: $sourceStatus, owner: $owner, location: $location, arv400: $arv400)';
}


}

/// @nodoc
abstract mixin class $EarthquakeStationCopyWith<$Res>  {
  factory $EarthquakeStationCopyWith(EarthquakeStation value, $Res Function(EarthquakeStation) _then) = _$EarthquakeStationCopyWithImpl;
@useResult
$Res call({
 String code,@JsonKey(name: 'no_code') String noCode, LocalizedName name,@JsonKey(includeIfNull: true) String? kana, EarthquakeStationStatus status,@JsonKey(name: 'source_status') String sourceStatus, String owner, ParameterLocation location,@JsonKey(includeIfNull: true, name: 'arv_400') num? arv400
});


$LocalizedNameCopyWith<$Res> get name;$ParameterLocationCopyWith<$Res> get location;

}
/// @nodoc
class _$EarthquakeStationCopyWithImpl<$Res>
    implements $EarthquakeStationCopyWith<$Res> {
  _$EarthquakeStationCopyWithImpl(this._self, this._then);

  final EarthquakeStation _self;
  final $Res Function(EarthquakeStation) _then;

/// Create a copy of EarthquakeStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? noCode = null,Object? name = null,Object? kana = freezed,Object? status = null,Object? sourceStatus = null,Object? owner = null,Object? location = null,Object? arv400 = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,noCode: null == noCode ? _self.noCode : noCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarthquakeStationStatus,sourceStatus: null == sourceStatus ? _self.sourceStatus : sourceStatus // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as ParameterLocation,arv400: freezed == arv400 ? _self.arv400 : arv400 // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}
/// Create a copy of EarthquakeStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of EarthquakeStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterLocationCopyWith<$Res> get location {
  
  return $ParameterLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeStation].
extension EarthquakeStationPatterns on EarthquakeStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeStation value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeStation value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code, @JsonKey(name: 'no_code')  String noCode,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  EarthquakeStationStatus status, @JsonKey(name: 'source_status')  String sourceStatus,  String owner,  ParameterLocation location, @JsonKey(includeIfNull: true, name: 'arv_400')  num? arv400)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeStation() when $default != null:
return $default(_that.code,_that.noCode,_that.name,_that.kana,_that.status,_that.sourceStatus,_that.owner,_that.location,_that.arv400);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code, @JsonKey(name: 'no_code')  String noCode,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  EarthquakeStationStatus status, @JsonKey(name: 'source_status')  String sourceStatus,  String owner,  ParameterLocation location, @JsonKey(includeIfNull: true, name: 'arv_400')  num? arv400)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeStation():
return $default(_that.code,_that.noCode,_that.name,_that.kana,_that.status,_that.sourceStatus,_that.owner,_that.location,_that.arv400);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code, @JsonKey(name: 'no_code')  String noCode,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  EarthquakeStationStatus status, @JsonKey(name: 'source_status')  String sourceStatus,  String owner,  ParameterLocation location, @JsonKey(includeIfNull: true, name: 'arv_400')  num? arv400)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeStation() when $default != null:
return $default(_that.code,_that.noCode,_that.name,_that.kana,_that.status,_that.sourceStatus,_that.owner,_that.location,_that.arv400);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeStation implements EarthquakeStation {
  const _EarthquakeStation({required this.code, @JsonKey(name: 'no_code') required this.noCode, required this.name, @JsonKey(includeIfNull: true) required this.kana, required this.status, @JsonKey(name: 'source_status') required this.sourceStatus, required this.owner, required this.location, @JsonKey(includeIfNull: true, name: 'arv_400') required this.arv400});
  factory _EarthquakeStation.fromJson(Map<String, dynamic> json) => _$EarthquakeStationFromJson(json);

@override final  String code;
@override@JsonKey(name: 'no_code') final  String noCode;
@override final  LocalizedName name;
@override@JsonKey(includeIfNull: true) final  String? kana;
@override final  EarthquakeStationStatus status;
@override@JsonKey(name: 'source_status') final  String sourceStatus;
@override final  String owner;
@override final  ParameterLocation location;
@override@JsonKey(includeIfNull: true, name: 'arv_400') final  num? arv400;

/// Create a copy of EarthquakeStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeStationCopyWith<_EarthquakeStation> get copyWith => __$EarthquakeStationCopyWithImpl<_EarthquakeStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeStation&&(identical(other.code, code) || other.code == code)&&(identical(other.noCode, noCode) || other.noCode == noCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.status, status) || other.status == status)&&(identical(other.sourceStatus, sourceStatus) || other.sourceStatus == sourceStatus)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.location, location) || other.location == location)&&(identical(other.arv400, arv400) || other.arv400 == arv400));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,noCode,name,kana,status,sourceStatus,owner,location,arv400);

@override
String toString() {
  return 'EarthquakeStation(code: $code, noCode: $noCode, name: $name, kana: $kana, status: $status, sourceStatus: $sourceStatus, owner: $owner, location: $location, arv400: $arv400)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeStationCopyWith<$Res> implements $EarthquakeStationCopyWith<$Res> {
  factory _$EarthquakeStationCopyWith(_EarthquakeStation value, $Res Function(_EarthquakeStation) _then) = __$EarthquakeStationCopyWithImpl;
@override @useResult
$Res call({
 String code,@JsonKey(name: 'no_code') String noCode, LocalizedName name,@JsonKey(includeIfNull: true) String? kana, EarthquakeStationStatus status,@JsonKey(name: 'source_status') String sourceStatus, String owner, ParameterLocation location,@JsonKey(includeIfNull: true, name: 'arv_400') num? arv400
});


@override $LocalizedNameCopyWith<$Res> get name;@override $ParameterLocationCopyWith<$Res> get location;

}
/// @nodoc
class __$EarthquakeStationCopyWithImpl<$Res>
    implements _$EarthquakeStationCopyWith<$Res> {
  __$EarthquakeStationCopyWithImpl(this._self, this._then);

  final _EarthquakeStation _self;
  final $Res Function(_EarthquakeStation) _then;

/// Create a copy of EarthquakeStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? noCode = null,Object? name = null,Object? kana = freezed,Object? status = null,Object? sourceStatus = null,Object? owner = null,Object? location = null,Object? arv400 = freezed,}) {
  return _then(_EarthquakeStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,noCode: null == noCode ? _self.noCode : noCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarthquakeStationStatus,sourceStatus: null == sourceStatus ? _self.sourceStatus : sourceStatus // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as ParameterLocation,arv400: freezed == arv400 ? _self.arv400 : arv400 // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

/// Create a copy of EarthquakeStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of EarthquakeStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterLocationCopyWith<$Res> get location {
  
  return $ParameterLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStation {

 String get code; LocalizedName get name;@JsonKey(includeIfNull: true) String? get kana; String get owner; ParameterLocation get location;
/// Create a copy of TsunamiStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationCopyWith<TsunamiStation> get copyWith => _$TsunamiStationCopyWithImpl<TsunamiStation>(this as TsunamiStation, _$identity);

  /// Serializes this TsunamiStation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,owner,location);

@override
String toString() {
  return 'TsunamiStation(code: $code, name: $name, kana: $kana, owner: $owner, location: $location)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationCopyWith<$Res>  {
  factory $TsunamiStationCopyWith(TsunamiStation value, $Res Function(TsunamiStation) _then) = _$TsunamiStationCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name,@JsonKey(includeIfNull: true) String? kana, String owner, ParameterLocation location
});


$LocalizedNameCopyWith<$Res> get name;$ParameterLocationCopyWith<$Res> get location;

}
/// @nodoc
class _$TsunamiStationCopyWithImpl<$Res>
    implements $TsunamiStationCopyWith<$Res> {
  _$TsunamiStationCopyWithImpl(this._self, this._then);

  final TsunamiStation _self;
  final $Res Function(TsunamiStation) _then;

/// Create a copy of TsunamiStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? owner = null,Object? location = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as ParameterLocation,
  ));
}
/// Create a copy of TsunamiStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {

  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of TsunamiStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterLocationCopyWith<$Res> get location {

  return $ParameterLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiStation].
extension TsunamiStationPatterns on TsunamiStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStation value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStation value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  String owner,  ParameterLocation location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStation() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.owner,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  String owner,  ParameterLocation location)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStation():
return $default(_that.code,_that.name,_that.kana,_that.owner,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  String owner,  ParameterLocation location)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStation() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.owner,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStation implements TsunamiStation {
  const _TsunamiStation({required this.code, required this.name, @JsonKey(includeIfNull: true) required this.kana, required this.owner, required this.location});
  factory _TsunamiStation.fromJson(Map<String, dynamic> json) => _$TsunamiStationFromJson(json);

@override final  String code;
@override final  LocalizedName name;
@override@JsonKey(includeIfNull: true) final  String? kana;
@override final  String owner;
@override final  ParameterLocation location;

/// Create a copy of TsunamiStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationCopyWith<_TsunamiStation> get copyWith => __$TsunamiStationCopyWithImpl<_TsunamiStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,owner,location);

@override
String toString() {
  return 'TsunamiStation(code: $code, name: $name, kana: $kana, owner: $owner, location: $location)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationCopyWith<$Res> implements $TsunamiStationCopyWith<$Res> {
  factory _$TsunamiStationCopyWith(_TsunamiStation value, $Res Function(_TsunamiStation) _then) = __$TsunamiStationCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name,@JsonKey(includeIfNull: true) String? kana, String owner, ParameterLocation location
});


@override $LocalizedNameCopyWith<$Res> get name;@override $ParameterLocationCopyWith<$Res> get location;

}
/// @nodoc
class __$TsunamiStationCopyWithImpl<$Res>
    implements _$TsunamiStationCopyWith<$Res> {
  __$TsunamiStationCopyWithImpl(this._self, this._then);

  final _TsunamiStation _self;
  final $Res Function(_TsunamiStation) _then;

/// Create a copy of TsunamiStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? owner = null,Object? location = null,}) {
  return _then(_TsunamiStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as ParameterLocation,
  ));
}

/// Create a copy of TsunamiStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {

  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of TsunamiStation
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

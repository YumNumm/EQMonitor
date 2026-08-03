// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_station_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeStationRegion {

 String get code; LocalizedName get name;@JsonKey(includeIfNull: true) String? get kana; List<EarthquakeStationCity> get cities;
/// Create a copy of EarthquakeStationRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeStationRegionCopyWith<EarthquakeStationRegion> get copyWith => _$EarthquakeStationRegionCopyWithImpl<EarthquakeStationRegion>(this as EarthquakeStationRegion, _$identity);

  /// Serializes this EarthquakeStationRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeStationRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&const DeepCollectionEquality().equals(other.cities, cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,const DeepCollectionEquality().hash(cities));

@override
String toString() {
  return 'EarthquakeStationRegion(code: $code, name: $name, kana: $kana, cities: $cities)';
}


}

/// @nodoc
abstract mixin class $EarthquakeStationRegionCopyWith<$Res>  {
  factory $EarthquakeStationRegionCopyWith(EarthquakeStationRegion value, $Res Function(EarthquakeStationRegion) _then) = _$EarthquakeStationRegionCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name,@JsonKey(includeIfNull: true) String? kana, List<EarthquakeStationCity> cities
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$EarthquakeStationRegionCopyWithImpl<$Res>
    implements $EarthquakeStationRegionCopyWith<$Res> {
  _$EarthquakeStationRegionCopyWithImpl(this._self, this._then);

  final EarthquakeStationRegion _self;
  final $Res Function(EarthquakeStationRegion) _then;

/// Create a copy of EarthquakeStationRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? cities = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<EarthquakeStationCity>,
  ));
}
/// Create a copy of EarthquakeStationRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {

  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeStationRegion].
extension EarthquakeStationRegionPatterns on EarthquakeStationRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeStationRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeStationRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeStationRegion value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeStationRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeStationRegion value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeStationRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  List<EarthquakeStationCity> cities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeStationRegion() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.cities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  List<EarthquakeStationCity> cities)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeStationRegion():
return $default(_that.code,_that.name,_that.kana,_that.cities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  List<EarthquakeStationCity> cities)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeStationRegion() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.cities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeStationRegion implements EarthquakeStationRegion {
  const _EarthquakeStationRegion({required this.code, required this.name, @JsonKey(includeIfNull: true) required this.kana, required final  List<EarthquakeStationCity> cities}): _cities = cities;
  factory _EarthquakeStationRegion.fromJson(Map<String, dynamic> json) => _$EarthquakeStationRegionFromJson(json);

@override final  String code;
@override final  LocalizedName name;
@override@JsonKey(includeIfNull: true) final  String? kana;
 final  List<EarthquakeStationCity> _cities;
@override List<EarthquakeStationCity> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}


/// Create a copy of EarthquakeStationRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeStationRegionCopyWith<_EarthquakeStationRegion> get copyWith => __$EarthquakeStationRegionCopyWithImpl<_EarthquakeStationRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeStationRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeStationRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&const DeepCollectionEquality().equals(other._cities, _cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,const DeepCollectionEquality().hash(_cities));

@override
String toString() {
  return 'EarthquakeStationRegion(code: $code, name: $name, kana: $kana, cities: $cities)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeStationRegionCopyWith<$Res> implements $EarthquakeStationRegionCopyWith<$Res> {
  factory _$EarthquakeStationRegionCopyWith(_EarthquakeStationRegion value, $Res Function(_EarthquakeStationRegion) _then) = __$EarthquakeStationRegionCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name,@JsonKey(includeIfNull: true) String? kana, List<EarthquakeStationCity> cities
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$EarthquakeStationRegionCopyWithImpl<$Res>
    implements _$EarthquakeStationRegionCopyWith<$Res> {
  __$EarthquakeStationRegionCopyWithImpl(this._self, this._then);

  final _EarthquakeStationRegion _self;
  final $Res Function(_EarthquakeStationRegion) _then;

/// Create a copy of EarthquakeStationRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? cities = null,}) {
  return _then(_EarthquakeStationRegion(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<EarthquakeStationCity>,
  ));
}

/// Create a copy of EarthquakeStationRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {

  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}

// dart format on

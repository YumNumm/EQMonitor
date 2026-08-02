// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_station_city.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeStationCity {

 String get code; LocalizedName get name;@JsonKey(includeIfNull: true) String? get kana; List<EarthquakeStation> get stations;
/// Create a copy of EarthquakeStationCity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeStationCityCopyWith<EarthquakeStationCity> get copyWith => _$EarthquakeStationCityCopyWithImpl<EarthquakeStationCity>(this as EarthquakeStationCity, _$identity);

  /// Serializes this EarthquakeStationCity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeStationCity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'EarthquakeStationCity(code: $code, name: $name, kana: $kana, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $EarthquakeStationCityCopyWith<$Res>  {
  factory $EarthquakeStationCityCopyWith(EarthquakeStationCity value, $Res Function(EarthquakeStationCity) _then) = _$EarthquakeStationCityCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name,@JsonKey(includeIfNull: true) String? kana, List<EarthquakeStation> stations
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$EarthquakeStationCityCopyWithImpl<$Res>
    implements $EarthquakeStationCityCopyWith<$Res> {
  _$EarthquakeStationCityCopyWithImpl(this._self, this._then);

  final EarthquakeStationCity _self;
  final $Res Function(EarthquakeStationCity) _then;

/// Create a copy of EarthquakeStationCity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? stations = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<EarthquakeStation>,
  ));
}
/// Create a copy of EarthquakeStationCity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {

  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeStationCity].
extension EarthquakeStationCityPatterns on EarthquakeStationCity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeStationCity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeStationCity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeStationCity value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeStationCity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeStationCity value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeStationCity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  List<EarthquakeStation> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeStationCity() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  List<EarthquakeStation> stations)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeStationCity():
return $default(_that.code,_that.name,_that.kana,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana,  List<EarthquakeStation> stations)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeStationCity() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeStationCity implements EarthquakeStationCity {
  const _EarthquakeStationCity({required this.code, required this.name, @JsonKey(includeIfNull: true) required this.kana, required final  List<EarthquakeStation> stations}): _stations = stations;
  factory _EarthquakeStationCity.fromJson(Map<String, dynamic> json) => _$EarthquakeStationCityFromJson(json);

@override final  String code;
@override final  LocalizedName name;
@override@JsonKey(includeIfNull: true) final  String? kana;
 final  List<EarthquakeStation> _stations;
@override List<EarthquakeStation> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of EarthquakeStationCity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeStationCityCopyWith<_EarthquakeStationCity> get copyWith => __$EarthquakeStationCityCopyWithImpl<_EarthquakeStationCity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeStationCityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeStationCity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'EarthquakeStationCity(code: $code, name: $name, kana: $kana, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeStationCityCopyWith<$Res> implements $EarthquakeStationCityCopyWith<$Res> {
  factory _$EarthquakeStationCityCopyWith(_EarthquakeStationCity value, $Res Function(_EarthquakeStationCity) _then) = __$EarthquakeStationCityCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name,@JsonKey(includeIfNull: true) String? kana, List<EarthquakeStation> stations
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$EarthquakeStationCityCopyWithImpl<$Res>
    implements _$EarthquakeStationCityCopyWith<$Res> {
  __$EarthquakeStationCityCopyWithImpl(this._self, this._then);

  final _EarthquakeStationCity _self;
  final $Res Function(_EarthquakeStationCity) _then;

/// Create a copy of EarthquakeStationCity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? stations = null,}) {
  return _then(_EarthquakeStationCity(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<EarthquakeStation>,
  ));
}

/// Create a copy of EarthquakeStationCity
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

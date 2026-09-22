// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_station_prefecture.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeStationPrefecture {

 String get code; LocalizedName get name; List<EarthquakeStationRegion> get regions;
/// Create a copy of EarthquakeStationPrefecture
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeStationPrefectureCopyWith<EarthquakeStationPrefecture> get copyWith => _$EarthquakeStationPrefectureCopyWithImpl<EarthquakeStationPrefecture>(this as EarthquakeStationPrefecture, _$identity);

  /// Serializes this EarthquakeStationPrefecture to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeStationPrefecture&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.regions, regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'EarthquakeStationPrefecture(code: $code, name: $name, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $EarthquakeStationPrefectureCopyWith<$Res>  {
  factory $EarthquakeStationPrefectureCopyWith(EarthquakeStationPrefecture value, $Res Function(EarthquakeStationPrefecture) _then) = _$EarthquakeStationPrefectureCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name, List<EarthquakeStationRegion> regions
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$EarthquakeStationPrefectureCopyWithImpl<$Res>
    implements $EarthquakeStationPrefectureCopyWith<$Res> {
  _$EarthquakeStationPrefectureCopyWithImpl(this._self, this._then);

  final EarthquakeStationPrefecture _self;
  final $Res Function(EarthquakeStationPrefecture) _then;

/// Create a copy of EarthquakeStationPrefecture
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? regions = null,}) {
  return _then(EarthquakeStationPrefecture(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<EarthquakeStationRegion>,
  ));
}
/// Create a copy of EarthquakeStationPrefecture
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeStationPrefecture].
extension EarthquakeStationPrefecturePatterns on EarthquakeStationPrefecture {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeStationPrefecture value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeStationPrefecture() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeStationPrefecture value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeStationPrefecture():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeStationPrefecture value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeStationPrefecture() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  List<EarthquakeStationRegion> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeStationPrefecture() when $default != null:
return $default(_that.code,_that.name,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  List<EarthquakeStationRegion> regions)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeStationPrefecture():
return $default(_that.code,_that.name,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name,  List<EarthquakeStationRegion> regions)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeStationPrefecture() when $default != null:
return $default(_that.code,_that.name,_that.regions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeStationPrefecture implements EarthquakeStationPrefecture {
  const _EarthquakeStationPrefecture({required this.code, required this.name, required  List<EarthquakeStationRegion> regions}): _regions = regions;
  factory _EarthquakeStationPrefecture.fromJson(Map<String, dynamic> json) => _$EarthquakeStationPrefectureFromJson(json);

@override final  String code;
@override final  LocalizedName name;
 final  List<EarthquakeStationRegion> _regions;
@override List<EarthquakeStationRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of EarthquakeStationPrefecture
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeStationPrefectureCopyWith<_EarthquakeStationPrefecture> get copyWith => __$EarthquakeStationPrefectureCopyWithImpl<_EarthquakeStationPrefecture>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeStationPrefectureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeStationPrefecture&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._regions, _regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'EarthquakeStationPrefecture(code: $code, name: $name, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeStationPrefectureCopyWith<$Res> implements $EarthquakeStationPrefectureCopyWith<$Res> {
  factory _$EarthquakeStationPrefectureCopyWith(_EarthquakeStationPrefecture value, $Res Function(_EarthquakeStationPrefecture) _then) = __$EarthquakeStationPrefectureCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name, List<EarthquakeStationRegion> regions
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$EarthquakeStationPrefectureCopyWithImpl<$Res>
    implements _$EarthquakeStationPrefectureCopyWith<$Res> {
  __$EarthquakeStationPrefectureCopyWithImpl(this._self, this._then);

  final _EarthquakeStationPrefecture _self;
  final $Res Function(_EarthquakeStationPrefecture) _then;

/// Create a copy of EarthquakeStationPrefecture
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? regions = null,}) {
  return _then(_EarthquakeStationPrefecture(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<EarthquakeStationRegion>,
  ));
}

/// Create a copy of EarthquakeStationPrefecture
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

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_pmtiles_chunk.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeismicityPmTilesChunk {

 Uint8List get hypocenterIds; Float64List get latitudes; Float64List get longitudes; Float32List get depthsKm; Uint8List get depthValidity; Float32List get magnitudes; Uint8List get magnitudeValidity; Int64List get originTimeUnixMilliseconds; Uint32List get maxIntensityDictionaryIndexes; Uint8List get maxIntensityValidity; Uint8List get maxIntensityDictionaryUtf8; Uint32List get maxIntensityDictionaryOffsets;
/// Create a copy of SeismicityPmTilesChunk
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityPmTilesChunkCopyWith<SeismicityPmTilesChunk> get copyWith => _$SeismicityPmTilesChunkCopyWithImpl<SeismicityPmTilesChunk>(this as SeismicityPmTilesChunk, _$identity);





@override
String toString() {
  return 'SeismicityPmTilesChunk(hypocenterIds: $hypocenterIds, latitudes: $latitudes, longitudes: $longitudes, depthsKm: $depthsKm, depthValidity: $depthValidity, magnitudes: $magnitudes, magnitudeValidity: $magnitudeValidity, originTimeUnixMilliseconds: $originTimeUnixMilliseconds, maxIntensityDictionaryIndexes: $maxIntensityDictionaryIndexes, maxIntensityValidity: $maxIntensityValidity, maxIntensityDictionaryUtf8: $maxIntensityDictionaryUtf8, maxIntensityDictionaryOffsets: $maxIntensityDictionaryOffsets)';
}


}

/// @nodoc
abstract mixin class $SeismicityPmTilesChunkCopyWith<$Res>  {
  factory $SeismicityPmTilesChunkCopyWith(SeismicityPmTilesChunk value, $Res Function(SeismicityPmTilesChunk) _then) = _$SeismicityPmTilesChunkCopyWithImpl;
@useResult
$Res call({
 Uint8List hypocenterIds, Float64List latitudes, Float64List longitudes, Float32List depthsKm, Uint8List depthValidity, Float32List magnitudes, Uint8List magnitudeValidity, Int64List originTimeUnixMilliseconds, Uint32List maxIntensityDictionaryIndexes, Uint8List maxIntensityValidity, Uint8List maxIntensityDictionaryUtf8, Uint32List maxIntensityDictionaryOffsets
});




}
/// @nodoc
class _$SeismicityPmTilesChunkCopyWithImpl<$Res>
    implements $SeismicityPmTilesChunkCopyWith<$Res> {
  _$SeismicityPmTilesChunkCopyWithImpl(this._self, this._then);

  final SeismicityPmTilesChunk _self;
  final $Res Function(SeismicityPmTilesChunk) _then;

/// Create a copy of SeismicityPmTilesChunk
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hypocenterIds = null,Object? latitudes = null,Object? longitudes = null,Object? depthsKm = null,Object? depthValidity = null,Object? magnitudes = null,Object? magnitudeValidity = null,Object? originTimeUnixMilliseconds = null,Object? maxIntensityDictionaryIndexes = null,Object? maxIntensityValidity = null,Object? maxIntensityDictionaryUtf8 = null,Object? maxIntensityDictionaryOffsets = null,}) {
  return _then(SeismicityPmTilesChunk(
hypocenterIds: null == hypocenterIds ? _self.hypocenterIds : hypocenterIds // ignore: cast_nullable_to_non_nullable
as Uint8List,latitudes: null == latitudes ? _self.latitudes : latitudes // ignore: cast_nullable_to_non_nullable
as Float64List,longitudes: null == longitudes ? _self.longitudes : longitudes // ignore: cast_nullable_to_non_nullable
as Float64List,depthsKm: null == depthsKm ? _self.depthsKm : depthsKm // ignore: cast_nullable_to_non_nullable
as Float32List,depthValidity: null == depthValidity ? _self.depthValidity : depthValidity // ignore: cast_nullable_to_non_nullable
as Uint8List,magnitudes: null == magnitudes ? _self.magnitudes : magnitudes // ignore: cast_nullable_to_non_nullable
as Float32List,magnitudeValidity: null == magnitudeValidity ? _self.magnitudeValidity : magnitudeValidity // ignore: cast_nullable_to_non_nullable
as Uint8List,originTimeUnixMilliseconds: null == originTimeUnixMilliseconds ? _self.originTimeUnixMilliseconds : originTimeUnixMilliseconds // ignore: cast_nullable_to_non_nullable
as Int64List,maxIntensityDictionaryIndexes: null == maxIntensityDictionaryIndexes ? _self.maxIntensityDictionaryIndexes : maxIntensityDictionaryIndexes // ignore: cast_nullable_to_non_nullable
as Uint32List,maxIntensityValidity: null == maxIntensityValidity ? _self.maxIntensityValidity : maxIntensityValidity // ignore: cast_nullable_to_non_nullable
as Uint8List,maxIntensityDictionaryUtf8: null == maxIntensityDictionaryUtf8 ? _self.maxIntensityDictionaryUtf8 : maxIntensityDictionaryUtf8 // ignore: cast_nullable_to_non_nullable
as Uint8List,maxIntensityDictionaryOffsets: null == maxIntensityDictionaryOffsets ? _self.maxIntensityDictionaryOffsets : maxIntensityDictionaryOffsets // ignore: cast_nullable_to_non_nullable
as Uint32List,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityPmTilesChunk].
extension SeismicityPmTilesChunkPatterns on SeismicityPmTilesChunk {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityPmTilesChunk value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityPmTilesChunk() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityPmTilesChunk value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityPmTilesChunk():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityPmTilesChunk value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityPmTilesChunk() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uint8List hypocenterIds,  Float64List latitudes,  Float64List longitudes,  Float32List depthsKm,  Uint8List depthValidity,  Float32List magnitudes,  Uint8List magnitudeValidity,  Int64List originTimeUnixMilliseconds,  Uint32List maxIntensityDictionaryIndexes,  Uint8List maxIntensityValidity,  Uint8List maxIntensityDictionaryUtf8,  Uint32List maxIntensityDictionaryOffsets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityPmTilesChunk() when $default != null:
return $default(_that.hypocenterIds,_that.latitudes,_that.longitudes,_that.depthsKm,_that.depthValidity,_that.magnitudes,_that.magnitudeValidity,_that.originTimeUnixMilliseconds,_that.maxIntensityDictionaryIndexes,_that.maxIntensityValidity,_that.maxIntensityDictionaryUtf8,_that.maxIntensityDictionaryOffsets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uint8List hypocenterIds,  Float64List latitudes,  Float64List longitudes,  Float32List depthsKm,  Uint8List depthValidity,  Float32List magnitudes,  Uint8List magnitudeValidity,  Int64List originTimeUnixMilliseconds,  Uint32List maxIntensityDictionaryIndexes,  Uint8List maxIntensityValidity,  Uint8List maxIntensityDictionaryUtf8,  Uint32List maxIntensityDictionaryOffsets)  $default,) {final _that = this;
switch (_that) {
case _SeismicityPmTilesChunk():
return $default(_that.hypocenterIds,_that.latitudes,_that.longitudes,_that.depthsKm,_that.depthValidity,_that.magnitudes,_that.magnitudeValidity,_that.originTimeUnixMilliseconds,_that.maxIntensityDictionaryIndexes,_that.maxIntensityValidity,_that.maxIntensityDictionaryUtf8,_that.maxIntensityDictionaryOffsets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uint8List hypocenterIds,  Float64List latitudes,  Float64List longitudes,  Float32List depthsKm,  Uint8List depthValidity,  Float32List magnitudes,  Uint8List magnitudeValidity,  Int64List originTimeUnixMilliseconds,  Uint32List maxIntensityDictionaryIndexes,  Uint8List maxIntensityValidity,  Uint8List maxIntensityDictionaryUtf8,  Uint32List maxIntensityDictionaryOffsets)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityPmTilesChunk() when $default != null:
return $default(_that.hypocenterIds,_that.latitudes,_that.longitudes,_that.depthsKm,_that.depthValidity,_that.magnitudes,_that.magnitudeValidity,_that.originTimeUnixMilliseconds,_that.maxIntensityDictionaryIndexes,_that.maxIntensityValidity,_that.maxIntensityDictionaryUtf8,_that.maxIntensityDictionaryOffsets);case _:
  return null;

}
}

}

/// @nodoc


class _SeismicityPmTilesChunk implements SeismicityPmTilesChunk {
  const _SeismicityPmTilesChunk({required this.hypocenterIds, required this.latitudes, required this.longitudes, required this.depthsKm, required this.depthValidity, required this.magnitudes, required this.magnitudeValidity, required this.originTimeUnixMilliseconds, required this.maxIntensityDictionaryIndexes, required this.maxIntensityValidity, required this.maxIntensityDictionaryUtf8, required this.maxIntensityDictionaryOffsets});
  

@override final  Uint8List hypocenterIds;
@override final  Float64List latitudes;
@override final  Float64List longitudes;
@override final  Float32List depthsKm;
@override final  Uint8List depthValidity;
@override final  Float32List magnitudes;
@override final  Uint8List magnitudeValidity;
@override final  Int64List originTimeUnixMilliseconds;
@override final  Uint32List maxIntensityDictionaryIndexes;
@override final  Uint8List maxIntensityValidity;
@override final  Uint8List maxIntensityDictionaryUtf8;
@override final  Uint32List maxIntensityDictionaryOffsets;

/// Create a copy of SeismicityPmTilesChunk
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityPmTilesChunkCopyWith<_SeismicityPmTilesChunk> get copyWith => __$SeismicityPmTilesChunkCopyWithImpl<_SeismicityPmTilesChunk>(this, _$identity);





@override
String toString() {
  return 'SeismicityPmTilesChunk(hypocenterIds: $hypocenterIds, latitudes: $latitudes, longitudes: $longitudes, depthsKm: $depthsKm, depthValidity: $depthValidity, magnitudes: $magnitudes, magnitudeValidity: $magnitudeValidity, originTimeUnixMilliseconds: $originTimeUnixMilliseconds, maxIntensityDictionaryIndexes: $maxIntensityDictionaryIndexes, maxIntensityValidity: $maxIntensityValidity, maxIntensityDictionaryUtf8: $maxIntensityDictionaryUtf8, maxIntensityDictionaryOffsets: $maxIntensityDictionaryOffsets)';
}


}

/// @nodoc
abstract mixin class _$SeismicityPmTilesChunkCopyWith<$Res> implements $SeismicityPmTilesChunkCopyWith<$Res> {
  factory _$SeismicityPmTilesChunkCopyWith(_SeismicityPmTilesChunk value, $Res Function(_SeismicityPmTilesChunk) _then) = __$SeismicityPmTilesChunkCopyWithImpl;
@override @useResult
$Res call({
 Uint8List hypocenterIds, Float64List latitudes, Float64List longitudes, Float32List depthsKm, Uint8List depthValidity, Float32List magnitudes, Uint8List magnitudeValidity, Int64List originTimeUnixMilliseconds, Uint32List maxIntensityDictionaryIndexes, Uint8List maxIntensityValidity, Uint8List maxIntensityDictionaryUtf8, Uint32List maxIntensityDictionaryOffsets
});




}
/// @nodoc
class __$SeismicityPmTilesChunkCopyWithImpl<$Res>
    implements _$SeismicityPmTilesChunkCopyWith<$Res> {
  __$SeismicityPmTilesChunkCopyWithImpl(this._self, this._then);

  final _SeismicityPmTilesChunk _self;
  final $Res Function(_SeismicityPmTilesChunk) _then;

/// Create a copy of SeismicityPmTilesChunk
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hypocenterIds = null,Object? latitudes = null,Object? longitudes = null,Object? depthsKm = null,Object? depthValidity = null,Object? magnitudes = null,Object? magnitudeValidity = null,Object? originTimeUnixMilliseconds = null,Object? maxIntensityDictionaryIndexes = null,Object? maxIntensityValidity = null,Object? maxIntensityDictionaryUtf8 = null,Object? maxIntensityDictionaryOffsets = null,}) {
  return _then(_SeismicityPmTilesChunk(
hypocenterIds: null == hypocenterIds ? _self.hypocenterIds : hypocenterIds // ignore: cast_nullable_to_non_nullable
as Uint8List,latitudes: null == latitudes ? _self.latitudes : latitudes // ignore: cast_nullable_to_non_nullable
as Float64List,longitudes: null == longitudes ? _self.longitudes : longitudes // ignore: cast_nullable_to_non_nullable
as Float64List,depthsKm: null == depthsKm ? _self.depthsKm : depthsKm // ignore: cast_nullable_to_non_nullable
as Float32List,depthValidity: null == depthValidity ? _self.depthValidity : depthValidity // ignore: cast_nullable_to_non_nullable
as Uint8List,magnitudes: null == magnitudes ? _self.magnitudes : magnitudes // ignore: cast_nullable_to_non_nullable
as Float32List,magnitudeValidity: null == magnitudeValidity ? _self.magnitudeValidity : magnitudeValidity // ignore: cast_nullable_to_non_nullable
as Uint8List,originTimeUnixMilliseconds: null == originTimeUnixMilliseconds ? _self.originTimeUnixMilliseconds : originTimeUnixMilliseconds // ignore: cast_nullable_to_non_nullable
as Int64List,maxIntensityDictionaryIndexes: null == maxIntensityDictionaryIndexes ? _self.maxIntensityDictionaryIndexes : maxIntensityDictionaryIndexes // ignore: cast_nullable_to_non_nullable
as Uint32List,maxIntensityValidity: null == maxIntensityValidity ? _self.maxIntensityValidity : maxIntensityValidity // ignore: cast_nullable_to_non_nullable
as Uint8List,maxIntensityDictionaryUtf8: null == maxIntensityDictionaryUtf8 ? _self.maxIntensityDictionaryUtf8 : maxIntensityDictionaryUtf8 // ignore: cast_nullable_to_non_nullable
as Uint8List,maxIntensityDictionaryOffsets: null == maxIntensityDictionaryOffsets ? _self.maxIntensityDictionaryOffsets : maxIntensityDictionaryOffsets // ignore: cast_nullable_to_non_nullable
as Uint32List,
  ));
}


}

// dart format on

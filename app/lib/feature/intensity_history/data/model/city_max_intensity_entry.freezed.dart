// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_max_intensity_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CityMaxIntensityEntry {

/// 気象庁防災情報XMLフォーマットの市区町村コード(7桁)。
 String get cityCode;/// この市区町村で観測された史上最大震度。
 JmaIntensity get intensity;
/// Create a copy of CityMaxIntensityEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityMaxIntensityEntryCopyWith<CityMaxIntensityEntry> get copyWith => _$CityMaxIntensityEntryCopyWithImpl<CityMaxIntensityEntry>(this as CityMaxIntensityEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityMaxIntensityEntry&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,cityCode,intensity);

@override
String toString() {
  return 'CityMaxIntensityEntry(cityCode: $cityCode, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $CityMaxIntensityEntryCopyWith<$Res>  {
  factory $CityMaxIntensityEntryCopyWith(CityMaxIntensityEntry value, $Res Function(CityMaxIntensityEntry) _then) = _$CityMaxIntensityEntryCopyWithImpl;
@useResult
$Res call({
 String cityCode, JmaIntensity intensity
});




}
/// @nodoc
class _$CityMaxIntensityEntryCopyWithImpl<$Res>
    implements $CityMaxIntensityEntryCopyWith<$Res> {
  _$CityMaxIntensityEntryCopyWithImpl(this._self, this._then);

  final CityMaxIntensityEntry _self;
  final $Res Function(CityMaxIntensityEntry) _then;

/// Create a copy of CityMaxIntensityEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cityCode = null,Object? intensity = null,}) {
  return _then(CityMaxIntensityEntry(
cityCode: null == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,
  ));
}

}


/// Adds pattern-matching-related methods to [CityMaxIntensityEntry].
extension CityMaxIntensityEntryPatterns on CityMaxIntensityEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityMaxIntensityEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityMaxIntensityEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityMaxIntensityEntry value)  $default,){
final _that = this;
switch (_that) {
case _CityMaxIntensityEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityMaxIntensityEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CityMaxIntensityEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cityCode,  JmaIntensity intensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityMaxIntensityEntry() when $default != null:
return $default(_that.cityCode,_that.intensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cityCode,  JmaIntensity intensity)  $default,) {final _that = this;
switch (_that) {
case _CityMaxIntensityEntry():
return $default(_that.cityCode,_that.intensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cityCode,  JmaIntensity intensity)?  $default,) {final _that = this;
switch (_that) {
case _CityMaxIntensityEntry() when $default != null:
return $default(_that.cityCode,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc


class _CityMaxIntensityEntry implements CityMaxIntensityEntry {
  const _CityMaxIntensityEntry({required this.cityCode, required this.intensity});
  

/// 気象庁防災情報XMLフォーマットの市区町村コード(7桁)。
@override final  String cityCode;
/// この市区町村で観測された史上最大震度。
@override final  JmaIntensity intensity;

/// Create a copy of CityMaxIntensityEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityMaxIntensityEntryCopyWith<_CityMaxIntensityEntry> get copyWith => __$CityMaxIntensityEntryCopyWithImpl<_CityMaxIntensityEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityMaxIntensityEntry&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,cityCode,intensity);

@override
String toString() {
  return 'CityMaxIntensityEntry(cityCode: $cityCode, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$CityMaxIntensityEntryCopyWith<$Res> implements $CityMaxIntensityEntryCopyWith<$Res> {
  factory _$CityMaxIntensityEntryCopyWith(_CityMaxIntensityEntry value, $Res Function(_CityMaxIntensityEntry) _then) = __$CityMaxIntensityEntryCopyWithImpl;
@override @useResult
$Res call({
 String cityCode, JmaIntensity intensity
});




}
/// @nodoc
class __$CityMaxIntensityEntryCopyWithImpl<$Res>
    implements _$CityMaxIntensityEntryCopyWith<$Res> {
  __$CityMaxIntensityEntryCopyWithImpl(this._self, this._then);

  final _CityMaxIntensityEntry _self;
  final $Res Function(_CityMaxIntensityEntry) _then;

/// Create a copy of CityMaxIntensityEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cityCode = null,Object? intensity = null,}) {
  return _then(_CityMaxIntensityEntry(
cityCode: null == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,
  ));
}


}

// dart format on

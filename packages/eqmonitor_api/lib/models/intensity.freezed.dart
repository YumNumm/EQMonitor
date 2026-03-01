// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Intensity {

@JsonKey(name: 'max_intensity') MaxIntensity get maxIntensity; List<IntensityItem> get prefectures; List<IntensityItem> get regions;@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') MaxLpgmIntensity? get maxLpgmIntensity;
/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityCopyWith<Intensity> get copyWith => _$IntensityCopyWithImpl<Intensity>(this as Intensity, _$identity);

  /// Serializes this Intensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Intensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other.prefectures, prefectures)&&const DeepCollectionEquality().equals(other.regions, regions)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,const DeepCollectionEquality().hash(prefectures),const DeepCollectionEquality().hash(regions),maxLpgmIntensity);

@override
String toString() {
  return 'Intensity(maxIntensity: $maxIntensity, prefectures: $prefectures, regions: $regions, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityCopyWith<$Res>  {
  factory $IntensityCopyWith(Intensity value, $Res Function(Intensity) _then) = _$IntensityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'max_intensity') MaxIntensity maxIntensity, List<IntensityItem> prefectures, List<IntensityItem> regions,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') MaxLpgmIntensity? maxLpgmIntensity
});




}
/// @nodoc
class _$IntensityCopyWithImpl<$Res>
    implements $IntensityCopyWith<$Res> {
  _$IntensityCopyWithImpl(this._self, this._then);

  final Intensity _self;
  final $Res Function(Intensity) _then;

/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxIntensity = null,Object? prefectures = null,Object? regions = null,Object? maxLpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as MaxIntensity,prefectures: null == prefectures ? _self.prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as MaxLpgmIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [Intensity].
extension IntensityPatterns on Intensity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Intensity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Intensity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Intensity value)  $default,){
final _that = this;
switch (_that) {
case _Intensity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Intensity value)?  $default,){
final _that = this;
switch (_that) {
case _Intensity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'max_intensity')  MaxIntensity maxIntensity,  List<IntensityItem> prefectures,  List<IntensityItem> regions, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  MaxLpgmIntensity? maxLpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Intensity() when $default != null:
return $default(_that.maxIntensity,_that.prefectures,_that.regions,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'max_intensity')  MaxIntensity maxIntensity,  List<IntensityItem> prefectures,  List<IntensityItem> regions, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  MaxLpgmIntensity? maxLpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _Intensity():
return $default(_that.maxIntensity,_that.prefectures,_that.regions,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'max_intensity')  MaxIntensity maxIntensity,  List<IntensityItem> prefectures,  List<IntensityItem> regions, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  MaxLpgmIntensity? maxLpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _Intensity() when $default != null:
return $default(_that.maxIntensity,_that.prefectures,_that.regions,_that.maxLpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Intensity implements Intensity {
  const _Intensity({@JsonKey(name: 'max_intensity') required this.maxIntensity, required final  List<IntensityItem> prefectures, required final  List<IntensityItem> regions, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') this.maxLpgmIntensity}): _prefectures = prefectures,_regions = regions;
  factory _Intensity.fromJson(Map<String, dynamic> json) => _$IntensityFromJson(json);

@override@JsonKey(name: 'max_intensity') final  MaxIntensity maxIntensity;
 final  List<IntensityItem> _prefectures;
@override List<IntensityItem> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}

 final  List<IntensityItem> _regions;
@override List<IntensityItem> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

@override@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') final  MaxLpgmIntensity? maxLpgmIntensity;

/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityCopyWith<_Intensity> get copyWith => __$IntensityCopyWithImpl<_Intensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Intensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures)&&const DeepCollectionEquality().equals(other._regions, _regions)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,const DeepCollectionEquality().hash(_prefectures),const DeepCollectionEquality().hash(_regions),maxLpgmIntensity);

@override
String toString() {
  return 'Intensity(maxIntensity: $maxIntensity, prefectures: $prefectures, regions: $regions, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityCopyWith<$Res> implements $IntensityCopyWith<$Res> {
  factory _$IntensityCopyWith(_Intensity value, $Res Function(_Intensity) _then) = __$IntensityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'max_intensity') MaxIntensity maxIntensity, List<IntensityItem> prefectures, List<IntensityItem> regions,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') MaxLpgmIntensity? maxLpgmIntensity
});




}
/// @nodoc
class __$IntensityCopyWithImpl<$Res>
    implements _$IntensityCopyWith<$Res> {
  __$IntensityCopyWithImpl(this._self, this._then);

  final _Intensity _self;
  final $Res Function(_Intensity) _then;

/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxIntensity = null,Object? prefectures = null,Object? regions = null,Object? maxLpgmIntensity = freezed,}) {
  return _then(_Intensity(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as MaxIntensity,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<IntensityItem>,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as MaxLpgmIntensity?,
  ));
}


}

// dart format on

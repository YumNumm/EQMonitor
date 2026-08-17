// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_telegram_body_intensity_region_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeTelegramBodyIntensityRegionModel {

 String get code; String get name; JmaIntensity? get intensity;
/// Create a copy of EarthquakeTelegramBodyIntensityRegionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyIntensityRegionModelCopyWith<EarthquakeTelegramBodyIntensityRegionModel> get copyWith => _$EarthquakeTelegramBodyIntensityRegionModelCopyWithImpl<EarthquakeTelegramBodyIntensityRegionModel>(this as EarthquakeTelegramBodyIntensityRegionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeTelegramBodyIntensityRegionModel&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,intensity);

@override
String toString() {
  return 'EarthquakeTelegramBodyIntensityRegionModel(code: $code, name: $name, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $EarthquakeTelegramBodyIntensityRegionModelCopyWith<$Res>  {
  factory $EarthquakeTelegramBodyIntensityRegionModelCopyWith(EarthquakeTelegramBodyIntensityRegionModel value, $Res Function(EarthquakeTelegramBodyIntensityRegionModel) _then) = _$EarthquakeTelegramBodyIntensityRegionModelCopyWithImpl;
@useResult
$Res call({
 String code, String name, JmaIntensity? intensity
});




}
/// @nodoc
class _$EarthquakeTelegramBodyIntensityRegionModelCopyWithImpl<$Res>
    implements $EarthquakeTelegramBodyIntensityRegionModelCopyWith<$Res> {
  _$EarthquakeTelegramBodyIntensityRegionModelCopyWithImpl(this._self, this._then);

  final EarthquakeTelegramBodyIntensityRegionModel _self;
  final $Res Function(EarthquakeTelegramBodyIntensityRegionModel) _then;

/// Create a copy of EarthquakeTelegramBodyIntensityRegionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,}) {
  return _then(EarthquakeTelegramBodyIntensityRegionModel(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeTelegramBodyIntensityRegionModel].
extension EarthquakeTelegramBodyIntensityRegionModelPatterns on EarthquakeTelegramBodyIntensityRegionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyIntensityRegionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyIntensityRegionModel value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeTelegramBodyIntensityRegionModel value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  JmaIntensity? intensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegionModel() when $default != null:
return $default(_that.code,_that.name,_that.intensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  JmaIntensity? intensity)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegionModel():
return $default(_that.code,_that.name,_that.intensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  JmaIntensity? intensity)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyIntensityRegionModel() when $default != null:
return $default(_that.code,_that.name,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeTelegramBodyIntensityRegionModel implements EarthquakeTelegramBodyIntensityRegionModel {
  const _EarthquakeTelegramBodyIntensityRegionModel({required this.code, required this.name, this.intensity});
  

@override final  String code;
@override final  String name;
@override final  JmaIntensity? intensity;

/// Create a copy of EarthquakeTelegramBodyIntensityRegionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeTelegramBodyIntensityRegionModelCopyWith<_EarthquakeTelegramBodyIntensityRegionModel> get copyWith => __$EarthquakeTelegramBodyIntensityRegionModelCopyWithImpl<_EarthquakeTelegramBodyIntensityRegionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeTelegramBodyIntensityRegionModel&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,intensity);

@override
String toString() {
  return 'EarthquakeTelegramBodyIntensityRegionModel(code: $code, name: $name, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeTelegramBodyIntensityRegionModelCopyWith<$Res> implements $EarthquakeTelegramBodyIntensityRegionModelCopyWith<$Res> {
  factory _$EarthquakeTelegramBodyIntensityRegionModelCopyWith(_EarthquakeTelegramBodyIntensityRegionModel value, $Res Function(_EarthquakeTelegramBodyIntensityRegionModel) _then) = __$EarthquakeTelegramBodyIntensityRegionModelCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, JmaIntensity? intensity
});




}
/// @nodoc
class __$EarthquakeTelegramBodyIntensityRegionModelCopyWithImpl<$Res>
    implements _$EarthquakeTelegramBodyIntensityRegionModelCopyWith<$Res> {
  __$EarthquakeTelegramBodyIntensityRegionModelCopyWithImpl(this._self, this._then);

  final _EarthquakeTelegramBodyIntensityRegionModel _self;
  final $Res Function(_EarthquakeTelegramBodyIntensityRegionModel) _then;

/// Create a copy of EarthquakeTelegramBodyIntensityRegionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,}) {
  return _then(_EarthquakeTelegramBodyIntensityRegionModel(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}


}

// dart format on

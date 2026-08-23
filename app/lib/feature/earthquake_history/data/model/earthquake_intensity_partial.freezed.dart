// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_intensity_partial.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeIntensityPartial {

 JmaIntensity get maxIntensity; JmaLpgmIntensity? get maxLpgmIntensity; ShindoDbIntensityClass? get maxIntensityClass;
/// Create a copy of EarthquakeIntensityPartial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeIntensityPartialCopyWith<EarthquakeIntensityPartial> get copyWith => _$EarthquakeIntensityPartialCopyWithImpl<EarthquakeIntensityPartial>(this as EarthquakeIntensityPartial, _$identity);

  /// Serializes this EarthquakeIntensityPartial to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeIntensityPartial&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.maxIntensityClass, maxIntensityClass) || other.maxIntensityClass == maxIntensityClass));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,maxIntensityClass);

@override
String toString() {
  return 'EarthquakeIntensityPartial(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, maxIntensityClass: $maxIntensityClass)';
}


}

/// @nodoc
abstract mixin class $EarthquakeIntensityPartialCopyWith<$Res>  {
  factory $EarthquakeIntensityPartialCopyWith(EarthquakeIntensityPartial value, $Res Function(EarthquakeIntensityPartial) _then) = _$EarthquakeIntensityPartialCopyWithImpl;
@useResult
$Res call({
 JmaIntensity maxIntensity, JmaLpgmIntensity? maxLpgmIntensity, ShindoDbIntensityClass? maxIntensityClass
});




}
/// @nodoc
class _$EarthquakeIntensityPartialCopyWithImpl<$Res>
    implements $EarthquakeIntensityPartialCopyWith<$Res> {
  _$EarthquakeIntensityPartialCopyWithImpl(this._self, this._then);

  final EarthquakeIntensityPartial _self;
  final $Res Function(EarthquakeIntensityPartial) _then;

/// Create a copy of EarthquakeIntensityPartial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? maxIntensityClass = freezed,}) {
  return _then(EarthquakeIntensityPartial(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,maxIntensityClass: freezed == maxIntensityClass ? _self.maxIntensityClass : maxIntensityClass // ignore: cast_nullable_to_non_nullable
as ShindoDbIntensityClass?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeIntensityPartial].
extension EarthquakeIntensityPartialPatterns on EarthquakeIntensityPartial {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeIntensityPartial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeIntensityPartial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeIntensityPartial value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeIntensityPartial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeIntensityPartial value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeIntensityPartial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaIntensity maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity,  ShindoDbIntensityClass? maxIntensityClass)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeIntensityPartial() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.maxIntensityClass);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaIntensity maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity,  ShindoDbIntensityClass? maxIntensityClass)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeIntensityPartial():
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.maxIntensityClass);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaIntensity maxIntensity,  JmaLpgmIntensity? maxLpgmIntensity,  ShindoDbIntensityClass? maxIntensityClass)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeIntensityPartial() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.maxIntensityClass);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeIntensityPartial implements EarthquakeIntensityPartial {
  const _EarthquakeIntensityPartial({required this.maxIntensity, required this.maxLpgmIntensity, this.maxIntensityClass});
  factory _EarthquakeIntensityPartial.fromJson(Map<String, dynamic> json) => _$EarthquakeIntensityPartialFromJson(json);

@override final  JmaIntensity maxIntensity;
@override final  JmaLpgmIntensity? maxLpgmIntensity;
@override final  ShindoDbIntensityClass? maxIntensityClass;

/// Create a copy of EarthquakeIntensityPartial
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeIntensityPartialCopyWith<_EarthquakeIntensityPartial> get copyWith => __$EarthquakeIntensityPartialCopyWithImpl<_EarthquakeIntensityPartial>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeIntensityPartialToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeIntensityPartial&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.maxIntensityClass, maxIntensityClass) || other.maxIntensityClass == maxIntensityClass));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,maxIntensityClass);

@override
String toString() {
  return 'EarthquakeIntensityPartial(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, maxIntensityClass: $maxIntensityClass)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeIntensityPartialCopyWith<$Res> implements $EarthquakeIntensityPartialCopyWith<$Res> {
  factory _$EarthquakeIntensityPartialCopyWith(_EarthquakeIntensityPartial value, $Res Function(_EarthquakeIntensityPartial) _then) = __$EarthquakeIntensityPartialCopyWithImpl;
@override @useResult
$Res call({
 JmaIntensity maxIntensity, JmaLpgmIntensity? maxLpgmIntensity, ShindoDbIntensityClass? maxIntensityClass
});




}
/// @nodoc
class __$EarthquakeIntensityPartialCopyWithImpl<$Res>
    implements _$EarthquakeIntensityPartialCopyWith<$Res> {
  __$EarthquakeIntensityPartialCopyWithImpl(this._self, this._then);

  final _EarthquakeIntensityPartial _self;
  final $Res Function(_EarthquakeIntensityPartial) _then;

/// Create a copy of EarthquakeIntensityPartial
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? maxIntensityClass = freezed,}) {
  return _then(_EarthquakeIntensityPartial(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,maxIntensityClass: freezed == maxIntensityClass ? _self.maxIntensityClass : maxIntensityClass // ignore: cast_nullable_to_non_nullable
as ShindoDbIntensityClass?,
  ));
}


}

// dart format on

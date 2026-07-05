// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_station_intensity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogStationIntensity {

/// The name has been replaced because it contains a keyword. Original name: `class`.
@JsonKey(name: 'class') CatalogIntensityClass get classValue;/// 計測震度
@JsonKey(includeIfNull: false) num? get instrumental;
/// Create a copy of CatalogStationIntensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogStationIntensityCopyWith<CatalogStationIntensity> get copyWith => _$CatalogStationIntensityCopyWithImpl<CatalogStationIntensity>(this as CatalogStationIntensity, _$identity);

  /// Serializes this CatalogStationIntensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogStationIntensity&&(identical(other.classValue, classValue) || other.classValue == classValue)&&(identical(other.instrumental, instrumental) || other.instrumental == instrumental));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classValue,instrumental);

@override
String toString() {
  return 'CatalogStationIntensity(classValue: $classValue, instrumental: $instrumental)';
}


}

/// @nodoc
abstract mixin class $CatalogStationIntensityCopyWith<$Res>  {
  factory $CatalogStationIntensityCopyWith(CatalogStationIntensity value, $Res Function(CatalogStationIntensity) _then) = _$CatalogStationIntensityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'class') CatalogIntensityClass classValue,@JsonKey(includeIfNull: false) num? instrumental
});




}
/// @nodoc
class _$CatalogStationIntensityCopyWithImpl<$Res>
    implements $CatalogStationIntensityCopyWith<$Res> {
  _$CatalogStationIntensityCopyWithImpl(this._self, this._then);

  final CatalogStationIntensity _self;
  final $Res Function(CatalogStationIntensity) _then;

/// Create a copy of CatalogStationIntensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classValue = null,Object? instrumental = freezed,}) {
  return _then(_self.copyWith(
classValue: null == classValue ? _self.classValue : classValue // ignore: cast_nullable_to_non_nullable
as CatalogIntensityClass,instrumental: freezed == instrumental ? _self.instrumental : instrumental // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogStationIntensity].
extension CatalogStationIntensityPatterns on CatalogStationIntensity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogStationIntensity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogStationIntensity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogStationIntensity value)  $default,){
final _that = this;
switch (_that) {
case _CatalogStationIntensity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogStationIntensity value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogStationIntensity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'class')  CatalogIntensityClass classValue, @JsonKey(includeIfNull: false)  num? instrumental)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogStationIntensity() when $default != null:
return $default(_that.classValue,_that.instrumental);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'class')  CatalogIntensityClass classValue, @JsonKey(includeIfNull: false)  num? instrumental)  $default,) {final _that = this;
switch (_that) {
case _CatalogStationIntensity():
return $default(_that.classValue,_that.instrumental);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'class')  CatalogIntensityClass classValue, @JsonKey(includeIfNull: false)  num? instrumental)?  $default,) {final _that = this;
switch (_that) {
case _CatalogStationIntensity() when $default != null:
return $default(_that.classValue,_that.instrumental);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogStationIntensity implements CatalogStationIntensity {
  const _CatalogStationIntensity({@JsonKey(name: 'class') required this.classValue, @JsonKey(includeIfNull: false) this.instrumental});
  factory _CatalogStationIntensity.fromJson(Map<String, dynamic> json) => _$CatalogStationIntensityFromJson(json);

/// The name has been replaced because it contains a keyword. Original name: `class`.
@override@JsonKey(name: 'class') final  CatalogIntensityClass classValue;
/// 計測震度
@override@JsonKey(includeIfNull: false) final  num? instrumental;

/// Create a copy of CatalogStationIntensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogStationIntensityCopyWith<_CatalogStationIntensity> get copyWith => __$CatalogStationIntensityCopyWithImpl<_CatalogStationIntensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogStationIntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogStationIntensity&&(identical(other.classValue, classValue) || other.classValue == classValue)&&(identical(other.instrumental, instrumental) || other.instrumental == instrumental));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classValue,instrumental);

@override
String toString() {
  return 'CatalogStationIntensity(classValue: $classValue, instrumental: $instrumental)';
}


}

/// @nodoc
abstract mixin class _$CatalogStationIntensityCopyWith<$Res> implements $CatalogStationIntensityCopyWith<$Res> {
  factory _$CatalogStationIntensityCopyWith(_CatalogStationIntensity value, $Res Function(_CatalogStationIntensity) _then) = __$CatalogStationIntensityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'class') CatalogIntensityClass classValue,@JsonKey(includeIfNull: false) num? instrumental
});




}
/// @nodoc
class __$CatalogStationIntensityCopyWithImpl<$Res>
    implements _$CatalogStationIntensityCopyWith<$Res> {
  __$CatalogStationIntensityCopyWithImpl(this._self, this._then);

  final _CatalogStationIntensity _self;
  final $Res Function(_CatalogStationIntensity) _then;

/// Create a copy of CatalogStationIntensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classValue = null,Object? instrumental = freezed,}) {
  return _then(_CatalogStationIntensity(
classValue: null == classValue ? _self.classValue : classValue // ignore: cast_nullable_to_non_nullable
as CatalogIntensityClass,instrumental: freezed == instrumental ? _self.instrumental : instrumental // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on

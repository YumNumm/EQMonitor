// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_auxiliary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HypocenterAuxiliary {

 String get code; String get name; String get direction;@JsonKey(name: 'distance_km') num get distanceKm;
/// Create a copy of HypocenterAuxiliary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterAuxiliaryCopyWith<HypocenterAuxiliary> get copyWith => _$HypocenterAuxiliaryCopyWithImpl<HypocenterAuxiliary>(this as HypocenterAuxiliary, _$identity);

  /// Serializes this HypocenterAuxiliary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterAuxiliary&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,direction,distanceKm);

@override
String toString() {
  return 'HypocenterAuxiliary(code: $code, name: $name, direction: $direction, distanceKm: $distanceKm)';
}


}

/// @nodoc
abstract mixin class $HypocenterAuxiliaryCopyWith<$Res>  {
  factory $HypocenterAuxiliaryCopyWith(HypocenterAuxiliary value, $Res Function(HypocenterAuxiliary) _then) = _$HypocenterAuxiliaryCopyWithImpl;
@useResult
$Res call({
 String code, String name, String direction,@JsonKey(name: 'distance_km') num distanceKm
});




}
/// @nodoc
class _$HypocenterAuxiliaryCopyWithImpl<$Res>
    implements $HypocenterAuxiliaryCopyWith<$Res> {
  _$HypocenterAuxiliaryCopyWithImpl(this._self, this._then);

  final HypocenterAuxiliary _self;
  final $Res Function(HypocenterAuxiliary) _then;

/// Create a copy of HypocenterAuxiliary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? direction = null,Object? distanceKm = null,}) {
  return _then(HypocenterAuxiliary(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [HypocenterAuxiliary].
extension HypocenterAuxiliaryPatterns on HypocenterAuxiliary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterAuxiliary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterAuxiliary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterAuxiliary value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterAuxiliary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterAuxiliary value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterAuxiliary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String direction, @JsonKey(name: 'distance_km')  num distanceKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterAuxiliary() when $default != null:
return $default(_that.code,_that.name,_that.direction,_that.distanceKm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String direction, @JsonKey(name: 'distance_km')  num distanceKm)  $default,) {final _that = this;
switch (_that) {
case _HypocenterAuxiliary():
return $default(_that.code,_that.name,_that.direction,_that.distanceKm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String direction, @JsonKey(name: 'distance_km')  num distanceKm)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterAuxiliary() when $default != null:
return $default(_that.code,_that.name,_that.direction,_that.distanceKm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HypocenterAuxiliary implements HypocenterAuxiliary {
  const _HypocenterAuxiliary({required this.code, required this.name, required this.direction, @JsonKey(name: 'distance_km') required this.distanceKm});
  factory _HypocenterAuxiliary.fromJson(Map<String, dynamic> json) => _$HypocenterAuxiliaryFromJson(json);

@override final  String code;
@override final  String name;
@override final  String direction;
@override@JsonKey(name: 'distance_km') final  num distanceKm;

/// Create a copy of HypocenterAuxiliary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterAuxiliaryCopyWith<_HypocenterAuxiliary> get copyWith => __$HypocenterAuxiliaryCopyWithImpl<_HypocenterAuxiliary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HypocenterAuxiliaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterAuxiliary&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,direction,distanceKm);

@override
String toString() {
  return 'HypocenterAuxiliary(code: $code, name: $name, direction: $direction, distanceKm: $distanceKm)';
}


}

/// @nodoc
abstract mixin class _$HypocenterAuxiliaryCopyWith<$Res> implements $HypocenterAuxiliaryCopyWith<$Res> {
  factory _$HypocenterAuxiliaryCopyWith(_HypocenterAuxiliary value, $Res Function(_HypocenterAuxiliary) _then) = __$HypocenterAuxiliaryCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String direction,@JsonKey(name: 'distance_km') num distanceKm
});




}
/// @nodoc
class __$HypocenterAuxiliaryCopyWithImpl<$Res>
    implements _$HypocenterAuxiliaryCopyWith<$Res> {
  __$HypocenterAuxiliaryCopyWithImpl(this._self, this._then);

  final _HypocenterAuxiliary _self;
  final $Res Function(_HypocenterAuxiliary) _then;

/// Create a copy of HypocenterAuxiliary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? direction = null,Object? distanceKm = null,}) {
  return _then(_HypocenterAuxiliary(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on

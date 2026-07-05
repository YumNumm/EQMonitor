// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_hypocenter_magnitude.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogHypocenterMagnitude {

 CatalogMagnitudeType get type; num get value;
/// Create a copy of CatalogHypocenterMagnitude
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogHypocenterMagnitudeCopyWith<CatalogHypocenterMagnitude> get copyWith => _$CatalogHypocenterMagnitudeCopyWithImpl<CatalogHypocenterMagnitude>(this as CatalogHypocenterMagnitude, _$identity);

  /// Serializes this CatalogHypocenterMagnitude to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogHypocenterMagnitude&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,value);

@override
String toString() {
  return 'CatalogHypocenterMagnitude(type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class $CatalogHypocenterMagnitudeCopyWith<$Res>  {
  factory $CatalogHypocenterMagnitudeCopyWith(CatalogHypocenterMagnitude value, $Res Function(CatalogHypocenterMagnitude) _then) = _$CatalogHypocenterMagnitudeCopyWithImpl;
@useResult
$Res call({
 CatalogMagnitudeType type, num value
});




}
/// @nodoc
class _$CatalogHypocenterMagnitudeCopyWithImpl<$Res>
    implements $CatalogHypocenterMagnitudeCopyWith<$Res> {
  _$CatalogHypocenterMagnitudeCopyWithImpl(this._self, this._then);

  final CatalogHypocenterMagnitude _self;
  final $Res Function(CatalogHypocenterMagnitude) _then;

/// Create a copy of CatalogHypocenterMagnitude
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? value = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CatalogMagnitudeType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogHypocenterMagnitude].
extension CatalogHypocenterMagnitudePatterns on CatalogHypocenterMagnitude {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogHypocenterMagnitude value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogHypocenterMagnitude() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogHypocenterMagnitude value)  $default,){
final _that = this;
switch (_that) {
case _CatalogHypocenterMagnitude():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogHypocenterMagnitude value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogHypocenterMagnitude() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CatalogMagnitudeType type,  num value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogHypocenterMagnitude() when $default != null:
return $default(_that.type,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CatalogMagnitudeType type,  num value)  $default,) {final _that = this;
switch (_that) {
case _CatalogHypocenterMagnitude():
return $default(_that.type,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CatalogMagnitudeType type,  num value)?  $default,) {final _that = this;
switch (_that) {
case _CatalogHypocenterMagnitude() when $default != null:
return $default(_that.type,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogHypocenterMagnitude implements CatalogHypocenterMagnitude {
  const _CatalogHypocenterMagnitude({required this.type, required this.value});
  factory _CatalogHypocenterMagnitude.fromJson(Map<String, dynamic> json) => _$CatalogHypocenterMagnitudeFromJson(json);

@override final  CatalogMagnitudeType type;
@override final  num value;

/// Create a copy of CatalogHypocenterMagnitude
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogHypocenterMagnitudeCopyWith<_CatalogHypocenterMagnitude> get copyWith => __$CatalogHypocenterMagnitudeCopyWithImpl<_CatalogHypocenterMagnitude>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogHypocenterMagnitudeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogHypocenterMagnitude&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,value);

@override
String toString() {
  return 'CatalogHypocenterMagnitude(type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class _$CatalogHypocenterMagnitudeCopyWith<$Res> implements $CatalogHypocenterMagnitudeCopyWith<$Res> {
  factory _$CatalogHypocenterMagnitudeCopyWith(_CatalogHypocenterMagnitude value, $Res Function(_CatalogHypocenterMagnitude) _then) = __$CatalogHypocenterMagnitudeCopyWithImpl;
@override @useResult
$Res call({
 CatalogMagnitudeType type, num value
});




}
/// @nodoc
class __$CatalogHypocenterMagnitudeCopyWithImpl<$Res>
    implements _$CatalogHypocenterMagnitudeCopyWith<$Res> {
  __$CatalogHypocenterMagnitudeCopyWithImpl(this._self, this._then);

  final _CatalogHypocenterMagnitude _self;
  final $Res Function(_CatalogHypocenterMagnitude) _then;

/// Create a copy of CatalogHypocenterMagnitude
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? value = null,}) {
  return _then(_CatalogHypocenterMagnitude(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CatalogMagnitudeType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on

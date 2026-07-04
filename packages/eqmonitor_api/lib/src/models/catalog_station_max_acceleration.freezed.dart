// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_station_max_acceleration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogStationMaxAcceleration {

@JsonKey(includeIfNull: false, name: 'synthesized_gal') num? get synthesizedGal;@JsonKey(includeIfNull: false, name: 'ns_gal') num? get nsGal;@JsonKey(includeIfNull: false, name: 'ew_gal') num? get ewGal;@JsonKey(includeIfNull: false, name: 'ud_gal') num? get udGal;
/// Create a copy of CatalogStationMaxAcceleration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogStationMaxAccelerationCopyWith<CatalogStationMaxAcceleration> get copyWith => _$CatalogStationMaxAccelerationCopyWithImpl<CatalogStationMaxAcceleration>(this as CatalogStationMaxAcceleration, _$identity);

  /// Serializes this CatalogStationMaxAcceleration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogStationMaxAcceleration&&(identical(other.synthesizedGal, synthesizedGal) || other.synthesizedGal == synthesizedGal)&&(identical(other.nsGal, nsGal) || other.nsGal == nsGal)&&(identical(other.ewGal, ewGal) || other.ewGal == ewGal)&&(identical(other.udGal, udGal) || other.udGal == udGal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,synthesizedGal,nsGal,ewGal,udGal);

@override
String toString() {
  return 'CatalogStationMaxAcceleration(synthesizedGal: $synthesizedGal, nsGal: $nsGal, ewGal: $ewGal, udGal: $udGal)';
}


}

/// @nodoc
abstract mixin class $CatalogStationMaxAccelerationCopyWith<$Res>  {
  factory $CatalogStationMaxAccelerationCopyWith(CatalogStationMaxAcceleration value, $Res Function(CatalogStationMaxAcceleration) _then) = _$CatalogStationMaxAccelerationCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'synthesized_gal') num? synthesizedGal,@JsonKey(includeIfNull: false, name: 'ns_gal') num? nsGal,@JsonKey(includeIfNull: false, name: 'ew_gal') num? ewGal,@JsonKey(includeIfNull: false, name: 'ud_gal') num? udGal
});




}
/// @nodoc
class _$CatalogStationMaxAccelerationCopyWithImpl<$Res>
    implements $CatalogStationMaxAccelerationCopyWith<$Res> {
  _$CatalogStationMaxAccelerationCopyWithImpl(this._self, this._then);

  final CatalogStationMaxAcceleration _self;
  final $Res Function(CatalogStationMaxAcceleration) _then;

/// Create a copy of CatalogStationMaxAcceleration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? synthesizedGal = freezed,Object? nsGal = freezed,Object? ewGal = freezed,Object? udGal = freezed,}) {
  return _then(_self.copyWith(
synthesizedGal: freezed == synthesizedGal ? _self.synthesizedGal : synthesizedGal // ignore: cast_nullable_to_non_nullable
as num?,nsGal: freezed == nsGal ? _self.nsGal : nsGal // ignore: cast_nullable_to_non_nullable
as num?,ewGal: freezed == ewGal ? _self.ewGal : ewGal // ignore: cast_nullable_to_non_nullable
as num?,udGal: freezed == udGal ? _self.udGal : udGal // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogStationMaxAcceleration].
extension CatalogStationMaxAccelerationPatterns on CatalogStationMaxAcceleration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogStationMaxAcceleration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogStationMaxAcceleration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogStationMaxAcceleration value)  $default,){
final _that = this;
switch (_that) {
case _CatalogStationMaxAcceleration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogStationMaxAcceleration value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogStationMaxAcceleration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'synthesized_gal')  num? synthesizedGal, @JsonKey(includeIfNull: false, name: 'ns_gal')  num? nsGal, @JsonKey(includeIfNull: false, name: 'ew_gal')  num? ewGal, @JsonKey(includeIfNull: false, name: 'ud_gal')  num? udGal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogStationMaxAcceleration() when $default != null:
return $default(_that.synthesizedGal,_that.nsGal,_that.ewGal,_that.udGal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'synthesized_gal')  num? synthesizedGal, @JsonKey(includeIfNull: false, name: 'ns_gal')  num? nsGal, @JsonKey(includeIfNull: false, name: 'ew_gal')  num? ewGal, @JsonKey(includeIfNull: false, name: 'ud_gal')  num? udGal)  $default,) {final _that = this;
switch (_that) {
case _CatalogStationMaxAcceleration():
return $default(_that.synthesizedGal,_that.nsGal,_that.ewGal,_that.udGal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'synthesized_gal')  num? synthesizedGal, @JsonKey(includeIfNull: false, name: 'ns_gal')  num? nsGal, @JsonKey(includeIfNull: false, name: 'ew_gal')  num? ewGal, @JsonKey(includeIfNull: false, name: 'ud_gal')  num? udGal)?  $default,) {final _that = this;
switch (_that) {
case _CatalogStationMaxAcceleration() when $default != null:
return $default(_that.synthesizedGal,_that.nsGal,_that.ewGal,_that.udGal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogStationMaxAcceleration implements CatalogStationMaxAcceleration {
  const _CatalogStationMaxAcceleration({@JsonKey(includeIfNull: false, name: 'synthesized_gal') this.synthesizedGal, @JsonKey(includeIfNull: false, name: 'ns_gal') this.nsGal, @JsonKey(includeIfNull: false, name: 'ew_gal') this.ewGal, @JsonKey(includeIfNull: false, name: 'ud_gal') this.udGal});
  factory _CatalogStationMaxAcceleration.fromJson(Map<String, dynamic> json) => _$CatalogStationMaxAccelerationFromJson(json);

@override@JsonKey(includeIfNull: false, name: 'synthesized_gal') final  num? synthesizedGal;
@override@JsonKey(includeIfNull: false, name: 'ns_gal') final  num? nsGal;
@override@JsonKey(includeIfNull: false, name: 'ew_gal') final  num? ewGal;
@override@JsonKey(includeIfNull: false, name: 'ud_gal') final  num? udGal;

/// Create a copy of CatalogStationMaxAcceleration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogStationMaxAccelerationCopyWith<_CatalogStationMaxAcceleration> get copyWith => __$CatalogStationMaxAccelerationCopyWithImpl<_CatalogStationMaxAcceleration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogStationMaxAccelerationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogStationMaxAcceleration&&(identical(other.synthesizedGal, synthesizedGal) || other.synthesizedGal == synthesizedGal)&&(identical(other.nsGal, nsGal) || other.nsGal == nsGal)&&(identical(other.ewGal, ewGal) || other.ewGal == ewGal)&&(identical(other.udGal, udGal) || other.udGal == udGal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,synthesizedGal,nsGal,ewGal,udGal);

@override
String toString() {
  return 'CatalogStationMaxAcceleration(synthesizedGal: $synthesizedGal, nsGal: $nsGal, ewGal: $ewGal, udGal: $udGal)';
}


}

/// @nodoc
abstract mixin class _$CatalogStationMaxAccelerationCopyWith<$Res> implements $CatalogStationMaxAccelerationCopyWith<$Res> {
  factory _$CatalogStationMaxAccelerationCopyWith(_CatalogStationMaxAcceleration value, $Res Function(_CatalogStationMaxAcceleration) _then) = __$CatalogStationMaxAccelerationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'synthesized_gal') num? synthesizedGal,@JsonKey(includeIfNull: false, name: 'ns_gal') num? nsGal,@JsonKey(includeIfNull: false, name: 'ew_gal') num? ewGal,@JsonKey(includeIfNull: false, name: 'ud_gal') num? udGal
});




}
/// @nodoc
class __$CatalogStationMaxAccelerationCopyWithImpl<$Res>
    implements _$CatalogStationMaxAccelerationCopyWith<$Res> {
  __$CatalogStationMaxAccelerationCopyWithImpl(this._self, this._then);

  final _CatalogStationMaxAcceleration _self;
  final $Res Function(_CatalogStationMaxAcceleration) _then;

/// Create a copy of CatalogStationMaxAcceleration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? synthesizedGal = freezed,Object? nsGal = freezed,Object? ewGal = freezed,Object? udGal = freezed,}) {
  return _then(_CatalogStationMaxAcceleration(
synthesizedGal: freezed == synthesizedGal ? _self.synthesizedGal : synthesizedGal // ignore: cast_nullable_to_non_nullable
as num?,nsGal: freezed == nsGal ? _self.nsGal : nsGal // ignore: cast_nullable_to_non_nullable
as num?,ewGal: freezed == ewGal ? _self.ewGal : ewGal // ignore: cast_nullable_to_non_nullable
as num?,udGal: freezed == udGal ? _self.udGal : udGal // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on

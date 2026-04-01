// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_periods.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrePeriods {

 num get band;@JsonKey(name: 'lpgm_intensity') JmaLpgmIntensity get lpgmIntensity; num get sva;
/// Create a copy of PrePeriods
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrePeriodsCopyWith<PrePeriods> get copyWith => _$PrePeriodsCopyWithImpl<PrePeriods>(this as PrePeriods, _$identity);

  /// Serializes this PrePeriods to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrePeriods&&(identical(other.band, band) || other.band == band)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,band,lpgmIntensity,sva);

@override
String toString() {
  return 'PrePeriods(band: $band, lpgmIntensity: $lpgmIntensity, sva: $sva)';
}


}

/// @nodoc
abstract mixin class $PrePeriodsCopyWith<$Res>  {
  factory $PrePeriodsCopyWith(PrePeriods value, $Res Function(PrePeriods) _then) = _$PrePeriodsCopyWithImpl;
@useResult
$Res call({
 num band,@JsonKey(name: 'lpgm_intensity') JmaLpgmIntensity lpgmIntensity, num sva
});




}
/// @nodoc
class _$PrePeriodsCopyWithImpl<$Res>
    implements $PrePeriodsCopyWith<$Res> {
  _$PrePeriodsCopyWithImpl(this._self, this._then);

  final PrePeriods _self;
  final $Res Function(PrePeriods) _then;

/// Create a copy of PrePeriods
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? band = null,Object? lpgmIntensity = null,Object? sva = null,}) {
  return _then(_self.copyWith(
band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as num,lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity,sva: null == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [PrePeriods].
extension PrePeriodsPatterns on PrePeriods {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrePeriods value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrePeriods() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrePeriods value)  $default,){
final _that = this;
switch (_that) {
case _PrePeriods():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrePeriods value)?  $default,){
final _that = this;
switch (_that) {
case _PrePeriods() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num band, @JsonKey(name: 'lpgm_intensity')  JmaLpgmIntensity lpgmIntensity,  num sva)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrePeriods() when $default != null:
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num band, @JsonKey(name: 'lpgm_intensity')  JmaLpgmIntensity lpgmIntensity,  num sva)  $default,) {final _that = this;
switch (_that) {
case _PrePeriods():
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num band, @JsonKey(name: 'lpgm_intensity')  JmaLpgmIntensity lpgmIntensity,  num sva)?  $default,) {final _that = this;
switch (_that) {
case _PrePeriods() when $default != null:
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrePeriods implements PrePeriods {
  const _PrePeriods({required this.band, @JsonKey(name: 'lpgm_intensity') required this.lpgmIntensity, required this.sva});
  factory _PrePeriods.fromJson(Map<String, dynamic> json) => _$PrePeriodsFromJson(json);

@override final  num band;
@override@JsonKey(name: 'lpgm_intensity') final  JmaLpgmIntensity lpgmIntensity;
@override final  num sva;

/// Create a copy of PrePeriods
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrePeriodsCopyWith<_PrePeriods> get copyWith => __$PrePeriodsCopyWithImpl<_PrePeriods>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrePeriodsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrePeriods&&(identical(other.band, band) || other.band == band)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,band,lpgmIntensity,sva);

@override
String toString() {
  return 'PrePeriods(band: $band, lpgmIntensity: $lpgmIntensity, sva: $sva)';
}


}

/// @nodoc
abstract mixin class _$PrePeriodsCopyWith<$Res> implements $PrePeriodsCopyWith<$Res> {
  factory _$PrePeriodsCopyWith(_PrePeriods value, $Res Function(_PrePeriods) _then) = __$PrePeriodsCopyWithImpl;
@override @useResult
$Res call({
 num band,@JsonKey(name: 'lpgm_intensity') JmaLpgmIntensity lpgmIntensity, num sva
});




}
/// @nodoc
class __$PrePeriodsCopyWithImpl<$Res>
    implements _$PrePeriodsCopyWith<$Res> {
  __$PrePeriodsCopyWithImpl(this._self, this._then);

  final _PrePeriods _self;
  final $Res Function(_PrePeriods) _then;

/// Create a copy of PrePeriods
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? band = null,Object? lpgmIntensity = null,Object? sva = null,}) {
  return _then(_PrePeriods(
band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as num,lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity,sva: null == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on

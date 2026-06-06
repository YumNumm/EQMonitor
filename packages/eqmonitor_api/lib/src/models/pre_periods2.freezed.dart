// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_periods2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrePeriods2 {

 num get band;@JsonKey(includeIfNull: true) num? get sva;@JsonKey(includeIfNull: true, name: 'lpgm_intensity') JmaLpgmIntensity? get lpgmIntensity;
/// Create a copy of PrePeriods2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrePeriods2CopyWith<PrePeriods2> get copyWith => _$PrePeriods2CopyWithImpl<PrePeriods2>(this as PrePeriods2, _$identity);

  /// Serializes this PrePeriods2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrePeriods2&&(identical(other.band, band) || other.band == band)&&(identical(other.sva, sva) || other.sva == sva)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,band,sva,lpgmIntensity);

@override
String toString() {
  return 'PrePeriods2(band: $band, sva: $sva, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $PrePeriods2CopyWith<$Res>  {
  factory $PrePeriods2CopyWith(PrePeriods2 value, $Res Function(PrePeriods2) _then) = _$PrePeriods2CopyWithImpl;
@useResult
$Res call({
 num band,@JsonKey(includeIfNull: true) num? sva,@JsonKey(includeIfNull: true, name: 'lpgm_intensity') JmaLpgmIntensity? lpgmIntensity
});




}
/// @nodoc
class _$PrePeriods2CopyWithImpl<$Res>
    implements $PrePeriods2CopyWith<$Res> {
  _$PrePeriods2CopyWithImpl(this._self, this._then);

  final PrePeriods2 _self;
  final $Res Function(PrePeriods2) _then;

/// Create a copy of PrePeriods2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? band = null,Object? sva = freezed,Object? lpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as num,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrePeriods2].
extension PrePeriods2Patterns on PrePeriods2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrePeriods2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrePeriods2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrePeriods2 value)  $default,){
final _that = this;
switch (_that) {
case _PrePeriods2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrePeriods2 value)?  $default,){
final _that = this;
switch (_that) {
case _PrePeriods2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num band, @JsonKey(includeIfNull: true)  num? sva, @JsonKey(includeIfNull: true, name: 'lpgm_intensity')  JmaLpgmIntensity? lpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrePeriods2() when $default != null:
return $default(_that.band,_that.sva,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num band, @JsonKey(includeIfNull: true)  num? sva, @JsonKey(includeIfNull: true, name: 'lpgm_intensity')  JmaLpgmIntensity? lpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _PrePeriods2():
return $default(_that.band,_that.sva,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num band, @JsonKey(includeIfNull: true)  num? sva, @JsonKey(includeIfNull: true, name: 'lpgm_intensity')  JmaLpgmIntensity? lpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _PrePeriods2() when $default != null:
return $default(_that.band,_that.sva,_that.lpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrePeriods2 implements PrePeriods2 {
  const _PrePeriods2({required this.band, @JsonKey(includeIfNull: true) required this.sva, @JsonKey(includeIfNull: true, name: 'lpgm_intensity') required this.lpgmIntensity});
  factory _PrePeriods2.fromJson(Map<String, dynamic> json) => _$PrePeriods2FromJson(json);

@override final  num band;
@override@JsonKey(includeIfNull: true) final  num? sva;
@override@JsonKey(includeIfNull: true, name: 'lpgm_intensity') final  JmaLpgmIntensity? lpgmIntensity;

/// Create a copy of PrePeriods2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrePeriods2CopyWith<_PrePeriods2> get copyWith => __$PrePeriods2CopyWithImpl<_PrePeriods2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrePeriods2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrePeriods2&&(identical(other.band, band) || other.band == band)&&(identical(other.sva, sva) || other.sva == sva)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,band,sva,lpgmIntensity);

@override
String toString() {
  return 'PrePeriods2(band: $band, sva: $sva, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$PrePeriods2CopyWith<$Res> implements $PrePeriods2CopyWith<$Res> {
  factory _$PrePeriods2CopyWith(_PrePeriods2 value, $Res Function(_PrePeriods2) _then) = __$PrePeriods2CopyWithImpl;
@override @useResult
$Res call({
 num band,@JsonKey(includeIfNull: true) num? sva,@JsonKey(includeIfNull: true, name: 'lpgm_intensity') JmaLpgmIntensity? lpgmIntensity
});




}
/// @nodoc
class __$PrePeriods2CopyWithImpl<$Res>
    implements _$PrePeriods2CopyWith<$Res> {
  __$PrePeriods2CopyWithImpl(this._self, this._then);

  final _PrePeriods2 _self;
  final $Res Function(_PrePeriods2) _then;

/// Create a copy of PrePeriods2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? band = null,Object? sva = freezed,Object? lpgmIntensity = freezed,}) {
  return _then(_PrePeriods2(
band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as num,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as num?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_partial.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityPartial {

@JsonKey(name: 'max_intensity') JmaIntensity get maxIntensity;@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') JmaLpgmIntensity? get maxLpgmIntensity;
/// Create a copy of IntensityPartial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityPartialCopyWith<IntensityPartial> get copyWith => _$IntensityPartialCopyWithImpl<IntensityPartial>(this as IntensityPartial, _$identity);

  /// Serializes this IntensityPartial to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityPartial&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensityPartial(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityPartialCopyWith<$Res>  {
  factory $IntensityPartialCopyWith(IntensityPartial value, $Res Function(IntensityPartial) _then) = _$IntensityPartialCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'max_intensity') JmaIntensity maxIntensity,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') JmaLpgmIntensity? maxLpgmIntensity
});




}
/// @nodoc
class _$IntensityPartialCopyWithImpl<$Res>
    implements $IntensityPartialCopyWith<$Res> {
  _$IntensityPartialCopyWithImpl(this._self, this._then);

  final IntensityPartial _self;
  final $Res Function(IntensityPartial) _then;

/// Create a copy of IntensityPartial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,}) {
  return _then(IntensityPartial(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityPartial].
extension IntensityPartialPatterns on IntensityPartial {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityPartial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityPartial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityPartial value)  $default,){
final _that = this;
switch (_that) {
case _IntensityPartial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityPartial value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityPartial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'max_intensity')  JmaIntensity maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  JmaLpgmIntensity? maxLpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityPartial() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'max_intensity')  JmaIntensity maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  JmaLpgmIntensity? maxLpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityPartial():
return $default(_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'max_intensity')  JmaIntensity maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  JmaLpgmIntensity? maxLpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityPartial() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityPartial implements IntensityPartial {
  const _IntensityPartial({@JsonKey(name: 'max_intensity') required this.maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') this.maxLpgmIntensity});
  factory _IntensityPartial.fromJson(Map<String, dynamic> json) => _$IntensityPartialFromJson(json);

@override@JsonKey(name: 'max_intensity') final  JmaIntensity maxIntensity;
@override@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') final  JmaLpgmIntensity? maxLpgmIntensity;

/// Create a copy of IntensityPartial
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityPartialCopyWith<_IntensityPartial> get copyWith => __$IntensityPartialCopyWithImpl<_IntensityPartial>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityPartialToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityPartial&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensityPartial(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityPartialCopyWith<$Res> implements $IntensityPartialCopyWith<$Res> {
  factory _$IntensityPartialCopyWith(_IntensityPartial value, $Res Function(_IntensityPartial) _then) = __$IntensityPartialCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'max_intensity') JmaIntensity maxIntensity,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') JmaLpgmIntensity? maxLpgmIntensity
});




}
/// @nodoc
class __$IntensityPartialCopyWithImpl<$Res>
    implements _$IntensityPartialCopyWith<$Res> {
  __$IntensityPartialCopyWithImpl(this._self, this._then);

  final _IntensityPartial _self;
  final $Res Function(_IntensityPartial) _then;

/// Create a copy of IntensityPartial
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,}) {
  return _then(_IntensityPartial(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,
  ));
}


}

// dart format on

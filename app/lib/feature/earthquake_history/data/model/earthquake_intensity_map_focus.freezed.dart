// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_intensity_map_focus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeIntensityMapFocus {

 EarthquakeIntensityMapFocusKind get kind; String get code;
/// Create a copy of EarthquakeIntensityMapFocus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeIntensityMapFocusCopyWith<EarthquakeIntensityMapFocus> get copyWith => _$EarthquakeIntensityMapFocusCopyWithImpl<EarthquakeIntensityMapFocus>(this as EarthquakeIntensityMapFocus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeIntensityMapFocus&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,kind,code);

@override
String toString() {
  return 'EarthquakeIntensityMapFocus(kind: $kind, code: $code)';
}


}

/// @nodoc
abstract mixin class $EarthquakeIntensityMapFocusCopyWith<$Res>  {
  factory $EarthquakeIntensityMapFocusCopyWith(EarthquakeIntensityMapFocus value, $Res Function(EarthquakeIntensityMapFocus) _then) = _$EarthquakeIntensityMapFocusCopyWithImpl;
@useResult
$Res call({
 EarthquakeIntensityMapFocusKind kind, String code
});




}
/// @nodoc
class _$EarthquakeIntensityMapFocusCopyWithImpl<$Res>
    implements $EarthquakeIntensityMapFocusCopyWith<$Res> {
  _$EarthquakeIntensityMapFocusCopyWithImpl(this._self, this._then);

  final EarthquakeIntensityMapFocus _self;
  final $Res Function(EarthquakeIntensityMapFocus) _then;

/// Create a copy of EarthquakeIntensityMapFocus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? code = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as EarthquakeIntensityMapFocusKind,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeIntensityMapFocus].
extension EarthquakeIntensityMapFocusPatterns on EarthquakeIntensityMapFocus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeIntensityMapFocus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeIntensityMapFocus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeIntensityMapFocus value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeIntensityMapFocus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeIntensityMapFocus value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeIntensityMapFocus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeIntensityMapFocusKind kind,  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeIntensityMapFocus() when $default != null:
return $default(_that.kind,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeIntensityMapFocusKind kind,  String code)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeIntensityMapFocus():
return $default(_that.kind,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeIntensityMapFocusKind kind,  String code)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeIntensityMapFocus() when $default != null:
return $default(_that.kind,_that.code);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeIntensityMapFocus implements EarthquakeIntensityMapFocus {
  const _EarthquakeIntensityMapFocus({required this.kind, required this.code});
  

@override final  EarthquakeIntensityMapFocusKind kind;
@override final  String code;

/// Create a copy of EarthquakeIntensityMapFocus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeIntensityMapFocusCopyWith<_EarthquakeIntensityMapFocus> get copyWith => __$EarthquakeIntensityMapFocusCopyWithImpl<_EarthquakeIntensityMapFocus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeIntensityMapFocus&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,kind,code);

@override
String toString() {
  return 'EarthquakeIntensityMapFocus(kind: $kind, code: $code)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeIntensityMapFocusCopyWith<$Res> implements $EarthquakeIntensityMapFocusCopyWith<$Res> {
  factory _$EarthquakeIntensityMapFocusCopyWith(_EarthquakeIntensityMapFocus value, $Res Function(_EarthquakeIntensityMapFocus) _then) = __$EarthquakeIntensityMapFocusCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeIntensityMapFocusKind kind, String code
});




}
/// @nodoc
class __$EarthquakeIntensityMapFocusCopyWithImpl<$Res>
    implements _$EarthquakeIntensityMapFocusCopyWith<$Res> {
  __$EarthquakeIntensityMapFocusCopyWithImpl(this._self, this._then);

  final _EarthquakeIntensityMapFocus _self;
  final $Res Function(_EarthquakeIntensityMapFocus) _then;

/// Create a copy of EarthquakeIntensityMapFocus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? code = null,}) {
  return _then(_EarthquakeIntensityMapFocus(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as EarthquakeIntensityMapFocusKind,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

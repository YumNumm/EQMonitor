// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_intensity_lpgm_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewIntensityLpgmValue {

 JmaLpgmIntensity get value;@JsonKey(name: 'is_over') bool get isOver;
/// Create a copy of EewIntensityLpgmValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityLpgmValueCopyWith<EewIntensityLpgmValue> get copyWith => _$EewIntensityLpgmValueCopyWithImpl<EewIntensityLpgmValue>(this as EewIntensityLpgmValue, _$identity);

  /// Serializes this EewIntensityLpgmValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityLpgmValue&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isOver);

@override
String toString() {
  return 'EewIntensityLpgmValue(value: $value, isOver: $isOver)';
}


}

/// @nodoc
abstract mixin class $EewIntensityLpgmValueCopyWith<$Res>  {
  factory $EewIntensityLpgmValueCopyWith(EewIntensityLpgmValue value, $Res Function(EewIntensityLpgmValue) _then) = _$EewIntensityLpgmValueCopyWithImpl;
@useResult
$Res call({
 JmaLpgmIntensity value,@JsonKey(name: 'is_over') bool isOver
});




}
/// @nodoc
class _$EewIntensityLpgmValueCopyWithImpl<$Res>
    implements $EewIntensityLpgmValueCopyWith<$Res> {
  _$EewIntensityLpgmValueCopyWithImpl(this._self, this._then);

  final EewIntensityLpgmValue _self;
  final $Res Function(EewIntensityLpgmValue) _then;

/// Create a copy of EewIntensityLpgmValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? isOver = null,}) {
  return _then(EewIntensityLpgmValue(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity,isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewIntensityLpgmValue].
extension EewIntensityLpgmValuePatterns on EewIntensityLpgmValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewIntensityLpgmValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewIntensityLpgmValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewIntensityLpgmValue value)  $default,){
final _that = this;
switch (_that) {
case _EewIntensityLpgmValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewIntensityLpgmValue value)?  $default,){
final _that = this;
switch (_that) {
case _EewIntensityLpgmValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaLpgmIntensity value, @JsonKey(name: 'is_over')  bool isOver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewIntensityLpgmValue() when $default != null:
return $default(_that.value,_that.isOver);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaLpgmIntensity value, @JsonKey(name: 'is_over')  bool isOver)  $default,) {final _that = this;
switch (_that) {
case _EewIntensityLpgmValue():
return $default(_that.value,_that.isOver);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaLpgmIntensity value, @JsonKey(name: 'is_over')  bool isOver)?  $default,) {final _that = this;
switch (_that) {
case _EewIntensityLpgmValue() when $default != null:
return $default(_that.value,_that.isOver);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewIntensityLpgmValue implements EewIntensityLpgmValue {
  const _EewIntensityLpgmValue({required this.value, @JsonKey(name: 'is_over') required this.isOver});
  factory _EewIntensityLpgmValue.fromJson(Map<String, dynamic> json) => _$EewIntensityLpgmValueFromJson(json);

@override final  JmaLpgmIntensity value;
@override@JsonKey(name: 'is_over') final  bool isOver;

/// Create a copy of EewIntensityLpgmValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewIntensityLpgmValueCopyWith<_EewIntensityLpgmValue> get copyWith => __$EewIntensityLpgmValueCopyWithImpl<_EewIntensityLpgmValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityLpgmValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewIntensityLpgmValue&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isOver);

@override
String toString() {
  return 'EewIntensityLpgmValue(value: $value, isOver: $isOver)';
}


}

/// @nodoc
abstract mixin class _$EewIntensityLpgmValueCopyWith<$Res> implements $EewIntensityLpgmValueCopyWith<$Res> {
  factory _$EewIntensityLpgmValueCopyWith(_EewIntensityLpgmValue value, $Res Function(_EewIntensityLpgmValue) _then) = __$EewIntensityLpgmValueCopyWithImpl;
@override @useResult
$Res call({
 JmaLpgmIntensity value,@JsonKey(name: 'is_over') bool isOver
});




}
/// @nodoc
class __$EewIntensityLpgmValueCopyWithImpl<$Res>
    implements _$EewIntensityLpgmValueCopyWith<$Res> {
  __$EewIntensityLpgmValueCopyWithImpl(this._self, this._then);

  final _EewIntensityLpgmValue _self;
  final $Res Function(_EewIntensityLpgmValue) _then;

/// Create a copy of EewIntensityLpgmValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? isOver = null,}) {
  return _then(_EewIntensityLpgmValue(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity,isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

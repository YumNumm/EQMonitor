// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_intensity_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewIntensityValue {

 JmaIntensity get value;@JsonKey(name: 'is_over') bool get isOver;
/// Create a copy of EewIntensityValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityValueCopyWith<EewIntensityValue> get copyWith => _$EewIntensityValueCopyWithImpl<EewIntensityValue>(this as EewIntensityValue, _$identity);

  /// Serializes this EewIntensityValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityValue&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isOver);

@override
String toString() {
  return 'EewIntensityValue(value: $value, isOver: $isOver)';
}


}

/// @nodoc
abstract mixin class $EewIntensityValueCopyWith<$Res>  {
  factory $EewIntensityValueCopyWith(EewIntensityValue value, $Res Function(EewIntensityValue) _then) = _$EewIntensityValueCopyWithImpl;
@useResult
$Res call({
 JmaIntensity value,@JsonKey(name: 'is_over') bool isOver
});




}
/// @nodoc
class _$EewIntensityValueCopyWithImpl<$Res>
    implements $EewIntensityValueCopyWith<$Res> {
  _$EewIntensityValueCopyWithImpl(this._self, this._then);

  final EewIntensityValue _self;
  final $Res Function(EewIntensityValue) _then;

/// Create a copy of EewIntensityValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? isOver = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as JmaIntensity,isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewIntensityValue].
extension EewIntensityValuePatterns on EewIntensityValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewIntensityValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewIntensityValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewIntensityValue value)  $default,){
final _that = this;
switch (_that) {
case _EewIntensityValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewIntensityValue value)?  $default,){
final _that = this;
switch (_that) {
case _EewIntensityValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaIntensity value, @JsonKey(name: 'is_over')  bool isOver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewIntensityValue() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaIntensity value, @JsonKey(name: 'is_over')  bool isOver)  $default,) {final _that = this;
switch (_that) {
case _EewIntensityValue():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaIntensity value, @JsonKey(name: 'is_over')  bool isOver)?  $default,) {final _that = this;
switch (_that) {
case _EewIntensityValue() when $default != null:
return $default(_that.value,_that.isOver);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewIntensityValue implements EewIntensityValue {
  const _EewIntensityValue({required this.value, @JsonKey(name: 'is_over') required this.isOver});
  factory _EewIntensityValue.fromJson(Map<String, dynamic> json) => _$EewIntensityValueFromJson(json);

@override final  JmaIntensity value;
@override@JsonKey(name: 'is_over') final  bool isOver;

/// Create a copy of EewIntensityValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewIntensityValueCopyWith<_EewIntensityValue> get copyWith => __$EewIntensityValueCopyWithImpl<_EewIntensityValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewIntensityValue&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isOver);

@override
String toString() {
  return 'EewIntensityValue(value: $value, isOver: $isOver)';
}


}

/// @nodoc
abstract mixin class _$EewIntensityValueCopyWith<$Res> implements $EewIntensityValueCopyWith<$Res> {
  factory _$EewIntensityValueCopyWith(_EewIntensityValue value, $Res Function(_EewIntensityValue) _then) = __$EewIntensityValueCopyWithImpl;
@override @useResult
$Res call({
 JmaIntensity value,@JsonKey(name: 'is_over') bool isOver
});




}
/// @nodoc
class __$EewIntensityValueCopyWithImpl<$Res>
    implements _$EewIntensityValueCopyWith<$Res> {
  __$EewIntensityValueCopyWithImpl(this._self, this._then);

  final _EewIntensityValue _self;
  final $Res Function(_EewIntensityValue) _then;

/// Create a copy of EewIntensityValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? isOver = null,}) {
  return _then(_EewIntensityValue(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as JmaIntensity,isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

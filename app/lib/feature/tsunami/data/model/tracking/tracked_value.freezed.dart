// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracked_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackedValue<T> {

 T get value; String get telegramId;
/// Create a copy of TrackedValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackedValueCopyWith<T, TrackedValue<T>> get copyWith => _$TrackedValueCopyWithImpl<T, TrackedValue<T>>(this as TrackedValue<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackedValue<T>&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),telegramId);

@override
String toString() {
  return 'TrackedValue<$T>(value: $value, telegramId: $telegramId)';
}


}

/// @nodoc
abstract mixin class $TrackedValueCopyWith<T,$Res>  {
  factory $TrackedValueCopyWith(TrackedValue<T> value, $Res Function(TrackedValue<T>) _then) = _$TrackedValueCopyWithImpl;
@useResult
$Res call({
 T value, String telegramId
});




}
/// @nodoc
class _$TrackedValueCopyWithImpl<T,$Res>
    implements $TrackedValueCopyWith<T, $Res> {
  _$TrackedValueCopyWithImpl(this._self, this._then);

  final TrackedValue<T> _self;
  final $Res Function(TrackedValue<T>) _then;

/// Create a copy of TrackedValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? telegramId = null,}) {
  return _then(TrackedValue(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackedValue].
extension TrackedValuePatterns<T> on TrackedValue<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackedValue<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackedValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackedValue<T> value)  $default,){
final _that = this;
switch (_that) {
case _TrackedValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackedValue<T> value)?  $default,){
final _that = this;
switch (_that) {
case _TrackedValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( T value,  String telegramId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackedValue() when $default != null:
return $default(_that.value,_that.telegramId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( T value,  String telegramId)  $default,) {final _that = this;
switch (_that) {
case _TrackedValue():
return $default(_that.value,_that.telegramId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( T value,  String telegramId)?  $default,) {final _that = this;
switch (_that) {
case _TrackedValue() when $default != null:
return $default(_that.value,_that.telegramId);case _:
  return null;

}
}

}

/// @nodoc


class _TrackedValue<T> implements TrackedValue<T> {
  const _TrackedValue({required this.value, required this.telegramId});
  

@override final  T value;
@override final  String telegramId;

/// Create a copy of TrackedValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackedValueCopyWith<T, _TrackedValue<T>> get copyWith => __$TrackedValueCopyWithImpl<T, _TrackedValue<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackedValue<T>&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),telegramId);

@override
String toString() {
  return 'TrackedValue<$T>(value: $value, telegramId: $telegramId)';
}


}

/// @nodoc
abstract mixin class _$TrackedValueCopyWith<T,$Res> implements $TrackedValueCopyWith<T, $Res> {
  factory _$TrackedValueCopyWith(_TrackedValue<T> value, $Res Function(_TrackedValue<T>) _then) = __$TrackedValueCopyWithImpl;
@override @useResult
$Res call({
 T value, String telegramId
});




}
/// @nodoc
class __$TrackedValueCopyWithImpl<T,$Res>
    implements _$TrackedValueCopyWith<T, $Res> {
  __$TrackedValueCopyWithImpl(this._self, this._then);

  final _TrackedValue<T> _self;
  final $Res Function(_TrackedValue<T>) _then;

/// Create a copy of TrackedValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? telegramId = null,}) {
  return _then(_TrackedValue<T>(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,telegramId: null == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

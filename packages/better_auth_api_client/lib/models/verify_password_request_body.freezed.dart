// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_password_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyPasswordRequestBody {

/// The password to verify
 String get password;
/// Create a copy of VerifyPasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyPasswordRequestBodyCopyWith<VerifyPasswordRequestBody> get copyWith => _$VerifyPasswordRequestBodyCopyWithImpl<VerifyPasswordRequestBody>(this as VerifyPasswordRequestBody, _$identity);

  /// Serializes this VerifyPasswordRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyPasswordRequestBody&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'VerifyPasswordRequestBody(password: $password)';
}


}

/// @nodoc
abstract mixin class $VerifyPasswordRequestBodyCopyWith<$Res>  {
  factory $VerifyPasswordRequestBodyCopyWith(VerifyPasswordRequestBody value, $Res Function(VerifyPasswordRequestBody) _then) = _$VerifyPasswordRequestBodyCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class _$VerifyPasswordRequestBodyCopyWithImpl<$Res>
    implements $VerifyPasswordRequestBodyCopyWith<$Res> {
  _$VerifyPasswordRequestBodyCopyWithImpl(this._self, this._then);

  final VerifyPasswordRequestBody _self;
  final $Res Function(VerifyPasswordRequestBody) _then;

/// Create a copy of VerifyPasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? password = null,}) {
  return _then(_self.copyWith(
password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyPasswordRequestBody].
extension VerifyPasswordRequestBodyPatterns on VerifyPasswordRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyPasswordRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyPasswordRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyPasswordRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _VerifyPasswordRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyPasswordRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyPasswordRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyPasswordRequestBody() when $default != null:
return $default(_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String password)  $default,) {final _that = this;
switch (_that) {
case _VerifyPasswordRequestBody():
return $default(_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String password)?  $default,) {final _that = this;
switch (_that) {
case _VerifyPasswordRequestBody() when $default != null:
return $default(_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyPasswordRequestBody implements VerifyPasswordRequestBody {
  const _VerifyPasswordRequestBody({required this.password});
  factory _VerifyPasswordRequestBody.fromJson(Map<String, dynamic> json) => _$VerifyPasswordRequestBodyFromJson(json);

/// The password to verify
@override final  String password;

/// Create a copy of VerifyPasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyPasswordRequestBodyCopyWith<_VerifyPasswordRequestBody> get copyWith => __$VerifyPasswordRequestBodyCopyWithImpl<_VerifyPasswordRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyPasswordRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPasswordRequestBody&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'VerifyPasswordRequestBody(password: $password)';
}


}

/// @nodoc
abstract mixin class _$VerifyPasswordRequestBodyCopyWith<$Res> implements $VerifyPasswordRequestBodyCopyWith<$Res> {
  factory _$VerifyPasswordRequestBodyCopyWith(_VerifyPasswordRequestBody value, $Res Function(_VerifyPasswordRequestBody) _then) = __$VerifyPasswordRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String password
});




}
/// @nodoc
class __$VerifyPasswordRequestBodyCopyWithImpl<$Res>
    implements _$VerifyPasswordRequestBodyCopyWith<$Res> {
  __$VerifyPasswordRequestBodyCopyWithImpl(this._self, this._then);

  final _VerifyPasswordRequestBody _self;
  final $Res Function(_VerifyPasswordRequestBody) _then;

/// Create a copy of VerifyPasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(_VerifyPasswordRequestBody(
password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

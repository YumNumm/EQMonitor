// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_password_reset_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestPasswordResetRequestBody {

/// The email address of the user to send a password reset email to
 String get email;/// The URL to redirect the user to reset their password. If the token isn't valid or expired, it'll be redirected with a query parameter `?error=INVALID_TOKEN`. If the token is valid, it'll be redirected with a query parameter `?token=VALID_TOKEN
@JsonKey(includeIfNull: false) String? get redirectTo;
/// Create a copy of RequestPasswordResetRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestPasswordResetRequestBodyCopyWith<RequestPasswordResetRequestBody> get copyWith => _$RequestPasswordResetRequestBodyCopyWithImpl<RequestPasswordResetRequestBody>(this as RequestPasswordResetRequestBody, _$identity);

  /// Serializes this RequestPasswordResetRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestPasswordResetRequestBody&&(identical(other.email, email) || other.email == email)&&(identical(other.redirectTo, redirectTo) || other.redirectTo == redirectTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,redirectTo);

@override
String toString() {
  return 'RequestPasswordResetRequestBody(email: $email, redirectTo: $redirectTo)';
}


}

/// @nodoc
abstract mixin class $RequestPasswordResetRequestBodyCopyWith<$Res>  {
  factory $RequestPasswordResetRequestBodyCopyWith(RequestPasswordResetRequestBody value, $Res Function(RequestPasswordResetRequestBody) _then) = _$RequestPasswordResetRequestBodyCopyWithImpl;
@useResult
$Res call({
 String email,@JsonKey(includeIfNull: false) String? redirectTo
});




}
/// @nodoc
class _$RequestPasswordResetRequestBodyCopyWithImpl<$Res>
    implements $RequestPasswordResetRequestBodyCopyWith<$Res> {
  _$RequestPasswordResetRequestBodyCopyWithImpl(this._self, this._then);

  final RequestPasswordResetRequestBody _self;
  final $Res Function(RequestPasswordResetRequestBody) _then;

/// Create a copy of RequestPasswordResetRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? redirectTo = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,redirectTo: freezed == redirectTo ? _self.redirectTo : redirectTo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestPasswordResetRequestBody].
extension RequestPasswordResetRequestBodyPatterns on RequestPasswordResetRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestPasswordResetRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestPasswordResetRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestPasswordResetRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _RequestPasswordResetRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestPasswordResetRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _RequestPasswordResetRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email, @JsonKey(includeIfNull: false)  String? redirectTo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestPasswordResetRequestBody() when $default != null:
return $default(_that.email,_that.redirectTo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email, @JsonKey(includeIfNull: false)  String? redirectTo)  $default,) {final _that = this;
switch (_that) {
case _RequestPasswordResetRequestBody():
return $default(_that.email,_that.redirectTo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email, @JsonKey(includeIfNull: false)  String? redirectTo)?  $default,) {final _that = this;
switch (_that) {
case _RequestPasswordResetRequestBody() when $default != null:
return $default(_that.email,_that.redirectTo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequestPasswordResetRequestBody implements RequestPasswordResetRequestBody {
  const _RequestPasswordResetRequestBody({required this.email, @JsonKey(includeIfNull: false) this.redirectTo});
  factory _RequestPasswordResetRequestBody.fromJson(Map<String, dynamic> json) => _$RequestPasswordResetRequestBodyFromJson(json);

/// The email address of the user to send a password reset email to
@override final  String email;
/// The URL to redirect the user to reset their password. If the token isn't valid or expired, it'll be redirected with a query parameter `?error=INVALID_TOKEN`. If the token is valid, it'll be redirected with a query parameter `?token=VALID_TOKEN
@override@JsonKey(includeIfNull: false) final  String? redirectTo;

/// Create a copy of RequestPasswordResetRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestPasswordResetRequestBodyCopyWith<_RequestPasswordResetRequestBody> get copyWith => __$RequestPasswordResetRequestBodyCopyWithImpl<_RequestPasswordResetRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestPasswordResetRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestPasswordResetRequestBody&&(identical(other.email, email) || other.email == email)&&(identical(other.redirectTo, redirectTo) || other.redirectTo == redirectTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,redirectTo);

@override
String toString() {
  return 'RequestPasswordResetRequestBody(email: $email, redirectTo: $redirectTo)';
}


}

/// @nodoc
abstract mixin class _$RequestPasswordResetRequestBodyCopyWith<$Res> implements $RequestPasswordResetRequestBodyCopyWith<$Res> {
  factory _$RequestPasswordResetRequestBodyCopyWith(_RequestPasswordResetRequestBody value, $Res Function(_RequestPasswordResetRequestBody) _then) = __$RequestPasswordResetRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String email,@JsonKey(includeIfNull: false) String? redirectTo
});




}
/// @nodoc
class __$RequestPasswordResetRequestBodyCopyWithImpl<$Res>
    implements _$RequestPasswordResetRequestBodyCopyWith<$Res> {
  __$RequestPasswordResetRequestBodyCopyWithImpl(this._self, this._then);

  final _RequestPasswordResetRequestBody _self;
  final $Res Function(_RequestPasswordResetRequestBody) _then;

/// Create a copy of RequestPasswordResetRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? redirectTo = freezed,}) {
  return _then(_RequestPasswordResetRequestBody(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,redirectTo: freezed == redirectTo ? _self.redirectTo : redirectTo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

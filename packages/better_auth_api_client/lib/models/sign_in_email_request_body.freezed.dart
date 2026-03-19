// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_email_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignInEmailRequestBody {

/// Email of the user
 String get email;/// Password of the user
 String get password;/// If this is false, the session will not be remembered. Default is `true`.
@JsonKey(includeIfNull: true) bool? get rememberMe;/// Callback URL to use as a redirect for email verification
@JsonKey(includeIfNull: false, name: 'callbackURL') String? get callbackUrl;
/// Create a copy of SignInEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInEmailRequestBodyCopyWith<SignInEmailRequestBody> get copyWith => _$SignInEmailRequestBodyCopyWithImpl<SignInEmailRequestBody>(this as SignInEmailRequestBody, _$identity);

  /// Serializes this SignInEmailRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInEmailRequestBody&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,rememberMe,callbackUrl);

@override
String toString() {
  return 'SignInEmailRequestBody(email: $email, password: $password, rememberMe: $rememberMe, callbackUrl: $callbackUrl)';
}


}

/// @nodoc
abstract mixin class $SignInEmailRequestBodyCopyWith<$Res>  {
  factory $SignInEmailRequestBodyCopyWith(SignInEmailRequestBody value, $Res Function(SignInEmailRequestBody) _then) = _$SignInEmailRequestBodyCopyWithImpl;
@useResult
$Res call({
 String email, String password,@JsonKey(includeIfNull: true) bool? rememberMe,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl
});




}
/// @nodoc
class _$SignInEmailRequestBodyCopyWithImpl<$Res>
    implements $SignInEmailRequestBodyCopyWith<$Res> {
  _$SignInEmailRequestBodyCopyWithImpl(this._self, this._then);

  final SignInEmailRequestBody _self;
  final $Res Function(SignInEmailRequestBody) _then;

/// Create a copy of SignInEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? rememberMe = freezed,Object? callbackUrl = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,rememberMe: freezed == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool?,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SignInEmailRequestBody].
extension SignInEmailRequestBodyPatterns on SignInEmailRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInEmailRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInEmailRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInEmailRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _SignInEmailRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInEmailRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _SignInEmailRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password, @JsonKey(includeIfNull: true)  bool? rememberMe, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInEmailRequestBody() when $default != null:
return $default(_that.email,_that.password,_that.rememberMe,_that.callbackUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password, @JsonKey(includeIfNull: true)  bool? rememberMe, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl)  $default,) {final _that = this;
switch (_that) {
case _SignInEmailRequestBody():
return $default(_that.email,_that.password,_that.rememberMe,_that.callbackUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password, @JsonKey(includeIfNull: true)  bool? rememberMe, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl)?  $default,) {final _that = this;
switch (_that) {
case _SignInEmailRequestBody() when $default != null:
return $default(_that.email,_that.password,_that.rememberMe,_that.callbackUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignInEmailRequestBody implements SignInEmailRequestBody {
  const _SignInEmailRequestBody({required this.email, required this.password, @JsonKey(includeIfNull: true) this.rememberMe = true, @JsonKey(includeIfNull: false, name: 'callbackURL') this.callbackUrl});
  factory _SignInEmailRequestBody.fromJson(Map<String, dynamic> json) => _$SignInEmailRequestBodyFromJson(json);

/// Email of the user
@override final  String email;
/// Password of the user
@override final  String password;
/// If this is false, the session will not be remembered. Default is `true`.
@override@JsonKey(includeIfNull: true) final  bool? rememberMe;
/// Callback URL to use as a redirect for email verification
@override@JsonKey(includeIfNull: false, name: 'callbackURL') final  String? callbackUrl;

/// Create a copy of SignInEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInEmailRequestBodyCopyWith<_SignInEmailRequestBody> get copyWith => __$SignInEmailRequestBodyCopyWithImpl<_SignInEmailRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignInEmailRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInEmailRequestBody&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,rememberMe,callbackUrl);

@override
String toString() {
  return 'SignInEmailRequestBody(email: $email, password: $password, rememberMe: $rememberMe, callbackUrl: $callbackUrl)';
}


}

/// @nodoc
abstract mixin class _$SignInEmailRequestBodyCopyWith<$Res> implements $SignInEmailRequestBodyCopyWith<$Res> {
  factory _$SignInEmailRequestBodyCopyWith(_SignInEmailRequestBody value, $Res Function(_SignInEmailRequestBody) _then) = __$SignInEmailRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String email, String password,@JsonKey(includeIfNull: true) bool? rememberMe,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl
});




}
/// @nodoc
class __$SignInEmailRequestBodyCopyWithImpl<$Res>
    implements _$SignInEmailRequestBodyCopyWith<$Res> {
  __$SignInEmailRequestBodyCopyWithImpl(this._self, this._then);

  final _SignInEmailRequestBody _self;
  final $Res Function(_SignInEmailRequestBody) _then;

/// Create a copy of SignInEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? rememberMe = freezed,Object? callbackUrl = freezed,}) {
  return _then(_SignInEmailRequestBody(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,rememberMe: freezed == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool?,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

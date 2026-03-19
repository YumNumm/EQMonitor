// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_email_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignUpEmailRequestBody {

/// The name of the user
 String get name;/// The email of the user
 String get email;/// The password of the user
 String get password;/// The profile image URL of the user
@JsonKey(includeIfNull: false) String? get image;/// The URL to use for email verification callback
@JsonKey(includeIfNull: false, name: 'callbackURL') String? get callbackUrl;/// If this is false, the session will not be remembered. Default is `true`.
@JsonKey(includeIfNull: false) bool? get rememberMe;
/// Create a copy of SignUpEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpEmailRequestBodyCopyWith<SignUpEmailRequestBody> get copyWith => _$SignUpEmailRequestBodyCopyWithImpl<SignUpEmailRequestBody>(this as SignUpEmailRequestBody, _$identity);

  /// Serializes this SignUpEmailRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpEmailRequestBody&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.image, image) || other.image == image)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,password,image,callbackUrl,rememberMe);

@override
String toString() {
  return 'SignUpEmailRequestBody(name: $name, email: $email, password: $password, image: $image, callbackUrl: $callbackUrl, rememberMe: $rememberMe)';
}


}

/// @nodoc
abstract mixin class $SignUpEmailRequestBodyCopyWith<$Res>  {
  factory $SignUpEmailRequestBodyCopyWith(SignUpEmailRequestBody value, $Res Function(SignUpEmailRequestBody) _then) = _$SignUpEmailRequestBodyCopyWithImpl;
@useResult
$Res call({
 String name, String email, String password,@JsonKey(includeIfNull: false) String? image,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl,@JsonKey(includeIfNull: false) bool? rememberMe
});




}
/// @nodoc
class _$SignUpEmailRequestBodyCopyWithImpl<$Res>
    implements $SignUpEmailRequestBodyCopyWith<$Res> {
  _$SignUpEmailRequestBodyCopyWithImpl(this._self, this._then);

  final SignUpEmailRequestBody _self;
  final $Res Function(SignUpEmailRequestBody) _then;

/// Create a copy of SignUpEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? password = null,Object? image = freezed,Object? callbackUrl = freezed,Object? rememberMe = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,rememberMe: freezed == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SignUpEmailRequestBody].
extension SignUpEmailRequestBodyPatterns on SignUpEmailRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpEmailRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpEmailRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpEmailRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _SignUpEmailRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpEmailRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpEmailRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String email,  String password, @JsonKey(includeIfNull: false)  String? image, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl, @JsonKey(includeIfNull: false)  bool? rememberMe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpEmailRequestBody() when $default != null:
return $default(_that.name,_that.email,_that.password,_that.image,_that.callbackUrl,_that.rememberMe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String email,  String password, @JsonKey(includeIfNull: false)  String? image, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl, @JsonKey(includeIfNull: false)  bool? rememberMe)  $default,) {final _that = this;
switch (_that) {
case _SignUpEmailRequestBody():
return $default(_that.name,_that.email,_that.password,_that.image,_that.callbackUrl,_that.rememberMe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String email,  String password, @JsonKey(includeIfNull: false)  String? image, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl, @JsonKey(includeIfNull: false)  bool? rememberMe)?  $default,) {final _that = this;
switch (_that) {
case _SignUpEmailRequestBody() when $default != null:
return $default(_that.name,_that.email,_that.password,_that.image,_that.callbackUrl,_that.rememberMe);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignUpEmailRequestBody implements SignUpEmailRequestBody {
  const _SignUpEmailRequestBody({required this.name, required this.email, required this.password, @JsonKey(includeIfNull: false) this.image, @JsonKey(includeIfNull: false, name: 'callbackURL') this.callbackUrl, @JsonKey(includeIfNull: false) this.rememberMe});
  factory _SignUpEmailRequestBody.fromJson(Map<String, dynamic> json) => _$SignUpEmailRequestBodyFromJson(json);

/// The name of the user
@override final  String name;
/// The email of the user
@override final  String email;
/// The password of the user
@override final  String password;
/// The profile image URL of the user
@override@JsonKey(includeIfNull: false) final  String? image;
/// The URL to use for email verification callback
@override@JsonKey(includeIfNull: false, name: 'callbackURL') final  String? callbackUrl;
/// If this is false, the session will not be remembered. Default is `true`.
@override@JsonKey(includeIfNull: false) final  bool? rememberMe;

/// Create a copy of SignUpEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpEmailRequestBodyCopyWith<_SignUpEmailRequestBody> get copyWith => __$SignUpEmailRequestBodyCopyWithImpl<_SignUpEmailRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignUpEmailRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpEmailRequestBody&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.image, image) || other.image == image)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,password,image,callbackUrl,rememberMe);

@override
String toString() {
  return 'SignUpEmailRequestBody(name: $name, email: $email, password: $password, image: $image, callbackUrl: $callbackUrl, rememberMe: $rememberMe)';
}


}

/// @nodoc
abstract mixin class _$SignUpEmailRequestBodyCopyWith<$Res> implements $SignUpEmailRequestBodyCopyWith<$Res> {
  factory _$SignUpEmailRequestBodyCopyWith(_SignUpEmailRequestBody value, $Res Function(_SignUpEmailRequestBody) _then) = __$SignUpEmailRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String name, String email, String password,@JsonKey(includeIfNull: false) String? image,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl,@JsonKey(includeIfNull: false) bool? rememberMe
});




}
/// @nodoc
class __$SignUpEmailRequestBodyCopyWithImpl<$Res>
    implements _$SignUpEmailRequestBodyCopyWith<$Res> {
  __$SignUpEmailRequestBodyCopyWithImpl(this._self, this._then);

  final _SignUpEmailRequestBody _self;
  final $Res Function(_SignUpEmailRequestBody) _then;

/// Create a copy of SignUpEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? password = null,Object? image = freezed,Object? callbackUrl = freezed,Object? rememberMe = freezed,}) {
  return _then(_SignUpEmailRequestBody(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,rememberMe: freezed == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on

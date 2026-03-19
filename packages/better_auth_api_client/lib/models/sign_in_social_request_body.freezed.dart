// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_social_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignInSocialRequestBody {

 String get provider;/// Callback URL to redirect to after the user has signed in
@JsonKey(includeIfNull: false, name: 'callbackURL') String? get callbackUrl;@JsonKey(includeIfNull: false, name: 'newUserCallbackURL') String? get newUserCallbackUrl;/// Callback URL to redirect to if an error happens
@JsonKey(includeIfNull: false, name: 'errorCallbackURL') String? get errorCallbackUrl;/// Disable automatic redirection to the provider. Useful for handling the redirection yourself
@JsonKey(includeIfNull: false) bool? get disableRedirect;@JsonKey(includeIfNull: false) IdToken? get idToken;/// Array of scopes to request from the provider. This will override the default scopes passed.
@JsonKey(includeIfNull: false) List<dynamic>? get scopes;/// Explicitly request sign-up. Useful when disableImplicitSignUp is true for this provider
@JsonKey(includeIfNull: false) bool? get requestSignUp;/// The login hint to use for the authorization code request
@JsonKey(includeIfNull: false) String? get loginHint;@JsonKey(includeIfNull: false) String? get additionalData;
/// Create a copy of SignInSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInSocialRequestBodyCopyWith<SignInSocialRequestBody> get copyWith => _$SignInSocialRequestBodyCopyWithImpl<SignInSocialRequestBody>(this as SignInSocialRequestBody, _$identity);

  /// Serializes this SignInSocialRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInSocialRequestBody&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl)&&(identical(other.newUserCallbackUrl, newUserCallbackUrl) || other.newUserCallbackUrl == newUserCallbackUrl)&&(identical(other.errorCallbackUrl, errorCallbackUrl) || other.errorCallbackUrl == errorCallbackUrl)&&(identical(other.disableRedirect, disableRedirect) || other.disableRedirect == disableRedirect)&&(identical(other.idToken, idToken) || other.idToken == idToken)&&const DeepCollectionEquality().equals(other.scopes, scopes)&&(identical(other.requestSignUp, requestSignUp) || other.requestSignUp == requestSignUp)&&(identical(other.loginHint, loginHint) || other.loginHint == loginHint)&&(identical(other.additionalData, additionalData) || other.additionalData == additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,callbackUrl,newUserCallbackUrl,errorCallbackUrl,disableRedirect,idToken,const DeepCollectionEquality().hash(scopes),requestSignUp,loginHint,additionalData);

@override
String toString() {
  return 'SignInSocialRequestBody(provider: $provider, callbackUrl: $callbackUrl, newUserCallbackUrl: $newUserCallbackUrl, errorCallbackUrl: $errorCallbackUrl, disableRedirect: $disableRedirect, idToken: $idToken, scopes: $scopes, requestSignUp: $requestSignUp, loginHint: $loginHint, additionalData: $additionalData)';
}


}

/// @nodoc
abstract mixin class $SignInSocialRequestBodyCopyWith<$Res>  {
  factory $SignInSocialRequestBodyCopyWith(SignInSocialRequestBody value, $Res Function(SignInSocialRequestBody) _then) = _$SignInSocialRequestBodyCopyWithImpl;
@useResult
$Res call({
 String provider,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl,@JsonKey(includeIfNull: false, name: 'newUserCallbackURL') String? newUserCallbackUrl,@JsonKey(includeIfNull: false, name: 'errorCallbackURL') String? errorCallbackUrl,@JsonKey(includeIfNull: false) bool? disableRedirect,@JsonKey(includeIfNull: false) IdToken? idToken,@JsonKey(includeIfNull: false) List<dynamic>? scopes,@JsonKey(includeIfNull: false) bool? requestSignUp,@JsonKey(includeIfNull: false) String? loginHint,@JsonKey(includeIfNull: false) String? additionalData
});


$IdTokenCopyWith<$Res>? get idToken;

}
/// @nodoc
class _$SignInSocialRequestBodyCopyWithImpl<$Res>
    implements $SignInSocialRequestBodyCopyWith<$Res> {
  _$SignInSocialRequestBodyCopyWithImpl(this._self, this._then);

  final SignInSocialRequestBody _self;
  final $Res Function(SignInSocialRequestBody) _then;

/// Create a copy of SignInSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? callbackUrl = freezed,Object? newUserCallbackUrl = freezed,Object? errorCallbackUrl = freezed,Object? disableRedirect = freezed,Object? idToken = freezed,Object? scopes = freezed,Object? requestSignUp = freezed,Object? loginHint = freezed,Object? additionalData = freezed,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,newUserCallbackUrl: freezed == newUserCallbackUrl ? _self.newUserCallbackUrl : newUserCallbackUrl // ignore: cast_nullable_to_non_nullable
as String?,errorCallbackUrl: freezed == errorCallbackUrl ? _self.errorCallbackUrl : errorCallbackUrl // ignore: cast_nullable_to_non_nullable
as String?,disableRedirect: freezed == disableRedirect ? _self.disableRedirect : disableRedirect // ignore: cast_nullable_to_non_nullable
as bool?,idToken: freezed == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as IdToken?,scopes: freezed == scopes ? _self.scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,requestSignUp: freezed == requestSignUp ? _self.requestSignUp : requestSignUp // ignore: cast_nullable_to_non_nullable
as bool?,loginHint: freezed == loginHint ? _self.loginHint : loginHint // ignore: cast_nullable_to_non_nullable
as String?,additionalData: freezed == additionalData ? _self.additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SignInSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdTokenCopyWith<$Res>? get idToken {
    if (_self.idToken == null) {
    return null;
  }

  return $IdTokenCopyWith<$Res>(_self.idToken!, (value) {
    return _then(_self.copyWith(idToken: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignInSocialRequestBody].
extension SignInSocialRequestBodyPatterns on SignInSocialRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInSocialRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInSocialRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInSocialRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _SignInSocialRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInSocialRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _SignInSocialRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String provider, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl, @JsonKey(includeIfNull: false, name: 'newUserCallbackURL')  String? newUserCallbackUrl, @JsonKey(includeIfNull: false, name: 'errorCallbackURL')  String? errorCallbackUrl, @JsonKey(includeIfNull: false)  bool? disableRedirect, @JsonKey(includeIfNull: false)  IdToken? idToken, @JsonKey(includeIfNull: false)  List<dynamic>? scopes, @JsonKey(includeIfNull: false)  bool? requestSignUp, @JsonKey(includeIfNull: false)  String? loginHint, @JsonKey(includeIfNull: false)  String? additionalData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInSocialRequestBody() when $default != null:
return $default(_that.provider,_that.callbackUrl,_that.newUserCallbackUrl,_that.errorCallbackUrl,_that.disableRedirect,_that.idToken,_that.scopes,_that.requestSignUp,_that.loginHint,_that.additionalData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String provider, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl, @JsonKey(includeIfNull: false, name: 'newUserCallbackURL')  String? newUserCallbackUrl, @JsonKey(includeIfNull: false, name: 'errorCallbackURL')  String? errorCallbackUrl, @JsonKey(includeIfNull: false)  bool? disableRedirect, @JsonKey(includeIfNull: false)  IdToken? idToken, @JsonKey(includeIfNull: false)  List<dynamic>? scopes, @JsonKey(includeIfNull: false)  bool? requestSignUp, @JsonKey(includeIfNull: false)  String? loginHint, @JsonKey(includeIfNull: false)  String? additionalData)  $default,) {final _that = this;
switch (_that) {
case _SignInSocialRequestBody():
return $default(_that.provider,_that.callbackUrl,_that.newUserCallbackUrl,_that.errorCallbackUrl,_that.disableRedirect,_that.idToken,_that.scopes,_that.requestSignUp,_that.loginHint,_that.additionalData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String provider, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl, @JsonKey(includeIfNull: false, name: 'newUserCallbackURL')  String? newUserCallbackUrl, @JsonKey(includeIfNull: false, name: 'errorCallbackURL')  String? errorCallbackUrl, @JsonKey(includeIfNull: false)  bool? disableRedirect, @JsonKey(includeIfNull: false)  IdToken? idToken, @JsonKey(includeIfNull: false)  List<dynamic>? scopes, @JsonKey(includeIfNull: false)  bool? requestSignUp, @JsonKey(includeIfNull: false)  String? loginHint, @JsonKey(includeIfNull: false)  String? additionalData)?  $default,) {final _that = this;
switch (_that) {
case _SignInSocialRequestBody() when $default != null:
return $default(_that.provider,_that.callbackUrl,_that.newUserCallbackUrl,_that.errorCallbackUrl,_that.disableRedirect,_that.idToken,_that.scopes,_that.requestSignUp,_that.loginHint,_that.additionalData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignInSocialRequestBody implements SignInSocialRequestBody {
  const _SignInSocialRequestBody({required this.provider, @JsonKey(includeIfNull: false, name: 'callbackURL') this.callbackUrl, @JsonKey(includeIfNull: false, name: 'newUserCallbackURL') this.newUserCallbackUrl, @JsonKey(includeIfNull: false, name: 'errorCallbackURL') this.errorCallbackUrl, @JsonKey(includeIfNull: false) this.disableRedirect, @JsonKey(includeIfNull: false) this.idToken, @JsonKey(includeIfNull: false) final  List<dynamic>? scopes, @JsonKey(includeIfNull: false) this.requestSignUp, @JsonKey(includeIfNull: false) this.loginHint, @JsonKey(includeIfNull: false) this.additionalData}): _scopes = scopes;
  factory _SignInSocialRequestBody.fromJson(Map<String, dynamic> json) => _$SignInSocialRequestBodyFromJson(json);

@override final  String provider;
/// Callback URL to redirect to after the user has signed in
@override@JsonKey(includeIfNull: false, name: 'callbackURL') final  String? callbackUrl;
@override@JsonKey(includeIfNull: false, name: 'newUserCallbackURL') final  String? newUserCallbackUrl;
/// Callback URL to redirect to if an error happens
@override@JsonKey(includeIfNull: false, name: 'errorCallbackURL') final  String? errorCallbackUrl;
/// Disable automatic redirection to the provider. Useful for handling the redirection yourself
@override@JsonKey(includeIfNull: false) final  bool? disableRedirect;
@override@JsonKey(includeIfNull: false) final  IdToken? idToken;
/// Array of scopes to request from the provider. This will override the default scopes passed.
 final  List<dynamic>? _scopes;
/// Array of scopes to request from the provider. This will override the default scopes passed.
@override@JsonKey(includeIfNull: false) List<dynamic>? get scopes {
  final value = _scopes;
  if (value == null) return null;
  if (_scopes is EqualUnmodifiableListView) return _scopes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Explicitly request sign-up. Useful when disableImplicitSignUp is true for this provider
@override@JsonKey(includeIfNull: false) final  bool? requestSignUp;
/// The login hint to use for the authorization code request
@override@JsonKey(includeIfNull: false) final  String? loginHint;
@override@JsonKey(includeIfNull: false) final  String? additionalData;

/// Create a copy of SignInSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInSocialRequestBodyCopyWith<_SignInSocialRequestBody> get copyWith => __$SignInSocialRequestBodyCopyWithImpl<_SignInSocialRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignInSocialRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInSocialRequestBody&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl)&&(identical(other.newUserCallbackUrl, newUserCallbackUrl) || other.newUserCallbackUrl == newUserCallbackUrl)&&(identical(other.errorCallbackUrl, errorCallbackUrl) || other.errorCallbackUrl == errorCallbackUrl)&&(identical(other.disableRedirect, disableRedirect) || other.disableRedirect == disableRedirect)&&(identical(other.idToken, idToken) || other.idToken == idToken)&&const DeepCollectionEquality().equals(other._scopes, _scopes)&&(identical(other.requestSignUp, requestSignUp) || other.requestSignUp == requestSignUp)&&(identical(other.loginHint, loginHint) || other.loginHint == loginHint)&&(identical(other.additionalData, additionalData) || other.additionalData == additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,callbackUrl,newUserCallbackUrl,errorCallbackUrl,disableRedirect,idToken,const DeepCollectionEquality().hash(_scopes),requestSignUp,loginHint,additionalData);

@override
String toString() {
  return 'SignInSocialRequestBody(provider: $provider, callbackUrl: $callbackUrl, newUserCallbackUrl: $newUserCallbackUrl, errorCallbackUrl: $errorCallbackUrl, disableRedirect: $disableRedirect, idToken: $idToken, scopes: $scopes, requestSignUp: $requestSignUp, loginHint: $loginHint, additionalData: $additionalData)';
}


}

/// @nodoc
abstract mixin class _$SignInSocialRequestBodyCopyWith<$Res> implements $SignInSocialRequestBodyCopyWith<$Res> {
  factory _$SignInSocialRequestBodyCopyWith(_SignInSocialRequestBody value, $Res Function(_SignInSocialRequestBody) _then) = __$SignInSocialRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String provider,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl,@JsonKey(includeIfNull: false, name: 'newUserCallbackURL') String? newUserCallbackUrl,@JsonKey(includeIfNull: false, name: 'errorCallbackURL') String? errorCallbackUrl,@JsonKey(includeIfNull: false) bool? disableRedirect,@JsonKey(includeIfNull: false) IdToken? idToken,@JsonKey(includeIfNull: false) List<dynamic>? scopes,@JsonKey(includeIfNull: false) bool? requestSignUp,@JsonKey(includeIfNull: false) String? loginHint,@JsonKey(includeIfNull: false) String? additionalData
});


@override $IdTokenCopyWith<$Res>? get idToken;

}
/// @nodoc
class __$SignInSocialRequestBodyCopyWithImpl<$Res>
    implements _$SignInSocialRequestBodyCopyWith<$Res> {
  __$SignInSocialRequestBodyCopyWithImpl(this._self, this._then);

  final _SignInSocialRequestBody _self;
  final $Res Function(_SignInSocialRequestBody) _then;

/// Create a copy of SignInSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? callbackUrl = freezed,Object? newUserCallbackUrl = freezed,Object? errorCallbackUrl = freezed,Object? disableRedirect = freezed,Object? idToken = freezed,Object? scopes = freezed,Object? requestSignUp = freezed,Object? loginHint = freezed,Object? additionalData = freezed,}) {
  return _then(_SignInSocialRequestBody(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,newUserCallbackUrl: freezed == newUserCallbackUrl ? _self.newUserCallbackUrl : newUserCallbackUrl // ignore: cast_nullable_to_non_nullable
as String?,errorCallbackUrl: freezed == errorCallbackUrl ? _self.errorCallbackUrl : errorCallbackUrl // ignore: cast_nullable_to_non_nullable
as String?,disableRedirect: freezed == disableRedirect ? _self.disableRedirect : disableRedirect // ignore: cast_nullable_to_non_nullable
as bool?,idToken: freezed == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as IdToken?,scopes: freezed == scopes ? _self._scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,requestSignUp: freezed == requestSignUp ? _self.requestSignUp : requestSignUp // ignore: cast_nullable_to_non_nullable
as bool?,loginHint: freezed == loginHint ? _self.loginHint : loginHint // ignore: cast_nullable_to_non_nullable
as String?,additionalData: freezed == additionalData ? _self.additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SignInSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdTokenCopyWith<$Res>? get idToken {
    if (_self.idToken == null) {
    return null;
  }

  return $IdTokenCopyWith<$Res>(_self.idToken!, (value) {
    return _then(_self.copyWith(idToken: value));
  });
}
}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_social_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LinkSocialRequestBody {

 String get provider;/// The URL to redirect to after the user has signed in
@JsonKey(includeIfNull: false, name: 'callbackURL') String? get callbackUrl;@JsonKey(includeIfNull: false) IdToken2? get idToken;@JsonKey(includeIfNull: false) bool? get requestSignUp;/// Additional scopes to request from the provider
@JsonKey(includeIfNull: false) List<dynamic>? get scopes;/// The URL to redirect to if there is an error during the link process
@JsonKey(includeIfNull: false, name: 'errorCallbackURL') String? get errorCallbackUrl;/// Disable automatic redirection to the provider. Useful for handling the redirection yourself
@JsonKey(includeIfNull: false) bool? get disableRedirect;@JsonKey(includeIfNull: false) String? get additionalData;
/// Create a copy of LinkSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkSocialRequestBodyCopyWith<LinkSocialRequestBody> get copyWith => _$LinkSocialRequestBodyCopyWithImpl<LinkSocialRequestBody>(this as LinkSocialRequestBody, _$identity);

  /// Serializes this LinkSocialRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkSocialRequestBody&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl)&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.requestSignUp, requestSignUp) || other.requestSignUp == requestSignUp)&&const DeepCollectionEquality().equals(other.scopes, scopes)&&(identical(other.errorCallbackUrl, errorCallbackUrl) || other.errorCallbackUrl == errorCallbackUrl)&&(identical(other.disableRedirect, disableRedirect) || other.disableRedirect == disableRedirect)&&(identical(other.additionalData, additionalData) || other.additionalData == additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,callbackUrl,idToken,requestSignUp,const DeepCollectionEquality().hash(scopes),errorCallbackUrl,disableRedirect,additionalData);

@override
String toString() {
  return 'LinkSocialRequestBody(provider: $provider, callbackUrl: $callbackUrl, idToken: $idToken, requestSignUp: $requestSignUp, scopes: $scopes, errorCallbackUrl: $errorCallbackUrl, disableRedirect: $disableRedirect, additionalData: $additionalData)';
}


}

/// @nodoc
abstract mixin class $LinkSocialRequestBodyCopyWith<$Res>  {
  factory $LinkSocialRequestBodyCopyWith(LinkSocialRequestBody value, $Res Function(LinkSocialRequestBody) _then) = _$LinkSocialRequestBodyCopyWithImpl;
@useResult
$Res call({
 String provider,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl,@JsonKey(includeIfNull: false) IdToken2? idToken,@JsonKey(includeIfNull: false) bool? requestSignUp,@JsonKey(includeIfNull: false) List<dynamic>? scopes,@JsonKey(includeIfNull: false, name: 'errorCallbackURL') String? errorCallbackUrl,@JsonKey(includeIfNull: false) bool? disableRedirect,@JsonKey(includeIfNull: false) String? additionalData
});


$IdToken2CopyWith<$Res>? get idToken;

}
/// @nodoc
class _$LinkSocialRequestBodyCopyWithImpl<$Res>
    implements $LinkSocialRequestBodyCopyWith<$Res> {
  _$LinkSocialRequestBodyCopyWithImpl(this._self, this._then);

  final LinkSocialRequestBody _self;
  final $Res Function(LinkSocialRequestBody) _then;

/// Create a copy of LinkSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? callbackUrl = freezed,Object? idToken = freezed,Object? requestSignUp = freezed,Object? scopes = freezed,Object? errorCallbackUrl = freezed,Object? disableRedirect = freezed,Object? additionalData = freezed,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,idToken: freezed == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as IdToken2?,requestSignUp: freezed == requestSignUp ? _self.requestSignUp : requestSignUp // ignore: cast_nullable_to_non_nullable
as bool?,scopes: freezed == scopes ? _self.scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,errorCallbackUrl: freezed == errorCallbackUrl ? _self.errorCallbackUrl : errorCallbackUrl // ignore: cast_nullable_to_non_nullable
as String?,disableRedirect: freezed == disableRedirect ? _self.disableRedirect : disableRedirect // ignore: cast_nullable_to_non_nullable
as bool?,additionalData: freezed == additionalData ? _self.additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of LinkSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdToken2CopyWith<$Res>? get idToken {
    if (_self.idToken == null) {
    return null;
  }

  return $IdToken2CopyWith<$Res>(_self.idToken!, (value) {
    return _then(_self.copyWith(idToken: value));
  });
}
}


/// Adds pattern-matching-related methods to [LinkSocialRequestBody].
extension LinkSocialRequestBodyPatterns on LinkSocialRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkSocialRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkSocialRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkSocialRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _LinkSocialRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkSocialRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _LinkSocialRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String provider, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl, @JsonKey(includeIfNull: false)  IdToken2? idToken, @JsonKey(includeIfNull: false)  bool? requestSignUp, @JsonKey(includeIfNull: false)  List<dynamic>? scopes, @JsonKey(includeIfNull: false, name: 'errorCallbackURL')  String? errorCallbackUrl, @JsonKey(includeIfNull: false)  bool? disableRedirect, @JsonKey(includeIfNull: false)  String? additionalData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LinkSocialRequestBody() when $default != null:
return $default(_that.provider,_that.callbackUrl,_that.idToken,_that.requestSignUp,_that.scopes,_that.errorCallbackUrl,_that.disableRedirect,_that.additionalData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String provider, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl, @JsonKey(includeIfNull: false)  IdToken2? idToken, @JsonKey(includeIfNull: false)  bool? requestSignUp, @JsonKey(includeIfNull: false)  List<dynamic>? scopes, @JsonKey(includeIfNull: false, name: 'errorCallbackURL')  String? errorCallbackUrl, @JsonKey(includeIfNull: false)  bool? disableRedirect, @JsonKey(includeIfNull: false)  String? additionalData)  $default,) {final _that = this;
switch (_that) {
case _LinkSocialRequestBody():
return $default(_that.provider,_that.callbackUrl,_that.idToken,_that.requestSignUp,_that.scopes,_that.errorCallbackUrl,_that.disableRedirect,_that.additionalData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String provider, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl, @JsonKey(includeIfNull: false)  IdToken2? idToken, @JsonKey(includeIfNull: false)  bool? requestSignUp, @JsonKey(includeIfNull: false)  List<dynamic>? scopes, @JsonKey(includeIfNull: false, name: 'errorCallbackURL')  String? errorCallbackUrl, @JsonKey(includeIfNull: false)  bool? disableRedirect, @JsonKey(includeIfNull: false)  String? additionalData)?  $default,) {final _that = this;
switch (_that) {
case _LinkSocialRequestBody() when $default != null:
return $default(_that.provider,_that.callbackUrl,_that.idToken,_that.requestSignUp,_that.scopes,_that.errorCallbackUrl,_that.disableRedirect,_that.additionalData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LinkSocialRequestBody implements LinkSocialRequestBody {
  const _LinkSocialRequestBody({required this.provider, @JsonKey(includeIfNull: false, name: 'callbackURL') this.callbackUrl, @JsonKey(includeIfNull: false) this.idToken, @JsonKey(includeIfNull: false) this.requestSignUp, @JsonKey(includeIfNull: false) final  List<dynamic>? scopes, @JsonKey(includeIfNull: false, name: 'errorCallbackURL') this.errorCallbackUrl, @JsonKey(includeIfNull: false) this.disableRedirect, @JsonKey(includeIfNull: false) this.additionalData}): _scopes = scopes;
  factory _LinkSocialRequestBody.fromJson(Map<String, dynamic> json) => _$LinkSocialRequestBodyFromJson(json);

@override final  String provider;
/// The URL to redirect to after the user has signed in
@override@JsonKey(includeIfNull: false, name: 'callbackURL') final  String? callbackUrl;
@override@JsonKey(includeIfNull: false) final  IdToken2? idToken;
@override@JsonKey(includeIfNull: false) final  bool? requestSignUp;
/// Additional scopes to request from the provider
 final  List<dynamic>? _scopes;
/// Additional scopes to request from the provider
@override@JsonKey(includeIfNull: false) List<dynamic>? get scopes {
  final value = _scopes;
  if (value == null) return null;
  if (_scopes is EqualUnmodifiableListView) return _scopes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// The URL to redirect to if there is an error during the link process
@override@JsonKey(includeIfNull: false, name: 'errorCallbackURL') final  String? errorCallbackUrl;
/// Disable automatic redirection to the provider. Useful for handling the redirection yourself
@override@JsonKey(includeIfNull: false) final  bool? disableRedirect;
@override@JsonKey(includeIfNull: false) final  String? additionalData;

/// Create a copy of LinkSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkSocialRequestBodyCopyWith<_LinkSocialRequestBody> get copyWith => __$LinkSocialRequestBodyCopyWithImpl<_LinkSocialRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinkSocialRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkSocialRequestBody&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl)&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.requestSignUp, requestSignUp) || other.requestSignUp == requestSignUp)&&const DeepCollectionEquality().equals(other._scopes, _scopes)&&(identical(other.errorCallbackUrl, errorCallbackUrl) || other.errorCallbackUrl == errorCallbackUrl)&&(identical(other.disableRedirect, disableRedirect) || other.disableRedirect == disableRedirect)&&(identical(other.additionalData, additionalData) || other.additionalData == additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,callbackUrl,idToken,requestSignUp,const DeepCollectionEquality().hash(_scopes),errorCallbackUrl,disableRedirect,additionalData);

@override
String toString() {
  return 'LinkSocialRequestBody(provider: $provider, callbackUrl: $callbackUrl, idToken: $idToken, requestSignUp: $requestSignUp, scopes: $scopes, errorCallbackUrl: $errorCallbackUrl, disableRedirect: $disableRedirect, additionalData: $additionalData)';
}


}

/// @nodoc
abstract mixin class _$LinkSocialRequestBodyCopyWith<$Res> implements $LinkSocialRequestBodyCopyWith<$Res> {
  factory _$LinkSocialRequestBodyCopyWith(_LinkSocialRequestBody value, $Res Function(_LinkSocialRequestBody) _then) = __$LinkSocialRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String provider,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl,@JsonKey(includeIfNull: false) IdToken2? idToken,@JsonKey(includeIfNull: false) bool? requestSignUp,@JsonKey(includeIfNull: false) List<dynamic>? scopes,@JsonKey(includeIfNull: false, name: 'errorCallbackURL') String? errorCallbackUrl,@JsonKey(includeIfNull: false) bool? disableRedirect,@JsonKey(includeIfNull: false) String? additionalData
});


@override $IdToken2CopyWith<$Res>? get idToken;

}
/// @nodoc
class __$LinkSocialRequestBodyCopyWithImpl<$Res>
    implements _$LinkSocialRequestBodyCopyWith<$Res> {
  __$LinkSocialRequestBodyCopyWithImpl(this._self, this._then);

  final _LinkSocialRequestBody _self;
  final $Res Function(_LinkSocialRequestBody) _then;

/// Create a copy of LinkSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? callbackUrl = freezed,Object? idToken = freezed,Object? requestSignUp = freezed,Object? scopes = freezed,Object? errorCallbackUrl = freezed,Object? disableRedirect = freezed,Object? additionalData = freezed,}) {
  return _then(_LinkSocialRequestBody(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,idToken: freezed == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as IdToken2?,requestSignUp: freezed == requestSignUp ? _self.requestSignUp : requestSignUp // ignore: cast_nullable_to_non_nullable
as bool?,scopes: freezed == scopes ? _self._scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,errorCallbackUrl: freezed == errorCallbackUrl ? _self.errorCallbackUrl : errorCallbackUrl // ignore: cast_nullable_to_non_nullable
as String?,disableRedirect: freezed == disableRedirect ? _self.disableRedirect : disableRedirect // ignore: cast_nullable_to_non_nullable
as bool?,additionalData: freezed == additionalData ? _self.additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LinkSocialRequestBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdToken2CopyWith<$Res>? get idToken {
    if (_self.idToken == null) {
    return null;
  }

  return $IdToken2CopyWith<$Res>(_self.idToken!, (value) {
    return _then(_self.copyWith(idToken: value));
  });
}
}

// dart format on

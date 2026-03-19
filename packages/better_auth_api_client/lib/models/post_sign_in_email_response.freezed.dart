// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_sign_in_email_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostSignInEmailResponse {

 Redirect get redirect;/// Session token
 String get token; User get user;@JsonKey(includeIfNull: false) String? get url;
/// Create a copy of PostSignInEmailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostSignInEmailResponseCopyWith<PostSignInEmailResponse> get copyWith => _$PostSignInEmailResponseCopyWithImpl<PostSignInEmailResponse>(this as PostSignInEmailResponse, _$identity);

  /// Serializes this PostSignInEmailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostSignInEmailResponse&&(identical(other.redirect, redirect) || other.redirect == redirect)&&(identical(other.token, token) || other.token == token)&&(identical(other.user, user) || other.user == user)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,redirect,token,user,url);

@override
String toString() {
  return 'PostSignInEmailResponse(redirect: $redirect, token: $token, user: $user, url: $url)';
}


}

/// @nodoc
abstract mixin class $PostSignInEmailResponseCopyWith<$Res>  {
  factory $PostSignInEmailResponseCopyWith(PostSignInEmailResponse value, $Res Function(PostSignInEmailResponse) _then) = _$PostSignInEmailResponseCopyWithImpl;
@useResult
$Res call({
 Redirect redirect, String token, User user,@JsonKey(includeIfNull: false) String? url
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$PostSignInEmailResponseCopyWithImpl<$Res>
    implements $PostSignInEmailResponseCopyWith<$Res> {
  _$PostSignInEmailResponseCopyWithImpl(this._self, this._then);

  final PostSignInEmailResponse _self;
  final $Res Function(PostSignInEmailResponse) _then;

/// Create a copy of PostSignInEmailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? redirect = null,Object? token = null,Object? user = null,Object? url = freezed,}) {
  return _then(_self.copyWith(
redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as Redirect,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PostSignInEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostSignInEmailResponse].
extension PostSignInEmailResponsePatterns on PostSignInEmailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostSignInEmailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostSignInEmailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostSignInEmailResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostSignInEmailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostSignInEmailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostSignInEmailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Redirect redirect,  String token,  User user, @JsonKey(includeIfNull: false)  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostSignInEmailResponse() when $default != null:
return $default(_that.redirect,_that.token,_that.user,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Redirect redirect,  String token,  User user, @JsonKey(includeIfNull: false)  String? url)  $default,) {final _that = this;
switch (_that) {
case _PostSignInEmailResponse():
return $default(_that.redirect,_that.token,_that.user,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Redirect redirect,  String token,  User user, @JsonKey(includeIfNull: false)  String? url)?  $default,) {final _that = this;
switch (_that) {
case _PostSignInEmailResponse() when $default != null:
return $default(_that.redirect,_that.token,_that.user,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostSignInEmailResponse implements PostSignInEmailResponse {
  const _PostSignInEmailResponse({required this.redirect, required this.token, required this.user, @JsonKey(includeIfNull: false) this.url});
  factory _PostSignInEmailResponse.fromJson(Map<String, dynamic> json) => _$PostSignInEmailResponseFromJson(json);

@override final  Redirect redirect;
/// Session token
@override final  String token;
@override final  User user;
@override@JsonKey(includeIfNull: false) final  String? url;

/// Create a copy of PostSignInEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostSignInEmailResponseCopyWith<_PostSignInEmailResponse> get copyWith => __$PostSignInEmailResponseCopyWithImpl<_PostSignInEmailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostSignInEmailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostSignInEmailResponse&&(identical(other.redirect, redirect) || other.redirect == redirect)&&(identical(other.token, token) || other.token == token)&&(identical(other.user, user) || other.user == user)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,redirect,token,user,url);

@override
String toString() {
  return 'PostSignInEmailResponse(redirect: $redirect, token: $token, user: $user, url: $url)';
}


}

/// @nodoc
abstract mixin class _$PostSignInEmailResponseCopyWith<$Res> implements $PostSignInEmailResponseCopyWith<$Res> {
  factory _$PostSignInEmailResponseCopyWith(_PostSignInEmailResponse value, $Res Function(_PostSignInEmailResponse) _then) = __$PostSignInEmailResponseCopyWithImpl;
@override @useResult
$Res call({
 Redirect redirect, String token, User user,@JsonKey(includeIfNull: false) String? url
});


@override $UserCopyWith<$Res> get user;

}
/// @nodoc
class __$PostSignInEmailResponseCopyWithImpl<$Res>
    implements _$PostSignInEmailResponseCopyWith<$Res> {
  __$PostSignInEmailResponseCopyWithImpl(this._self, this._then);

  final _PostSignInEmailResponse _self;
  final $Res Function(_PostSignInEmailResponse) _then;

/// Create a copy of PostSignInEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? redirect = null,Object? token = null,Object? user = null,Object? url = freezed,}) {
  return _then(_PostSignInEmailResponse(
redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as Redirect,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PostSignInEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on

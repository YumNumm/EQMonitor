// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_sign_in_social_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostSignInSocialResponse {

 String get token; User get user; Redirect get redirect;@JsonKey(includeIfNull: false) String? get url;
/// Create a copy of PostSignInSocialResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostSignInSocialResponseCopyWith<PostSignInSocialResponse> get copyWith => _$PostSignInSocialResponseCopyWithImpl<PostSignInSocialResponse>(this as PostSignInSocialResponse, _$identity);

  /// Serializes this PostSignInSocialResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostSignInSocialResponse&&(identical(other.token, token) || other.token == token)&&(identical(other.user, user) || other.user == user)&&(identical(other.redirect, redirect) || other.redirect == redirect)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,user,redirect,url);

@override
String toString() {
  return 'PostSignInSocialResponse(token: $token, user: $user, redirect: $redirect, url: $url)';
}


}

/// @nodoc
abstract mixin class $PostSignInSocialResponseCopyWith<$Res>  {
  factory $PostSignInSocialResponseCopyWith(PostSignInSocialResponse value, $Res Function(PostSignInSocialResponse) _then) = _$PostSignInSocialResponseCopyWithImpl;
@useResult
$Res call({
 String token, User user, Redirect redirect,@JsonKey(includeIfNull: false) String? url
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$PostSignInSocialResponseCopyWithImpl<$Res>
    implements $PostSignInSocialResponseCopyWith<$Res> {
  _$PostSignInSocialResponseCopyWithImpl(this._self, this._then);

  final PostSignInSocialResponse _self;
  final $Res Function(PostSignInSocialResponse) _then;

/// Create a copy of PostSignInSocialResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? user = null,Object? redirect = null,Object? url = freezed,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as Redirect,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PostSignInSocialResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostSignInSocialResponse].
extension PostSignInSocialResponsePatterns on PostSignInSocialResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostSignInSocialResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostSignInSocialResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostSignInSocialResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostSignInSocialResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostSignInSocialResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostSignInSocialResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  User user,  Redirect redirect, @JsonKey(includeIfNull: false)  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostSignInSocialResponse() when $default != null:
return $default(_that.token,_that.user,_that.redirect,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  User user,  Redirect redirect, @JsonKey(includeIfNull: false)  String? url)  $default,) {final _that = this;
switch (_that) {
case _PostSignInSocialResponse():
return $default(_that.token,_that.user,_that.redirect,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  User user,  Redirect redirect, @JsonKey(includeIfNull: false)  String? url)?  $default,) {final _that = this;
switch (_that) {
case _PostSignInSocialResponse() when $default != null:
return $default(_that.token,_that.user,_that.redirect,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostSignInSocialResponse implements PostSignInSocialResponse {
  const _PostSignInSocialResponse({required this.token, required this.user, required this.redirect, @JsonKey(includeIfNull: false) this.url});
  factory _PostSignInSocialResponse.fromJson(Map<String, dynamic> json) => _$PostSignInSocialResponseFromJson(json);

@override final  String token;
@override final  User user;
@override final  Redirect redirect;
@override@JsonKey(includeIfNull: false) final  String? url;

/// Create a copy of PostSignInSocialResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostSignInSocialResponseCopyWith<_PostSignInSocialResponse> get copyWith => __$PostSignInSocialResponseCopyWithImpl<_PostSignInSocialResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostSignInSocialResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostSignInSocialResponse&&(identical(other.token, token) || other.token == token)&&(identical(other.user, user) || other.user == user)&&(identical(other.redirect, redirect) || other.redirect == redirect)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,user,redirect,url);

@override
String toString() {
  return 'PostSignInSocialResponse(token: $token, user: $user, redirect: $redirect, url: $url)';
}


}

/// @nodoc
abstract mixin class _$PostSignInSocialResponseCopyWith<$Res> implements $PostSignInSocialResponseCopyWith<$Res> {
  factory _$PostSignInSocialResponseCopyWith(_PostSignInSocialResponse value, $Res Function(_PostSignInSocialResponse) _then) = __$PostSignInSocialResponseCopyWithImpl;
@override @useResult
$Res call({
 String token, User user, Redirect redirect,@JsonKey(includeIfNull: false) String? url
});


@override $UserCopyWith<$Res> get user;

}
/// @nodoc
class __$PostSignInSocialResponseCopyWithImpl<$Res>
    implements _$PostSignInSocialResponseCopyWith<$Res> {
  __$PostSignInSocialResponseCopyWithImpl(this._self, this._then);

  final _PostSignInSocialResponse _self;
  final $Res Function(_PostSignInSocialResponse) _then;

/// Create a copy of PostSignInSocialResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? user = null,Object? redirect = null,Object? url = freezed,}) {
  return _then(_PostSignInSocialResponse(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as Redirect,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PostSignInSocialResponse
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

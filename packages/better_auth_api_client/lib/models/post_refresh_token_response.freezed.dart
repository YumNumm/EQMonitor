// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_refresh_token_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostRefreshTokenResponse {

 String get tokenType; String get idToken; String get accessToken; String get refreshToken; DateTime get accessTokenExpiresAt; DateTime get refreshTokenExpiresAt;
/// Create a copy of PostRefreshTokenResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostRefreshTokenResponseCopyWith<PostRefreshTokenResponse> get copyWith => _$PostRefreshTokenResponseCopyWithImpl<PostRefreshTokenResponse>(this as PostRefreshTokenResponse, _$identity);

  /// Serializes this PostRefreshTokenResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostRefreshTokenResponse&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.accessTokenExpiresAt, accessTokenExpiresAt) || other.accessTokenExpiresAt == accessTokenExpiresAt)&&(identical(other.refreshTokenExpiresAt, refreshTokenExpiresAt) || other.refreshTokenExpiresAt == refreshTokenExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tokenType,idToken,accessToken,refreshToken,accessTokenExpiresAt,refreshTokenExpiresAt);

@override
String toString() {
  return 'PostRefreshTokenResponse(tokenType: $tokenType, idToken: $idToken, accessToken: $accessToken, refreshToken: $refreshToken, accessTokenExpiresAt: $accessTokenExpiresAt, refreshTokenExpiresAt: $refreshTokenExpiresAt)';
}


}

/// @nodoc
abstract mixin class $PostRefreshTokenResponseCopyWith<$Res>  {
  factory $PostRefreshTokenResponseCopyWith(PostRefreshTokenResponse value, $Res Function(PostRefreshTokenResponse) _then) = _$PostRefreshTokenResponseCopyWithImpl;
@useResult
$Res call({
 String tokenType, String idToken, String accessToken, String refreshToken, DateTime accessTokenExpiresAt, DateTime refreshTokenExpiresAt
});




}
/// @nodoc
class _$PostRefreshTokenResponseCopyWithImpl<$Res>
    implements $PostRefreshTokenResponseCopyWith<$Res> {
  _$PostRefreshTokenResponseCopyWithImpl(this._self, this._then);

  final PostRefreshTokenResponse _self;
  final $Res Function(PostRefreshTokenResponse) _then;

/// Create a copy of PostRefreshTokenResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tokenType = null,Object? idToken = null,Object? accessToken = null,Object? refreshToken = null,Object? accessTokenExpiresAt = null,Object? refreshTokenExpiresAt = null,}) {
  return _then(_self.copyWith(
tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,accessTokenExpiresAt: null == accessTokenExpiresAt ? _self.accessTokenExpiresAt : accessTokenExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,refreshTokenExpiresAt: null == refreshTokenExpiresAt ? _self.refreshTokenExpiresAt : refreshTokenExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PostRefreshTokenResponse].
extension PostRefreshTokenResponsePatterns on PostRefreshTokenResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostRefreshTokenResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostRefreshTokenResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostRefreshTokenResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostRefreshTokenResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostRefreshTokenResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostRefreshTokenResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tokenType,  String idToken,  String accessToken,  String refreshToken,  DateTime accessTokenExpiresAt,  DateTime refreshTokenExpiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostRefreshTokenResponse() when $default != null:
return $default(_that.tokenType,_that.idToken,_that.accessToken,_that.refreshToken,_that.accessTokenExpiresAt,_that.refreshTokenExpiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tokenType,  String idToken,  String accessToken,  String refreshToken,  DateTime accessTokenExpiresAt,  DateTime refreshTokenExpiresAt)  $default,) {final _that = this;
switch (_that) {
case _PostRefreshTokenResponse():
return $default(_that.tokenType,_that.idToken,_that.accessToken,_that.refreshToken,_that.accessTokenExpiresAt,_that.refreshTokenExpiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tokenType,  String idToken,  String accessToken,  String refreshToken,  DateTime accessTokenExpiresAt,  DateTime refreshTokenExpiresAt)?  $default,) {final _that = this;
switch (_that) {
case _PostRefreshTokenResponse() when $default != null:
return $default(_that.tokenType,_that.idToken,_that.accessToken,_that.refreshToken,_that.accessTokenExpiresAt,_that.refreshTokenExpiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostRefreshTokenResponse implements PostRefreshTokenResponse {
  const _PostRefreshTokenResponse({required this.tokenType, required this.idToken, required this.accessToken, required this.refreshToken, required this.accessTokenExpiresAt, required this.refreshTokenExpiresAt});
  factory _PostRefreshTokenResponse.fromJson(Map<String, dynamic> json) => _$PostRefreshTokenResponseFromJson(json);

@override final  String tokenType;
@override final  String idToken;
@override final  String accessToken;
@override final  String refreshToken;
@override final  DateTime accessTokenExpiresAt;
@override final  DateTime refreshTokenExpiresAt;

/// Create a copy of PostRefreshTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostRefreshTokenResponseCopyWith<_PostRefreshTokenResponse> get copyWith => __$PostRefreshTokenResponseCopyWithImpl<_PostRefreshTokenResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostRefreshTokenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostRefreshTokenResponse&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.accessTokenExpiresAt, accessTokenExpiresAt) || other.accessTokenExpiresAt == accessTokenExpiresAt)&&(identical(other.refreshTokenExpiresAt, refreshTokenExpiresAt) || other.refreshTokenExpiresAt == refreshTokenExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tokenType,idToken,accessToken,refreshToken,accessTokenExpiresAt,refreshTokenExpiresAt);

@override
String toString() {
  return 'PostRefreshTokenResponse(tokenType: $tokenType, idToken: $idToken, accessToken: $accessToken, refreshToken: $refreshToken, accessTokenExpiresAt: $accessTokenExpiresAt, refreshTokenExpiresAt: $refreshTokenExpiresAt)';
}


}

/// @nodoc
abstract mixin class _$PostRefreshTokenResponseCopyWith<$Res> implements $PostRefreshTokenResponseCopyWith<$Res> {
  factory _$PostRefreshTokenResponseCopyWith(_PostRefreshTokenResponse value, $Res Function(_PostRefreshTokenResponse) _then) = __$PostRefreshTokenResponseCopyWithImpl;
@override @useResult
$Res call({
 String tokenType, String idToken, String accessToken, String refreshToken, DateTime accessTokenExpiresAt, DateTime refreshTokenExpiresAt
});




}
/// @nodoc
class __$PostRefreshTokenResponseCopyWithImpl<$Res>
    implements _$PostRefreshTokenResponseCopyWith<$Res> {
  __$PostRefreshTokenResponseCopyWithImpl(this._self, this._then);

  final _PostRefreshTokenResponse _self;
  final $Res Function(_PostRefreshTokenResponse) _then;

/// Create a copy of PostRefreshTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tokenType = null,Object? idToken = null,Object? accessToken = null,Object? refreshToken = null,Object? accessTokenExpiresAt = null,Object? refreshTokenExpiresAt = null,}) {
  return _then(_PostRefreshTokenResponse(
tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,accessTokenExpiresAt: null == accessTokenExpiresAt ? _self.accessTokenExpiresAt : accessTokenExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,refreshTokenExpiresAt: null == refreshTokenExpiresAt ? _self.refreshTokenExpiresAt : refreshTokenExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

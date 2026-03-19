// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_get_access_token_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostGetAccessTokenResponse {

 String get tokenType; String get idToken; String get accessToken; DateTime get accessTokenExpiresAt;
/// Create a copy of PostGetAccessTokenResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostGetAccessTokenResponseCopyWith<PostGetAccessTokenResponse> get copyWith => _$PostGetAccessTokenResponseCopyWithImpl<PostGetAccessTokenResponse>(this as PostGetAccessTokenResponse, _$identity);

  /// Serializes this PostGetAccessTokenResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostGetAccessTokenResponse&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.accessTokenExpiresAt, accessTokenExpiresAt) || other.accessTokenExpiresAt == accessTokenExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tokenType,idToken,accessToken,accessTokenExpiresAt);

@override
String toString() {
  return 'PostGetAccessTokenResponse(tokenType: $tokenType, idToken: $idToken, accessToken: $accessToken, accessTokenExpiresAt: $accessTokenExpiresAt)';
}


}

/// @nodoc
abstract mixin class $PostGetAccessTokenResponseCopyWith<$Res>  {
  factory $PostGetAccessTokenResponseCopyWith(PostGetAccessTokenResponse value, $Res Function(PostGetAccessTokenResponse) _then) = _$PostGetAccessTokenResponseCopyWithImpl;
@useResult
$Res call({
 String tokenType, String idToken, String accessToken, DateTime accessTokenExpiresAt
});




}
/// @nodoc
class _$PostGetAccessTokenResponseCopyWithImpl<$Res>
    implements $PostGetAccessTokenResponseCopyWith<$Res> {
  _$PostGetAccessTokenResponseCopyWithImpl(this._self, this._then);

  final PostGetAccessTokenResponse _self;
  final $Res Function(PostGetAccessTokenResponse) _then;

/// Create a copy of PostGetAccessTokenResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tokenType = null,Object? idToken = null,Object? accessToken = null,Object? accessTokenExpiresAt = null,}) {
  return _then(_self.copyWith(
tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,accessTokenExpiresAt: null == accessTokenExpiresAt ? _self.accessTokenExpiresAt : accessTokenExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PostGetAccessTokenResponse].
extension PostGetAccessTokenResponsePatterns on PostGetAccessTokenResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostGetAccessTokenResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostGetAccessTokenResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostGetAccessTokenResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostGetAccessTokenResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostGetAccessTokenResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostGetAccessTokenResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tokenType,  String idToken,  String accessToken,  DateTime accessTokenExpiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostGetAccessTokenResponse() when $default != null:
return $default(_that.tokenType,_that.idToken,_that.accessToken,_that.accessTokenExpiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tokenType,  String idToken,  String accessToken,  DateTime accessTokenExpiresAt)  $default,) {final _that = this;
switch (_that) {
case _PostGetAccessTokenResponse():
return $default(_that.tokenType,_that.idToken,_that.accessToken,_that.accessTokenExpiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tokenType,  String idToken,  String accessToken,  DateTime accessTokenExpiresAt)?  $default,) {final _that = this;
switch (_that) {
case _PostGetAccessTokenResponse() when $default != null:
return $default(_that.tokenType,_that.idToken,_that.accessToken,_that.accessTokenExpiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostGetAccessTokenResponse implements PostGetAccessTokenResponse {
  const _PostGetAccessTokenResponse({required this.tokenType, required this.idToken, required this.accessToken, required this.accessTokenExpiresAt});
  factory _PostGetAccessTokenResponse.fromJson(Map<String, dynamic> json) => _$PostGetAccessTokenResponseFromJson(json);

@override final  String tokenType;
@override final  String idToken;
@override final  String accessToken;
@override final  DateTime accessTokenExpiresAt;

/// Create a copy of PostGetAccessTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostGetAccessTokenResponseCopyWith<_PostGetAccessTokenResponse> get copyWith => __$PostGetAccessTokenResponseCopyWithImpl<_PostGetAccessTokenResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostGetAccessTokenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostGetAccessTokenResponse&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.accessTokenExpiresAt, accessTokenExpiresAt) || other.accessTokenExpiresAt == accessTokenExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tokenType,idToken,accessToken,accessTokenExpiresAt);

@override
String toString() {
  return 'PostGetAccessTokenResponse(tokenType: $tokenType, idToken: $idToken, accessToken: $accessToken, accessTokenExpiresAt: $accessTokenExpiresAt)';
}


}

/// @nodoc
abstract mixin class _$PostGetAccessTokenResponseCopyWith<$Res> implements $PostGetAccessTokenResponseCopyWith<$Res> {
  factory _$PostGetAccessTokenResponseCopyWith(_PostGetAccessTokenResponse value, $Res Function(_PostGetAccessTokenResponse) _then) = __$PostGetAccessTokenResponseCopyWithImpl;
@override @useResult
$Res call({
 String tokenType, String idToken, String accessToken, DateTime accessTokenExpiresAt
});




}
/// @nodoc
class __$PostGetAccessTokenResponseCopyWithImpl<$Res>
    implements _$PostGetAccessTokenResponseCopyWith<$Res> {
  __$PostGetAccessTokenResponseCopyWithImpl(this._self, this._then);

  final _PostGetAccessTokenResponse _self;
  final $Res Function(_PostGetAccessTokenResponse) _then;

/// Create a copy of PostGetAccessTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tokenType = null,Object? idToken = null,Object? accessToken = null,Object? accessTokenExpiresAt = null,}) {
  return _then(_PostGetAccessTokenResponse(
tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,accessTokenExpiresAt: null == accessTokenExpiresAt ? _self.accessTokenExpiresAt : accessTokenExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

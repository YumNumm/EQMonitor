// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'id_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IdToken {

/// ID token from the provider
 String get token;/// Nonce used to generate the token
@JsonKey(includeIfNull: false) String? get nonce;/// Access token from the provider
@JsonKey(includeIfNull: false) String? get accessToken;/// Refresh token from the provider
@JsonKey(includeIfNull: false) String? get refreshToken;/// Expiry date of the token
@JsonKey(includeIfNull: false) num? get expiresAt;/// The user object from the provider. Only available for some providers like Apple.
@JsonKey(includeIfNull: false) User? get user;
/// Create a copy of IdToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IdTokenCopyWith<IdToken> get copyWith => _$IdTokenCopyWithImpl<IdToken>(this as IdToken, _$identity);

  /// Serializes this IdToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IdToken&&(identical(other.token, token) || other.token == token)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,nonce,accessToken,refreshToken,expiresAt,user);

@override
String toString() {
  return 'IdToken(token: $token, nonce: $nonce, accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt, user: $user)';
}


}

/// @nodoc
abstract mixin class $IdTokenCopyWith<$Res>  {
  factory $IdTokenCopyWith(IdToken value, $Res Function(IdToken) _then) = _$IdTokenCopyWithImpl;
@useResult
$Res call({
 String token,@JsonKey(includeIfNull: false) String? nonce,@JsonKey(includeIfNull: false) String? accessToken,@JsonKey(includeIfNull: false) String? refreshToken,@JsonKey(includeIfNull: false) num? expiresAt,@JsonKey(includeIfNull: false) User? user
});


$UserCopyWith<$Res>? get user;

}
/// @nodoc
class _$IdTokenCopyWithImpl<$Res>
    implements $IdTokenCopyWith<$Res> {
  _$IdTokenCopyWithImpl(this._self, this._then);

  final IdToken _self;
  final $Res Function(IdToken) _then;

/// Create a copy of IdToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? nonce = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? expiresAt = freezed,Object? user = freezed,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,nonce: freezed == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as num?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}
/// Create a copy of IdToken
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [IdToken].
extension IdTokenPatterns on IdToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IdToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IdToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IdToken value)  $default,){
final _that = this;
switch (_that) {
case _IdToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IdToken value)?  $default,){
final _that = this;
switch (_that) {
case _IdToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token, @JsonKey(includeIfNull: false)  String? nonce, @JsonKey(includeIfNull: false)  String? accessToken, @JsonKey(includeIfNull: false)  String? refreshToken, @JsonKey(includeIfNull: false)  num? expiresAt, @JsonKey(includeIfNull: false)  User? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IdToken() when $default != null:
return $default(_that.token,_that.nonce,_that.accessToken,_that.refreshToken,_that.expiresAt,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token, @JsonKey(includeIfNull: false)  String? nonce, @JsonKey(includeIfNull: false)  String? accessToken, @JsonKey(includeIfNull: false)  String? refreshToken, @JsonKey(includeIfNull: false)  num? expiresAt, @JsonKey(includeIfNull: false)  User? user)  $default,) {final _that = this;
switch (_that) {
case _IdToken():
return $default(_that.token,_that.nonce,_that.accessToken,_that.refreshToken,_that.expiresAt,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token, @JsonKey(includeIfNull: false)  String? nonce, @JsonKey(includeIfNull: false)  String? accessToken, @JsonKey(includeIfNull: false)  String? refreshToken, @JsonKey(includeIfNull: false)  num? expiresAt, @JsonKey(includeIfNull: false)  User? user)?  $default,) {final _that = this;
switch (_that) {
case _IdToken() when $default != null:
return $default(_that.token,_that.nonce,_that.accessToken,_that.refreshToken,_that.expiresAt,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IdToken implements IdToken {
  const _IdToken({required this.token, @JsonKey(includeIfNull: false) this.nonce, @JsonKey(includeIfNull: false) this.accessToken, @JsonKey(includeIfNull: false) this.refreshToken, @JsonKey(includeIfNull: false) this.expiresAt, @JsonKey(includeIfNull: false) this.user});
  factory _IdToken.fromJson(Map<String, dynamic> json) => _$IdTokenFromJson(json);

/// ID token from the provider
@override final  String token;
/// Nonce used to generate the token
@override@JsonKey(includeIfNull: false) final  String? nonce;
/// Access token from the provider
@override@JsonKey(includeIfNull: false) final  String? accessToken;
/// Refresh token from the provider
@override@JsonKey(includeIfNull: false) final  String? refreshToken;
/// Expiry date of the token
@override@JsonKey(includeIfNull: false) final  num? expiresAt;
/// The user object from the provider. Only available for some providers like Apple.
@override@JsonKey(includeIfNull: false) final  User? user;

/// Create a copy of IdToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IdTokenCopyWith<_IdToken> get copyWith => __$IdTokenCopyWithImpl<_IdToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IdTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IdToken&&(identical(other.token, token) || other.token == token)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,nonce,accessToken,refreshToken,expiresAt,user);

@override
String toString() {
  return 'IdToken(token: $token, nonce: $nonce, accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt, user: $user)';
}


}

/// @nodoc
abstract mixin class _$IdTokenCopyWith<$Res> implements $IdTokenCopyWith<$Res> {
  factory _$IdTokenCopyWith(_IdToken value, $Res Function(_IdToken) _then) = __$IdTokenCopyWithImpl;
@override @useResult
$Res call({
 String token,@JsonKey(includeIfNull: false) String? nonce,@JsonKey(includeIfNull: false) String? accessToken,@JsonKey(includeIfNull: false) String? refreshToken,@JsonKey(includeIfNull: false) num? expiresAt,@JsonKey(includeIfNull: false) User? user
});


@override $UserCopyWith<$Res>? get user;

}
/// @nodoc
class __$IdTokenCopyWithImpl<$Res>
    implements _$IdTokenCopyWith<$Res> {
  __$IdTokenCopyWithImpl(this._self, this._then);

  final _IdToken _self;
  final $Res Function(_IdToken) _then;

/// Create a copy of IdToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? nonce = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? expiresAt = freezed,Object? user = freezed,}) {
  return _then(_IdToken(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,nonce: freezed == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as num?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}

/// Create a copy of IdToken
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on

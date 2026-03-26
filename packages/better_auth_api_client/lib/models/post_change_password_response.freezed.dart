// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_change_password_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostChangePasswordResponse {

 User3 get user;/// New session token if other sessions were revoked
@JsonKey(includeIfNull: false) String? get token;
/// Create a copy of PostChangePasswordResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostChangePasswordResponseCopyWith<PostChangePasswordResponse> get copyWith => _$PostChangePasswordResponseCopyWithImpl<PostChangePasswordResponse>(this as PostChangePasswordResponse, _$identity);

  /// Serializes this PostChangePasswordResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostChangePasswordResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,token);

@override
String toString() {
  return 'PostChangePasswordResponse(user: $user, token: $token)';
}


}

/// @nodoc
abstract mixin class $PostChangePasswordResponseCopyWith<$Res>  {
  factory $PostChangePasswordResponseCopyWith(PostChangePasswordResponse value, $Res Function(PostChangePasswordResponse) _then) = _$PostChangePasswordResponseCopyWithImpl;
@useResult
$Res call({
 User3 user,@JsonKey(includeIfNull: false) String? token
});


$User3CopyWith<$Res> get user;

}
/// @nodoc
class _$PostChangePasswordResponseCopyWithImpl<$Res>
    implements $PostChangePasswordResponseCopyWith<$Res> {
  _$PostChangePasswordResponseCopyWithImpl(this._self, this._then);

  final PostChangePasswordResponse _self;
  final $Res Function(PostChangePasswordResponse) _then;

/// Create a copy of PostChangePasswordResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? token = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User3,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PostChangePasswordResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$User3CopyWith<$Res> get user {
  
  return $User3CopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostChangePasswordResponse].
extension PostChangePasswordResponsePatterns on PostChangePasswordResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostChangePasswordResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostChangePasswordResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostChangePasswordResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostChangePasswordResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostChangePasswordResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostChangePasswordResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User3 user, @JsonKey(includeIfNull: false)  String? token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostChangePasswordResponse() when $default != null:
return $default(_that.user,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User3 user, @JsonKey(includeIfNull: false)  String? token)  $default,) {final _that = this;
switch (_that) {
case _PostChangePasswordResponse():
return $default(_that.user,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User3 user, @JsonKey(includeIfNull: false)  String? token)?  $default,) {final _that = this;
switch (_that) {
case _PostChangePasswordResponse() when $default != null:
return $default(_that.user,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostChangePasswordResponse implements PostChangePasswordResponse {
  const _PostChangePasswordResponse({required this.user, @JsonKey(includeIfNull: false) this.token});
  factory _PostChangePasswordResponse.fromJson(Map<String, dynamic> json) => _$PostChangePasswordResponseFromJson(json);

@override final  User3 user;
/// New session token if other sessions were revoked
@override@JsonKey(includeIfNull: false) final  String? token;

/// Create a copy of PostChangePasswordResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostChangePasswordResponseCopyWith<_PostChangePasswordResponse> get copyWith => __$PostChangePasswordResponseCopyWithImpl<_PostChangePasswordResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostChangePasswordResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostChangePasswordResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,token);

@override
String toString() {
  return 'PostChangePasswordResponse(user: $user, token: $token)';
}


}

/// @nodoc
abstract mixin class _$PostChangePasswordResponseCopyWith<$Res> implements $PostChangePasswordResponseCopyWith<$Res> {
  factory _$PostChangePasswordResponseCopyWith(_PostChangePasswordResponse value, $Res Function(_PostChangePasswordResponse) _then) = __$PostChangePasswordResponseCopyWithImpl;
@override @useResult
$Res call({
 User3 user,@JsonKey(includeIfNull: false) String? token
});


@override $User3CopyWith<$Res> get user;

}
/// @nodoc
class __$PostChangePasswordResponseCopyWithImpl<$Res>
    implements _$PostChangePasswordResponseCopyWith<$Res> {
  __$PostChangePasswordResponseCopyWithImpl(this._self, this._then);

  final _PostChangePasswordResponse _self;
  final $Res Function(_PostChangePasswordResponse) _then;

/// Create a copy of PostChangePasswordResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? token = freezed,}) {
  return _then(_PostChangePasswordResponse(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User3,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PostChangePasswordResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$User3CopyWith<$Res> get user {
  
  return $User3CopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on

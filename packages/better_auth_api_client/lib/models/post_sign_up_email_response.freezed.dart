// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_sign_up_email_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostSignUpEmailResponse {

 User2 get user;/// Authentication token for the session
@JsonKey(includeIfNull: false) String? get token;
/// Create a copy of PostSignUpEmailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostSignUpEmailResponseCopyWith<PostSignUpEmailResponse> get copyWith => _$PostSignUpEmailResponseCopyWithImpl<PostSignUpEmailResponse>(this as PostSignUpEmailResponse, _$identity);

  /// Serializes this PostSignUpEmailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostSignUpEmailResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,token);

@override
String toString() {
  return 'PostSignUpEmailResponse(user: $user, token: $token)';
}


}

/// @nodoc
abstract mixin class $PostSignUpEmailResponseCopyWith<$Res>  {
  factory $PostSignUpEmailResponseCopyWith(PostSignUpEmailResponse value, $Res Function(PostSignUpEmailResponse) _then) = _$PostSignUpEmailResponseCopyWithImpl;
@useResult
$Res call({
 User2 user,@JsonKey(includeIfNull: false) String? token
});


$User2CopyWith<$Res> get user;

}
/// @nodoc
class _$PostSignUpEmailResponseCopyWithImpl<$Res>
    implements $PostSignUpEmailResponseCopyWith<$Res> {
  _$PostSignUpEmailResponseCopyWithImpl(this._self, this._then);

  final PostSignUpEmailResponse _self;
  final $Res Function(PostSignUpEmailResponse) _then;

/// Create a copy of PostSignUpEmailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? token = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User2,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PostSignUpEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$User2CopyWith<$Res> get user {
  
  return $User2CopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostSignUpEmailResponse].
extension PostSignUpEmailResponsePatterns on PostSignUpEmailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostSignUpEmailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostSignUpEmailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostSignUpEmailResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostSignUpEmailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostSignUpEmailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostSignUpEmailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User2 user, @JsonKey(includeIfNull: false)  String? token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostSignUpEmailResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User2 user, @JsonKey(includeIfNull: false)  String? token)  $default,) {final _that = this;
switch (_that) {
case _PostSignUpEmailResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User2 user, @JsonKey(includeIfNull: false)  String? token)?  $default,) {final _that = this;
switch (_that) {
case _PostSignUpEmailResponse() when $default != null:
return $default(_that.user,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostSignUpEmailResponse implements PostSignUpEmailResponse {
  const _PostSignUpEmailResponse({required this.user, @JsonKey(includeIfNull: false) this.token});
  factory _PostSignUpEmailResponse.fromJson(Map<String, dynamic> json) => _$PostSignUpEmailResponseFromJson(json);

@override final  User2 user;
/// Authentication token for the session
@override@JsonKey(includeIfNull: false) final  String? token;

/// Create a copy of PostSignUpEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostSignUpEmailResponseCopyWith<_PostSignUpEmailResponse> get copyWith => __$PostSignUpEmailResponseCopyWithImpl<_PostSignUpEmailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostSignUpEmailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostSignUpEmailResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,token);

@override
String toString() {
  return 'PostSignUpEmailResponse(user: $user, token: $token)';
}


}

/// @nodoc
abstract mixin class _$PostSignUpEmailResponseCopyWith<$Res> implements $PostSignUpEmailResponseCopyWith<$Res> {
  factory _$PostSignUpEmailResponseCopyWith(_PostSignUpEmailResponse value, $Res Function(_PostSignUpEmailResponse) _then) = __$PostSignUpEmailResponseCopyWithImpl;
@override @useResult
$Res call({
 User2 user,@JsonKey(includeIfNull: false) String? token
});


@override $User2CopyWith<$Res> get user;

}
/// @nodoc
class __$PostSignUpEmailResponseCopyWithImpl<$Res>
    implements _$PostSignUpEmailResponseCopyWith<$Res> {
  __$PostSignUpEmailResponseCopyWithImpl(this._self, this._then);

  final _PostSignUpEmailResponse _self;
  final $Res Function(_PostSignUpEmailResponse) _then;

/// Create a copy of PostSignUpEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? token = freezed,}) {
  return _then(_PostSignUpEmailResponse(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User2,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PostSignUpEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$User2CopyWith<$Res> get user {
  
  return $User2CopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on

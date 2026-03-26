// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_sign_in_anonymous_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostSignInAnonymousResponse {

 User get user; Session get session;
/// Create a copy of PostSignInAnonymousResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostSignInAnonymousResponseCopyWith<PostSignInAnonymousResponse> get copyWith => _$PostSignInAnonymousResponseCopyWithImpl<PostSignInAnonymousResponse>(this as PostSignInAnonymousResponse, _$identity);

  /// Serializes this PostSignInAnonymousResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostSignInAnonymousResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.session, session) || other.session == session));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,session);

@override
String toString() {
  return 'PostSignInAnonymousResponse(user: $user, session: $session)';
}


}

/// @nodoc
abstract mixin class $PostSignInAnonymousResponseCopyWith<$Res>  {
  factory $PostSignInAnonymousResponseCopyWith(PostSignInAnonymousResponse value, $Res Function(PostSignInAnonymousResponse) _then) = _$PostSignInAnonymousResponseCopyWithImpl;
@useResult
$Res call({
 User user, Session session
});


$UserCopyWith<$Res> get user;$SessionCopyWith<$Res> get session;

}
/// @nodoc
class _$PostSignInAnonymousResponseCopyWithImpl<$Res>
    implements $PostSignInAnonymousResponseCopyWith<$Res> {
  _$PostSignInAnonymousResponseCopyWithImpl(this._self, this._then);

  final PostSignInAnonymousResponse _self;
  final $Res Function(PostSignInAnonymousResponse) _then;

/// Create a copy of PostSignInAnonymousResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? session = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,
  ));
}
/// Create a copy of PostSignInAnonymousResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of PostSignInAnonymousResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res> get session {
  
  return $SessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostSignInAnonymousResponse].
extension PostSignInAnonymousResponsePatterns on PostSignInAnonymousResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostSignInAnonymousResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostSignInAnonymousResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostSignInAnonymousResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostSignInAnonymousResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostSignInAnonymousResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostSignInAnonymousResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User user,  Session session)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostSignInAnonymousResponse() when $default != null:
return $default(_that.user,_that.session);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User user,  Session session)  $default,) {final _that = this;
switch (_that) {
case _PostSignInAnonymousResponse():
return $default(_that.user,_that.session);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User user,  Session session)?  $default,) {final _that = this;
switch (_that) {
case _PostSignInAnonymousResponse() when $default != null:
return $default(_that.user,_that.session);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostSignInAnonymousResponse implements PostSignInAnonymousResponse {
  const _PostSignInAnonymousResponse({required this.user, required this.session});
  factory _PostSignInAnonymousResponse.fromJson(Map<String, dynamic> json) => _$PostSignInAnonymousResponseFromJson(json);

@override final  User user;
@override final  Session session;

/// Create a copy of PostSignInAnonymousResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostSignInAnonymousResponseCopyWith<_PostSignInAnonymousResponse> get copyWith => __$PostSignInAnonymousResponseCopyWithImpl<_PostSignInAnonymousResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostSignInAnonymousResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostSignInAnonymousResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.session, session) || other.session == session));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,session);

@override
String toString() {
  return 'PostSignInAnonymousResponse(user: $user, session: $session)';
}


}

/// @nodoc
abstract mixin class _$PostSignInAnonymousResponseCopyWith<$Res> implements $PostSignInAnonymousResponseCopyWith<$Res> {
  factory _$PostSignInAnonymousResponseCopyWith(_PostSignInAnonymousResponse value, $Res Function(_PostSignInAnonymousResponse) _then) = __$PostSignInAnonymousResponseCopyWithImpl;
@override @useResult
$Res call({
 User user, Session session
});


@override $UserCopyWith<$Res> get user;@override $SessionCopyWith<$Res> get session;

}
/// @nodoc
class __$PostSignInAnonymousResponseCopyWithImpl<$Res>
    implements _$PostSignInAnonymousResponseCopyWith<$Res> {
  __$PostSignInAnonymousResponseCopyWithImpl(this._self, this._then);

  final _PostSignInAnonymousResponse _self;
  final $Res Function(_PostSignInAnonymousResponse) _then;

/// Create a copy of PostSignInAnonymousResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? session = null,}) {
  return _then(_PostSignInAnonymousResponse(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,
  ));
}

/// Create a copy of PostSignInAnonymousResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of PostSignInAnonymousResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res> get session {
  
  return $SessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_get_session_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostGetSessionResponse {

 Session get session; User get user;
/// Create a copy of PostGetSessionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostGetSessionResponseCopyWith<PostGetSessionResponse> get copyWith => _$PostGetSessionResponseCopyWithImpl<PostGetSessionResponse>(this as PostGetSessionResponse, _$identity);

  /// Serializes this PostGetSessionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostGetSessionResponse&&(identical(other.session, session) || other.session == session)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session,user);

@override
String toString() {
  return 'PostGetSessionResponse(session: $session, user: $user)';
}


}

/// @nodoc
abstract mixin class $PostGetSessionResponseCopyWith<$Res>  {
  factory $PostGetSessionResponseCopyWith(PostGetSessionResponse value, $Res Function(PostGetSessionResponse) _then) = _$PostGetSessionResponseCopyWithImpl;
@useResult
$Res call({
 Session session, User user
});


$SessionCopyWith<$Res> get session;$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$PostGetSessionResponseCopyWithImpl<$Res>
    implements $PostGetSessionResponseCopyWith<$Res> {
  _$PostGetSessionResponseCopyWithImpl(this._self, this._then);

  final PostGetSessionResponse _self;
  final $Res Function(PostGetSessionResponse) _then;

/// Create a copy of PostGetSessionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,Object? user = null,}) {
  return _then(_self.copyWith(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}
/// Create a copy of PostGetSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res> get session {
  
  return $SessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of PostGetSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostGetSessionResponse].
extension PostGetSessionResponsePatterns on PostGetSessionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostGetSessionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostGetSessionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostGetSessionResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostGetSessionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostGetSessionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostGetSessionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Session session,  User user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostGetSessionResponse() when $default != null:
return $default(_that.session,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Session session,  User user)  $default,) {final _that = this;
switch (_that) {
case _PostGetSessionResponse():
return $default(_that.session,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Session session,  User user)?  $default,) {final _that = this;
switch (_that) {
case _PostGetSessionResponse() when $default != null:
return $default(_that.session,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostGetSessionResponse implements PostGetSessionResponse {
  const _PostGetSessionResponse({required this.session, required this.user});
  factory _PostGetSessionResponse.fromJson(Map<String, dynamic> json) => _$PostGetSessionResponseFromJson(json);

@override final  Session session;
@override final  User user;

/// Create a copy of PostGetSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostGetSessionResponseCopyWith<_PostGetSessionResponse> get copyWith => __$PostGetSessionResponseCopyWithImpl<_PostGetSessionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostGetSessionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostGetSessionResponse&&(identical(other.session, session) || other.session == session)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session,user);

@override
String toString() {
  return 'PostGetSessionResponse(session: $session, user: $user)';
}


}

/// @nodoc
abstract mixin class _$PostGetSessionResponseCopyWith<$Res> implements $PostGetSessionResponseCopyWith<$Res> {
  factory _$PostGetSessionResponseCopyWith(_PostGetSessionResponse value, $Res Function(_PostGetSessionResponse) _then) = __$PostGetSessionResponseCopyWithImpl;
@override @useResult
$Res call({
 Session session, User user
});


@override $SessionCopyWith<$Res> get session;@override $UserCopyWith<$Res> get user;

}
/// @nodoc
class __$PostGetSessionResponseCopyWithImpl<$Res>
    implements _$PostGetSessionResponseCopyWith<$Res> {
  __$PostGetSessionResponseCopyWithImpl(this._self, this._then);

  final _PostGetSessionResponse _self;
  final $Res Function(_PostGetSessionResponse) _then;

/// Create a copy of PostGetSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,Object? user = null,}) {
  return _then(_PostGetSessionResponse(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of PostGetSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res> get session {
  
  return $SessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of PostGetSessionResponse
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

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_update_user_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostUpdateUserResponse {

 User get user;
/// Create a copy of PostUpdateUserResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostUpdateUserResponseCopyWith<PostUpdateUserResponse> get copyWith => _$PostUpdateUserResponseCopyWithImpl<PostUpdateUserResponse>(this as PostUpdateUserResponse, _$identity);

  /// Serializes this PostUpdateUserResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostUpdateUserResponse&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'PostUpdateUserResponse(user: $user)';
}


}

/// @nodoc
abstract mixin class $PostUpdateUserResponseCopyWith<$Res>  {
  factory $PostUpdateUserResponseCopyWith(PostUpdateUserResponse value, $Res Function(PostUpdateUserResponse) _then) = _$PostUpdateUserResponseCopyWithImpl;
@useResult
$Res call({
 User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$PostUpdateUserResponseCopyWithImpl<$Res>
    implements $PostUpdateUserResponseCopyWith<$Res> {
  _$PostUpdateUserResponseCopyWithImpl(this._self, this._then);

  final PostUpdateUserResponse _self;
  final $Res Function(PostUpdateUserResponse) _then;

/// Create a copy of PostUpdateUserResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}
/// Create a copy of PostUpdateUserResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostUpdateUserResponse].
extension PostUpdateUserResponsePatterns on PostUpdateUserResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostUpdateUserResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostUpdateUserResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostUpdateUserResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostUpdateUserResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostUpdateUserResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostUpdateUserResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostUpdateUserResponse() when $default != null:
return $default(_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User user)  $default,) {final _that = this;
switch (_that) {
case _PostUpdateUserResponse():
return $default(_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User user)?  $default,) {final _that = this;
switch (_that) {
case _PostUpdateUserResponse() when $default != null:
return $default(_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostUpdateUserResponse implements PostUpdateUserResponse {
  const _PostUpdateUserResponse({required this.user});
  factory _PostUpdateUserResponse.fromJson(Map<String, dynamic> json) => _$PostUpdateUserResponseFromJson(json);

@override final  User user;

/// Create a copy of PostUpdateUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostUpdateUserResponseCopyWith<_PostUpdateUserResponse> get copyWith => __$PostUpdateUserResponseCopyWithImpl<_PostUpdateUserResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostUpdateUserResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostUpdateUserResponse&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'PostUpdateUserResponse(user: $user)';
}


}

/// @nodoc
abstract mixin class _$PostUpdateUserResponseCopyWith<$Res> implements $PostUpdateUserResponseCopyWith<$Res> {
  factory _$PostUpdateUserResponseCopyWith(_PostUpdateUserResponse value, $Res Function(_PostUpdateUserResponse) _then) = __$PostUpdateUserResponseCopyWithImpl;
@override @useResult
$Res call({
 User user
});


@override $UserCopyWith<$Res> get user;

}
/// @nodoc
class __$PostUpdateUserResponseCopyWithImpl<$Res>
    implements _$PostUpdateUserResponseCopyWith<$Res> {
  __$PostUpdateUserResponseCopyWithImpl(this._self, this._then);

  final _PostUpdateUserResponse _self;
  final $Res Function(_PostUpdateUserResponse) _then;

/// Create a copy of PostUpdateUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_PostUpdateUserResponse(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of PostUpdateUserResponse
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

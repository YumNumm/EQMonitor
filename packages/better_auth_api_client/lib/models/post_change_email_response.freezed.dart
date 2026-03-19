// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_change_email_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostChangeEmailResponse {

/// Indicates if the request was successful
 bool get status;@JsonKey(includeIfNull: false) User? get user;/// Status message of the email change process
@JsonKey(includeIfNull: false) Message? get message;
/// Create a copy of PostChangeEmailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostChangeEmailResponseCopyWith<PostChangeEmailResponse> get copyWith => _$PostChangeEmailResponseCopyWithImpl<PostChangeEmailResponse>(this as PostChangeEmailResponse, _$identity);

  /// Serializes this PostChangeEmailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostChangeEmailResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,user,message);

@override
String toString() {
  return 'PostChangeEmailResponse(status: $status, user: $user, message: $message)';
}


}

/// @nodoc
abstract mixin class $PostChangeEmailResponseCopyWith<$Res>  {
  factory $PostChangeEmailResponseCopyWith(PostChangeEmailResponse value, $Res Function(PostChangeEmailResponse) _then) = _$PostChangeEmailResponseCopyWithImpl;
@useResult
$Res call({
 bool status,@JsonKey(includeIfNull: false) User? user,@JsonKey(includeIfNull: false) Message? message
});


$UserCopyWith<$Res>? get user;

}
/// @nodoc
class _$PostChangeEmailResponseCopyWithImpl<$Res>
    implements $PostChangeEmailResponseCopyWith<$Res> {
  _$PostChangeEmailResponseCopyWithImpl(this._self, this._then);

  final PostChangeEmailResponse _self;
  final $Res Function(PostChangeEmailResponse) _then;

/// Create a copy of PostChangeEmailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? user = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Message?,
  ));
}
/// Create a copy of PostChangeEmailResponse
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


/// Adds pattern-matching-related methods to [PostChangeEmailResponse].
extension PostChangeEmailResponsePatterns on PostChangeEmailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostChangeEmailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostChangeEmailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostChangeEmailResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostChangeEmailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostChangeEmailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostChangeEmailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool status, @JsonKey(includeIfNull: false)  User? user, @JsonKey(includeIfNull: false)  Message? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostChangeEmailResponse() when $default != null:
return $default(_that.status,_that.user,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool status, @JsonKey(includeIfNull: false)  User? user, @JsonKey(includeIfNull: false)  Message? message)  $default,) {final _that = this;
switch (_that) {
case _PostChangeEmailResponse():
return $default(_that.status,_that.user,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool status, @JsonKey(includeIfNull: false)  User? user, @JsonKey(includeIfNull: false)  Message? message)?  $default,) {final _that = this;
switch (_that) {
case _PostChangeEmailResponse() when $default != null:
return $default(_that.status,_that.user,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostChangeEmailResponse implements PostChangeEmailResponse {
  const _PostChangeEmailResponse({required this.status, @JsonKey(includeIfNull: false) this.user, @JsonKey(includeIfNull: false) this.message});
  factory _PostChangeEmailResponse.fromJson(Map<String, dynamic> json) => _$PostChangeEmailResponseFromJson(json);

/// Indicates if the request was successful
@override final  bool status;
@override@JsonKey(includeIfNull: false) final  User? user;
/// Status message of the email change process
@override@JsonKey(includeIfNull: false) final  Message? message;

/// Create a copy of PostChangeEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostChangeEmailResponseCopyWith<_PostChangeEmailResponse> get copyWith => __$PostChangeEmailResponseCopyWithImpl<_PostChangeEmailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostChangeEmailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostChangeEmailResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,user,message);

@override
String toString() {
  return 'PostChangeEmailResponse(status: $status, user: $user, message: $message)';
}


}

/// @nodoc
abstract mixin class _$PostChangeEmailResponseCopyWith<$Res> implements $PostChangeEmailResponseCopyWith<$Res> {
  factory _$PostChangeEmailResponseCopyWith(_PostChangeEmailResponse value, $Res Function(_PostChangeEmailResponse) _then) = __$PostChangeEmailResponseCopyWithImpl;
@override @useResult
$Res call({
 bool status,@JsonKey(includeIfNull: false) User? user,@JsonKey(includeIfNull: false) Message? message
});


@override $UserCopyWith<$Res>? get user;

}
/// @nodoc
class __$PostChangeEmailResponseCopyWithImpl<$Res>
    implements _$PostChangeEmailResponseCopyWith<$Res> {
  __$PostChangeEmailResponseCopyWithImpl(this._self, this._then);

  final _PostChangeEmailResponse _self;
  final $Res Function(_PostChangeEmailResponse) _then;

/// Create a copy of PostChangeEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? user = freezed,Object? message = freezed,}) {
  return _then(_PostChangeEmailResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Message?,
  ));
}

/// Create a copy of PostChangeEmailResponse
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

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_verify_email_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetVerifyEmailResponse {

 User get user;/// Indicates if the email was verified successfully
 bool get status;
/// Create a copy of GetVerifyEmailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetVerifyEmailResponseCopyWith<GetVerifyEmailResponse> get copyWith => _$GetVerifyEmailResponseCopyWithImpl<GetVerifyEmailResponse>(this as GetVerifyEmailResponse, _$identity);

  /// Serializes this GetVerifyEmailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetVerifyEmailResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,status);

@override
String toString() {
  return 'GetVerifyEmailResponse(user: $user, status: $status)';
}


}

/// @nodoc
abstract mixin class $GetVerifyEmailResponseCopyWith<$Res>  {
  factory $GetVerifyEmailResponseCopyWith(GetVerifyEmailResponse value, $Res Function(GetVerifyEmailResponse) _then) = _$GetVerifyEmailResponseCopyWithImpl;
@useResult
$Res call({
 User user, bool status
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$GetVerifyEmailResponseCopyWithImpl<$Res>
    implements $GetVerifyEmailResponseCopyWith<$Res> {
  _$GetVerifyEmailResponseCopyWithImpl(this._self, this._then);

  final GetVerifyEmailResponse _self;
  final $Res Function(GetVerifyEmailResponse) _then;

/// Create a copy of GetVerifyEmailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? status = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of GetVerifyEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [GetVerifyEmailResponse].
extension GetVerifyEmailResponsePatterns on GetVerifyEmailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetVerifyEmailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetVerifyEmailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetVerifyEmailResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetVerifyEmailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetVerifyEmailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetVerifyEmailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User user,  bool status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetVerifyEmailResponse() when $default != null:
return $default(_that.user,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User user,  bool status)  $default,) {final _that = this;
switch (_that) {
case _GetVerifyEmailResponse():
return $default(_that.user,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User user,  bool status)?  $default,) {final _that = this;
switch (_that) {
case _GetVerifyEmailResponse() when $default != null:
return $default(_that.user,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetVerifyEmailResponse implements GetVerifyEmailResponse {
  const _GetVerifyEmailResponse({required this.user, required this.status});
  factory _GetVerifyEmailResponse.fromJson(Map<String, dynamic> json) => _$GetVerifyEmailResponseFromJson(json);

@override final  User user;
/// Indicates if the email was verified successfully
@override final  bool status;

/// Create a copy of GetVerifyEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetVerifyEmailResponseCopyWith<_GetVerifyEmailResponse> get copyWith => __$GetVerifyEmailResponseCopyWithImpl<_GetVerifyEmailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetVerifyEmailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetVerifyEmailResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,status);

@override
String toString() {
  return 'GetVerifyEmailResponse(user: $user, status: $status)';
}


}

/// @nodoc
abstract mixin class _$GetVerifyEmailResponseCopyWith<$Res> implements $GetVerifyEmailResponseCopyWith<$Res> {
  factory _$GetVerifyEmailResponseCopyWith(_GetVerifyEmailResponse value, $Res Function(_GetVerifyEmailResponse) _then) = __$GetVerifyEmailResponseCopyWithImpl;
@override @useResult
$Res call({
 User user, bool status
});


@override $UserCopyWith<$Res> get user;

}
/// @nodoc
class __$GetVerifyEmailResponseCopyWithImpl<$Res>
    implements _$GetVerifyEmailResponseCopyWith<$Res> {
  __$GetVerifyEmailResponseCopyWithImpl(this._self, this._then);

  final _GetVerifyEmailResponse _self;
  final $Res Function(_GetVerifyEmailResponse) _then;

/// Create a copy of GetVerifyEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? status = null,}) {
  return _then(_GetVerifyEmailResponse(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of GetVerifyEmailResponse
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

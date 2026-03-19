// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_user_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeleteUserRequestBody {

/// The callback URL to redirect to after the user is deleted
@JsonKey(name: 'callbackURL') String get callbackUrl;/// The user's password. Required if session is not fresh
 String get password;/// The deletion verification token
 String get token;
/// Create a copy of DeleteUserRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteUserRequestBodyCopyWith<DeleteUserRequestBody> get copyWith => _$DeleteUserRequestBodyCopyWithImpl<DeleteUserRequestBody>(this as DeleteUserRequestBody, _$identity);

  /// Serializes this DeleteUserRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteUserRequestBody&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl)&&(identical(other.password, password) || other.password == password)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callbackUrl,password,token);

@override
String toString() {
  return 'DeleteUserRequestBody(callbackUrl: $callbackUrl, password: $password, token: $token)';
}


}

/// @nodoc
abstract mixin class $DeleteUserRequestBodyCopyWith<$Res>  {
  factory $DeleteUserRequestBodyCopyWith(DeleteUserRequestBody value, $Res Function(DeleteUserRequestBody) _then) = _$DeleteUserRequestBodyCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'callbackURL') String callbackUrl, String password, String token
});




}
/// @nodoc
class _$DeleteUserRequestBodyCopyWithImpl<$Res>
    implements $DeleteUserRequestBodyCopyWith<$Res> {
  _$DeleteUserRequestBodyCopyWithImpl(this._self, this._then);

  final DeleteUserRequestBody _self;
  final $Res Function(DeleteUserRequestBody) _then;

/// Create a copy of DeleteUserRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callbackUrl = null,Object? password = null,Object? token = null,}) {
  return _then(_self.copyWith(
callbackUrl: null == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeleteUserRequestBody].
extension DeleteUserRequestBodyPatterns on DeleteUserRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeleteUserRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeleteUserRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeleteUserRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _DeleteUserRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeleteUserRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _DeleteUserRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'callbackURL')  String callbackUrl,  String password,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeleteUserRequestBody() when $default != null:
return $default(_that.callbackUrl,_that.password,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'callbackURL')  String callbackUrl,  String password,  String token)  $default,) {final _that = this;
switch (_that) {
case _DeleteUserRequestBody():
return $default(_that.callbackUrl,_that.password,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'callbackURL')  String callbackUrl,  String password,  String token)?  $default,) {final _that = this;
switch (_that) {
case _DeleteUserRequestBody() when $default != null:
return $default(_that.callbackUrl,_that.password,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeleteUserRequestBody implements DeleteUserRequestBody {
  const _DeleteUserRequestBody({@JsonKey(name: 'callbackURL') required this.callbackUrl, required this.password, required this.token});
  factory _DeleteUserRequestBody.fromJson(Map<String, dynamic> json) => _$DeleteUserRequestBodyFromJson(json);

/// The callback URL to redirect to after the user is deleted
@override@JsonKey(name: 'callbackURL') final  String callbackUrl;
/// The user's password. Required if session is not fresh
@override final  String password;
/// The deletion verification token
@override final  String token;

/// Create a copy of DeleteUserRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteUserRequestBodyCopyWith<_DeleteUserRequestBody> get copyWith => __$DeleteUserRequestBodyCopyWithImpl<_DeleteUserRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeleteUserRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteUserRequestBody&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl)&&(identical(other.password, password) || other.password == password)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callbackUrl,password,token);

@override
String toString() {
  return 'DeleteUserRequestBody(callbackUrl: $callbackUrl, password: $password, token: $token)';
}


}

/// @nodoc
abstract mixin class _$DeleteUserRequestBodyCopyWith<$Res> implements $DeleteUserRequestBodyCopyWith<$Res> {
  factory _$DeleteUserRequestBodyCopyWith(_DeleteUserRequestBody value, $Res Function(_DeleteUserRequestBody) _then) = __$DeleteUserRequestBodyCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'callbackURL') String callbackUrl, String password, String token
});




}
/// @nodoc
class __$DeleteUserRequestBodyCopyWithImpl<$Res>
    implements _$DeleteUserRequestBodyCopyWith<$Res> {
  __$DeleteUserRequestBodyCopyWithImpl(this._self, this._then);

  final _DeleteUserRequestBody _self;
  final $Res Function(_DeleteUserRequestBody) _then;

/// Create a copy of DeleteUserRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callbackUrl = null,Object? password = null,Object? token = null,}) {
  return _then(_DeleteUserRequestBody(
callbackUrl: null == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

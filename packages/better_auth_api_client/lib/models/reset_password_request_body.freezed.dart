// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResetPasswordRequestBody {

/// The new password to set
 String get newPassword;/// The token to reset the password
@JsonKey(includeIfNull: false) String? get token;
/// Create a copy of ResetPasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordRequestBodyCopyWith<ResetPasswordRequestBody> get copyWith => _$ResetPasswordRequestBodyCopyWithImpl<ResetPasswordRequestBody>(this as ResetPasswordRequestBody, _$identity);

  /// Serializes this ResetPasswordRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordRequestBody&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,newPassword,token);

@override
String toString() {
  return 'ResetPasswordRequestBody(newPassword: $newPassword, token: $token)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordRequestBodyCopyWith<$Res>  {
  factory $ResetPasswordRequestBodyCopyWith(ResetPasswordRequestBody value, $Res Function(ResetPasswordRequestBody) _then) = _$ResetPasswordRequestBodyCopyWithImpl;
@useResult
$Res call({
 String newPassword,@JsonKey(includeIfNull: false) String? token
});




}
/// @nodoc
class _$ResetPasswordRequestBodyCopyWithImpl<$Res>
    implements $ResetPasswordRequestBodyCopyWith<$Res> {
  _$ResetPasswordRequestBodyCopyWithImpl(this._self, this._then);

  final ResetPasswordRequestBody _self;
  final $Res Function(ResetPasswordRequestBody) _then;

/// Create a copy of ResetPasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? newPassword = null,Object? token = freezed,}) {
  return _then(_self.copyWith(
newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResetPasswordRequestBody].
extension ResetPasswordRequestBodyPatterns on ResetPasswordRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResetPasswordRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResetPasswordRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResetPasswordRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResetPasswordRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String newPassword, @JsonKey(includeIfNull: false)  String? token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResetPasswordRequestBody() when $default != null:
return $default(_that.newPassword,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String newPassword, @JsonKey(includeIfNull: false)  String? token)  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordRequestBody():
return $default(_that.newPassword,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String newPassword, @JsonKey(includeIfNull: false)  String? token)?  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordRequestBody() when $default != null:
return $default(_that.newPassword,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResetPasswordRequestBody implements ResetPasswordRequestBody {
  const _ResetPasswordRequestBody({required this.newPassword, @JsonKey(includeIfNull: false) this.token});
  factory _ResetPasswordRequestBody.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestBodyFromJson(json);

/// The new password to set
@override final  String newPassword;
/// The token to reset the password
@override@JsonKey(includeIfNull: false) final  String? token;

/// Create a copy of ResetPasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPasswordRequestBodyCopyWith<_ResetPasswordRequestBody> get copyWith => __$ResetPasswordRequestBodyCopyWithImpl<_ResetPasswordRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResetPasswordRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPasswordRequestBody&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,newPassword,token);

@override
String toString() {
  return 'ResetPasswordRequestBody(newPassword: $newPassword, token: $token)';
}


}

/// @nodoc
abstract mixin class _$ResetPasswordRequestBodyCopyWith<$Res> implements $ResetPasswordRequestBodyCopyWith<$Res> {
  factory _$ResetPasswordRequestBodyCopyWith(_ResetPasswordRequestBody value, $Res Function(_ResetPasswordRequestBody) _then) = __$ResetPasswordRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String newPassword,@JsonKey(includeIfNull: false) String? token
});




}
/// @nodoc
class __$ResetPasswordRequestBodyCopyWithImpl<$Res>
    implements _$ResetPasswordRequestBodyCopyWith<$Res> {
  __$ResetPasswordRequestBodyCopyWithImpl(this._self, this._then);

  final _ResetPasswordRequestBody _self;
  final $Res Function(_ResetPasswordRequestBody) _then;

/// Create a copy of ResetPasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? newPassword = null,Object? token = freezed,}) {
  return _then(_ResetPasswordRequestBody(
newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

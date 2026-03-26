// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_reset_password_token_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetResetPasswordTokenResponse {

 String get token;
/// Create a copy of GetResetPasswordTokenResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetResetPasswordTokenResponseCopyWith<GetResetPasswordTokenResponse> get copyWith => _$GetResetPasswordTokenResponseCopyWithImpl<GetResetPasswordTokenResponse>(this as GetResetPasswordTokenResponse, _$identity);

  /// Serializes this GetResetPasswordTokenResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetResetPasswordTokenResponse&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'GetResetPasswordTokenResponse(token: $token)';
}


}

/// @nodoc
abstract mixin class $GetResetPasswordTokenResponseCopyWith<$Res>  {
  factory $GetResetPasswordTokenResponseCopyWith(GetResetPasswordTokenResponse value, $Res Function(GetResetPasswordTokenResponse) _then) = _$GetResetPasswordTokenResponseCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class _$GetResetPasswordTokenResponseCopyWithImpl<$Res>
    implements $GetResetPasswordTokenResponseCopyWith<$Res> {
  _$GetResetPasswordTokenResponseCopyWithImpl(this._self, this._then);

  final GetResetPasswordTokenResponse _self;
  final $Res Function(GetResetPasswordTokenResponse) _then;

/// Create a copy of GetResetPasswordTokenResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetResetPasswordTokenResponse].
extension GetResetPasswordTokenResponsePatterns on GetResetPasswordTokenResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetResetPasswordTokenResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetResetPasswordTokenResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetResetPasswordTokenResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetResetPasswordTokenResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetResetPasswordTokenResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetResetPasswordTokenResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetResetPasswordTokenResponse() when $default != null:
return $default(_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token)  $default,) {final _that = this;
switch (_that) {
case _GetResetPasswordTokenResponse():
return $default(_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token)?  $default,) {final _that = this;
switch (_that) {
case _GetResetPasswordTokenResponse() when $default != null:
return $default(_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetResetPasswordTokenResponse implements GetResetPasswordTokenResponse {
  const _GetResetPasswordTokenResponse({required this.token});
  factory _GetResetPasswordTokenResponse.fromJson(Map<String, dynamic> json) => _$GetResetPasswordTokenResponseFromJson(json);

@override final  String token;

/// Create a copy of GetResetPasswordTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetResetPasswordTokenResponseCopyWith<_GetResetPasswordTokenResponse> get copyWith => __$GetResetPasswordTokenResponseCopyWithImpl<_GetResetPasswordTokenResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetResetPasswordTokenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetResetPasswordTokenResponse&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'GetResetPasswordTokenResponse(token: $token)';
}


}

/// @nodoc
abstract mixin class _$GetResetPasswordTokenResponseCopyWith<$Res> implements $GetResetPasswordTokenResponseCopyWith<$Res> {
  factory _$GetResetPasswordTokenResponseCopyWith(_GetResetPasswordTokenResponse value, $Res Function(_GetResetPasswordTokenResponse) _then) = __$GetResetPasswordTokenResponseCopyWithImpl;
@override @useResult
$Res call({
 String token
});




}
/// @nodoc
class __$GetResetPasswordTokenResponseCopyWithImpl<$Res>
    implements _$GetResetPasswordTokenResponseCopyWith<$Res> {
  __$GetResetPasswordTokenResponseCopyWithImpl(this._self, this._then);

  final _GetResetPasswordTokenResponse _self;
  final $Res Function(_GetResetPasswordTokenResponse) _then;

/// Create a copy of GetResetPasswordTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(_GetResetPasswordTokenResponse(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

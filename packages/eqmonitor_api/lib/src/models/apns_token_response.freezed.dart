// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apns_token_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApnsTokenResponse {

 ApnsTokenType get type; String get token; ApnsEnvironment get environment;
/// Create a copy of ApnsTokenResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApnsTokenResponseCopyWith<ApnsTokenResponse> get copyWith => _$ApnsTokenResponseCopyWithImpl<ApnsTokenResponse>(this as ApnsTokenResponse, _$identity);

  /// Serializes this ApnsTokenResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApnsTokenResponse&&(identical(other.type, type) || other.type == type)&&(identical(other.token, token) || other.token == token)&&(identical(other.environment, environment) || other.environment == environment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,token,environment);

@override
String toString() {
  return 'ApnsTokenResponse(type: $type, token: $token, environment: $environment)';
}


}

/// @nodoc
abstract mixin class $ApnsTokenResponseCopyWith<$Res>  {
  factory $ApnsTokenResponseCopyWith(ApnsTokenResponse value, $Res Function(ApnsTokenResponse) _then) = _$ApnsTokenResponseCopyWithImpl;
@useResult
$Res call({
 ApnsTokenType type, String token, ApnsEnvironment environment
});




}
/// @nodoc
class _$ApnsTokenResponseCopyWithImpl<$Res>
    implements $ApnsTokenResponseCopyWith<$Res> {
  _$ApnsTokenResponseCopyWithImpl(this._self, this._then);

  final ApnsTokenResponse _self;
  final $Res Function(ApnsTokenResponse) _then;

/// Create a copy of ApnsTokenResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? token = null,Object? environment = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ApnsTokenType,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as ApnsEnvironment,
  ));
}

}


/// Adds pattern-matching-related methods to [ApnsTokenResponse].
extension ApnsTokenResponsePatterns on ApnsTokenResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApnsTokenResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApnsTokenResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApnsTokenResponse value)  $default,){
final _that = this;
switch (_that) {
case _ApnsTokenResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApnsTokenResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ApnsTokenResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApnsTokenType type,  String token,  ApnsEnvironment environment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApnsTokenResponse() when $default != null:
return $default(_that.type,_that.token,_that.environment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApnsTokenType type,  String token,  ApnsEnvironment environment)  $default,) {final _that = this;
switch (_that) {
case _ApnsTokenResponse():
return $default(_that.type,_that.token,_that.environment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApnsTokenType type,  String token,  ApnsEnvironment environment)?  $default,) {final _that = this;
switch (_that) {
case _ApnsTokenResponse() when $default != null:
return $default(_that.type,_that.token,_that.environment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApnsTokenResponse implements ApnsTokenResponse {
  const _ApnsTokenResponse({required this.type, required this.token, required this.environment});
  factory _ApnsTokenResponse.fromJson(Map<String, dynamic> json) => _$ApnsTokenResponseFromJson(json);

@override final  ApnsTokenType type;
@override final  String token;
@override final  ApnsEnvironment environment;

/// Create a copy of ApnsTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApnsTokenResponseCopyWith<_ApnsTokenResponse> get copyWith => __$ApnsTokenResponseCopyWithImpl<_ApnsTokenResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApnsTokenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApnsTokenResponse&&(identical(other.type, type) || other.type == type)&&(identical(other.token, token) || other.token == token)&&(identical(other.environment, environment) || other.environment == environment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,token,environment);

@override
String toString() {
  return 'ApnsTokenResponse(type: $type, token: $token, environment: $environment)';
}


}

/// @nodoc
abstract mixin class _$ApnsTokenResponseCopyWith<$Res> implements $ApnsTokenResponseCopyWith<$Res> {
  factory _$ApnsTokenResponseCopyWith(_ApnsTokenResponse value, $Res Function(_ApnsTokenResponse) _then) = __$ApnsTokenResponseCopyWithImpl;
@override @useResult
$Res call({
 ApnsTokenType type, String token, ApnsEnvironment environment
});




}
/// @nodoc
class __$ApnsTokenResponseCopyWithImpl<$Res>
    implements _$ApnsTokenResponseCopyWith<$Res> {
  __$ApnsTokenResponseCopyWithImpl(this._self, this._then);

  final _ApnsTokenResponse _self;
  final $Res Function(_ApnsTokenResponse) _then;

/// Create a copy of ApnsTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? token = null,Object? environment = null,}) {
  return _then(_ApnsTokenResponse(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ApnsTokenType,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as ApnsEnvironment,
  ));
}


}

// dart format on

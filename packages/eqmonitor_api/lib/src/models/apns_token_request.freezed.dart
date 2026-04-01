// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apns_token_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApnsTokenRequest {

 String get token;@JsonKey(includeIfNull: false) ApnsEnvironment? get environment;
/// Create a copy of ApnsTokenRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApnsTokenRequestCopyWith<ApnsTokenRequest> get copyWith => _$ApnsTokenRequestCopyWithImpl<ApnsTokenRequest>(this as ApnsTokenRequest, _$identity);

  /// Serializes this ApnsTokenRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApnsTokenRequest&&(identical(other.token, token) || other.token == token)&&(identical(other.environment, environment) || other.environment == environment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,environment);

@override
String toString() {
  return 'ApnsTokenRequest(token: $token, environment: $environment)';
}


}

/// @nodoc
abstract mixin class $ApnsTokenRequestCopyWith<$Res>  {
  factory $ApnsTokenRequestCopyWith(ApnsTokenRequest value, $Res Function(ApnsTokenRequest) _then) = _$ApnsTokenRequestCopyWithImpl;
@useResult
$Res call({
 String token,@JsonKey(includeIfNull: false) ApnsEnvironment? environment
});




}
/// @nodoc
class _$ApnsTokenRequestCopyWithImpl<$Res>
    implements $ApnsTokenRequestCopyWith<$Res> {
  _$ApnsTokenRequestCopyWithImpl(this._self, this._then);

  final ApnsTokenRequest _self;
  final $Res Function(ApnsTokenRequest) _then;

/// Create a copy of ApnsTokenRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? environment = freezed,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,environment: freezed == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as ApnsEnvironment?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApnsTokenRequest].
extension ApnsTokenRequestPatterns on ApnsTokenRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApnsTokenRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApnsTokenRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApnsTokenRequest value)  $default,){
final _that = this;
switch (_that) {
case _ApnsTokenRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApnsTokenRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ApnsTokenRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token, @JsonKey(includeIfNull: false)  ApnsEnvironment? environment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApnsTokenRequest() when $default != null:
return $default(_that.token,_that.environment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token, @JsonKey(includeIfNull: false)  ApnsEnvironment? environment)  $default,) {final _that = this;
switch (_that) {
case _ApnsTokenRequest():
return $default(_that.token,_that.environment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token, @JsonKey(includeIfNull: false)  ApnsEnvironment? environment)?  $default,) {final _that = this;
switch (_that) {
case _ApnsTokenRequest() when $default != null:
return $default(_that.token,_that.environment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApnsTokenRequest implements ApnsTokenRequest {
  const _ApnsTokenRequest({required this.token, @JsonKey(includeIfNull: false) this.environment});
  factory _ApnsTokenRequest.fromJson(Map<String, dynamic> json) => _$ApnsTokenRequestFromJson(json);

@override final  String token;
@override@JsonKey(includeIfNull: false) final  ApnsEnvironment? environment;

/// Create a copy of ApnsTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApnsTokenRequestCopyWith<_ApnsTokenRequest> get copyWith => __$ApnsTokenRequestCopyWithImpl<_ApnsTokenRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApnsTokenRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApnsTokenRequest&&(identical(other.token, token) || other.token == token)&&(identical(other.environment, environment) || other.environment == environment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,environment);

@override
String toString() {
  return 'ApnsTokenRequest(token: $token, environment: $environment)';
}


}

/// @nodoc
abstract mixin class _$ApnsTokenRequestCopyWith<$Res> implements $ApnsTokenRequestCopyWith<$Res> {
  factory _$ApnsTokenRequestCopyWith(_ApnsTokenRequest value, $Res Function(_ApnsTokenRequest) _then) = __$ApnsTokenRequestCopyWithImpl;
@override @useResult
$Res call({
 String token,@JsonKey(includeIfNull: false) ApnsEnvironment? environment
});




}
/// @nodoc
class __$ApnsTokenRequestCopyWithImpl<$Res>
    implements _$ApnsTokenRequestCopyWith<$Res> {
  __$ApnsTokenRequestCopyWithImpl(this._self, this._then);

  final _ApnsTokenRequest _self;
  final $Res Function(_ApnsTokenRequest) _then;

/// Create a copy of ApnsTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? environment = freezed,}) {
  return _then(_ApnsTokenRequest(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,environment: freezed == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as ApnsEnvironment?,
  ));
}


}

// dart format on

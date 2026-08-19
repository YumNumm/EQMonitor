// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionResponse {

 String get id; String get token;@JsonKey(name: 'expires_at') String get expiresAt;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;@JsonKey(includeIfNull: true, name: 'ip_address') String? get ipAddress;@JsonKey(includeIfNull: true, name: 'user_agent') String? get userAgent;
/// Create a copy of SessionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionResponseCopyWith<SessionResponse> get copyWith => _$SessionResponseCopyWithImpl<SessionResponse>(this as SessionResponse, _$identity);

  /// Serializes this SessionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,token,expiresAt,createdAt,updatedAt,ipAddress,userAgent);

@override
String toString() {
  return 'SessionResponse(id: $id, token: $token, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt, ipAddress: $ipAddress, userAgent: $userAgent)';
}


}

/// @nodoc
abstract mixin class $SessionResponseCopyWith<$Res>  {
  factory $SessionResponseCopyWith(SessionResponse value, $Res Function(SessionResponse) _then) = _$SessionResponseCopyWithImpl;
@useResult
$Res call({
 String id, String token,@JsonKey(name: 'expires_at') String expiresAt,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt,@JsonKey(includeIfNull: true, name: 'ip_address') String? ipAddress,@JsonKey(includeIfNull: true, name: 'user_agent') String? userAgent
});




}
/// @nodoc
class _$SessionResponseCopyWithImpl<$Res>
    implements $SessionResponseCopyWith<$Res> {
  _$SessionResponseCopyWithImpl(this._self, this._then);

  final SessionResponse _self;
  final $Res Function(SessionResponse) _then;

/// Create a copy of SessionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? token = null,Object? expiresAt = null,Object? createdAt = null,Object? updatedAt = null,Object? ipAddress = freezed,Object? userAgent = freezed,}) {
  return _then(SessionResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionResponse].
extension SessionResponsePatterns on SessionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionResponse value)  $default,){
final _that = this;
switch (_that) {
case _SessionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SessionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String token, @JsonKey(name: 'expires_at')  String expiresAt, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt, @JsonKey(includeIfNull: true, name: 'ip_address')  String? ipAddress, @JsonKey(includeIfNull: true, name: 'user_agent')  String? userAgent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionResponse() when $default != null:
return $default(_that.id,_that.token,_that.expiresAt,_that.createdAt,_that.updatedAt,_that.ipAddress,_that.userAgent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String token, @JsonKey(name: 'expires_at')  String expiresAt, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt, @JsonKey(includeIfNull: true, name: 'ip_address')  String? ipAddress, @JsonKey(includeIfNull: true, name: 'user_agent')  String? userAgent)  $default,) {final _that = this;
switch (_that) {
case _SessionResponse():
return $default(_that.id,_that.token,_that.expiresAt,_that.createdAt,_that.updatedAt,_that.ipAddress,_that.userAgent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String token, @JsonKey(name: 'expires_at')  String expiresAt, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt, @JsonKey(includeIfNull: true, name: 'ip_address')  String? ipAddress, @JsonKey(includeIfNull: true, name: 'user_agent')  String? userAgent)?  $default,) {final _that = this;
switch (_that) {
case _SessionResponse() when $default != null:
return $default(_that.id,_that.token,_that.expiresAt,_that.createdAt,_that.updatedAt,_that.ipAddress,_that.userAgent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionResponse implements SessionResponse {
  const _SessionResponse({required this.id, required this.token, @JsonKey(name: 'expires_at') required this.expiresAt, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(includeIfNull: true, name: 'ip_address') required this.ipAddress, @JsonKey(includeIfNull: true, name: 'user_agent') required this.userAgent});
  factory _SessionResponse.fromJson(Map<String, dynamic> json) => _$SessionResponseFromJson(json);

@override final  String id;
@override final  String token;
@override@JsonKey(name: 'expires_at') final  String expiresAt;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;
@override@JsonKey(includeIfNull: true, name: 'ip_address') final  String? ipAddress;
@override@JsonKey(includeIfNull: true, name: 'user_agent') final  String? userAgent;

/// Create a copy of SessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionResponseCopyWith<_SessionResponse> get copyWith => __$SessionResponseCopyWithImpl<_SessionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,token,expiresAt,createdAt,updatedAt,ipAddress,userAgent);

@override
String toString() {
  return 'SessionResponse(id: $id, token: $token, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt, ipAddress: $ipAddress, userAgent: $userAgent)';
}


}

/// @nodoc
abstract mixin class _$SessionResponseCopyWith<$Res> implements $SessionResponseCopyWith<$Res> {
  factory _$SessionResponseCopyWith(_SessionResponse value, $Res Function(_SessionResponse) _then) = __$SessionResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String token,@JsonKey(name: 'expires_at') String expiresAt,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt,@JsonKey(includeIfNull: true, name: 'ip_address') String? ipAddress,@JsonKey(includeIfNull: true, name: 'user_agent') String? userAgent
});




}
/// @nodoc
class __$SessionResponseCopyWithImpl<$Res>
    implements _$SessionResponseCopyWith<$Res> {
  __$SessionResponseCopyWithImpl(this._self, this._then);

  final _SessionResponse _self;
  final $Res Function(_SessionResponse) _then;

/// Create a copy of SessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? token = null,Object? expiresAt = null,Object? createdAt = null,Object? updatedAt = null,Object? ipAddress = freezed,Object? userAgent = freezed,}) {
  return _then(_SessionResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

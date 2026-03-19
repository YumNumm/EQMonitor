// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Session {

 DateTime get expiresAt; String get token; DateTime get updatedAt; String get userId; DateTime? get createdAt;@JsonKey(includeIfNull: false) String? get id;@JsonKey(includeIfNull: false) String? get ipAddress;@JsonKey(includeIfNull: false) String? get userAgent;@JsonKey(includeIfNull: false) String? get impersonatedBy;
/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionCopyWith<Session> get copyWith => _$SessionCopyWithImpl<Session>(this as Session, _$identity);

  /// Serializes this Session to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Session&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.token, token) || other.token == token)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.impersonatedBy, impersonatedBy) || other.impersonatedBy == impersonatedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiresAt,token,updatedAt,userId,createdAt,id,ipAddress,userAgent,impersonatedBy);

@override
String toString() {
  return 'Session(expiresAt: $expiresAt, token: $token, updatedAt: $updatedAt, userId: $userId, createdAt: $createdAt, id: $id, ipAddress: $ipAddress, userAgent: $userAgent, impersonatedBy: $impersonatedBy)';
}


}

/// @nodoc
abstract mixin class $SessionCopyWith<$Res>  {
  factory $SessionCopyWith(Session value, $Res Function(Session) _then) = _$SessionCopyWithImpl;
@useResult
$Res call({
 DateTime expiresAt, String token, DateTime updatedAt, String userId, DateTime? createdAt,@JsonKey(includeIfNull: false) String? id,@JsonKey(includeIfNull: false) String? ipAddress,@JsonKey(includeIfNull: false) String? userAgent,@JsonKey(includeIfNull: false) String? impersonatedBy
});




}
/// @nodoc
class _$SessionCopyWithImpl<$Res>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._self, this._then);

  final Session _self;
  final $Res Function(Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expiresAt = null,Object? token = null,Object? updatedAt = null,Object? userId = null,Object? createdAt = freezed,Object? id = freezed,Object? ipAddress = freezed,Object? userAgent = freezed,Object? impersonatedBy = freezed,}) {
  return _then(_self.copyWith(
expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,impersonatedBy: freezed == impersonatedBy ? _self.impersonatedBy : impersonatedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Session].
extension SessionPatterns on Session {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Session value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Session() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Session value)  $default,){
final _that = this;
switch (_that) {
case _Session():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Session value)?  $default,){
final _that = this;
switch (_that) {
case _Session() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime expiresAt,  String token,  DateTime updatedAt,  String userId,  DateTime? createdAt, @JsonKey(includeIfNull: false)  String? id, @JsonKey(includeIfNull: false)  String? ipAddress, @JsonKey(includeIfNull: false)  String? userAgent, @JsonKey(includeIfNull: false)  String? impersonatedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.expiresAt,_that.token,_that.updatedAt,_that.userId,_that.createdAt,_that.id,_that.ipAddress,_that.userAgent,_that.impersonatedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime expiresAt,  String token,  DateTime updatedAt,  String userId,  DateTime? createdAt, @JsonKey(includeIfNull: false)  String? id, @JsonKey(includeIfNull: false)  String? ipAddress, @JsonKey(includeIfNull: false)  String? userAgent, @JsonKey(includeIfNull: false)  String? impersonatedBy)  $default,) {final _that = this;
switch (_that) {
case _Session():
return $default(_that.expiresAt,_that.token,_that.updatedAt,_that.userId,_that.createdAt,_that.id,_that.ipAddress,_that.userAgent,_that.impersonatedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime expiresAt,  String token,  DateTime updatedAt,  String userId,  DateTime? createdAt, @JsonKey(includeIfNull: false)  String? id, @JsonKey(includeIfNull: false)  String? ipAddress, @JsonKey(includeIfNull: false)  String? userAgent, @JsonKey(includeIfNull: false)  String? impersonatedBy)?  $default,) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.expiresAt,_that.token,_that.updatedAt,_that.userId,_that.createdAt,_that.id,_that.ipAddress,_that.userAgent,_that.impersonatedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Session implements Session {
  const _Session({required this.expiresAt, required this.token, required this.updatedAt, required this.userId, this.createdAt, @JsonKey(includeIfNull: false) this.id, @JsonKey(includeIfNull: false) this.ipAddress, @JsonKey(includeIfNull: false) this.userAgent, @JsonKey(includeIfNull: false) this.impersonatedBy});
  factory _Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

@override final  DateTime expiresAt;
@override final  String token;
@override final  DateTime updatedAt;
@override final  String userId;
@override final  DateTime? createdAt;
@override@JsonKey(includeIfNull: false) final  String? id;
@override@JsonKey(includeIfNull: false) final  String? ipAddress;
@override@JsonKey(includeIfNull: false) final  String? userAgent;
@override@JsonKey(includeIfNull: false) final  String? impersonatedBy;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionCopyWith<_Session> get copyWith => __$SessionCopyWithImpl<_Session>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Session&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.token, token) || other.token == token)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.impersonatedBy, impersonatedBy) || other.impersonatedBy == impersonatedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiresAt,token,updatedAt,userId,createdAt,id,ipAddress,userAgent,impersonatedBy);

@override
String toString() {
  return 'Session(expiresAt: $expiresAt, token: $token, updatedAt: $updatedAt, userId: $userId, createdAt: $createdAt, id: $id, ipAddress: $ipAddress, userAgent: $userAgent, impersonatedBy: $impersonatedBy)';
}


}

/// @nodoc
abstract mixin class _$SessionCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$SessionCopyWith(_Session value, $Res Function(_Session) _then) = __$SessionCopyWithImpl;
@override @useResult
$Res call({
 DateTime expiresAt, String token, DateTime updatedAt, String userId, DateTime? createdAt,@JsonKey(includeIfNull: false) String? id,@JsonKey(includeIfNull: false) String? ipAddress,@JsonKey(includeIfNull: false) String? userAgent,@JsonKey(includeIfNull: false) String? impersonatedBy
});




}
/// @nodoc
class __$SessionCopyWithImpl<$Res>
    implements _$SessionCopyWith<$Res> {
  __$SessionCopyWithImpl(this._self, this._then);

  final _Session _self;
  final $Res Function(_Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expiresAt = null,Object? token = null,Object? updatedAt = null,Object? userId = null,Object? createdAt = freezed,Object? id = freezed,Object? ipAddress = freezed,Object? userAgent = freezed,Object? impersonatedBy = freezed,}) {
  return _then(_Session(
expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,impersonatedBy: freezed == impersonatedBy ? _self.impersonatedBy : impersonatedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

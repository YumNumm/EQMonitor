// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Device {

 String get id; DeviceType get type; String get userId; String get createdAt; String get updatedAt;
/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceCopyWith<Device> get copyWith => _$DeviceCopyWithImpl<Device>(this as Device, _$identity);

  /// Serializes this Device to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Device&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,userId,createdAt,updatedAt);

@override
String toString() {
  return 'Device(id: $id, type: $type, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DeviceCopyWith<$Res>  {
  factory $DeviceCopyWith(Device value, $Res Function(Device) _then) = _$DeviceCopyWithImpl;
@useResult
$Res call({
 String id, DeviceType type, String userId, String createdAt, String updatedAt
});




}
/// @nodoc
class _$DeviceCopyWithImpl<$Res>
    implements $DeviceCopyWith<$Res> {
  _$DeviceCopyWithImpl(this._self, this._then);

  final Device _self;
  final $Res Function(Device) _then;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? userId = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Device].
extension DevicePatterns on Device {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Device value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Device() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Device value)  $default,){
final _that = this;
switch (_that) {
case _Device():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Device value)?  $default,){
final _that = this;
switch (_that) {
case _Device() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DeviceType type,  String userId,  String createdAt,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Device() when $default != null:
return $default(_that.id,_that.type,_that.userId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DeviceType type,  String userId,  String createdAt,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Device():
return $default(_that.id,_that.type,_that.userId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DeviceType type,  String userId,  String createdAt,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Device() when $default != null:
return $default(_that.id,_that.type,_that.userId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Device implements Device {
  const _Device({required this.id, required this.type, required this.userId, required this.createdAt, required this.updatedAt});
  factory _Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

@override final  String id;
@override final  DeviceType type;
@override final  String userId;
@override final  String createdAt;
@override final  String updatedAt;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceCopyWith<_Device> get copyWith => __$DeviceCopyWithImpl<_Device>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Device&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,userId,createdAt,updatedAt);

@override
String toString() {
  return 'Device(id: $id, type: $type, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DeviceCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$DeviceCopyWith(_Device value, $Res Function(_Device) _then) = __$DeviceCopyWithImpl;
@override @useResult
$Res call({
 String id, DeviceType type, String userId, String createdAt, String updatedAt
});




}
/// @nodoc
class __$DeviceCopyWithImpl<$Res>
    implements _$DeviceCopyWith<$Res> {
  __$DeviceCopyWithImpl(this._self, this._then);

  final _Device _self;
  final $Res Function(_Device) _then;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? userId = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Device(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DeviceUpsertRequest {

 DeviceType get type;@JsonKey(name: 'user_id') String get userId;
/// Create a copy of DeviceUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceUpsertRequestCopyWith<DeviceUpsertRequest> get copyWith => _$DeviceUpsertRequestCopyWithImpl<DeviceUpsertRequest>(this as DeviceUpsertRequest, _$identity);

  /// Serializes this DeviceUpsertRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceUpsertRequest&&(identical(other.type, type) || other.type == type)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,userId);

@override
String toString() {
  return 'DeviceUpsertRequest(type: $type, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $DeviceUpsertRequestCopyWith<$Res>  {
  factory $DeviceUpsertRequestCopyWith(DeviceUpsertRequest value, $Res Function(DeviceUpsertRequest) _then) = _$DeviceUpsertRequestCopyWithImpl;
@useResult
$Res call({
 DeviceType type,@JsonKey(name: 'user_id') String userId
});




}
/// @nodoc
class _$DeviceUpsertRequestCopyWithImpl<$Res>
    implements $DeviceUpsertRequestCopyWith<$Res> {
  _$DeviceUpsertRequestCopyWithImpl(this._self, this._then);

  final DeviceUpsertRequest _self;
  final $Res Function(DeviceUpsertRequest) _then;

/// Create a copy of DeviceUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? userId = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceUpsertRequest].
extension DeviceUpsertRequestPatterns on DeviceUpsertRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceUpsertRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceUpsertRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceUpsertRequest value)  $default,){
final _that = this;
switch (_that) {
case _DeviceUpsertRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceUpsertRequest value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceUpsertRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeviceType type, @JsonKey(name: 'user_id')  String userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceUpsertRequest() when $default != null:
return $default(_that.type,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeviceType type, @JsonKey(name: 'user_id')  String userId)  $default,) {final _that = this;
switch (_that) {
case _DeviceUpsertRequest():
return $default(_that.type,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeviceType type, @JsonKey(name: 'user_id')  String userId)?  $default,) {final _that = this;
switch (_that) {
case _DeviceUpsertRequest() when $default != null:
return $default(_that.type,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceUpsertRequest implements DeviceUpsertRequest {
  const _DeviceUpsertRequest({required this.type, @JsonKey(name: 'user_id') required this.userId});
  factory _DeviceUpsertRequest.fromJson(Map<String, dynamic> json) => _$DeviceUpsertRequestFromJson(json);

@override final  DeviceType type;
@override@JsonKey(name: 'user_id') final  String userId;

/// Create a copy of DeviceUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceUpsertRequestCopyWith<_DeviceUpsertRequest> get copyWith => __$DeviceUpsertRequestCopyWithImpl<_DeviceUpsertRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceUpsertRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceUpsertRequest&&(identical(other.type, type) || other.type == type)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,userId);

@override
String toString() {
  return 'DeviceUpsertRequest(type: $type, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$DeviceUpsertRequestCopyWith<$Res> implements $DeviceUpsertRequestCopyWith<$Res> {
  factory _$DeviceUpsertRequestCopyWith(_DeviceUpsertRequest value, $Res Function(_DeviceUpsertRequest) _then) = __$DeviceUpsertRequestCopyWithImpl;
@override @useResult
$Res call({
 DeviceType type,@JsonKey(name: 'user_id') String userId
});




}
/// @nodoc
class __$DeviceUpsertRequestCopyWithImpl<$Res>
    implements _$DeviceUpsertRequestCopyWith<$Res> {
  __$DeviceUpsertRequestCopyWithImpl(this._self, this._then);

  final _DeviceUpsertRequest _self;
  final $Res Function(_DeviceUpsertRequest) _then;

/// Create a copy of DeviceUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? userId = null,}) {
  return _then(_DeviceUpsertRequest(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ApnsToken {

 ApnsTokenType get type; String get token;
/// Create a copy of ApnsToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApnsTokenCopyWith<ApnsToken> get copyWith => _$ApnsTokenCopyWithImpl<ApnsToken>(this as ApnsToken, _$identity);

  /// Serializes this ApnsToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApnsToken&&(identical(other.type, type) || other.type == type)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,token);

@override
String toString() {
  return 'ApnsToken(type: $type, token: $token)';
}


}

/// @nodoc
abstract mixin class $ApnsTokenCopyWith<$Res>  {
  factory $ApnsTokenCopyWith(ApnsToken value, $Res Function(ApnsToken) _then) = _$ApnsTokenCopyWithImpl;
@useResult
$Res call({
 ApnsTokenType type, String token
});




}
/// @nodoc
class _$ApnsTokenCopyWithImpl<$Res>
    implements $ApnsTokenCopyWith<$Res> {
  _$ApnsTokenCopyWithImpl(this._self, this._then);

  final ApnsToken _self;
  final $Res Function(ApnsToken) _then;

/// Create a copy of ApnsToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? token = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ApnsTokenType,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ApnsToken].
extension ApnsTokenPatterns on ApnsToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApnsToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApnsToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApnsToken value)  $default,){
final _that = this;
switch (_that) {
case _ApnsToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApnsToken value)?  $default,){
final _that = this;
switch (_that) {
case _ApnsToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApnsTokenType type,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApnsToken() when $default != null:
return $default(_that.type,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApnsTokenType type,  String token)  $default,) {final _that = this;
switch (_that) {
case _ApnsToken():
return $default(_that.type,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApnsTokenType type,  String token)?  $default,) {final _that = this;
switch (_that) {
case _ApnsToken() when $default != null:
return $default(_that.type,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApnsToken implements ApnsToken {
  const _ApnsToken({required this.type, required this.token});
  factory _ApnsToken.fromJson(Map<String, dynamic> json) => _$ApnsTokenFromJson(json);

@override final  ApnsTokenType type;
@override final  String token;

/// Create a copy of ApnsToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApnsTokenCopyWith<_ApnsToken> get copyWith => __$ApnsTokenCopyWithImpl<_ApnsToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApnsTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApnsToken&&(identical(other.type, type) || other.type == type)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,token);

@override
String toString() {
  return 'ApnsToken(type: $type, token: $token)';
}


}

/// @nodoc
abstract mixin class _$ApnsTokenCopyWith<$Res> implements $ApnsTokenCopyWith<$Res> {
  factory _$ApnsTokenCopyWith(_ApnsToken value, $Res Function(_ApnsToken) _then) = __$ApnsTokenCopyWithImpl;
@override @useResult
$Res call({
 ApnsTokenType type, String token
});




}
/// @nodoc
class __$ApnsTokenCopyWithImpl<$Res>
    implements _$ApnsTokenCopyWith<$Res> {
  __$ApnsTokenCopyWithImpl(this._self, this._then);

  final _ApnsToken _self;
  final $Res Function(_ApnsToken) _then;

/// Create a copy of ApnsToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? token = null,}) {
  return _then(_ApnsToken(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ApnsTokenType,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ApnsTokenRequest {

 String get token;
/// Create a copy of ApnsTokenRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApnsTokenRequestCopyWith<ApnsTokenRequest> get copyWith => _$ApnsTokenRequestCopyWithImpl<ApnsTokenRequest>(this as ApnsTokenRequest, _$identity);

  /// Serializes this ApnsTokenRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApnsTokenRequest&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'ApnsTokenRequest(token: $token)';
}


}

/// @nodoc
abstract mixin class $ApnsTokenRequestCopyWith<$Res>  {
  factory $ApnsTokenRequestCopyWith(ApnsTokenRequest value, $Res Function(ApnsTokenRequest) _then) = _$ApnsTokenRequestCopyWithImpl;
@useResult
$Res call({
 String token
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
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApnsTokenRequest() when $default != null:
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
case _ApnsTokenRequest():
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
case _ApnsTokenRequest() when $default != null:
return $default(_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApnsTokenRequest implements ApnsTokenRequest {
  const _ApnsTokenRequest({required this.token});
  factory _ApnsTokenRequest.fromJson(Map<String, dynamic> json) => _$ApnsTokenRequestFromJson(json);

@override final  String token;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApnsTokenRequest&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'ApnsTokenRequest(token: $token)';
}


}

/// @nodoc
abstract mixin class _$ApnsTokenRequestCopyWith<$Res> implements $ApnsTokenRequestCopyWith<$Res> {
  factory _$ApnsTokenRequestCopyWith(_ApnsTokenRequest value, $Res Function(_ApnsTokenRequest) _then) = __$ApnsTokenRequestCopyWithImpl;
@override @useResult
$Res call({
 String token
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
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(_ApnsTokenRequest(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FcmToken {

 String get token;
/// Create a copy of FcmToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FcmTokenCopyWith<FcmToken> get copyWith => _$FcmTokenCopyWithImpl<FcmToken>(this as FcmToken, _$identity);

  /// Serializes this FcmToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FcmToken&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'FcmToken(token: $token)';
}


}

/// @nodoc
abstract mixin class $FcmTokenCopyWith<$Res>  {
  factory $FcmTokenCopyWith(FcmToken value, $Res Function(FcmToken) _then) = _$FcmTokenCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class _$FcmTokenCopyWithImpl<$Res>
    implements $FcmTokenCopyWith<$Res> {
  _$FcmTokenCopyWithImpl(this._self, this._then);

  final FcmToken _self;
  final $Res Function(FcmToken) _then;

/// Create a copy of FcmToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FcmToken].
extension FcmTokenPatterns on FcmToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FcmToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FcmToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FcmToken value)  $default,){
final _that = this;
switch (_that) {
case _FcmToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FcmToken value)?  $default,){
final _that = this;
switch (_that) {
case _FcmToken() when $default != null:
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
case _FcmToken() when $default != null:
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
case _FcmToken():
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
case _FcmToken() when $default != null:
return $default(_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FcmToken implements FcmToken {
  const _FcmToken({required this.token});
  factory _FcmToken.fromJson(Map<String, dynamic> json) => _$FcmTokenFromJson(json);

@override final  String token;

/// Create a copy of FcmToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FcmTokenCopyWith<_FcmToken> get copyWith => __$FcmTokenCopyWithImpl<_FcmToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FcmTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FcmToken&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'FcmToken(token: $token)';
}


}

/// @nodoc
abstract mixin class _$FcmTokenCopyWith<$Res> implements $FcmTokenCopyWith<$Res> {
  factory _$FcmTokenCopyWith(_FcmToken value, $Res Function(_FcmToken) _then) = __$FcmTokenCopyWithImpl;
@override @useResult
$Res call({
 String token
});




}
/// @nodoc
class __$FcmTokenCopyWithImpl<$Res>
    implements _$FcmTokenCopyWith<$Res> {
  __$FcmTokenCopyWithImpl(this._self, this._then);

  final _FcmToken _self;
  final $Res Function(_FcmToken) _then;

/// Create a copy of FcmToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(_FcmToken(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FcmTokenRequest {

 String get token;
/// Create a copy of FcmTokenRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FcmTokenRequestCopyWith<FcmTokenRequest> get copyWith => _$FcmTokenRequestCopyWithImpl<FcmTokenRequest>(this as FcmTokenRequest, _$identity);

  /// Serializes this FcmTokenRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FcmTokenRequest&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'FcmTokenRequest(token: $token)';
}


}

/// @nodoc
abstract mixin class $FcmTokenRequestCopyWith<$Res>  {
  factory $FcmTokenRequestCopyWith(FcmTokenRequest value, $Res Function(FcmTokenRequest) _then) = _$FcmTokenRequestCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class _$FcmTokenRequestCopyWithImpl<$Res>
    implements $FcmTokenRequestCopyWith<$Res> {
  _$FcmTokenRequestCopyWithImpl(this._self, this._then);

  final FcmTokenRequest _self;
  final $Res Function(FcmTokenRequest) _then;

/// Create a copy of FcmTokenRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FcmTokenRequest].
extension FcmTokenRequestPatterns on FcmTokenRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FcmTokenRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FcmTokenRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FcmTokenRequest value)  $default,){
final _that = this;
switch (_that) {
case _FcmTokenRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FcmTokenRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FcmTokenRequest() when $default != null:
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
case _FcmTokenRequest() when $default != null:
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
case _FcmTokenRequest():
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
case _FcmTokenRequest() when $default != null:
return $default(_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FcmTokenRequest implements FcmTokenRequest {
  const _FcmTokenRequest({required this.token});
  factory _FcmTokenRequest.fromJson(Map<String, dynamic> json) => _$FcmTokenRequestFromJson(json);

@override final  String token;

/// Create a copy of FcmTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FcmTokenRequestCopyWith<_FcmTokenRequest> get copyWith => __$FcmTokenRequestCopyWithImpl<_FcmTokenRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FcmTokenRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FcmTokenRequest&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'FcmTokenRequest(token: $token)';
}


}

/// @nodoc
abstract mixin class _$FcmTokenRequestCopyWith<$Res> implements $FcmTokenRequestCopyWith<$Res> {
  factory _$FcmTokenRequestCopyWith(_FcmTokenRequest value, $Res Function(_FcmTokenRequest) _then) = __$FcmTokenRequestCopyWithImpl;
@override @useResult
$Res call({
 String token
});




}
/// @nodoc
class __$FcmTokenRequestCopyWithImpl<$Res>
    implements _$FcmTokenRequestCopyWith<$Res> {
  __$FcmTokenRequestCopyWithImpl(this._self, this._then);

  final _FcmTokenRequest _self;
  final $Res Function(_FcmTokenRequest) _then;

/// Create a copy of FcmTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(_FcmTokenRequest(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LiveActivityTokenRequest {

 String get token;
/// Create a copy of LiveActivityTokenRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveActivityTokenRequestCopyWith<LiveActivityTokenRequest> get copyWith => _$LiveActivityTokenRequestCopyWithImpl<LiveActivityTokenRequest>(this as LiveActivityTokenRequest, _$identity);

  /// Serializes this LiveActivityTokenRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveActivityTokenRequest&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'LiveActivityTokenRequest(token: $token)';
}


}

/// @nodoc
abstract mixin class $LiveActivityTokenRequestCopyWith<$Res>  {
  factory $LiveActivityTokenRequestCopyWith(LiveActivityTokenRequest value, $Res Function(LiveActivityTokenRequest) _then) = _$LiveActivityTokenRequestCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class _$LiveActivityTokenRequestCopyWithImpl<$Res>
    implements $LiveActivityTokenRequestCopyWith<$Res> {
  _$LiveActivityTokenRequestCopyWithImpl(this._self, this._then);

  final LiveActivityTokenRequest _self;
  final $Res Function(LiveActivityTokenRequest) _then;

/// Create a copy of LiveActivityTokenRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveActivityTokenRequest].
extension LiveActivityTokenRequestPatterns on LiveActivityTokenRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveActivityTokenRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveActivityTokenRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveActivityTokenRequest value)  $default,){
final _that = this;
switch (_that) {
case _LiveActivityTokenRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveActivityTokenRequest value)?  $default,){
final _that = this;
switch (_that) {
case _LiveActivityTokenRequest() when $default != null:
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
case _LiveActivityTokenRequest() when $default != null:
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
case _LiveActivityTokenRequest():
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
case _LiveActivityTokenRequest() when $default != null:
return $default(_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveActivityTokenRequest implements LiveActivityTokenRequest {
  const _LiveActivityTokenRequest({required this.token});
  factory _LiveActivityTokenRequest.fromJson(Map<String, dynamic> json) => _$LiveActivityTokenRequestFromJson(json);

@override final  String token;

/// Create a copy of LiveActivityTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveActivityTokenRequestCopyWith<_LiveActivityTokenRequest> get copyWith => __$LiveActivityTokenRequestCopyWithImpl<_LiveActivityTokenRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveActivityTokenRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveActivityTokenRequest&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'LiveActivityTokenRequest(token: $token)';
}


}

/// @nodoc
abstract mixin class _$LiveActivityTokenRequestCopyWith<$Res> implements $LiveActivityTokenRequestCopyWith<$Res> {
  factory _$LiveActivityTokenRequestCopyWith(_LiveActivityTokenRequest value, $Res Function(_LiveActivityTokenRequest) _then) = __$LiveActivityTokenRequestCopyWithImpl;
@override @useResult
$Res call({
 String token
});




}
/// @nodoc
class __$LiveActivityTokenRequestCopyWithImpl<$Res>
    implements _$LiveActivityTokenRequestCopyWith<$Res> {
  __$LiveActivityTokenRequestCopyWithImpl(this._self, this._then);

  final _LiveActivityTokenRequest _self;
  final $Res Function(_LiveActivityTokenRequest) _then;

/// Create a copy of LiveActivityTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(_LiveActivityTokenRequest(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LiveActivityInfo {

 String get liveActivityId; String get eventId; LiveActivityStartTrigger get startTrigger; String get createdAt;
/// Create a copy of LiveActivityInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveActivityInfoCopyWith<LiveActivityInfo> get copyWith => _$LiveActivityInfoCopyWithImpl<LiveActivityInfo>(this as LiveActivityInfo, _$identity);

  /// Serializes this LiveActivityInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveActivityInfo&&(identical(other.liveActivityId, liveActivityId) || other.liveActivityId == liveActivityId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.startTrigger, startTrigger) || other.startTrigger == startTrigger)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,liveActivityId,eventId,startTrigger,createdAt);

@override
String toString() {
  return 'LiveActivityInfo(liveActivityId: $liveActivityId, eventId: $eventId, startTrigger: $startTrigger, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LiveActivityInfoCopyWith<$Res>  {
  factory $LiveActivityInfoCopyWith(LiveActivityInfo value, $Res Function(LiveActivityInfo) _then) = _$LiveActivityInfoCopyWithImpl;
@useResult
$Res call({
 String liveActivityId, String eventId, LiveActivityStartTrigger startTrigger, String createdAt
});




}
/// @nodoc
class _$LiveActivityInfoCopyWithImpl<$Res>
    implements $LiveActivityInfoCopyWith<$Res> {
  _$LiveActivityInfoCopyWithImpl(this._self, this._then);

  final LiveActivityInfo _self;
  final $Res Function(LiveActivityInfo) _then;

/// Create a copy of LiveActivityInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? liveActivityId = null,Object? eventId = null,Object? startTrigger = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
liveActivityId: null == liveActivityId ? _self.liveActivityId : liveActivityId // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,startTrigger: null == startTrigger ? _self.startTrigger : startTrigger // ignore: cast_nullable_to_non_nullable
as LiveActivityStartTrigger,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveActivityInfo].
extension LiveActivityInfoPatterns on LiveActivityInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveActivityInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveActivityInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveActivityInfo value)  $default,){
final _that = this;
switch (_that) {
case _LiveActivityInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveActivityInfo value)?  $default,){
final _that = this;
switch (_that) {
case _LiveActivityInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String liveActivityId,  String eventId,  LiveActivityStartTrigger startTrigger,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveActivityInfo() when $default != null:
return $default(_that.liveActivityId,_that.eventId,_that.startTrigger,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String liveActivityId,  String eventId,  LiveActivityStartTrigger startTrigger,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _LiveActivityInfo():
return $default(_that.liveActivityId,_that.eventId,_that.startTrigger,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String liveActivityId,  String eventId,  LiveActivityStartTrigger startTrigger,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LiveActivityInfo() when $default != null:
return $default(_that.liveActivityId,_that.eventId,_that.startTrigger,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveActivityInfo implements LiveActivityInfo {
  const _LiveActivityInfo({required this.liveActivityId, required this.eventId, required this.startTrigger, required this.createdAt});
  factory _LiveActivityInfo.fromJson(Map<String, dynamic> json) => _$LiveActivityInfoFromJson(json);

@override final  String liveActivityId;
@override final  String eventId;
@override final  LiveActivityStartTrigger startTrigger;
@override final  String createdAt;

/// Create a copy of LiveActivityInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveActivityInfoCopyWith<_LiveActivityInfo> get copyWith => __$LiveActivityInfoCopyWithImpl<_LiveActivityInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveActivityInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveActivityInfo&&(identical(other.liveActivityId, liveActivityId) || other.liveActivityId == liveActivityId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.startTrigger, startTrigger) || other.startTrigger == startTrigger)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,liveActivityId,eventId,startTrigger,createdAt);

@override
String toString() {
  return 'LiveActivityInfo(liveActivityId: $liveActivityId, eventId: $eventId, startTrigger: $startTrigger, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LiveActivityInfoCopyWith<$Res> implements $LiveActivityInfoCopyWith<$Res> {
  factory _$LiveActivityInfoCopyWith(_LiveActivityInfo value, $Res Function(_LiveActivityInfo) _then) = __$LiveActivityInfoCopyWithImpl;
@override @useResult
$Res call({
 String liveActivityId, String eventId, LiveActivityStartTrigger startTrigger, String createdAt
});




}
/// @nodoc
class __$LiveActivityInfoCopyWithImpl<$Res>
    implements _$LiveActivityInfoCopyWith<$Res> {
  __$LiveActivityInfoCopyWithImpl(this._self, this._then);

  final _LiveActivityInfo _self;
  final $Res Function(_LiveActivityInfo) _then;

/// Create a copy of LiveActivityInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? liveActivityId = null,Object? eventId = null,Object? startTrigger = null,Object? createdAt = null,}) {
  return _then(_LiveActivityInfo(
liveActivityId: null == liveActivityId ? _self.liveActivityId : liveActivityId // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,startTrigger: null == startTrigger ? _self.startTrigger : startTrigger // ignore: cast_nullable_to_non_nullable
as LiveActivityStartTrigger,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

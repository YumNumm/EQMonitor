// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_list_accounts_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetListAccountsResponse {

 String get id; String get providerId; DateTime get createdAt; DateTime get updatedAt; String get accountId; String get userId; List<String> get scopes;
/// Create a copy of GetListAccountsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetListAccountsResponseCopyWith<GetListAccountsResponse> get copyWith => _$GetListAccountsResponseCopyWithImpl<GetListAccountsResponse>(this as GetListAccountsResponse, _$identity);

  /// Serializes this GetListAccountsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetListAccountsResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.scopes, scopes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,providerId,createdAt,updatedAt,accountId,userId,const DeepCollectionEquality().hash(scopes));

@override
String toString() {
  return 'GetListAccountsResponse(id: $id, providerId: $providerId, createdAt: $createdAt, updatedAt: $updatedAt, accountId: $accountId, userId: $userId, scopes: $scopes)';
}


}

/// @nodoc
abstract mixin class $GetListAccountsResponseCopyWith<$Res>  {
  factory $GetListAccountsResponseCopyWith(GetListAccountsResponse value, $Res Function(GetListAccountsResponse) _then) = _$GetListAccountsResponseCopyWithImpl;
@useResult
$Res call({
 String id, String providerId, DateTime createdAt, DateTime updatedAt, String accountId, String userId, List<String> scopes
});




}
/// @nodoc
class _$GetListAccountsResponseCopyWithImpl<$Res>
    implements $GetListAccountsResponseCopyWith<$Res> {
  _$GetListAccountsResponseCopyWithImpl(this._self, this._then);

  final GetListAccountsResponse _self;
  final $Res Function(GetListAccountsResponse) _then;

/// Create a copy of GetListAccountsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? providerId = null,Object? createdAt = null,Object? updatedAt = null,Object? accountId = null,Object? userId = null,Object? scopes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,scopes: null == scopes ? _self.scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [GetListAccountsResponse].
extension GetListAccountsResponsePatterns on GetListAccountsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetListAccountsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetListAccountsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetListAccountsResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetListAccountsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetListAccountsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetListAccountsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String providerId,  DateTime createdAt,  DateTime updatedAt,  String accountId,  String userId,  List<String> scopes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetListAccountsResponse() when $default != null:
return $default(_that.id,_that.providerId,_that.createdAt,_that.updatedAt,_that.accountId,_that.userId,_that.scopes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String providerId,  DateTime createdAt,  DateTime updatedAt,  String accountId,  String userId,  List<String> scopes)  $default,) {final _that = this;
switch (_that) {
case _GetListAccountsResponse():
return $default(_that.id,_that.providerId,_that.createdAt,_that.updatedAt,_that.accountId,_that.userId,_that.scopes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String providerId,  DateTime createdAt,  DateTime updatedAt,  String accountId,  String userId,  List<String> scopes)?  $default,) {final _that = this;
switch (_that) {
case _GetListAccountsResponse() when $default != null:
return $default(_that.id,_that.providerId,_that.createdAt,_that.updatedAt,_that.accountId,_that.userId,_that.scopes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetListAccountsResponse implements GetListAccountsResponse {
  const _GetListAccountsResponse({required this.id, required this.providerId, required this.createdAt, required this.updatedAt, required this.accountId, required this.userId, required final  List<String> scopes}): _scopes = scopes;
  factory _GetListAccountsResponse.fromJson(Map<String, dynamic> json) => _$GetListAccountsResponseFromJson(json);

@override final  String id;
@override final  String providerId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String accountId;
@override final  String userId;
 final  List<String> _scopes;
@override List<String> get scopes {
  if (_scopes is EqualUnmodifiableListView) return _scopes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scopes);
}


/// Create a copy of GetListAccountsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetListAccountsResponseCopyWith<_GetListAccountsResponse> get copyWith => __$GetListAccountsResponseCopyWithImpl<_GetListAccountsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetListAccountsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetListAccountsResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._scopes, _scopes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,providerId,createdAt,updatedAt,accountId,userId,const DeepCollectionEquality().hash(_scopes));

@override
String toString() {
  return 'GetListAccountsResponse(id: $id, providerId: $providerId, createdAt: $createdAt, updatedAt: $updatedAt, accountId: $accountId, userId: $userId, scopes: $scopes)';
}


}

/// @nodoc
abstract mixin class _$GetListAccountsResponseCopyWith<$Res> implements $GetListAccountsResponseCopyWith<$Res> {
  factory _$GetListAccountsResponseCopyWith(_GetListAccountsResponse value, $Res Function(_GetListAccountsResponse) _then) = __$GetListAccountsResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String providerId, DateTime createdAt, DateTime updatedAt, String accountId, String userId, List<String> scopes
});




}
/// @nodoc
class __$GetListAccountsResponseCopyWithImpl<$Res>
    implements _$GetListAccountsResponseCopyWith<$Res> {
  __$GetListAccountsResponseCopyWithImpl(this._self, this._then);

  final _GetListAccountsResponse _self;
  final $Res Function(_GetListAccountsResponse) _then;

/// Create a copy of GetListAccountsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? providerId = null,Object? createdAt = null,Object? updatedAt = null,Object? accountId = null,Object? userId = null,Object? scopes = null,}) {
  return _then(_GetListAccountsResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,scopes: null == scopes ? _self._scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

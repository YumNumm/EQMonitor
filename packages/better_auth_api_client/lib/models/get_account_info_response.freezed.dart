// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_account_info_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetAccountInfoResponse {

 User4 get user; dynamic get data;
/// Create a copy of GetAccountInfoResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetAccountInfoResponseCopyWith<GetAccountInfoResponse> get copyWith => _$GetAccountInfoResponseCopyWithImpl<GetAccountInfoResponse>(this as GetAccountInfoResponse, _$identity);

  /// Serializes this GetAccountInfoResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetAccountInfoResponse&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'GetAccountInfoResponse(user: $user, data: $data)';
}


}

/// @nodoc
abstract mixin class $GetAccountInfoResponseCopyWith<$Res>  {
  factory $GetAccountInfoResponseCopyWith(GetAccountInfoResponse value, $Res Function(GetAccountInfoResponse) _then) = _$GetAccountInfoResponseCopyWithImpl;
@useResult
$Res call({
 User4 user, dynamic data
});


$User4CopyWith<$Res> get user;

}
/// @nodoc
class _$GetAccountInfoResponseCopyWithImpl<$Res>
    implements $GetAccountInfoResponseCopyWith<$Res> {
  _$GetAccountInfoResponseCopyWithImpl(this._self, this._then);

  final GetAccountInfoResponse _self;
  final $Res Function(GetAccountInfoResponse) _then;

/// Create a copy of GetAccountInfoResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User4,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of GetAccountInfoResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$User4CopyWith<$Res> get user {
  
  return $User4CopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [GetAccountInfoResponse].
extension GetAccountInfoResponsePatterns on GetAccountInfoResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetAccountInfoResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetAccountInfoResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetAccountInfoResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetAccountInfoResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetAccountInfoResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetAccountInfoResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User4 user,  dynamic data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetAccountInfoResponse() when $default != null:
return $default(_that.user,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User4 user,  dynamic data)  $default,) {final _that = this;
switch (_that) {
case _GetAccountInfoResponse():
return $default(_that.user,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User4 user,  dynamic data)?  $default,) {final _that = this;
switch (_that) {
case _GetAccountInfoResponse() when $default != null:
return $default(_that.user,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetAccountInfoResponse implements GetAccountInfoResponse {
  const _GetAccountInfoResponse({required this.user, required this.data});
  factory _GetAccountInfoResponse.fromJson(Map<String, dynamic> json) => _$GetAccountInfoResponseFromJson(json);

@override final  User4 user;
@override final  dynamic data;

/// Create a copy of GetAccountInfoResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetAccountInfoResponseCopyWith<_GetAccountInfoResponse> get copyWith => __$GetAccountInfoResponseCopyWithImpl<_GetAccountInfoResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetAccountInfoResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetAccountInfoResponse&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'GetAccountInfoResponse(user: $user, data: $data)';
}


}

/// @nodoc
abstract mixin class _$GetAccountInfoResponseCopyWith<$Res> implements $GetAccountInfoResponseCopyWith<$Res> {
  factory _$GetAccountInfoResponseCopyWith(_GetAccountInfoResponse value, $Res Function(_GetAccountInfoResponse) _then) = __$GetAccountInfoResponseCopyWithImpl;
@override @useResult
$Res call({
 User4 user, dynamic data
});


@override $User4CopyWith<$Res> get user;

}
/// @nodoc
class __$GetAccountInfoResponseCopyWithImpl<$Res>
    implements _$GetAccountInfoResponseCopyWith<$Res> {
  __$GetAccountInfoResponseCopyWithImpl(this._self, this._then);

  final _GetAccountInfoResponse _self;
  final $Res Function(_GetAccountInfoResponse) _then;

/// Create a copy of GetAccountInfoResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? data = freezed,}) {
  return _then(_GetAccountInfoResponse(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User4,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of GetAccountInfoResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$User4CopyWith<$Res> get user {
  
  return $User4CopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on

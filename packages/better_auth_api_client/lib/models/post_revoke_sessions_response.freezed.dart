// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_revoke_sessions_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostRevokeSessionsResponse {

/// Indicates if all sessions were revoked successfully
 bool get status;
/// Create a copy of PostRevokeSessionsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostRevokeSessionsResponseCopyWith<PostRevokeSessionsResponse> get copyWith => _$PostRevokeSessionsResponseCopyWithImpl<PostRevokeSessionsResponse>(this as PostRevokeSessionsResponse, _$identity);

  /// Serializes this PostRevokeSessionsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostRevokeSessionsResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostRevokeSessionsResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class $PostRevokeSessionsResponseCopyWith<$Res>  {
  factory $PostRevokeSessionsResponseCopyWith(PostRevokeSessionsResponse value, $Res Function(PostRevokeSessionsResponse) _then) = _$PostRevokeSessionsResponseCopyWithImpl;
@useResult
$Res call({
 bool status
});




}
/// @nodoc
class _$PostRevokeSessionsResponseCopyWithImpl<$Res>
    implements $PostRevokeSessionsResponseCopyWith<$Res> {
  _$PostRevokeSessionsResponseCopyWithImpl(this._self, this._then);

  final PostRevokeSessionsResponse _self;
  final $Res Function(PostRevokeSessionsResponse) _then;

/// Create a copy of PostRevokeSessionsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostRevokeSessionsResponse].
extension PostRevokeSessionsResponsePatterns on PostRevokeSessionsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostRevokeSessionsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostRevokeSessionsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostRevokeSessionsResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostRevokeSessionsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostRevokeSessionsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostRevokeSessionsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostRevokeSessionsResponse() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool status)  $default,) {final _that = this;
switch (_that) {
case _PostRevokeSessionsResponse():
return $default(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool status)?  $default,) {final _that = this;
switch (_that) {
case _PostRevokeSessionsResponse() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostRevokeSessionsResponse implements PostRevokeSessionsResponse {
  const _PostRevokeSessionsResponse({required this.status});
  factory _PostRevokeSessionsResponse.fromJson(Map<String, dynamic> json) => _$PostRevokeSessionsResponseFromJson(json);

/// Indicates if all sessions were revoked successfully
@override final  bool status;

/// Create a copy of PostRevokeSessionsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostRevokeSessionsResponseCopyWith<_PostRevokeSessionsResponse> get copyWith => __$PostRevokeSessionsResponseCopyWithImpl<_PostRevokeSessionsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostRevokeSessionsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostRevokeSessionsResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostRevokeSessionsResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class _$PostRevokeSessionsResponseCopyWith<$Res> implements $PostRevokeSessionsResponseCopyWith<$Res> {
  factory _$PostRevokeSessionsResponseCopyWith(_PostRevokeSessionsResponse value, $Res Function(_PostRevokeSessionsResponse) _then) = __$PostRevokeSessionsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool status
});




}
/// @nodoc
class __$PostRevokeSessionsResponseCopyWithImpl<$Res>
    implements _$PostRevokeSessionsResponseCopyWith<$Res> {
  __$PostRevokeSessionsResponseCopyWithImpl(this._self, this._then);

  final _PostRevokeSessionsResponse _self;
  final $Res Function(_PostRevokeSessionsResponse) _then;

/// Create a copy of PostRevokeSessionsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_PostRevokeSessionsResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

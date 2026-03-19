// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_revoke_session_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostRevokeSessionResponse {

/// Indicates if the session was revoked successfully
 bool get status;
/// Create a copy of PostRevokeSessionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostRevokeSessionResponseCopyWith<PostRevokeSessionResponse> get copyWith => _$PostRevokeSessionResponseCopyWithImpl<PostRevokeSessionResponse>(this as PostRevokeSessionResponse, _$identity);

  /// Serializes this PostRevokeSessionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostRevokeSessionResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostRevokeSessionResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class $PostRevokeSessionResponseCopyWith<$Res>  {
  factory $PostRevokeSessionResponseCopyWith(PostRevokeSessionResponse value, $Res Function(PostRevokeSessionResponse) _then) = _$PostRevokeSessionResponseCopyWithImpl;
@useResult
$Res call({
 bool status
});




}
/// @nodoc
class _$PostRevokeSessionResponseCopyWithImpl<$Res>
    implements $PostRevokeSessionResponseCopyWith<$Res> {
  _$PostRevokeSessionResponseCopyWithImpl(this._self, this._then);

  final PostRevokeSessionResponse _self;
  final $Res Function(PostRevokeSessionResponse) _then;

/// Create a copy of PostRevokeSessionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostRevokeSessionResponse].
extension PostRevokeSessionResponsePatterns on PostRevokeSessionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostRevokeSessionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostRevokeSessionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostRevokeSessionResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostRevokeSessionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostRevokeSessionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostRevokeSessionResponse() when $default != null:
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
case _PostRevokeSessionResponse() when $default != null:
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
case _PostRevokeSessionResponse():
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
case _PostRevokeSessionResponse() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostRevokeSessionResponse implements PostRevokeSessionResponse {
  const _PostRevokeSessionResponse({required this.status});
  factory _PostRevokeSessionResponse.fromJson(Map<String, dynamic> json) => _$PostRevokeSessionResponseFromJson(json);

/// Indicates if the session was revoked successfully
@override final  bool status;

/// Create a copy of PostRevokeSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostRevokeSessionResponseCopyWith<_PostRevokeSessionResponse> get copyWith => __$PostRevokeSessionResponseCopyWithImpl<_PostRevokeSessionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostRevokeSessionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostRevokeSessionResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostRevokeSessionResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class _$PostRevokeSessionResponseCopyWith<$Res> implements $PostRevokeSessionResponseCopyWith<$Res> {
  factory _$PostRevokeSessionResponseCopyWith(_PostRevokeSessionResponse value, $Res Function(_PostRevokeSessionResponse) _then) = __$PostRevokeSessionResponseCopyWithImpl;
@override @useResult
$Res call({
 bool status
});




}
/// @nodoc
class __$PostRevokeSessionResponseCopyWithImpl<$Res>
    implements _$PostRevokeSessionResponseCopyWith<$Res> {
  __$PostRevokeSessionResponseCopyWithImpl(this._self, this._then);

  final _PostRevokeSessionResponse _self;
  final $Res Function(_PostRevokeSessionResponse) _then;

/// Create a copy of PostRevokeSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_PostRevokeSessionResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

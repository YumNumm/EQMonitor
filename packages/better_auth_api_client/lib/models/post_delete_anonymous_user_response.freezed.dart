// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_delete_anonymous_user_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostDeleteAnonymousUserResponse {

 bool get success;
/// Create a copy of PostDeleteAnonymousUserResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDeleteAnonymousUserResponseCopyWith<PostDeleteAnonymousUserResponse> get copyWith => _$PostDeleteAnonymousUserResponseCopyWithImpl<PostDeleteAnonymousUserResponse>(this as PostDeleteAnonymousUserResponse, _$identity);

  /// Serializes this PostDeleteAnonymousUserResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDeleteAnonymousUserResponse&&(identical(other.success, success) || other.success == success));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success);

@override
String toString() {
  return 'PostDeleteAnonymousUserResponse(success: $success)';
}


}

/// @nodoc
abstract mixin class $PostDeleteAnonymousUserResponseCopyWith<$Res>  {
  factory $PostDeleteAnonymousUserResponseCopyWith(PostDeleteAnonymousUserResponse value, $Res Function(PostDeleteAnonymousUserResponse) _then) = _$PostDeleteAnonymousUserResponseCopyWithImpl;
@useResult
$Res call({
 bool success
});




}
/// @nodoc
class _$PostDeleteAnonymousUserResponseCopyWithImpl<$Res>
    implements $PostDeleteAnonymousUserResponseCopyWith<$Res> {
  _$PostDeleteAnonymousUserResponseCopyWithImpl(this._self, this._then);

  final PostDeleteAnonymousUserResponse _self;
  final $Res Function(PostDeleteAnonymousUserResponse) _then;

/// Create a copy of PostDeleteAnonymousUserResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostDeleteAnonymousUserResponse].
extension PostDeleteAnonymousUserResponsePatterns on PostDeleteAnonymousUserResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDeleteAnonymousUserResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDeleteAnonymousUserResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDeleteAnonymousUserResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostDeleteAnonymousUserResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDeleteAnonymousUserResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostDeleteAnonymousUserResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDeleteAnonymousUserResponse() when $default != null:
return $default(_that.success);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success)  $default,) {final _that = this;
switch (_that) {
case _PostDeleteAnonymousUserResponse():
return $default(_that.success);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success)?  $default,) {final _that = this;
switch (_that) {
case _PostDeleteAnonymousUserResponse() when $default != null:
return $default(_that.success);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostDeleteAnonymousUserResponse implements PostDeleteAnonymousUserResponse {
  const _PostDeleteAnonymousUserResponse({required this.success});
  factory _PostDeleteAnonymousUserResponse.fromJson(Map<String, dynamic> json) => _$PostDeleteAnonymousUserResponseFromJson(json);

@override final  bool success;

/// Create a copy of PostDeleteAnonymousUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDeleteAnonymousUserResponseCopyWith<_PostDeleteAnonymousUserResponse> get copyWith => __$PostDeleteAnonymousUserResponseCopyWithImpl<_PostDeleteAnonymousUserResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostDeleteAnonymousUserResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDeleteAnonymousUserResponse&&(identical(other.success, success) || other.success == success));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success);

@override
String toString() {
  return 'PostDeleteAnonymousUserResponse(success: $success)';
}


}

/// @nodoc
abstract mixin class _$PostDeleteAnonymousUserResponseCopyWith<$Res> implements $PostDeleteAnonymousUserResponseCopyWith<$Res> {
  factory _$PostDeleteAnonymousUserResponseCopyWith(_PostDeleteAnonymousUserResponse value, $Res Function(_PostDeleteAnonymousUserResponse) _then) = __$PostDeleteAnonymousUserResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success
});




}
/// @nodoc
class __$PostDeleteAnonymousUserResponseCopyWithImpl<$Res>
    implements _$PostDeleteAnonymousUserResponseCopyWith<$Res> {
  __$PostDeleteAnonymousUserResponseCopyWithImpl(this._self, this._then);

  final _PostDeleteAnonymousUserResponse _self;
  final $Res Function(_PostDeleteAnonymousUserResponse) _then;

/// Create a copy of PostDeleteAnonymousUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,}) {
  return _then(_PostDeleteAnonymousUserResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

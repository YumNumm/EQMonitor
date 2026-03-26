// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_delete_user_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostDeleteUserResponse {

/// Indicates if the operation was successful
 bool get success;/// Status message of the deletion process
 Message2 get message;
/// Create a copy of PostDeleteUserResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDeleteUserResponseCopyWith<PostDeleteUserResponse> get copyWith => _$PostDeleteUserResponseCopyWithImpl<PostDeleteUserResponse>(this as PostDeleteUserResponse, _$identity);

  /// Serializes this PostDeleteUserResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDeleteUserResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'PostDeleteUserResponse(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class $PostDeleteUserResponseCopyWith<$Res>  {
  factory $PostDeleteUserResponseCopyWith(PostDeleteUserResponse value, $Res Function(PostDeleteUserResponse) _then) = _$PostDeleteUserResponseCopyWithImpl;
@useResult
$Res call({
 bool success, Message2 message
});




}
/// @nodoc
class _$PostDeleteUserResponseCopyWithImpl<$Res>
    implements $PostDeleteUserResponseCopyWith<$Res> {
  _$PostDeleteUserResponseCopyWithImpl(this._self, this._then);

  final PostDeleteUserResponse _self;
  final $Res Function(PostDeleteUserResponse) _then;

/// Create a copy of PostDeleteUserResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Message2,
  ));
}

}


/// Adds pattern-matching-related methods to [PostDeleteUserResponse].
extension PostDeleteUserResponsePatterns on PostDeleteUserResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDeleteUserResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDeleteUserResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDeleteUserResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostDeleteUserResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDeleteUserResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostDeleteUserResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  Message2 message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDeleteUserResponse() when $default != null:
return $default(_that.success,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  Message2 message)  $default,) {final _that = this;
switch (_that) {
case _PostDeleteUserResponse():
return $default(_that.success,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  Message2 message)?  $default,) {final _that = this;
switch (_that) {
case _PostDeleteUserResponse() when $default != null:
return $default(_that.success,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostDeleteUserResponse implements PostDeleteUserResponse {
  const _PostDeleteUserResponse({required this.success, required this.message});
  factory _PostDeleteUserResponse.fromJson(Map<String, dynamic> json) => _$PostDeleteUserResponseFromJson(json);

/// Indicates if the operation was successful
@override final  bool success;
/// Status message of the deletion process
@override final  Message2 message;

/// Create a copy of PostDeleteUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDeleteUserResponseCopyWith<_PostDeleteUserResponse> get copyWith => __$PostDeleteUserResponseCopyWithImpl<_PostDeleteUserResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostDeleteUserResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDeleteUserResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'PostDeleteUserResponse(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class _$PostDeleteUserResponseCopyWith<$Res> implements $PostDeleteUserResponseCopyWith<$Res> {
  factory _$PostDeleteUserResponseCopyWith(_PostDeleteUserResponse value, $Res Function(_PostDeleteUserResponse) _then) = __$PostDeleteUserResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, Message2 message
});




}
/// @nodoc
class __$PostDeleteUserResponseCopyWithImpl<$Res>
    implements _$PostDeleteUserResponseCopyWith<$Res> {
  __$PostDeleteUserResponseCopyWithImpl(this._self, this._then);

  final _PostDeleteUserResponse _self;
  final $Res Function(_PostDeleteUserResponse) _then;

/// Create a copy of PostDeleteUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,}) {
  return _then(_PostDeleteUserResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Message2,
  ));
}


}

// dart format on

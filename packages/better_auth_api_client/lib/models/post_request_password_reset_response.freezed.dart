// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_request_password_reset_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostRequestPasswordResetResponse {

 bool get status; String get message;
/// Create a copy of PostRequestPasswordResetResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostRequestPasswordResetResponseCopyWith<PostRequestPasswordResetResponse> get copyWith => _$PostRequestPasswordResetResponseCopyWithImpl<PostRequestPasswordResetResponse>(this as PostRequestPasswordResetResponse, _$identity);

  /// Serializes this PostRequestPasswordResetResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostRequestPasswordResetResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message);

@override
String toString() {
  return 'PostRequestPasswordResetResponse(status: $status, message: $message)';
}


}

/// @nodoc
abstract mixin class $PostRequestPasswordResetResponseCopyWith<$Res>  {
  factory $PostRequestPasswordResetResponseCopyWith(PostRequestPasswordResetResponse value, $Res Function(PostRequestPasswordResetResponse) _then) = _$PostRequestPasswordResetResponseCopyWithImpl;
@useResult
$Res call({
 bool status, String message
});




}
/// @nodoc
class _$PostRequestPasswordResetResponseCopyWithImpl<$Res>
    implements $PostRequestPasswordResetResponseCopyWith<$Res> {
  _$PostRequestPasswordResetResponseCopyWithImpl(this._self, this._then);

  final PostRequestPasswordResetResponse _self;
  final $Res Function(PostRequestPasswordResetResponse) _then;

/// Create a copy of PostRequestPasswordResetResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PostRequestPasswordResetResponse].
extension PostRequestPasswordResetResponsePatterns on PostRequestPasswordResetResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostRequestPasswordResetResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostRequestPasswordResetResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostRequestPasswordResetResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostRequestPasswordResetResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostRequestPasswordResetResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostRequestPasswordResetResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool status,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostRequestPasswordResetResponse() when $default != null:
return $default(_that.status,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool status,  String message)  $default,) {final _that = this;
switch (_that) {
case _PostRequestPasswordResetResponse():
return $default(_that.status,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool status,  String message)?  $default,) {final _that = this;
switch (_that) {
case _PostRequestPasswordResetResponse() when $default != null:
return $default(_that.status,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostRequestPasswordResetResponse implements PostRequestPasswordResetResponse {
  const _PostRequestPasswordResetResponse({required this.status, required this.message});
  factory _PostRequestPasswordResetResponse.fromJson(Map<String, dynamic> json) => _$PostRequestPasswordResetResponseFromJson(json);

@override final  bool status;
@override final  String message;

/// Create a copy of PostRequestPasswordResetResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostRequestPasswordResetResponseCopyWith<_PostRequestPasswordResetResponse> get copyWith => __$PostRequestPasswordResetResponseCopyWithImpl<_PostRequestPasswordResetResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostRequestPasswordResetResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostRequestPasswordResetResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message);

@override
String toString() {
  return 'PostRequestPasswordResetResponse(status: $status, message: $message)';
}


}

/// @nodoc
abstract mixin class _$PostRequestPasswordResetResponseCopyWith<$Res> implements $PostRequestPasswordResetResponseCopyWith<$Res> {
  factory _$PostRequestPasswordResetResponseCopyWith(_PostRequestPasswordResetResponse value, $Res Function(_PostRequestPasswordResetResponse) _then) = __$PostRequestPasswordResetResponseCopyWithImpl;
@override @useResult
$Res call({
 bool status, String message
});




}
/// @nodoc
class __$PostRequestPasswordResetResponseCopyWithImpl<$Res>
    implements _$PostRequestPasswordResetResponseCopyWith<$Res> {
  __$PostRequestPasswordResetResponseCopyWithImpl(this._self, this._then);

  final _PostRequestPasswordResetResponse _self;
  final $Res Function(_PostRequestPasswordResetResponse) _then;

/// Create a copy of PostRequestPasswordResetResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = null,}) {
  return _then(_PostRequestPasswordResetResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

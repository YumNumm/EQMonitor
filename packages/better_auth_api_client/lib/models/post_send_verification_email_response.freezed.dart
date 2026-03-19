// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_send_verification_email_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostSendVerificationEmailResponse {

/// Indicates if the email was sent successfully
 bool get status;
/// Create a copy of PostSendVerificationEmailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostSendVerificationEmailResponseCopyWith<PostSendVerificationEmailResponse> get copyWith => _$PostSendVerificationEmailResponseCopyWithImpl<PostSendVerificationEmailResponse>(this as PostSendVerificationEmailResponse, _$identity);

  /// Serializes this PostSendVerificationEmailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostSendVerificationEmailResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostSendVerificationEmailResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class $PostSendVerificationEmailResponseCopyWith<$Res>  {
  factory $PostSendVerificationEmailResponseCopyWith(PostSendVerificationEmailResponse value, $Res Function(PostSendVerificationEmailResponse) _then) = _$PostSendVerificationEmailResponseCopyWithImpl;
@useResult
$Res call({
 bool status
});




}
/// @nodoc
class _$PostSendVerificationEmailResponseCopyWithImpl<$Res>
    implements $PostSendVerificationEmailResponseCopyWith<$Res> {
  _$PostSendVerificationEmailResponseCopyWithImpl(this._self, this._then);

  final PostSendVerificationEmailResponse _self;
  final $Res Function(PostSendVerificationEmailResponse) _then;

/// Create a copy of PostSendVerificationEmailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostSendVerificationEmailResponse].
extension PostSendVerificationEmailResponsePatterns on PostSendVerificationEmailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostSendVerificationEmailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostSendVerificationEmailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostSendVerificationEmailResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostSendVerificationEmailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostSendVerificationEmailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostSendVerificationEmailResponse() when $default != null:
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
case _PostSendVerificationEmailResponse() when $default != null:
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
case _PostSendVerificationEmailResponse():
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
case _PostSendVerificationEmailResponse() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostSendVerificationEmailResponse implements PostSendVerificationEmailResponse {
  const _PostSendVerificationEmailResponse({required this.status});
  factory _PostSendVerificationEmailResponse.fromJson(Map<String, dynamic> json) => _$PostSendVerificationEmailResponseFromJson(json);

/// Indicates if the email was sent successfully
@override final  bool status;

/// Create a copy of PostSendVerificationEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostSendVerificationEmailResponseCopyWith<_PostSendVerificationEmailResponse> get copyWith => __$PostSendVerificationEmailResponseCopyWithImpl<_PostSendVerificationEmailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostSendVerificationEmailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostSendVerificationEmailResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostSendVerificationEmailResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class _$PostSendVerificationEmailResponseCopyWith<$Res> implements $PostSendVerificationEmailResponseCopyWith<$Res> {
  factory _$PostSendVerificationEmailResponseCopyWith(_PostSendVerificationEmailResponse value, $Res Function(_PostSendVerificationEmailResponse) _then) = __$PostSendVerificationEmailResponseCopyWithImpl;
@override @useResult
$Res call({
 bool status
});




}
/// @nodoc
class __$PostSendVerificationEmailResponseCopyWithImpl<$Res>
    implements _$PostSendVerificationEmailResponseCopyWith<$Res> {
  __$PostSendVerificationEmailResponseCopyWithImpl(this._self, this._then);

  final _PostSendVerificationEmailResponse _self;
  final $Res Function(_PostSendVerificationEmailResponse) _then;

/// Create a copy of PostSendVerificationEmailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_PostSendVerificationEmailResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

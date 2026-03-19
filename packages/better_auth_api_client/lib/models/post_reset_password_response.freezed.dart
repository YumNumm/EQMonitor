// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_reset_password_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostResetPasswordResponse {

 bool get status;
/// Create a copy of PostResetPasswordResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostResetPasswordResponseCopyWith<PostResetPasswordResponse> get copyWith => _$PostResetPasswordResponseCopyWithImpl<PostResetPasswordResponse>(this as PostResetPasswordResponse, _$identity);

  /// Serializes this PostResetPasswordResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostResetPasswordResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostResetPasswordResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class $PostResetPasswordResponseCopyWith<$Res>  {
  factory $PostResetPasswordResponseCopyWith(PostResetPasswordResponse value, $Res Function(PostResetPasswordResponse) _then) = _$PostResetPasswordResponseCopyWithImpl;
@useResult
$Res call({
 bool status
});




}
/// @nodoc
class _$PostResetPasswordResponseCopyWithImpl<$Res>
    implements $PostResetPasswordResponseCopyWith<$Res> {
  _$PostResetPasswordResponseCopyWithImpl(this._self, this._then);

  final PostResetPasswordResponse _self;
  final $Res Function(PostResetPasswordResponse) _then;

/// Create a copy of PostResetPasswordResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostResetPasswordResponse].
extension PostResetPasswordResponsePatterns on PostResetPasswordResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostResetPasswordResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostResetPasswordResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostResetPasswordResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostResetPasswordResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostResetPasswordResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostResetPasswordResponse() when $default != null:
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
case _PostResetPasswordResponse() when $default != null:
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
case _PostResetPasswordResponse():
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
case _PostResetPasswordResponse() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostResetPasswordResponse implements PostResetPasswordResponse {
  const _PostResetPasswordResponse({required this.status});
  factory _PostResetPasswordResponse.fromJson(Map<String, dynamic> json) => _$PostResetPasswordResponseFromJson(json);

@override final  bool status;

/// Create a copy of PostResetPasswordResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostResetPasswordResponseCopyWith<_PostResetPasswordResponse> get copyWith => __$PostResetPasswordResponseCopyWithImpl<_PostResetPasswordResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostResetPasswordResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostResetPasswordResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostResetPasswordResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class _$PostResetPasswordResponseCopyWith<$Res> implements $PostResetPasswordResponseCopyWith<$Res> {
  factory _$PostResetPasswordResponseCopyWith(_PostResetPasswordResponse value, $Res Function(_PostResetPasswordResponse) _then) = __$PostResetPasswordResponseCopyWithImpl;
@override @useResult
$Res call({
 bool status
});




}
/// @nodoc
class __$PostResetPasswordResponseCopyWithImpl<$Res>
    implements _$PostResetPasswordResponseCopyWith<$Res> {
  __$PostResetPasswordResponseCopyWithImpl(this._self, this._then);

  final _PostResetPasswordResponse _self;
  final $Res Function(_PostResetPasswordResponse) _then;

/// Create a copy of PostResetPasswordResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_PostResetPasswordResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

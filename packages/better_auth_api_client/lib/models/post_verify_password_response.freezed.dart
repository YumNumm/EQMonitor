// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_verify_password_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostVerifyPasswordResponse {

 bool get status;
/// Create a copy of PostVerifyPasswordResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostVerifyPasswordResponseCopyWith<PostVerifyPasswordResponse> get copyWith => _$PostVerifyPasswordResponseCopyWithImpl<PostVerifyPasswordResponse>(this as PostVerifyPasswordResponse, _$identity);

  /// Serializes this PostVerifyPasswordResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostVerifyPasswordResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostVerifyPasswordResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class $PostVerifyPasswordResponseCopyWith<$Res>  {
  factory $PostVerifyPasswordResponseCopyWith(PostVerifyPasswordResponse value, $Res Function(PostVerifyPasswordResponse) _then) = _$PostVerifyPasswordResponseCopyWithImpl;
@useResult
$Res call({
 bool status
});




}
/// @nodoc
class _$PostVerifyPasswordResponseCopyWithImpl<$Res>
    implements $PostVerifyPasswordResponseCopyWith<$Res> {
  _$PostVerifyPasswordResponseCopyWithImpl(this._self, this._then);

  final PostVerifyPasswordResponse _self;
  final $Res Function(PostVerifyPasswordResponse) _then;

/// Create a copy of PostVerifyPasswordResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostVerifyPasswordResponse].
extension PostVerifyPasswordResponsePatterns on PostVerifyPasswordResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostVerifyPasswordResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostVerifyPasswordResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostVerifyPasswordResponse value)  $default,){
final _that = this;
switch (_that) {
case _PostVerifyPasswordResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostVerifyPasswordResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PostVerifyPasswordResponse() when $default != null:
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
case _PostVerifyPasswordResponse() when $default != null:
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
case _PostVerifyPasswordResponse():
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
case _PostVerifyPasswordResponse() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostVerifyPasswordResponse implements PostVerifyPasswordResponse {
  const _PostVerifyPasswordResponse({required this.status});
  factory _PostVerifyPasswordResponse.fromJson(Map<String, dynamic> json) => _$PostVerifyPasswordResponseFromJson(json);

@override final  bool status;

/// Create a copy of PostVerifyPasswordResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostVerifyPasswordResponseCopyWith<_PostVerifyPasswordResponse> get copyWith => __$PostVerifyPasswordResponseCopyWithImpl<_PostVerifyPasswordResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostVerifyPasswordResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostVerifyPasswordResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PostVerifyPasswordResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class _$PostVerifyPasswordResponseCopyWith<$Res> implements $PostVerifyPasswordResponseCopyWith<$Res> {
  factory _$PostVerifyPasswordResponseCopyWith(_PostVerifyPasswordResponse value, $Res Function(_PostVerifyPasswordResponse) _then) = __$PostVerifyPasswordResponseCopyWithImpl;
@override @useResult
$Res call({
 bool status
});




}
/// @nodoc
class __$PostVerifyPasswordResponseCopyWithImpl<$Res>
    implements _$PostVerifyPasswordResponseCopyWith<$Res> {
  __$PostVerifyPasswordResponseCopyWithImpl(this._self, this._then);

  final _PostVerifyPasswordResponse _self;
  final $Res Function(_PostVerifyPasswordResponse) _then;

/// Create a copy of PostVerifyPasswordResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_PostVerifyPasswordResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

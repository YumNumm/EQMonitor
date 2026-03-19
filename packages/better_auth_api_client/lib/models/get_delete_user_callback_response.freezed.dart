// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_delete_user_callback_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetDeleteUserCallbackResponse {

/// Indicates if the deletion was successful
 bool get success;/// Confirmation message
 Message3 get message;
/// Create a copy of GetDeleteUserCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetDeleteUserCallbackResponseCopyWith<GetDeleteUserCallbackResponse> get copyWith => _$GetDeleteUserCallbackResponseCopyWithImpl<GetDeleteUserCallbackResponse>(this as GetDeleteUserCallbackResponse, _$identity);

  /// Serializes this GetDeleteUserCallbackResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetDeleteUserCallbackResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'GetDeleteUserCallbackResponse(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class $GetDeleteUserCallbackResponseCopyWith<$Res>  {
  factory $GetDeleteUserCallbackResponseCopyWith(GetDeleteUserCallbackResponse value, $Res Function(GetDeleteUserCallbackResponse) _then) = _$GetDeleteUserCallbackResponseCopyWithImpl;
@useResult
$Res call({
 bool success, Message3 message
});




}
/// @nodoc
class _$GetDeleteUserCallbackResponseCopyWithImpl<$Res>
    implements $GetDeleteUserCallbackResponseCopyWith<$Res> {
  _$GetDeleteUserCallbackResponseCopyWithImpl(this._self, this._then);

  final GetDeleteUserCallbackResponse _self;
  final $Res Function(GetDeleteUserCallbackResponse) _then;

/// Create a copy of GetDeleteUserCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Message3,
  ));
}

}


/// Adds pattern-matching-related methods to [GetDeleteUserCallbackResponse].
extension GetDeleteUserCallbackResponsePatterns on GetDeleteUserCallbackResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetDeleteUserCallbackResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetDeleteUserCallbackResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetDeleteUserCallbackResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetDeleteUserCallbackResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetDeleteUserCallbackResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetDeleteUserCallbackResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  Message3 message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetDeleteUserCallbackResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  Message3 message)  $default,) {final _that = this;
switch (_that) {
case _GetDeleteUserCallbackResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  Message3 message)?  $default,) {final _that = this;
switch (_that) {
case _GetDeleteUserCallbackResponse() when $default != null:
return $default(_that.success,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetDeleteUserCallbackResponse implements GetDeleteUserCallbackResponse {
  const _GetDeleteUserCallbackResponse({required this.success, required this.message});
  factory _GetDeleteUserCallbackResponse.fromJson(Map<String, dynamic> json) => _$GetDeleteUserCallbackResponseFromJson(json);

/// Indicates if the deletion was successful
@override final  bool success;
/// Confirmation message
@override final  Message3 message;

/// Create a copy of GetDeleteUserCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetDeleteUserCallbackResponseCopyWith<_GetDeleteUserCallbackResponse> get copyWith => __$GetDeleteUserCallbackResponseCopyWithImpl<_GetDeleteUserCallbackResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetDeleteUserCallbackResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetDeleteUserCallbackResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'GetDeleteUserCallbackResponse(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class _$GetDeleteUserCallbackResponseCopyWith<$Res> implements $GetDeleteUserCallbackResponseCopyWith<$Res> {
  factory _$GetDeleteUserCallbackResponseCopyWith(_GetDeleteUserCallbackResponse value, $Res Function(_GetDeleteUserCallbackResponse) _then) = __$GetDeleteUserCallbackResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, Message3 message
});




}
/// @nodoc
class __$GetDeleteUserCallbackResponseCopyWithImpl<$Res>
    implements _$GetDeleteUserCallbackResponseCopyWith<$Res> {
  __$GetDeleteUserCallbackResponseCopyWithImpl(this._self, this._then);

  final _GetDeleteUserCallbackResponse _self;
  final $Res Function(_GetDeleteUserCallbackResponse) _then;

/// Create a copy of GetDeleteUserCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,}) {
  return _then(_GetDeleteUserCallbackResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Message3,
  ));
}


}

// dart format on

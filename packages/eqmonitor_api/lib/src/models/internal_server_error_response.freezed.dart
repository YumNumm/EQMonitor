// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internal_server_error_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InternalServerErrorResponse {

/// const: "INTERNAL_SERVER_ERROR"
 String get code;/// const: "Internal Server Error"
 String get message;@JsonKey(includeIfNull: false) String? get reason;
/// Create a copy of InternalServerErrorResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InternalServerErrorResponseCopyWith<InternalServerErrorResponse> get copyWith => _$InternalServerErrorResponseCopyWithImpl<InternalServerErrorResponse>(this as InternalServerErrorResponse, _$identity);

  /// Serializes this InternalServerErrorResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InternalServerErrorResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,reason);

@override
String toString() {
  return 'InternalServerErrorResponse(code: $code, message: $message, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $InternalServerErrorResponseCopyWith<$Res>  {
  factory $InternalServerErrorResponseCopyWith(InternalServerErrorResponse value, $Res Function(InternalServerErrorResponse) _then) = _$InternalServerErrorResponseCopyWithImpl;
@useResult
$Res call({
 String code, String message,@JsonKey(includeIfNull: false) String? reason
});




}
/// @nodoc
class _$InternalServerErrorResponseCopyWithImpl<$Res>
    implements $InternalServerErrorResponseCopyWith<$Res> {
  _$InternalServerErrorResponseCopyWithImpl(this._self, this._then);

  final InternalServerErrorResponse _self;
  final $Res Function(InternalServerErrorResponse) _then;

/// Create a copy of InternalServerErrorResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? reason = freezed,}) {
  return _then(InternalServerErrorResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InternalServerErrorResponse].
extension InternalServerErrorResponsePatterns on InternalServerErrorResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InternalServerErrorResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InternalServerErrorResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InternalServerErrorResponse value)  $default,){
final _that = this;
switch (_that) {
case _InternalServerErrorResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InternalServerErrorResponse value)?  $default,){
final _that = this;
switch (_that) {
case _InternalServerErrorResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message, @JsonKey(includeIfNull: false)  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InternalServerErrorResponse() when $default != null:
return $default(_that.code,_that.message,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message, @JsonKey(includeIfNull: false)  String? reason)  $default,) {final _that = this;
switch (_that) {
case _InternalServerErrorResponse():
return $default(_that.code,_that.message,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message, @JsonKey(includeIfNull: false)  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _InternalServerErrorResponse() when $default != null:
return $default(_that.code,_that.message,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InternalServerErrorResponse implements InternalServerErrorResponse {
  const _InternalServerErrorResponse({required this.code, required this.message, @JsonKey(includeIfNull: false) this.reason});
  factory _InternalServerErrorResponse.fromJson(Map<String, dynamic> json) => _$InternalServerErrorResponseFromJson(json);

/// const: "INTERNAL_SERVER_ERROR"
@override final  String code;
/// const: "Internal Server Error"
@override final  String message;
@override@JsonKey(includeIfNull: false) final  String? reason;

/// Create a copy of InternalServerErrorResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InternalServerErrorResponseCopyWith<_InternalServerErrorResponse> get copyWith => __$InternalServerErrorResponseCopyWithImpl<_InternalServerErrorResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InternalServerErrorResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InternalServerErrorResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,reason);

@override
String toString() {
  return 'InternalServerErrorResponse(code: $code, message: $message, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$InternalServerErrorResponseCopyWith<$Res> implements $InternalServerErrorResponseCopyWith<$Res> {
  factory _$InternalServerErrorResponseCopyWith(_InternalServerErrorResponse value, $Res Function(_InternalServerErrorResponse) _then) = __$InternalServerErrorResponseCopyWithImpl;
@override @useResult
$Res call({
 String code, String message,@JsonKey(includeIfNull: false) String? reason
});




}
/// @nodoc
class __$InternalServerErrorResponseCopyWithImpl<$Res>
    implements _$InternalServerErrorResponseCopyWith<$Res> {
  __$InternalServerErrorResponseCopyWithImpl(this._self, this._then);

  final _InternalServerErrorResponse _self;
  final $Res Function(_InternalServerErrorResponse) _then;

/// Create a copy of InternalServerErrorResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? reason = freezed,}) {
  return _then(_InternalServerErrorResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

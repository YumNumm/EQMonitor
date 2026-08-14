// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_service_unavailable_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShakeDetectionServiceUnavailableResponse {

/// const: "SERVICE_UNAVAILABLE"
 String get code; String get message;
/// Create a copy of ShakeDetectionServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionServiceUnavailableResponseCopyWith<ShakeDetectionServiceUnavailableResponse> get copyWith => _$ShakeDetectionServiceUnavailableResponseCopyWithImpl<ShakeDetectionServiceUnavailableResponse>(this as ShakeDetectionServiceUnavailableResponse, _$identity);

  /// Serializes this ShakeDetectionServiceUnavailableResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionServiceUnavailableResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ShakeDetectionServiceUnavailableResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionServiceUnavailableResponseCopyWith<$Res>  {
  factory $ShakeDetectionServiceUnavailableResponseCopyWith(ShakeDetectionServiceUnavailableResponse value, $Res Function(ShakeDetectionServiceUnavailableResponse) _then) = _$ShakeDetectionServiceUnavailableResponseCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$ShakeDetectionServiceUnavailableResponseCopyWithImpl<$Res>
    implements $ShakeDetectionServiceUnavailableResponseCopyWith<$Res> {
  _$ShakeDetectionServiceUnavailableResponseCopyWithImpl(this._self, this._then);

  final ShakeDetectionServiceUnavailableResponse _self;
  final $Res Function(ShakeDetectionServiceUnavailableResponse) _then;

/// Create a copy of ShakeDetectionServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(ShakeDetectionServiceUnavailableResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ShakeDetectionServiceUnavailableResponse].
extension ShakeDetectionServiceUnavailableResponsePatterns on ShakeDetectionServiceUnavailableResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionServiceUnavailableResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionServiceUnavailableResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionServiceUnavailableResponse value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionServiceUnavailableResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionServiceUnavailableResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionServiceUnavailableResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionServiceUnavailableResponse() when $default != null:
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionServiceUnavailableResponse():
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionServiceUnavailableResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShakeDetectionServiceUnavailableResponse implements ShakeDetectionServiceUnavailableResponse {
  const _ShakeDetectionServiceUnavailableResponse({required this.code, required this.message});
  factory _ShakeDetectionServiceUnavailableResponse.fromJson(Map<String, dynamic> json) => _$ShakeDetectionServiceUnavailableResponseFromJson(json);

/// const: "SERVICE_UNAVAILABLE"
@override final  String code;
@override final  String message;

/// Create a copy of ShakeDetectionServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionServiceUnavailableResponseCopyWith<_ShakeDetectionServiceUnavailableResponse> get copyWith => __$ShakeDetectionServiceUnavailableResponseCopyWithImpl<_ShakeDetectionServiceUnavailableResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionServiceUnavailableResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionServiceUnavailableResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ShakeDetectionServiceUnavailableResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionServiceUnavailableResponseCopyWith<$Res> implements $ShakeDetectionServiceUnavailableResponseCopyWith<$Res> {
  factory _$ShakeDetectionServiceUnavailableResponseCopyWith(_ShakeDetectionServiceUnavailableResponse value, $Res Function(_ShakeDetectionServiceUnavailableResponse) _then) = __$ShakeDetectionServiceUnavailableResponseCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$ShakeDetectionServiceUnavailableResponseCopyWithImpl<$Res>
    implements _$ShakeDetectionServiceUnavailableResponseCopyWith<$Res> {
  __$ShakeDetectionServiceUnavailableResponseCopyWithImpl(this._self, this._then);

  final _ShakeDetectionServiceUnavailableResponse _self;
  final $Res Function(_ShakeDetectionServiceUnavailableResponse) _then;

/// Create a copy of ShakeDetectionServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_ShakeDetectionServiceUnavailableResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

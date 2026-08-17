// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parameter_service_unavailable_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParameterServiceUnavailableResponse {

/// const: "SERVICE_UNAVAILABLE"
 String get code; String get message;
/// Create a copy of ParameterServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParameterServiceUnavailableResponseCopyWith<ParameterServiceUnavailableResponse> get copyWith => _$ParameterServiceUnavailableResponseCopyWithImpl<ParameterServiceUnavailableResponse>(this as ParameterServiceUnavailableResponse, _$identity);

  /// Serializes this ParameterServiceUnavailableResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterServiceUnavailableResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ParameterServiceUnavailableResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ParameterServiceUnavailableResponseCopyWith<$Res>  {
  factory $ParameterServiceUnavailableResponseCopyWith(ParameterServiceUnavailableResponse value, $Res Function(ParameterServiceUnavailableResponse) _then) = _$ParameterServiceUnavailableResponseCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$ParameterServiceUnavailableResponseCopyWithImpl<$Res>
    implements $ParameterServiceUnavailableResponseCopyWith<$Res> {
  _$ParameterServiceUnavailableResponseCopyWithImpl(this._self, this._then);

  final ParameterServiceUnavailableResponse _self;
  final $Res Function(ParameterServiceUnavailableResponse) _then;

/// Create a copy of ParameterServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(ParameterServiceUnavailableResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ParameterServiceUnavailableResponse].
extension ParameterServiceUnavailableResponsePatterns on ParameterServiceUnavailableResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParameterServiceUnavailableResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParameterServiceUnavailableResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParameterServiceUnavailableResponse value)  $default,){
final _that = this;
switch (_that) {
case _ParameterServiceUnavailableResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParameterServiceUnavailableResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ParameterServiceUnavailableResponse() when $default != null:
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
case _ParameterServiceUnavailableResponse() when $default != null:
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
case _ParameterServiceUnavailableResponse():
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
case _ParameterServiceUnavailableResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParameterServiceUnavailableResponse implements ParameterServiceUnavailableResponse {
  const _ParameterServiceUnavailableResponse({required this.code, required this.message});
  factory _ParameterServiceUnavailableResponse.fromJson(Map<String, dynamic> json) => _$ParameterServiceUnavailableResponseFromJson(json);

/// const: "SERVICE_UNAVAILABLE"
@override final  String code;
@override final  String message;

/// Create a copy of ParameterServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParameterServiceUnavailableResponseCopyWith<_ParameterServiceUnavailableResponse> get copyWith => __$ParameterServiceUnavailableResponseCopyWithImpl<_ParameterServiceUnavailableResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParameterServiceUnavailableResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParameterServiceUnavailableResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ParameterServiceUnavailableResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ParameterServiceUnavailableResponseCopyWith<$Res> implements $ParameterServiceUnavailableResponseCopyWith<$Res> {
  factory _$ParameterServiceUnavailableResponseCopyWith(_ParameterServiceUnavailableResponse value, $Res Function(_ParameterServiceUnavailableResponse) _then) = __$ParameterServiceUnavailableResponseCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$ParameterServiceUnavailableResponseCopyWithImpl<$Res>
    implements _$ParameterServiceUnavailableResponseCopyWith<$Res> {
  __$ParameterServiceUnavailableResponseCopyWithImpl(this._self, this._then);

  final _ParameterServiceUnavailableResponse _self;
  final $Res Function(_ParameterServiceUnavailableResponse) _then;

/// Create a copy of ParameterServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_ParameterServiceUnavailableResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

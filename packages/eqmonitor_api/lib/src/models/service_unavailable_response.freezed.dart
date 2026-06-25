// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_unavailable_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceUnavailableResponse {

 String get code; String get message;
/// Create a copy of ServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceUnavailableResponseCopyWith<ServiceUnavailableResponse> get copyWith => _$ServiceUnavailableResponseCopyWithImpl<ServiceUnavailableResponse>(this as ServiceUnavailableResponse, _$identity);

  /// Serializes this ServiceUnavailableResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceUnavailableResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ServiceUnavailableResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ServiceUnavailableResponseCopyWith<$Res>  {
  factory $ServiceUnavailableResponseCopyWith(ServiceUnavailableResponse value, $Res Function(ServiceUnavailableResponse) _then) = _$ServiceUnavailableResponseCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$ServiceUnavailableResponseCopyWithImpl<$Res>
    implements $ServiceUnavailableResponseCopyWith<$Res> {
  _$ServiceUnavailableResponseCopyWithImpl(this._self, this._then);

  final ServiceUnavailableResponse _self;
  final $Res Function(ServiceUnavailableResponse) _then;

/// Create a copy of ServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceUnavailableResponse].
extension ServiceUnavailableResponsePatterns on ServiceUnavailableResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceUnavailableResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceUnavailableResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceUnavailableResponse value)  $default,){
final _that = this;
switch (_that) {
case _ServiceUnavailableResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceUnavailableResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceUnavailableResponse() when $default != null:
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
case _ServiceUnavailableResponse() when $default != null:
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
case _ServiceUnavailableResponse():
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
case _ServiceUnavailableResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceUnavailableResponse implements ServiceUnavailableResponse {
  const _ServiceUnavailableResponse({required this.code, required this.message});
  factory _ServiceUnavailableResponse.fromJson(Map<String, dynamic> json) => _$ServiceUnavailableResponseFromJson(json);

@override final  String code;
@override final  String message;

/// Create a copy of ServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceUnavailableResponseCopyWith<_ServiceUnavailableResponse> get copyWith => __$ServiceUnavailableResponseCopyWithImpl<_ServiceUnavailableResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceUnavailableResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceUnavailableResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ServiceUnavailableResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ServiceUnavailableResponseCopyWith<$Res> implements $ServiceUnavailableResponseCopyWith<$Res> {
  factory _$ServiceUnavailableResponseCopyWith(_ServiceUnavailableResponse value, $Res Function(_ServiceUnavailableResponse) _then) = __$ServiceUnavailableResponseCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$ServiceUnavailableResponseCopyWithImpl<$Res>
    implements _$ServiceUnavailableResponseCopyWith<$Res> {
  __$ServiceUnavailableResponseCopyWithImpl(this._self, this._then);

  final _ServiceUnavailableResponse _self;
  final $Res Function(_ServiceUnavailableResponse) _then;

/// Create a copy of ServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_ServiceUnavailableResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

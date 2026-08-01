// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_service_unavailable_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HypocenterServiceUnavailableResponse {

/// const: "SERVICE_UNAVAILABLE"
 String get code; String get message;
/// Create a copy of HypocenterServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterServiceUnavailableResponseCopyWith<HypocenterServiceUnavailableResponse> get copyWith => _$HypocenterServiceUnavailableResponseCopyWithImpl<HypocenterServiceUnavailableResponse>(this as HypocenterServiceUnavailableResponse, _$identity);

  /// Serializes this HypocenterServiceUnavailableResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterServiceUnavailableResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'HypocenterServiceUnavailableResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $HypocenterServiceUnavailableResponseCopyWith<$Res>  {
  factory $HypocenterServiceUnavailableResponseCopyWith(HypocenterServiceUnavailableResponse value, $Res Function(HypocenterServiceUnavailableResponse) _then) = _$HypocenterServiceUnavailableResponseCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$HypocenterServiceUnavailableResponseCopyWithImpl<$Res>
    implements $HypocenterServiceUnavailableResponseCopyWith<$Res> {
  _$HypocenterServiceUnavailableResponseCopyWithImpl(this._self, this._then);

  final HypocenterServiceUnavailableResponse _self;
  final $Res Function(HypocenterServiceUnavailableResponse) _then;

/// Create a copy of HypocenterServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HypocenterServiceUnavailableResponse].
extension HypocenterServiceUnavailableResponsePatterns on HypocenterServiceUnavailableResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterServiceUnavailableResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterServiceUnavailableResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterServiceUnavailableResponse value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterServiceUnavailableResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterServiceUnavailableResponse value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterServiceUnavailableResponse() when $default != null:
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
case _HypocenterServiceUnavailableResponse() when $default != null:
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
case _HypocenterServiceUnavailableResponse():
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
case _HypocenterServiceUnavailableResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HypocenterServiceUnavailableResponse implements HypocenterServiceUnavailableResponse {
  const _HypocenterServiceUnavailableResponse({required this.code, required this.message});
  factory _HypocenterServiceUnavailableResponse.fromJson(Map<String, dynamic> json) => _$HypocenterServiceUnavailableResponseFromJson(json);

/// const: "SERVICE_UNAVAILABLE"
@override final  String code;
@override final  String message;

/// Create a copy of HypocenterServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterServiceUnavailableResponseCopyWith<_HypocenterServiceUnavailableResponse> get copyWith => __$HypocenterServiceUnavailableResponseCopyWithImpl<_HypocenterServiceUnavailableResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HypocenterServiceUnavailableResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterServiceUnavailableResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'HypocenterServiceUnavailableResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$HypocenterServiceUnavailableResponseCopyWith<$Res> implements $HypocenterServiceUnavailableResponseCopyWith<$Res> {
  factory _$HypocenterServiceUnavailableResponseCopyWith(_HypocenterServiceUnavailableResponse value, $Res Function(_HypocenterServiceUnavailableResponse) _then) = __$HypocenterServiceUnavailableResponseCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$HypocenterServiceUnavailableResponseCopyWithImpl<$Res>
    implements _$HypocenterServiceUnavailableResponseCopyWith<$Res> {
  __$HypocenterServiceUnavailableResponseCopyWithImpl(this._self, this._then);

  final _HypocenterServiceUnavailableResponse _self;
  final $Res Function(_HypocenterServiceUnavailableResponse) _then;

/// Create a copy of HypocenterServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_HypocenterServiceUnavailableResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

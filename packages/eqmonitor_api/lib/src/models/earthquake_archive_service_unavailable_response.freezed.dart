// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_archive_service_unavailable_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeArchiveServiceUnavailableResponse {

/// const: "SERVICE_UNAVAILABLE"
 String get code; String get message;
/// Create a copy of EarthquakeArchiveServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeArchiveServiceUnavailableResponseCopyWith<EarthquakeArchiveServiceUnavailableResponse> get copyWith => _$EarthquakeArchiveServiceUnavailableResponseCopyWithImpl<EarthquakeArchiveServiceUnavailableResponse>(this as EarthquakeArchiveServiceUnavailableResponse, _$identity);

  /// Serializes this EarthquakeArchiveServiceUnavailableResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeArchiveServiceUnavailableResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'EarthquakeArchiveServiceUnavailableResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $EarthquakeArchiveServiceUnavailableResponseCopyWith<$Res>  {
  factory $EarthquakeArchiveServiceUnavailableResponseCopyWith(EarthquakeArchiveServiceUnavailableResponse value, $Res Function(EarthquakeArchiveServiceUnavailableResponse) _then) = _$EarthquakeArchiveServiceUnavailableResponseCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$EarthquakeArchiveServiceUnavailableResponseCopyWithImpl<$Res>
    implements $EarthquakeArchiveServiceUnavailableResponseCopyWith<$Res> {
  _$EarthquakeArchiveServiceUnavailableResponseCopyWithImpl(this._self, this._then);

  final EarthquakeArchiveServiceUnavailableResponse _self;
  final $Res Function(EarthquakeArchiveServiceUnavailableResponse) _then;

/// Create a copy of EarthquakeArchiveServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(EarthquakeArchiveServiceUnavailableResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeArchiveServiceUnavailableResponse].
extension EarthquakeArchiveServiceUnavailableResponsePatterns on EarthquakeArchiveServiceUnavailableResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeArchiveServiceUnavailableResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeArchiveServiceUnavailableResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeArchiveServiceUnavailableResponse value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeArchiveServiceUnavailableResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeArchiveServiceUnavailableResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeArchiveServiceUnavailableResponse() when $default != null:
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
case _EarthquakeArchiveServiceUnavailableResponse() when $default != null:
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
case _EarthquakeArchiveServiceUnavailableResponse():
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
case _EarthquakeArchiveServiceUnavailableResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeArchiveServiceUnavailableResponse implements EarthquakeArchiveServiceUnavailableResponse {
  const _EarthquakeArchiveServiceUnavailableResponse({required this.code, required this.message});
  factory _EarthquakeArchiveServiceUnavailableResponse.fromJson(Map<String, dynamic> json) => _$EarthquakeArchiveServiceUnavailableResponseFromJson(json);

/// const: "SERVICE_UNAVAILABLE"
@override final  String code;
@override final  String message;

/// Create a copy of EarthquakeArchiveServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeArchiveServiceUnavailableResponseCopyWith<_EarthquakeArchiveServiceUnavailableResponse> get copyWith => __$EarthquakeArchiveServiceUnavailableResponseCopyWithImpl<_EarthquakeArchiveServiceUnavailableResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeArchiveServiceUnavailableResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeArchiveServiceUnavailableResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'EarthquakeArchiveServiceUnavailableResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeArchiveServiceUnavailableResponseCopyWith<$Res> implements $EarthquakeArchiveServiceUnavailableResponseCopyWith<$Res> {
  factory _$EarthquakeArchiveServiceUnavailableResponseCopyWith(_EarthquakeArchiveServiceUnavailableResponse value, $Res Function(_EarthquakeArchiveServiceUnavailableResponse) _then) = __$EarthquakeArchiveServiceUnavailableResponseCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$EarthquakeArchiveServiceUnavailableResponseCopyWithImpl<$Res>
    implements _$EarthquakeArchiveServiceUnavailableResponseCopyWith<$Res> {
  __$EarthquakeArchiveServiceUnavailableResponseCopyWithImpl(this._self, this._then);

  final _EarthquakeArchiveServiceUnavailableResponse _self;
  final $Res Function(_EarthquakeArchiveServiceUnavailableResponse) _then;

/// Create a copy of EarthquakeArchiveServiceUnavailableResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_EarthquakeArchiveServiceUnavailableResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

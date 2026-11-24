// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_archive_forbidden_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeArchiveForbiddenResponse {

/// const: "FORBIDDEN"
 String get code; String get message;
/// Create a copy of EarthquakeArchiveForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeArchiveForbiddenResponseCopyWith<EarthquakeArchiveForbiddenResponse> get copyWith => _$EarthquakeArchiveForbiddenResponseCopyWithImpl<EarthquakeArchiveForbiddenResponse>(this as EarthquakeArchiveForbiddenResponse, _$identity);

  /// Serializes this EarthquakeArchiveForbiddenResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeArchiveForbiddenResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'EarthquakeArchiveForbiddenResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $EarthquakeArchiveForbiddenResponseCopyWith<$Res>  {
  factory $EarthquakeArchiveForbiddenResponseCopyWith(EarthquakeArchiveForbiddenResponse value, $Res Function(EarthquakeArchiveForbiddenResponse) _then) = _$EarthquakeArchiveForbiddenResponseCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$EarthquakeArchiveForbiddenResponseCopyWithImpl<$Res>
    implements $EarthquakeArchiveForbiddenResponseCopyWith<$Res> {
  _$EarthquakeArchiveForbiddenResponseCopyWithImpl(this._self, this._then);

  final EarthquakeArchiveForbiddenResponse _self;
  final $Res Function(EarthquakeArchiveForbiddenResponse) _then;

/// Create a copy of EarthquakeArchiveForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(EarthquakeArchiveForbiddenResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeArchiveForbiddenResponse].
extension EarthquakeArchiveForbiddenResponsePatterns on EarthquakeArchiveForbiddenResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeArchiveForbiddenResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeArchiveForbiddenResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeArchiveForbiddenResponse value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeArchiveForbiddenResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeArchiveForbiddenResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeArchiveForbiddenResponse() when $default != null:
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
case _EarthquakeArchiveForbiddenResponse() when $default != null:
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
case _EarthquakeArchiveForbiddenResponse():
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
case _EarthquakeArchiveForbiddenResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeArchiveForbiddenResponse implements EarthquakeArchiveForbiddenResponse {
  const _EarthquakeArchiveForbiddenResponse({required this.code, required this.message});
  factory _EarthquakeArchiveForbiddenResponse.fromJson(Map<String, dynamic> json) => _$EarthquakeArchiveForbiddenResponseFromJson(json);

/// const: "FORBIDDEN"
@override final  String code;
@override final  String message;

/// Create a copy of EarthquakeArchiveForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeArchiveForbiddenResponseCopyWith<_EarthquakeArchiveForbiddenResponse> get copyWith => __$EarthquakeArchiveForbiddenResponseCopyWithImpl<_EarthquakeArchiveForbiddenResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeArchiveForbiddenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeArchiveForbiddenResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'EarthquakeArchiveForbiddenResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeArchiveForbiddenResponseCopyWith<$Res> implements $EarthquakeArchiveForbiddenResponseCopyWith<$Res> {
  factory _$EarthquakeArchiveForbiddenResponseCopyWith(_EarthquakeArchiveForbiddenResponse value, $Res Function(_EarthquakeArchiveForbiddenResponse) _then) = __$EarthquakeArchiveForbiddenResponseCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$EarthquakeArchiveForbiddenResponseCopyWithImpl<$Res>
    implements _$EarthquakeArchiveForbiddenResponseCopyWith<$Res> {
  __$EarthquakeArchiveForbiddenResponseCopyWithImpl(this._self, this._then);

  final _EarthquakeArchiveForbiddenResponse _self;
  final $Res Function(_EarthquakeArchiveForbiddenResponse) _then;

/// Create a copy of EarthquakeArchiveForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_EarthquakeArchiveForbiddenResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

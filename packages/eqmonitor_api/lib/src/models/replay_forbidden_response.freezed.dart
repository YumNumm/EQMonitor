// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_forbidden_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReplayForbiddenResponse {

/// const: "FORBIDDEN"
 String get code; String get message;
/// Create a copy of ReplayForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayForbiddenResponseCopyWith<ReplayForbiddenResponse> get copyWith => _$ReplayForbiddenResponseCopyWithImpl<ReplayForbiddenResponse>(this as ReplayForbiddenResponse, _$identity);

  /// Serializes this ReplayForbiddenResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayForbiddenResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ReplayForbiddenResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ReplayForbiddenResponseCopyWith<$Res>  {
  factory $ReplayForbiddenResponseCopyWith(ReplayForbiddenResponse value, $Res Function(ReplayForbiddenResponse) _then) = _$ReplayForbiddenResponseCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$ReplayForbiddenResponseCopyWithImpl<$Res>
    implements $ReplayForbiddenResponseCopyWith<$Res> {
  _$ReplayForbiddenResponseCopyWithImpl(this._self, this._then);

  final ReplayForbiddenResponse _self;
  final $Res Function(ReplayForbiddenResponse) _then;

/// Create a copy of ReplayForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(ReplayForbiddenResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplayForbiddenResponse].
extension ReplayForbiddenResponsePatterns on ReplayForbiddenResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayForbiddenResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayForbiddenResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayForbiddenResponse value)  $default,){
final _that = this;
switch (_that) {
case _ReplayForbiddenResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayForbiddenResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayForbiddenResponse() when $default != null:
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
case _ReplayForbiddenResponse() when $default != null:
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
case _ReplayForbiddenResponse():
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
case _ReplayForbiddenResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplayForbiddenResponse implements ReplayForbiddenResponse {
  const _ReplayForbiddenResponse({required this.code, required this.message});
  factory _ReplayForbiddenResponse.fromJson(Map<String, dynamic> json) => _$ReplayForbiddenResponseFromJson(json);

/// const: "FORBIDDEN"
@override final  String code;
@override final  String message;

/// Create a copy of ReplayForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayForbiddenResponseCopyWith<_ReplayForbiddenResponse> get copyWith => __$ReplayForbiddenResponseCopyWithImpl<_ReplayForbiddenResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplayForbiddenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayForbiddenResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ReplayForbiddenResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ReplayForbiddenResponseCopyWith<$Res> implements $ReplayForbiddenResponseCopyWith<$Res> {
  factory _$ReplayForbiddenResponseCopyWith(_ReplayForbiddenResponse value, $Res Function(_ReplayForbiddenResponse) _then) = __$ReplayForbiddenResponseCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$ReplayForbiddenResponseCopyWithImpl<$Res>
    implements _$ReplayForbiddenResponseCopyWith<$Res> {
  __$ReplayForbiddenResponseCopyWithImpl(this._self, this._then);

  final _ReplayForbiddenResponse _self;
  final $Res Function(_ReplayForbiddenResponse) _then;

/// Create a copy of ReplayForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_ReplayForbiddenResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

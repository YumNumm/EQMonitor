// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forbidden_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ForbiddenResponse {

 String get code; String get message;
/// Create a copy of ForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForbiddenResponseCopyWith<ForbiddenResponse> get copyWith => _$ForbiddenResponseCopyWithImpl<ForbiddenResponse>(this as ForbiddenResponse, _$identity);

  /// Serializes this ForbiddenResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForbiddenResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ForbiddenResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ForbiddenResponseCopyWith<$Res>  {
  factory $ForbiddenResponseCopyWith(ForbiddenResponse value, $Res Function(ForbiddenResponse) _then) = _$ForbiddenResponseCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$ForbiddenResponseCopyWithImpl<$Res>
    implements $ForbiddenResponseCopyWith<$Res> {
  _$ForbiddenResponseCopyWithImpl(this._self, this._then);

  final ForbiddenResponse _self;
  final $Res Function(ForbiddenResponse) _then;

/// Create a copy of ForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ForbiddenResponse].
extension ForbiddenResponsePatterns on ForbiddenResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForbiddenResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForbiddenResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForbiddenResponse value)  $default,){
final _that = this;
switch (_that) {
case _ForbiddenResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForbiddenResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ForbiddenResponse() when $default != null:
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
case _ForbiddenResponse() when $default != null:
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
case _ForbiddenResponse():
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
case _ForbiddenResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForbiddenResponse implements ForbiddenResponse {
  const _ForbiddenResponse({required this.code, required this.message});
  factory _ForbiddenResponse.fromJson(Map<String, dynamic> json) => _$ForbiddenResponseFromJson(json);

@override final  String code;
@override final  String message;

/// Create a copy of ForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForbiddenResponseCopyWith<_ForbiddenResponse> get copyWith => __$ForbiddenResponseCopyWithImpl<_ForbiddenResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForbiddenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForbiddenResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ForbiddenResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ForbiddenResponseCopyWith<$Res> implements $ForbiddenResponseCopyWith<$Res> {
  factory _$ForbiddenResponseCopyWith(_ForbiddenResponse value, $Res Function(_ForbiddenResponse) _then) = __$ForbiddenResponseCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$ForbiddenResponseCopyWithImpl<$Res>
    implements _$ForbiddenResponseCopyWith<$Res> {
  __$ForbiddenResponseCopyWithImpl(this._self, this._then);

  final _ForbiddenResponse _self;
  final $Res Function(_ForbiddenResponse) _then;

/// Create a copy of ForbiddenResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_ForbiddenResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

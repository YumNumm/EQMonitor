// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unauthorized_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnauthorizedResponse {

 dynamic get code; String get message;
/// Create a copy of UnauthorizedResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnauthorizedResponseCopyWith<UnauthorizedResponse> get copyWith => _$UnauthorizedResponseCopyWithImpl<UnauthorizedResponse>(this as UnauthorizedResponse, _$identity);

  /// Serializes this UnauthorizedResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedResponse&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(code),message);

@override
String toString() {
  return 'UnauthorizedResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $UnauthorizedResponseCopyWith<$Res>  {
  factory $UnauthorizedResponseCopyWith(UnauthorizedResponse value, $Res Function(UnauthorizedResponse) _then) = _$UnauthorizedResponseCopyWithImpl;
@useResult
$Res call({
 dynamic code, String message
});




}
/// @nodoc
class _$UnauthorizedResponseCopyWithImpl<$Res>
    implements $UnauthorizedResponseCopyWith<$Res> {
  _$UnauthorizedResponseCopyWithImpl(this._self, this._then);

  final UnauthorizedResponse _self;
  final $Res Function(UnauthorizedResponse) _then;

/// Create a copy of UnauthorizedResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? message = null,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as dynamic,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UnauthorizedResponse].
extension UnauthorizedResponsePatterns on UnauthorizedResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnauthorizedResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnauthorizedResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnauthorizedResponse value)  $default,){
final _that = this;
switch (_that) {
case _UnauthorizedResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnauthorizedResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UnauthorizedResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic code,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnauthorizedResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic code,  String message)  $default,) {final _that = this;
switch (_that) {
case _UnauthorizedResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic code,  String message)?  $default,) {final _that = this;
switch (_that) {
case _UnauthorizedResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnauthorizedResponse implements UnauthorizedResponse {
  const _UnauthorizedResponse({required this.code, required this.message});
  factory _UnauthorizedResponse.fromJson(Map<String, dynamic> json) => _$UnauthorizedResponseFromJson(json);

@override final  dynamic code;
@override final  String message;

/// Create a copy of UnauthorizedResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnauthorizedResponseCopyWith<_UnauthorizedResponse> get copyWith => __$UnauthorizedResponseCopyWithImpl<_UnauthorizedResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnauthorizedResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnauthorizedResponse&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(code),message);

@override
String toString() {
  return 'UnauthorizedResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$UnauthorizedResponseCopyWith<$Res> implements $UnauthorizedResponseCopyWith<$Res> {
  factory _$UnauthorizedResponseCopyWith(_UnauthorizedResponse value, $Res Function(_UnauthorizedResponse) _then) = __$UnauthorizedResponseCopyWithImpl;
@override @useResult
$Res call({
 dynamic code, String message
});




}
/// @nodoc
class __$UnauthorizedResponseCopyWithImpl<$Res>
    implements _$UnauthorizedResponseCopyWith<$Res> {
  __$UnauthorizedResponseCopyWithImpl(this._self, this._then);

  final _UnauthorizedResponse _self;
  final $Res Function(_UnauthorizedResponse) _then;

/// Create a copy of UnauthorizedResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? message = null,}) {
  return _then(_UnauthorizedResponse(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as dynamic,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

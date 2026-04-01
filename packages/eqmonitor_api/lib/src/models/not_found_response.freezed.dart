// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'not_found_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotFoundResponse {

 dynamic get code; String get message;
/// Create a copy of NotFoundResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotFoundResponseCopyWith<NotFoundResponse> get copyWith => _$NotFoundResponseCopyWithImpl<NotFoundResponse>(this as NotFoundResponse, _$identity);

  /// Serializes this NotFoundResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFoundResponse&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(code),message);

@override
String toString() {
  return 'NotFoundResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $NotFoundResponseCopyWith<$Res>  {
  factory $NotFoundResponseCopyWith(NotFoundResponse value, $Res Function(NotFoundResponse) _then) = _$NotFoundResponseCopyWithImpl;
@useResult
$Res call({
 dynamic code, String message
});




}
/// @nodoc
class _$NotFoundResponseCopyWithImpl<$Res>
    implements $NotFoundResponseCopyWith<$Res> {
  _$NotFoundResponseCopyWithImpl(this._self, this._then);

  final NotFoundResponse _self;
  final $Res Function(NotFoundResponse) _then;

/// Create a copy of NotFoundResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? message = null,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as dynamic,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotFoundResponse].
extension NotFoundResponsePatterns on NotFoundResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotFoundResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotFoundResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotFoundResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotFoundResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotFoundResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotFoundResponse() when $default != null:
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
case _NotFoundResponse() when $default != null:
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
case _NotFoundResponse():
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
case _NotFoundResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotFoundResponse implements NotFoundResponse {
  const _NotFoundResponse({required this.code, required this.message});
  factory _NotFoundResponse.fromJson(Map<String, dynamic> json) => _$NotFoundResponseFromJson(json);

@override final  dynamic code;
@override final  String message;

/// Create a copy of NotFoundResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotFoundResponseCopyWith<_NotFoundResponse> get copyWith => __$NotFoundResponseCopyWithImpl<_NotFoundResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotFoundResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotFoundResponse&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(code),message);

@override
String toString() {
  return 'NotFoundResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$NotFoundResponseCopyWith<$Res> implements $NotFoundResponseCopyWith<$Res> {
  factory _$NotFoundResponseCopyWith(_NotFoundResponse value, $Res Function(_NotFoundResponse) _then) = __$NotFoundResponseCopyWithImpl;
@override @useResult
$Res call({
 dynamic code, String message
});




}
/// @nodoc
class __$NotFoundResponseCopyWithImpl<$Res>
    implements _$NotFoundResponseCopyWith<$Res> {
  __$NotFoundResponseCopyWithImpl(this._self, this._then);

  final _NotFoundResponse _self;
  final $Res Function(_NotFoundResponse) _then;

/// Create a copy of NotFoundResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? message = null,}) {
  return _then(_NotFoundResponse(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as dynamic,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

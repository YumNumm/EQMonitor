// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'v2_device_me_fcm_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$V2DeviceMeFcmRequestBody {

 String get token;
/// Create a copy of V2DeviceMeFcmRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$V2DeviceMeFcmRequestBodyCopyWith<V2DeviceMeFcmRequestBody> get copyWith => _$V2DeviceMeFcmRequestBodyCopyWithImpl<V2DeviceMeFcmRequestBody>(this as V2DeviceMeFcmRequestBody, _$identity);

  /// Serializes this V2DeviceMeFcmRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is V2DeviceMeFcmRequestBody&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'V2DeviceMeFcmRequestBody(token: $token)';
}


}

/// @nodoc
abstract mixin class $V2DeviceMeFcmRequestBodyCopyWith<$Res>  {
  factory $V2DeviceMeFcmRequestBodyCopyWith(V2DeviceMeFcmRequestBody value, $Res Function(V2DeviceMeFcmRequestBody) _then) = _$V2DeviceMeFcmRequestBodyCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class _$V2DeviceMeFcmRequestBodyCopyWithImpl<$Res>
    implements $V2DeviceMeFcmRequestBodyCopyWith<$Res> {
  _$V2DeviceMeFcmRequestBodyCopyWithImpl(this._self, this._then);

  final V2DeviceMeFcmRequestBody _self;
  final $Res Function(V2DeviceMeFcmRequestBody) _then;

/// Create a copy of V2DeviceMeFcmRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,}) {
  return _then(V2DeviceMeFcmRequestBody(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [V2DeviceMeFcmRequestBody].
extension V2DeviceMeFcmRequestBodyPatterns on V2DeviceMeFcmRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _V2DeviceMeFcmRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _V2DeviceMeFcmRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _V2DeviceMeFcmRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _V2DeviceMeFcmRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _V2DeviceMeFcmRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _V2DeviceMeFcmRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _V2DeviceMeFcmRequestBody() when $default != null:
return $default(_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token)  $default,) {final _that = this;
switch (_that) {
case _V2DeviceMeFcmRequestBody():
return $default(_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token)?  $default,) {final _that = this;
switch (_that) {
case _V2DeviceMeFcmRequestBody() when $default != null:
return $default(_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _V2DeviceMeFcmRequestBody implements V2DeviceMeFcmRequestBody {
  const _V2DeviceMeFcmRequestBody({required this.token});
  factory _V2DeviceMeFcmRequestBody.fromJson(Map<String, dynamic> json) => _$V2DeviceMeFcmRequestBodyFromJson(json);

@override final  String token;

/// Create a copy of V2DeviceMeFcmRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$V2DeviceMeFcmRequestBodyCopyWith<_V2DeviceMeFcmRequestBody> get copyWith => __$V2DeviceMeFcmRequestBodyCopyWithImpl<_V2DeviceMeFcmRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$V2DeviceMeFcmRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _V2DeviceMeFcmRequestBody&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'V2DeviceMeFcmRequestBody(token: $token)';
}


}

/// @nodoc
abstract mixin class _$V2DeviceMeFcmRequestBodyCopyWith<$Res> implements $V2DeviceMeFcmRequestBodyCopyWith<$Res> {
  factory _$V2DeviceMeFcmRequestBodyCopyWith(_V2DeviceMeFcmRequestBody value, $Res Function(_V2DeviceMeFcmRequestBody) _then) = __$V2DeviceMeFcmRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String token
});




}
/// @nodoc
class __$V2DeviceMeFcmRequestBodyCopyWithImpl<$Res>
    implements _$V2DeviceMeFcmRequestBodyCopyWith<$Res> {
  __$V2DeviceMeFcmRequestBodyCopyWithImpl(this._self, this._then);

  final _V2DeviceMeFcmRequestBody _self;
  final $Res Function(_V2DeviceMeFcmRequestBody) _then;

/// Create a copy of V2DeviceMeFcmRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(_V2DeviceMeFcmRequestBody(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

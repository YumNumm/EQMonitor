// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm_token_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FcmTokenUpdateResponse {

 String? get token; String? get fcmVerify;
/// Create a copy of FcmTokenUpdateResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FcmTokenUpdateResponseCopyWith<FcmTokenUpdateResponse> get copyWith => _$FcmTokenUpdateResponseCopyWithImpl<FcmTokenUpdateResponse>(this as FcmTokenUpdateResponse, _$identity);

  /// Serializes this FcmTokenUpdateResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FcmTokenUpdateResponse&&(identical(other.token, token) || other.token == token)&&(identical(other.fcmVerify, fcmVerify) || other.fcmVerify == fcmVerify));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,fcmVerify);

@override
String toString() {
  return 'FcmTokenUpdateResponse(token: $token, fcmVerify: $fcmVerify)';
}


}

/// @nodoc
abstract mixin class $FcmTokenUpdateResponseCopyWith<$Res>  {
  factory $FcmTokenUpdateResponseCopyWith(FcmTokenUpdateResponse value, $Res Function(FcmTokenUpdateResponse) _then) = _$FcmTokenUpdateResponseCopyWithImpl;
@useResult
$Res call({
 String? token, String? fcmVerify
});




}
/// @nodoc
class _$FcmTokenUpdateResponseCopyWithImpl<$Res>
    implements $FcmTokenUpdateResponseCopyWith<$Res> {
  _$FcmTokenUpdateResponseCopyWithImpl(this._self, this._then);

  final FcmTokenUpdateResponse _self;
  final $Res Function(FcmTokenUpdateResponse) _then;

/// Create a copy of FcmTokenUpdateResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = freezed,Object? fcmVerify = freezed,}) {
  return _then(_self.copyWith(
token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,fcmVerify: freezed == fcmVerify ? _self.fcmVerify : fcmVerify // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FcmTokenUpdateResponse].
extension FcmTokenUpdateResponsePatterns on FcmTokenUpdateResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FcmTokenUpdateResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FcmTokenUpdateResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FcmTokenUpdateResponse value)  $default,){
final _that = this;
switch (_that) {
case _FcmTokenUpdateResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FcmTokenUpdateResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FcmTokenUpdateResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? token,  String? fcmVerify)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FcmTokenUpdateResponse() when $default != null:
return $default(_that.token,_that.fcmVerify);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? token,  String? fcmVerify)  $default,) {final _that = this;
switch (_that) {
case _FcmTokenUpdateResponse():
return $default(_that.token,_that.fcmVerify);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? token,  String? fcmVerify)?  $default,) {final _that = this;
switch (_that) {
case _FcmTokenUpdateResponse() when $default != null:
return $default(_that.token,_that.fcmVerify);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FcmTokenUpdateResponse implements FcmTokenUpdateResponse {
  const _FcmTokenUpdateResponse({required this.token, required this.fcmVerify});
  factory _FcmTokenUpdateResponse.fromJson(Map<String, dynamic> json) => _$FcmTokenUpdateResponseFromJson(json);

@override final  String? token;
@override final  String? fcmVerify;

/// Create a copy of FcmTokenUpdateResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FcmTokenUpdateResponseCopyWith<_FcmTokenUpdateResponse> get copyWith => __$FcmTokenUpdateResponseCopyWithImpl<_FcmTokenUpdateResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FcmTokenUpdateResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FcmTokenUpdateResponse&&(identical(other.token, token) || other.token == token)&&(identical(other.fcmVerify, fcmVerify) || other.fcmVerify == fcmVerify));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,fcmVerify);

@override
String toString() {
  return 'FcmTokenUpdateResponse(token: $token, fcmVerify: $fcmVerify)';
}


}

/// @nodoc
abstract mixin class _$FcmTokenUpdateResponseCopyWith<$Res> implements $FcmTokenUpdateResponseCopyWith<$Res> {
  factory _$FcmTokenUpdateResponseCopyWith(_FcmTokenUpdateResponse value, $Res Function(_FcmTokenUpdateResponse) _then) = __$FcmTokenUpdateResponseCopyWithImpl;
@override @useResult
$Res call({
 String? token, String? fcmVerify
});




}
/// @nodoc
class __$FcmTokenUpdateResponseCopyWithImpl<$Res>
    implements _$FcmTokenUpdateResponseCopyWith<$Res> {
  __$FcmTokenUpdateResponseCopyWithImpl(this._self, this._then);

  final _FcmTokenUpdateResponse _self;
  final $Res Function(_FcmTokenUpdateResponse) _then;

/// Create a copy of FcmTokenUpdateResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = freezed,Object? fcmVerify = freezed,}) {
  return _then(_FcmTokenUpdateResponse(
token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,fcmVerify: freezed == fcmVerify ? _self.fcmVerify : fcmVerify // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChallengeResponse {

 String get challengeCode; DateTime get expiresAt;
/// Create a copy of ChallengeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeResponseCopyWith<ChallengeResponse> get copyWith => _$ChallengeResponseCopyWithImpl<ChallengeResponse>(this as ChallengeResponse, _$identity);

  /// Serializes this ChallengeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeResponse&&(identical(other.challengeCode, challengeCode) || other.challengeCode == challengeCode)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,challengeCode,expiresAt);

@override
String toString() {
  return 'ChallengeResponse(challengeCode: $challengeCode, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $ChallengeResponseCopyWith<$Res>  {
  factory $ChallengeResponseCopyWith(ChallengeResponse value, $Res Function(ChallengeResponse) _then) = _$ChallengeResponseCopyWithImpl;
@useResult
$Res call({
 String challengeCode, DateTime expiresAt
});




}
/// @nodoc
class _$ChallengeResponseCopyWithImpl<$Res>
    implements $ChallengeResponseCopyWith<$Res> {
  _$ChallengeResponseCopyWithImpl(this._self, this._then);

  final ChallengeResponse _self;
  final $Res Function(ChallengeResponse) _then;

/// Create a copy of ChallengeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? challengeCode = null,Object? expiresAt = null,}) {
  return _then(ChallengeResponse(
challengeCode: null == challengeCode ? _self.challengeCode : challengeCode // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChallengeResponse].
extension ChallengeResponsePatterns on ChallengeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChallengeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChallengeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChallengeResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChallengeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChallengeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChallengeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String challengeCode,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChallengeResponse() when $default != null:
return $default(_that.challengeCode,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String challengeCode,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _ChallengeResponse():
return $default(_that.challengeCode,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String challengeCode,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _ChallengeResponse() when $default != null:
return $default(_that.challengeCode,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChallengeResponse implements ChallengeResponse {
  const _ChallengeResponse({required this.challengeCode, required this.expiresAt});
  factory _ChallengeResponse.fromJson(Map<String, dynamic> json) => _$ChallengeResponseFromJson(json);

@override final  String challengeCode;
@override final  DateTime expiresAt;

/// Create a copy of ChallengeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChallengeResponseCopyWith<_ChallengeResponse> get copyWith => __$ChallengeResponseCopyWithImpl<_ChallengeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChallengeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChallengeResponse&&(identical(other.challengeCode, challengeCode) || other.challengeCode == challengeCode)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,challengeCode,expiresAt);

@override
String toString() {
  return 'ChallengeResponse(challengeCode: $challengeCode, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$ChallengeResponseCopyWith<$Res> implements $ChallengeResponseCopyWith<$Res> {
  factory _$ChallengeResponseCopyWith(_ChallengeResponse value, $Res Function(_ChallengeResponse) _then) = __$ChallengeResponseCopyWithImpl;
@override @useResult
$Res call({
 String challengeCode, DateTime expiresAt
});




}
/// @nodoc
class __$ChallengeResponseCopyWithImpl<$Res>
    implements _$ChallengeResponseCopyWith<$Res> {
  __$ChallengeResponseCopyWithImpl(this._self, this._then);

  final _ChallengeResponse _self;
  final $Res Function(_ChallengeResponse) _then;

/// Create a copy of ChallengeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? challengeCode = null,Object? expiresAt = null,}) {
  return _then(_ChallengeResponse(
challengeCode: null == challengeCode ? _self.challengeCode : challengeCode // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

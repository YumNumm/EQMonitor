// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_verification_email_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SendVerificationEmailRequestBody {

/// The email to send the verification email to
 String get email;/// The URL to use for email verification callback
@JsonKey(includeIfNull: false, name: 'callbackURL') String? get callbackUrl;
/// Create a copy of SendVerificationEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendVerificationEmailRequestBodyCopyWith<SendVerificationEmailRequestBody> get copyWith => _$SendVerificationEmailRequestBodyCopyWithImpl<SendVerificationEmailRequestBody>(this as SendVerificationEmailRequestBody, _$identity);

  /// Serializes this SendVerificationEmailRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendVerificationEmailRequestBody&&(identical(other.email, email) || other.email == email)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,callbackUrl);

@override
String toString() {
  return 'SendVerificationEmailRequestBody(email: $email, callbackUrl: $callbackUrl)';
}


}

/// @nodoc
abstract mixin class $SendVerificationEmailRequestBodyCopyWith<$Res>  {
  factory $SendVerificationEmailRequestBodyCopyWith(SendVerificationEmailRequestBody value, $Res Function(SendVerificationEmailRequestBody) _then) = _$SendVerificationEmailRequestBodyCopyWithImpl;
@useResult
$Res call({
 String email,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl
});




}
/// @nodoc
class _$SendVerificationEmailRequestBodyCopyWithImpl<$Res>
    implements $SendVerificationEmailRequestBodyCopyWith<$Res> {
  _$SendVerificationEmailRequestBodyCopyWithImpl(this._self, this._then);

  final SendVerificationEmailRequestBody _self;
  final $Res Function(SendVerificationEmailRequestBody) _then;

/// Create a copy of SendVerificationEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? callbackUrl = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SendVerificationEmailRequestBody].
extension SendVerificationEmailRequestBodyPatterns on SendVerificationEmailRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendVerificationEmailRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendVerificationEmailRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendVerificationEmailRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _SendVerificationEmailRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendVerificationEmailRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _SendVerificationEmailRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendVerificationEmailRequestBody() when $default != null:
return $default(_that.email,_that.callbackUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl)  $default,) {final _that = this;
switch (_that) {
case _SendVerificationEmailRequestBody():
return $default(_that.email,_that.callbackUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl)?  $default,) {final _that = this;
switch (_that) {
case _SendVerificationEmailRequestBody() when $default != null:
return $default(_that.email,_that.callbackUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendVerificationEmailRequestBody implements SendVerificationEmailRequestBody {
  const _SendVerificationEmailRequestBody({required this.email, @JsonKey(includeIfNull: false, name: 'callbackURL') this.callbackUrl});
  factory _SendVerificationEmailRequestBody.fromJson(Map<String, dynamic> json) => _$SendVerificationEmailRequestBodyFromJson(json);

/// The email to send the verification email to
@override final  String email;
/// The URL to use for email verification callback
@override@JsonKey(includeIfNull: false, name: 'callbackURL') final  String? callbackUrl;

/// Create a copy of SendVerificationEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendVerificationEmailRequestBodyCopyWith<_SendVerificationEmailRequestBody> get copyWith => __$SendVerificationEmailRequestBodyCopyWithImpl<_SendVerificationEmailRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendVerificationEmailRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendVerificationEmailRequestBody&&(identical(other.email, email) || other.email == email)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,callbackUrl);

@override
String toString() {
  return 'SendVerificationEmailRequestBody(email: $email, callbackUrl: $callbackUrl)';
}


}

/// @nodoc
abstract mixin class _$SendVerificationEmailRequestBodyCopyWith<$Res> implements $SendVerificationEmailRequestBodyCopyWith<$Res> {
  factory _$SendVerificationEmailRequestBodyCopyWith(_SendVerificationEmailRequestBody value, $Res Function(_SendVerificationEmailRequestBody) _then) = __$SendVerificationEmailRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String email,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl
});




}
/// @nodoc
class __$SendVerificationEmailRequestBodyCopyWithImpl<$Res>
    implements _$SendVerificationEmailRequestBodyCopyWith<$Res> {
  __$SendVerificationEmailRequestBodyCopyWithImpl(this._self, this._then);

  final _SendVerificationEmailRequestBody _self;
  final $Res Function(_SendVerificationEmailRequestBody) _then;

/// Create a copy of SendVerificationEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? callbackUrl = freezed,}) {
  return _then(_SendVerificationEmailRequestBody(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

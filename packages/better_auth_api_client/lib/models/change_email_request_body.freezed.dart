// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_email_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChangeEmailRequestBody {

/// The new email address to set must be a valid email address
 String get newEmail;/// The URL to redirect to after email verification
@JsonKey(includeIfNull: false, name: 'callbackURL') String? get callbackUrl;
/// Create a copy of ChangeEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeEmailRequestBodyCopyWith<ChangeEmailRequestBody> get copyWith => _$ChangeEmailRequestBodyCopyWithImpl<ChangeEmailRequestBody>(this as ChangeEmailRequestBody, _$identity);

  /// Serializes this ChangeEmailRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeEmailRequestBody&&(identical(other.newEmail, newEmail) || other.newEmail == newEmail)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,newEmail,callbackUrl);

@override
String toString() {
  return 'ChangeEmailRequestBody(newEmail: $newEmail, callbackUrl: $callbackUrl)';
}


}

/// @nodoc
abstract mixin class $ChangeEmailRequestBodyCopyWith<$Res>  {
  factory $ChangeEmailRequestBodyCopyWith(ChangeEmailRequestBody value, $Res Function(ChangeEmailRequestBody) _then) = _$ChangeEmailRequestBodyCopyWithImpl;
@useResult
$Res call({
 String newEmail,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl
});




}
/// @nodoc
class _$ChangeEmailRequestBodyCopyWithImpl<$Res>
    implements $ChangeEmailRequestBodyCopyWith<$Res> {
  _$ChangeEmailRequestBodyCopyWithImpl(this._self, this._then);

  final ChangeEmailRequestBody _self;
  final $Res Function(ChangeEmailRequestBody) _then;

/// Create a copy of ChangeEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? newEmail = null,Object? callbackUrl = freezed,}) {
  return _then(_self.copyWith(
newEmail: null == newEmail ? _self.newEmail : newEmail // ignore: cast_nullable_to_non_nullable
as String,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangeEmailRequestBody].
extension ChangeEmailRequestBodyPatterns on ChangeEmailRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangeEmailRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangeEmailRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangeEmailRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _ChangeEmailRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangeEmailRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _ChangeEmailRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String newEmail, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangeEmailRequestBody() when $default != null:
return $default(_that.newEmail,_that.callbackUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String newEmail, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl)  $default,) {final _that = this;
switch (_that) {
case _ChangeEmailRequestBody():
return $default(_that.newEmail,_that.callbackUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String newEmail, @JsonKey(includeIfNull: false, name: 'callbackURL')  String? callbackUrl)?  $default,) {final _that = this;
switch (_that) {
case _ChangeEmailRequestBody() when $default != null:
return $default(_that.newEmail,_that.callbackUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangeEmailRequestBody implements ChangeEmailRequestBody {
  const _ChangeEmailRequestBody({required this.newEmail, @JsonKey(includeIfNull: false, name: 'callbackURL') this.callbackUrl});
  factory _ChangeEmailRequestBody.fromJson(Map<String, dynamic> json) => _$ChangeEmailRequestBodyFromJson(json);

/// The new email address to set must be a valid email address
@override final  String newEmail;
/// The URL to redirect to after email verification
@override@JsonKey(includeIfNull: false, name: 'callbackURL') final  String? callbackUrl;

/// Create a copy of ChangeEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeEmailRequestBodyCopyWith<_ChangeEmailRequestBody> get copyWith => __$ChangeEmailRequestBodyCopyWithImpl<_ChangeEmailRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangeEmailRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeEmailRequestBody&&(identical(other.newEmail, newEmail) || other.newEmail == newEmail)&&(identical(other.callbackUrl, callbackUrl) || other.callbackUrl == callbackUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,newEmail,callbackUrl);

@override
String toString() {
  return 'ChangeEmailRequestBody(newEmail: $newEmail, callbackUrl: $callbackUrl)';
}


}

/// @nodoc
abstract mixin class _$ChangeEmailRequestBodyCopyWith<$Res> implements $ChangeEmailRequestBodyCopyWith<$Res> {
  factory _$ChangeEmailRequestBodyCopyWith(_ChangeEmailRequestBody value, $Res Function(_ChangeEmailRequestBody) _then) = __$ChangeEmailRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String newEmail,@JsonKey(includeIfNull: false, name: 'callbackURL') String? callbackUrl
});




}
/// @nodoc
class __$ChangeEmailRequestBodyCopyWithImpl<$Res>
    implements _$ChangeEmailRequestBodyCopyWith<$Res> {
  __$ChangeEmailRequestBodyCopyWithImpl(this._self, this._then);

  final _ChangeEmailRequestBody _self;
  final $Res Function(_ChangeEmailRequestBody) _then;

/// Create a copy of ChangeEmailRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? newEmail = null,Object? callbackUrl = freezed,}) {
  return _then(_ChangeEmailRequestBody(
newEmail: null == newEmail ? _self.newEmail : newEmail // ignore: cast_nullable_to_non_nullable
as String,callbackUrl: freezed == callbackUrl ? _self.callbackUrl : callbackUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

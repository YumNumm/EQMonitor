// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_password_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChangePasswordRequestBody {

/// The new password to set
 String get newPassword;/// The current password is required
 String get currentPassword;/// Must be a boolean value
@JsonKey(includeIfNull: false) bool? get revokeOtherSessions;
/// Create a copy of ChangePasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordRequestBodyCopyWith<ChangePasswordRequestBody> get copyWith => _$ChangePasswordRequestBodyCopyWithImpl<ChangePasswordRequestBody>(this as ChangePasswordRequestBody, _$identity);

  /// Serializes this ChangePasswordRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordRequestBody&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.revokeOtherSessions, revokeOtherSessions) || other.revokeOtherSessions == revokeOtherSessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,newPassword,currentPassword,revokeOtherSessions);

@override
String toString() {
  return 'ChangePasswordRequestBody(newPassword: $newPassword, currentPassword: $currentPassword, revokeOtherSessions: $revokeOtherSessions)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordRequestBodyCopyWith<$Res>  {
  factory $ChangePasswordRequestBodyCopyWith(ChangePasswordRequestBody value, $Res Function(ChangePasswordRequestBody) _then) = _$ChangePasswordRequestBodyCopyWithImpl;
@useResult
$Res call({
 String newPassword, String currentPassword,@JsonKey(includeIfNull: false) bool? revokeOtherSessions
});




}
/// @nodoc
class _$ChangePasswordRequestBodyCopyWithImpl<$Res>
    implements $ChangePasswordRequestBodyCopyWith<$Res> {
  _$ChangePasswordRequestBodyCopyWithImpl(this._self, this._then);

  final ChangePasswordRequestBody _self;
  final $Res Function(ChangePasswordRequestBody) _then;

/// Create a copy of ChangePasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? newPassword = null,Object? currentPassword = null,Object? revokeOtherSessions = freezed,}) {
  return _then(_self.copyWith(
newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,revokeOtherSessions: freezed == revokeOtherSessions ? _self.revokeOtherSessions : revokeOtherSessions // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangePasswordRequestBody].
extension ChangePasswordRequestBodyPatterns on ChangePasswordRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangePasswordRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangePasswordRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangePasswordRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangePasswordRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String newPassword,  String currentPassword, @JsonKey(includeIfNull: false)  bool? revokeOtherSessions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangePasswordRequestBody() when $default != null:
return $default(_that.newPassword,_that.currentPassword,_that.revokeOtherSessions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String newPassword,  String currentPassword, @JsonKey(includeIfNull: false)  bool? revokeOtherSessions)  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordRequestBody():
return $default(_that.newPassword,_that.currentPassword,_that.revokeOtherSessions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String newPassword,  String currentPassword, @JsonKey(includeIfNull: false)  bool? revokeOtherSessions)?  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordRequestBody() when $default != null:
return $default(_that.newPassword,_that.currentPassword,_that.revokeOtherSessions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangePasswordRequestBody implements ChangePasswordRequestBody {
  const _ChangePasswordRequestBody({required this.newPassword, required this.currentPassword, @JsonKey(includeIfNull: false) this.revokeOtherSessions});
  factory _ChangePasswordRequestBody.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestBodyFromJson(json);

/// The new password to set
@override final  String newPassword;
/// The current password is required
@override final  String currentPassword;
/// Must be a boolean value
@override@JsonKey(includeIfNull: false) final  bool? revokeOtherSessions;

/// Create a copy of ChangePasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePasswordRequestBodyCopyWith<_ChangePasswordRequestBody> get copyWith => __$ChangePasswordRequestBodyCopyWithImpl<_ChangePasswordRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangePasswordRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePasswordRequestBody&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.revokeOtherSessions, revokeOtherSessions) || other.revokeOtherSessions == revokeOtherSessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,newPassword,currentPassword,revokeOtherSessions);

@override
String toString() {
  return 'ChangePasswordRequestBody(newPassword: $newPassword, currentPassword: $currentPassword, revokeOtherSessions: $revokeOtherSessions)';
}


}

/// @nodoc
abstract mixin class _$ChangePasswordRequestBodyCopyWith<$Res> implements $ChangePasswordRequestBodyCopyWith<$Res> {
  factory _$ChangePasswordRequestBodyCopyWith(_ChangePasswordRequestBody value, $Res Function(_ChangePasswordRequestBody) _then) = __$ChangePasswordRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String newPassword, String currentPassword,@JsonKey(includeIfNull: false) bool? revokeOtherSessions
});




}
/// @nodoc
class __$ChangePasswordRequestBodyCopyWithImpl<$Res>
    implements _$ChangePasswordRequestBodyCopyWith<$Res> {
  __$ChangePasswordRequestBodyCopyWithImpl(this._self, this._then);

  final _ChangePasswordRequestBody _self;
  final $Res Function(_ChangePasswordRequestBody) _then;

/// Create a copy of ChangePasswordRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? newPassword = null,Object? currentPassword = null,Object? revokeOtherSessions = freezed,}) {
  return _then(_ChangePasswordRequestBody(
newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,revokeOtherSessions: freezed == revokeOtherSessions ? _self.revokeOtherSessions : revokeOtherSessions // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on

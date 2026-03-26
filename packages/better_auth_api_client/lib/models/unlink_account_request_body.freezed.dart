// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unlink_account_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnlinkAccountRequestBody {

 String get providerId;@JsonKey(includeIfNull: false) String? get accountId;
/// Create a copy of UnlinkAccountRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnlinkAccountRequestBodyCopyWith<UnlinkAccountRequestBody> get copyWith => _$UnlinkAccountRequestBodyCopyWithImpl<UnlinkAccountRequestBody>(this as UnlinkAccountRequestBody, _$identity);

  /// Serializes this UnlinkAccountRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnlinkAccountRequestBody&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.accountId, accountId) || other.accountId == accountId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,providerId,accountId);

@override
String toString() {
  return 'UnlinkAccountRequestBody(providerId: $providerId, accountId: $accountId)';
}


}

/// @nodoc
abstract mixin class $UnlinkAccountRequestBodyCopyWith<$Res>  {
  factory $UnlinkAccountRequestBodyCopyWith(UnlinkAccountRequestBody value, $Res Function(UnlinkAccountRequestBody) _then) = _$UnlinkAccountRequestBodyCopyWithImpl;
@useResult
$Res call({
 String providerId,@JsonKey(includeIfNull: false) String? accountId
});




}
/// @nodoc
class _$UnlinkAccountRequestBodyCopyWithImpl<$Res>
    implements $UnlinkAccountRequestBodyCopyWith<$Res> {
  _$UnlinkAccountRequestBodyCopyWithImpl(this._self, this._then);

  final UnlinkAccountRequestBody _self;
  final $Res Function(UnlinkAccountRequestBody) _then;

/// Create a copy of UnlinkAccountRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? providerId = null,Object? accountId = freezed,}) {
  return _then(_self.copyWith(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UnlinkAccountRequestBody].
extension UnlinkAccountRequestBodyPatterns on UnlinkAccountRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnlinkAccountRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnlinkAccountRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnlinkAccountRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _UnlinkAccountRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnlinkAccountRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _UnlinkAccountRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String providerId, @JsonKey(includeIfNull: false)  String? accountId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnlinkAccountRequestBody() when $default != null:
return $default(_that.providerId,_that.accountId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String providerId, @JsonKey(includeIfNull: false)  String? accountId)  $default,) {final _that = this;
switch (_that) {
case _UnlinkAccountRequestBody():
return $default(_that.providerId,_that.accountId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String providerId, @JsonKey(includeIfNull: false)  String? accountId)?  $default,) {final _that = this;
switch (_that) {
case _UnlinkAccountRequestBody() when $default != null:
return $default(_that.providerId,_that.accountId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnlinkAccountRequestBody implements UnlinkAccountRequestBody {
  const _UnlinkAccountRequestBody({required this.providerId, @JsonKey(includeIfNull: false) this.accountId});
  factory _UnlinkAccountRequestBody.fromJson(Map<String, dynamic> json) => _$UnlinkAccountRequestBodyFromJson(json);

@override final  String providerId;
@override@JsonKey(includeIfNull: false) final  String? accountId;

/// Create a copy of UnlinkAccountRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnlinkAccountRequestBodyCopyWith<_UnlinkAccountRequestBody> get copyWith => __$UnlinkAccountRequestBodyCopyWithImpl<_UnlinkAccountRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnlinkAccountRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnlinkAccountRequestBody&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.accountId, accountId) || other.accountId == accountId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,providerId,accountId);

@override
String toString() {
  return 'UnlinkAccountRequestBody(providerId: $providerId, accountId: $accountId)';
}


}

/// @nodoc
abstract mixin class _$UnlinkAccountRequestBodyCopyWith<$Res> implements $UnlinkAccountRequestBodyCopyWith<$Res> {
  factory _$UnlinkAccountRequestBodyCopyWith(_UnlinkAccountRequestBody value, $Res Function(_UnlinkAccountRequestBody) _then) = __$UnlinkAccountRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String providerId,@JsonKey(includeIfNull: false) String? accountId
});




}
/// @nodoc
class __$UnlinkAccountRequestBodyCopyWithImpl<$Res>
    implements _$UnlinkAccountRequestBodyCopyWith<$Res> {
  __$UnlinkAccountRequestBodyCopyWithImpl(this._self, this._then);

  final _UnlinkAccountRequestBody _self;
  final $Res Function(_UnlinkAccountRequestBody) _then;

/// Create a copy of UnlinkAccountRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? providerId = null,Object? accountId = freezed,}) {
  return _then(_UnlinkAccountRequestBody(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

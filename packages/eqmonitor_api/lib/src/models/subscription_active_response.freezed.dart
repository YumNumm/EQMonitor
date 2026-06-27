// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_active_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionActiveResponse {

/// const: "ACTIVE" | const: "GRACE_PERIOD"
 Status get status; String get productId;@JsonKey(includeIfNull: true) DateTime? get expiresAt; bool get willRenew;
/// Create a copy of SubscriptionActiveResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionActiveResponseCopyWith<SubscriptionActiveResponse> get copyWith => _$SubscriptionActiveResponseCopyWithImpl<SubscriptionActiveResponse>(this as SubscriptionActiveResponse, _$identity);

  /// Serializes this SubscriptionActiveResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionActiveResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.willRenew, willRenew) || other.willRenew == willRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,productId,expiresAt,willRenew);

@override
String toString() {
  return 'SubscriptionActiveResponse(status: $status, productId: $productId, expiresAt: $expiresAt, willRenew: $willRenew)';
}


}

/// @nodoc
abstract mixin class $SubscriptionActiveResponseCopyWith<$Res>  {
  factory $SubscriptionActiveResponseCopyWith(SubscriptionActiveResponse value, $Res Function(SubscriptionActiveResponse) _then) = _$SubscriptionActiveResponseCopyWithImpl;
@useResult
$Res call({
 Status status, String productId,@JsonKey(includeIfNull: true) DateTime? expiresAt, bool willRenew
});




}
/// @nodoc
class _$SubscriptionActiveResponseCopyWithImpl<$Res>
    implements $SubscriptionActiveResponseCopyWith<$Res> {
  _$SubscriptionActiveResponseCopyWithImpl(this._self, this._then);

  final SubscriptionActiveResponse _self;
  final $Res Function(SubscriptionActiveResponse) _then;

/// Create a copy of SubscriptionActiveResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? productId = null,Object? expiresAt = freezed,Object? willRenew = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,willRenew: null == willRenew ? _self.willRenew : willRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionActiveResponse].
extension SubscriptionActiveResponsePatterns on SubscriptionActiveResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionActiveResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionActiveResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionActiveResponse value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionActiveResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionActiveResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionActiveResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Status status,  String productId, @JsonKey(includeIfNull: true)  DateTime? expiresAt,  bool willRenew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionActiveResponse() when $default != null:
return $default(_that.status,_that.productId,_that.expiresAt,_that.willRenew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Status status,  String productId, @JsonKey(includeIfNull: true)  DateTime? expiresAt,  bool willRenew)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionActiveResponse():
return $default(_that.status,_that.productId,_that.expiresAt,_that.willRenew);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Status status,  String productId, @JsonKey(includeIfNull: true)  DateTime? expiresAt,  bool willRenew)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionActiveResponse() when $default != null:
return $default(_that.status,_that.productId,_that.expiresAt,_that.willRenew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionActiveResponse implements SubscriptionActiveResponse {
  const _SubscriptionActiveResponse({required this.status, required this.productId, @JsonKey(includeIfNull: true) required this.expiresAt, required this.willRenew});
  factory _SubscriptionActiveResponse.fromJson(Map<String, dynamic> json) => _$SubscriptionActiveResponseFromJson(json);

/// const: "ACTIVE" | const: "GRACE_PERIOD"
@override final  Status status;
@override final  String productId;
@override@JsonKey(includeIfNull: true) final  DateTime? expiresAt;
@override final  bool willRenew;

/// Create a copy of SubscriptionActiveResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionActiveResponseCopyWith<_SubscriptionActiveResponse> get copyWith => __$SubscriptionActiveResponseCopyWithImpl<_SubscriptionActiveResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionActiveResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionActiveResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.willRenew, willRenew) || other.willRenew == willRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,productId,expiresAt,willRenew);

@override
String toString() {
  return 'SubscriptionActiveResponse(status: $status, productId: $productId, expiresAt: $expiresAt, willRenew: $willRenew)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionActiveResponseCopyWith<$Res> implements $SubscriptionActiveResponseCopyWith<$Res> {
  factory _$SubscriptionActiveResponseCopyWith(_SubscriptionActiveResponse value, $Res Function(_SubscriptionActiveResponse) _then) = __$SubscriptionActiveResponseCopyWithImpl;
@override @useResult
$Res call({
 Status status, String productId,@JsonKey(includeIfNull: true) DateTime? expiresAt, bool willRenew
});




}
/// @nodoc
class __$SubscriptionActiveResponseCopyWithImpl<$Res>
    implements _$SubscriptionActiveResponseCopyWith<$Res> {
  __$SubscriptionActiveResponseCopyWithImpl(this._self, this._then);

  final _SubscriptionActiveResponse _self;
  final $Res Function(_SubscriptionActiveResponse) _then;

/// Create a copy of SubscriptionActiveResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? productId = null,Object? expiresAt = freezed,Object? willRenew = null,}) {
  return _then(_SubscriptionActiveResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,willRenew: null == willRenew ? _self.willRenew : willRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

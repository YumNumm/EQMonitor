// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_inactive_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionInactiveResponse {

/// const: "INACTIVE"
 String get status;
/// Create a copy of SubscriptionInactiveResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionInactiveResponseCopyWith<SubscriptionInactiveResponse> get copyWith => _$SubscriptionInactiveResponseCopyWithImpl<SubscriptionInactiveResponse>(this as SubscriptionInactiveResponse, _$identity);

  /// Serializes this SubscriptionInactiveResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionInactiveResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'SubscriptionInactiveResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class $SubscriptionInactiveResponseCopyWith<$Res>  {
  factory $SubscriptionInactiveResponseCopyWith(SubscriptionInactiveResponse value, $Res Function(SubscriptionInactiveResponse) _then) = _$SubscriptionInactiveResponseCopyWithImpl;
@useResult
$Res call({
 String status
});




}
/// @nodoc
class _$SubscriptionInactiveResponseCopyWithImpl<$Res>
    implements $SubscriptionInactiveResponseCopyWith<$Res> {
  _$SubscriptionInactiveResponseCopyWithImpl(this._self, this._then);

  final SubscriptionInactiveResponse _self;
  final $Res Function(SubscriptionInactiveResponse) _then;

/// Create a copy of SubscriptionInactiveResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(SubscriptionInactiveResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionInactiveResponse].
extension SubscriptionInactiveResponsePatterns on SubscriptionInactiveResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionInactiveResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionInactiveResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionInactiveResponse value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionInactiveResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionInactiveResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionInactiveResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionInactiveResponse() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionInactiveResponse():
return $default(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionInactiveResponse() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionInactiveResponse implements SubscriptionInactiveResponse {
  const _SubscriptionInactiveResponse({required this.status});
  factory _SubscriptionInactiveResponse.fromJson(Map<String, dynamic> json) => _$SubscriptionInactiveResponseFromJson(json);

/// const: "INACTIVE"
@override final  String status;

/// Create a copy of SubscriptionInactiveResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionInactiveResponseCopyWith<_SubscriptionInactiveResponse> get copyWith => __$SubscriptionInactiveResponseCopyWithImpl<_SubscriptionInactiveResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionInactiveResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionInactiveResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'SubscriptionInactiveResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionInactiveResponseCopyWith<$Res> implements $SubscriptionInactiveResponseCopyWith<$Res> {
  factory _$SubscriptionInactiveResponseCopyWith(_SubscriptionInactiveResponse value, $Res Function(_SubscriptionInactiveResponse) _then) = __$SubscriptionInactiveResponseCopyWithImpl;
@override @useResult
$Res call({
 String status
});




}
/// @nodoc
class __$SubscriptionInactiveResponseCopyWithImpl<$Res>
    implements _$SubscriptionInactiveResponseCopyWith<$Res> {
  __$SubscriptionInactiveResponseCopyWithImpl(this._self, this._then);

  final _SubscriptionInactiveResponse _self;
  final $Res Function(_SubscriptionInactiveResponse) _then;

/// Create a copy of SubscriptionInactiveResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_SubscriptionInactiveResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

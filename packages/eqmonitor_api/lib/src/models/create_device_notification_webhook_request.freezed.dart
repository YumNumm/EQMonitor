// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_device_notification_webhook_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateDeviceNotificationWebhookRequest {

/// Webhookの有効期限（日数）。nullまたは省略時は無期限
@JsonKey(includeIfNull: false) int? get expiresInDays;
/// Create a copy of CreateDeviceNotificationWebhookRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateDeviceNotificationWebhookRequestCopyWith<CreateDeviceNotificationWebhookRequest> get copyWith => _$CreateDeviceNotificationWebhookRequestCopyWithImpl<CreateDeviceNotificationWebhookRequest>(this as CreateDeviceNotificationWebhookRequest, _$identity);

  /// Serializes this CreateDeviceNotificationWebhookRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateDeviceNotificationWebhookRequest&&(identical(other.expiresInDays, expiresInDays) || other.expiresInDays == expiresInDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiresInDays);

@override
String toString() {
  return 'CreateDeviceNotificationWebhookRequest(expiresInDays: $expiresInDays)';
}


}

/// @nodoc
abstract mixin class $CreateDeviceNotificationWebhookRequestCopyWith<$Res>  {
  factory $CreateDeviceNotificationWebhookRequestCopyWith(CreateDeviceNotificationWebhookRequest value, $Res Function(CreateDeviceNotificationWebhookRequest) _then) = _$CreateDeviceNotificationWebhookRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) int? expiresInDays
});




}
/// @nodoc
class _$CreateDeviceNotificationWebhookRequestCopyWithImpl<$Res>
    implements $CreateDeviceNotificationWebhookRequestCopyWith<$Res> {
  _$CreateDeviceNotificationWebhookRequestCopyWithImpl(this._self, this._then);

  final CreateDeviceNotificationWebhookRequest _self;
  final $Res Function(CreateDeviceNotificationWebhookRequest) _then;

/// Create a copy of CreateDeviceNotificationWebhookRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expiresInDays = freezed,}) {
  return _then(CreateDeviceNotificationWebhookRequest(
expiresInDays: freezed == expiresInDays ? _self.expiresInDays : expiresInDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateDeviceNotificationWebhookRequest].
extension CreateDeviceNotificationWebhookRequestPatterns on CreateDeviceNotificationWebhookRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateDeviceNotificationWebhookRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateDeviceNotificationWebhookRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateDeviceNotificationWebhookRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateDeviceNotificationWebhookRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateDeviceNotificationWebhookRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateDeviceNotificationWebhookRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? expiresInDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateDeviceNotificationWebhookRequest() when $default != null:
return $default(_that.expiresInDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? expiresInDays)  $default,) {final _that = this;
switch (_that) {
case _CreateDeviceNotificationWebhookRequest():
return $default(_that.expiresInDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  int? expiresInDays)?  $default,) {final _that = this;
switch (_that) {
case _CreateDeviceNotificationWebhookRequest() when $default != null:
return $default(_that.expiresInDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateDeviceNotificationWebhookRequest implements CreateDeviceNotificationWebhookRequest {
  const _CreateDeviceNotificationWebhookRequest({@JsonKey(includeIfNull: false) this.expiresInDays});
  factory _CreateDeviceNotificationWebhookRequest.fromJson(Map<String, dynamic> json) => _$CreateDeviceNotificationWebhookRequestFromJson(json);

/// Webhookの有効期限（日数）。nullまたは省略時は無期限
@override@JsonKey(includeIfNull: false) final  int? expiresInDays;

/// Create a copy of CreateDeviceNotificationWebhookRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateDeviceNotificationWebhookRequestCopyWith<_CreateDeviceNotificationWebhookRequest> get copyWith => __$CreateDeviceNotificationWebhookRequestCopyWithImpl<_CreateDeviceNotificationWebhookRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateDeviceNotificationWebhookRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateDeviceNotificationWebhookRequest&&(identical(other.expiresInDays, expiresInDays) || other.expiresInDays == expiresInDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiresInDays);

@override
String toString() {
  return 'CreateDeviceNotificationWebhookRequest(expiresInDays: $expiresInDays)';
}


}

/// @nodoc
abstract mixin class _$CreateDeviceNotificationWebhookRequestCopyWith<$Res> implements $CreateDeviceNotificationWebhookRequestCopyWith<$Res> {
  factory _$CreateDeviceNotificationWebhookRequestCopyWith(_CreateDeviceNotificationWebhookRequest value, $Res Function(_CreateDeviceNotificationWebhookRequest) _then) = __$CreateDeviceNotificationWebhookRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) int? expiresInDays
});




}
/// @nodoc
class __$CreateDeviceNotificationWebhookRequestCopyWithImpl<$Res>
    implements _$CreateDeviceNotificationWebhookRequestCopyWith<$Res> {
  __$CreateDeviceNotificationWebhookRequestCopyWithImpl(this._self, this._then);

  final _CreateDeviceNotificationWebhookRequest _self;
  final $Res Function(_CreateDeviceNotificationWebhookRequest) _then;

/// Create a copy of CreateDeviceNotificationWebhookRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expiresInDays = freezed,}) {
  return _then(_CreateDeviceNotificationWebhookRequest(
expiresInDays: freezed == expiresInDays ? _self.expiresInDays : expiresInDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on

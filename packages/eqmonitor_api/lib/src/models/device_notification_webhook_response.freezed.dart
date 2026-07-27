// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_notification_webhook_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceNotificationWebhookResponse {

 String get id; DateTime get createdAt;@JsonKey(includeIfNull: true) DateTime? get expiresAt; bool get approved;@JsonKey(includeIfNull: true) String? get webhookUrl;
/// Create a copy of DeviceNotificationWebhookResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceNotificationWebhookResponseCopyWith<DeviceNotificationWebhookResponse> get copyWith => _$DeviceNotificationWebhookResponseCopyWithImpl<DeviceNotificationWebhookResponse>(this as DeviceNotificationWebhookResponse, _$identity);

  /// Serializes this DeviceNotificationWebhookResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceNotificationWebhookResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.webhookUrl, webhookUrl) || other.webhookUrl == webhookUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,expiresAt,approved,webhookUrl);

@override
String toString() {
  return 'DeviceNotificationWebhookResponse(id: $id, createdAt: $createdAt, expiresAt: $expiresAt, approved: $approved, webhookUrl: $webhookUrl)';
}


}

/// @nodoc
abstract mixin class $DeviceNotificationWebhookResponseCopyWith<$Res>  {
  factory $DeviceNotificationWebhookResponseCopyWith(DeviceNotificationWebhookResponse value, $Res Function(DeviceNotificationWebhookResponse) _then) = _$DeviceNotificationWebhookResponseCopyWithImpl;
@useResult
$Res call({
 String id, DateTime createdAt,@JsonKey(includeIfNull: true) DateTime? expiresAt, bool approved,@JsonKey(includeIfNull: true) String? webhookUrl
});




}
/// @nodoc
class _$DeviceNotificationWebhookResponseCopyWithImpl<$Res>
    implements $DeviceNotificationWebhookResponseCopyWith<$Res> {
  _$DeviceNotificationWebhookResponseCopyWithImpl(this._self, this._then);

  final DeviceNotificationWebhookResponse _self;
  final $Res Function(DeviceNotificationWebhookResponse) _then;

/// Create a copy of DeviceNotificationWebhookResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? expiresAt = freezed,Object? approved = null,Object? webhookUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as bool,webhookUrl: freezed == webhookUrl ? _self.webhookUrl : webhookUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceNotificationWebhookResponse].
extension DeviceNotificationWebhookResponsePatterns on DeviceNotificationWebhookResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceNotificationWebhookResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceNotificationWebhookResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceNotificationWebhookResponse value)  $default,){
final _that = this;
switch (_that) {
case _DeviceNotificationWebhookResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceNotificationWebhookResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceNotificationWebhookResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime createdAt, @JsonKey(includeIfNull: true)  DateTime? expiresAt,  bool approved, @JsonKey(includeIfNull: true)  String? webhookUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceNotificationWebhookResponse() when $default != null:
return $default(_that.id,_that.createdAt,_that.expiresAt,_that.approved,_that.webhookUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime createdAt, @JsonKey(includeIfNull: true)  DateTime? expiresAt,  bool approved, @JsonKey(includeIfNull: true)  String? webhookUrl)  $default,) {final _that = this;
switch (_that) {
case _DeviceNotificationWebhookResponse():
return $default(_that.id,_that.createdAt,_that.expiresAt,_that.approved,_that.webhookUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime createdAt, @JsonKey(includeIfNull: true)  DateTime? expiresAt,  bool approved, @JsonKey(includeIfNull: true)  String? webhookUrl)?  $default,) {final _that = this;
switch (_that) {
case _DeviceNotificationWebhookResponse() when $default != null:
return $default(_that.id,_that.createdAt,_that.expiresAt,_that.approved,_that.webhookUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceNotificationWebhookResponse implements DeviceNotificationWebhookResponse {
  const _DeviceNotificationWebhookResponse({required this.id, required this.createdAt, @JsonKey(includeIfNull: true) required this.expiresAt, required this.approved, @JsonKey(includeIfNull: true) required this.webhookUrl});
  factory _DeviceNotificationWebhookResponse.fromJson(Map<String, dynamic> json) => _$DeviceNotificationWebhookResponseFromJson(json);

@override final  String id;
@override final  DateTime createdAt;
@override@JsonKey(includeIfNull: true) final  DateTime? expiresAt;
@override final  bool approved;
@override@JsonKey(includeIfNull: true) final  String? webhookUrl;

/// Create a copy of DeviceNotificationWebhookResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceNotificationWebhookResponseCopyWith<_DeviceNotificationWebhookResponse> get copyWith => __$DeviceNotificationWebhookResponseCopyWithImpl<_DeviceNotificationWebhookResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceNotificationWebhookResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceNotificationWebhookResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.webhookUrl, webhookUrl) || other.webhookUrl == webhookUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,expiresAt,approved,webhookUrl);

@override
String toString() {
  return 'DeviceNotificationWebhookResponse(id: $id, createdAt: $createdAt, expiresAt: $expiresAt, approved: $approved, webhookUrl: $webhookUrl)';
}


}

/// @nodoc
abstract mixin class _$DeviceNotificationWebhookResponseCopyWith<$Res> implements $DeviceNotificationWebhookResponseCopyWith<$Res> {
  factory _$DeviceNotificationWebhookResponseCopyWith(_DeviceNotificationWebhookResponse value, $Res Function(_DeviceNotificationWebhookResponse) _then) = __$DeviceNotificationWebhookResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime createdAt,@JsonKey(includeIfNull: true) DateTime? expiresAt, bool approved,@JsonKey(includeIfNull: true) String? webhookUrl
});




}
/// @nodoc
class __$DeviceNotificationWebhookResponseCopyWithImpl<$Res>
    implements _$DeviceNotificationWebhookResponseCopyWith<$Res> {
  __$DeviceNotificationWebhookResponseCopyWithImpl(this._self, this._then);

  final _DeviceNotificationWebhookResponse _self;
  final $Res Function(_DeviceNotificationWebhookResponse) _then;

/// Create a copy of DeviceNotificationWebhookResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? expiresAt = freezed,Object? approved = null,Object? webhookUrl = freezed,}) {
  return _then(_DeviceNotificationWebhookResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as bool,webhookUrl: freezed == webhookUrl ? _self.webhookUrl : webhookUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

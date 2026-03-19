// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_log_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationLogItem {

@JsonKey(name: 'stream_id') String get streamId;@JsonKey(name: 'device_id') String get deviceId; NotificationLogItemFramework get framework; NotificationLogItemResult get result;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(includeIfNull: false, name: 'error_code') String? get errorCode;@JsonKey(includeIfNull: false, name: 'error_message') String? get errorMessage;@JsonKey(includeIfNull: false, name: 'event_id') String? get eventId;@JsonKey(includeIfNull: false) String? get title;@JsonKey(includeIfNull: false) String? get body;@JsonKey(includeIfNull: false, name: 'android_priority') String? get androidPriority;@JsonKey(includeIfNull: false, name: 'android_notification_priority') String? get androidNotificationPriority;@JsonKey(includeIfNull: false, name: 'channel_id') String? get channelId;@JsonKey(includeIfNull: false, name: 'apns_priority') String? get apnsPriority;@JsonKey(includeIfNull: false, name: 'interruption_level') String? get interruptionLevel;
/// Create a copy of NotificationLogItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationLogItemCopyWith<NotificationLogItem> get copyWith => _$NotificationLogItemCopyWithImpl<NotificationLogItem>(this as NotificationLogItem, _$identity);

  /// Serializes this NotificationLogItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationLogItem&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.framework, framework) || other.framework == framework)&&(identical(other.result, result) || other.result == result)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.androidPriority, androidPriority) || other.androidPriority == androidPriority)&&(identical(other.androidNotificationPriority, androidNotificationPriority) || other.androidNotificationPriority == androidNotificationPriority)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.apnsPriority, apnsPriority) || other.apnsPriority == apnsPriority)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streamId,deviceId,framework,result,createdAt,errorCode,errorMessage,eventId,title,body,androidPriority,androidNotificationPriority,channelId,apnsPriority,interruptionLevel);

@override
String toString() {
  return 'NotificationLogItem(streamId: $streamId, deviceId: $deviceId, framework: $framework, result: $result, createdAt: $createdAt, errorCode: $errorCode, errorMessage: $errorMessage, eventId: $eventId, title: $title, body: $body, androidPriority: $androidPriority, androidNotificationPriority: $androidNotificationPriority, channelId: $channelId, apnsPriority: $apnsPriority, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class $NotificationLogItemCopyWith<$Res>  {
  factory $NotificationLogItemCopyWith(NotificationLogItem value, $Res Function(NotificationLogItem) _then) = _$NotificationLogItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'stream_id') String streamId,@JsonKey(name: 'device_id') String deviceId, NotificationLogItemFramework framework, NotificationLogItemResult result,@JsonKey(name: 'created_at') String createdAt,@JsonKey(includeIfNull: false, name: 'error_code') String? errorCode,@JsonKey(includeIfNull: false, name: 'error_message') String? errorMessage,@JsonKey(includeIfNull: false, name: 'event_id') String? eventId,@JsonKey(includeIfNull: false) String? title,@JsonKey(includeIfNull: false) String? body,@JsonKey(includeIfNull: false, name: 'android_priority') String? androidPriority,@JsonKey(includeIfNull: false, name: 'android_notification_priority') String? androidNotificationPriority,@JsonKey(includeIfNull: false, name: 'channel_id') String? channelId,@JsonKey(includeIfNull: false, name: 'apns_priority') String? apnsPriority,@JsonKey(includeIfNull: false, name: 'interruption_level') String? interruptionLevel
});




}
/// @nodoc
class _$NotificationLogItemCopyWithImpl<$Res>
    implements $NotificationLogItemCopyWith<$Res> {
  _$NotificationLogItemCopyWithImpl(this._self, this._then);

  final NotificationLogItem _self;
  final $Res Function(NotificationLogItem) _then;

/// Create a copy of NotificationLogItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streamId = null,Object? deviceId = null,Object? framework = null,Object? result = null,Object? createdAt = null,Object? errorCode = freezed,Object? errorMessage = freezed,Object? eventId = freezed,Object? title = freezed,Object? body = freezed,Object? androidPriority = freezed,Object? androidNotificationPriority = freezed,Object? channelId = freezed,Object? apnsPriority = freezed,Object? interruptionLevel = freezed,}) {
  return _then(_self.copyWith(
streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,framework: null == framework ? _self.framework : framework // ignore: cast_nullable_to_non_nullable
as NotificationLogItemFramework,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as NotificationLogItemResult,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,androidPriority: freezed == androidPriority ? _self.androidPriority : androidPriority // ignore: cast_nullable_to_non_nullable
as String?,androidNotificationPriority: freezed == androidNotificationPriority ? _self.androidNotificationPriority : androidNotificationPriority // ignore: cast_nullable_to_non_nullable
as String?,channelId: freezed == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String?,apnsPriority: freezed == apnsPriority ? _self.apnsPriority : apnsPriority // ignore: cast_nullable_to_non_nullable
as String?,interruptionLevel: freezed == interruptionLevel ? _self.interruptionLevel : interruptionLevel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationLogItem].
extension NotificationLogItemPatterns on NotificationLogItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationLogItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationLogItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationLogItem value)  $default,){
final _that = this;
switch (_that) {
case _NotificationLogItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationLogItem value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationLogItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'stream_id')  String streamId, @JsonKey(name: 'device_id')  String deviceId,  NotificationLogItemFramework framework,  NotificationLogItemResult result, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(includeIfNull: false, name: 'error_code')  String? errorCode, @JsonKey(includeIfNull: false, name: 'error_message')  String? errorMessage, @JsonKey(includeIfNull: false, name: 'event_id')  String? eventId, @JsonKey(includeIfNull: false)  String? title, @JsonKey(includeIfNull: false)  String? body, @JsonKey(includeIfNull: false, name: 'android_priority')  String? androidPriority, @JsonKey(includeIfNull: false, name: 'android_notification_priority')  String? androidNotificationPriority, @JsonKey(includeIfNull: false, name: 'channel_id')  String? channelId, @JsonKey(includeIfNull: false, name: 'apns_priority')  String? apnsPriority, @JsonKey(includeIfNull: false, name: 'interruption_level')  String? interruptionLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationLogItem() when $default != null:
return $default(_that.streamId,_that.deviceId,_that.framework,_that.result,_that.createdAt,_that.errorCode,_that.errorMessage,_that.eventId,_that.title,_that.body,_that.androidPriority,_that.androidNotificationPriority,_that.channelId,_that.apnsPriority,_that.interruptionLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'stream_id')  String streamId, @JsonKey(name: 'device_id')  String deviceId,  NotificationLogItemFramework framework,  NotificationLogItemResult result, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(includeIfNull: false, name: 'error_code')  String? errorCode, @JsonKey(includeIfNull: false, name: 'error_message')  String? errorMessage, @JsonKey(includeIfNull: false, name: 'event_id')  String? eventId, @JsonKey(includeIfNull: false)  String? title, @JsonKey(includeIfNull: false)  String? body, @JsonKey(includeIfNull: false, name: 'android_priority')  String? androidPriority, @JsonKey(includeIfNull: false, name: 'android_notification_priority')  String? androidNotificationPriority, @JsonKey(includeIfNull: false, name: 'channel_id')  String? channelId, @JsonKey(includeIfNull: false, name: 'apns_priority')  String? apnsPriority, @JsonKey(includeIfNull: false, name: 'interruption_level')  String? interruptionLevel)  $default,) {final _that = this;
switch (_that) {
case _NotificationLogItem():
return $default(_that.streamId,_that.deviceId,_that.framework,_that.result,_that.createdAt,_that.errorCode,_that.errorMessage,_that.eventId,_that.title,_that.body,_that.androidPriority,_that.androidNotificationPriority,_that.channelId,_that.apnsPriority,_that.interruptionLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'stream_id')  String streamId, @JsonKey(name: 'device_id')  String deviceId,  NotificationLogItemFramework framework,  NotificationLogItemResult result, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(includeIfNull: false, name: 'error_code')  String? errorCode, @JsonKey(includeIfNull: false, name: 'error_message')  String? errorMessage, @JsonKey(includeIfNull: false, name: 'event_id')  String? eventId, @JsonKey(includeIfNull: false)  String? title, @JsonKey(includeIfNull: false)  String? body, @JsonKey(includeIfNull: false, name: 'android_priority')  String? androidPriority, @JsonKey(includeIfNull: false, name: 'android_notification_priority')  String? androidNotificationPriority, @JsonKey(includeIfNull: false, name: 'channel_id')  String? channelId, @JsonKey(includeIfNull: false, name: 'apns_priority')  String? apnsPriority, @JsonKey(includeIfNull: false, name: 'interruption_level')  String? interruptionLevel)?  $default,) {final _that = this;
switch (_that) {
case _NotificationLogItem() when $default != null:
return $default(_that.streamId,_that.deviceId,_that.framework,_that.result,_that.createdAt,_that.errorCode,_that.errorMessage,_that.eventId,_that.title,_that.body,_that.androidPriority,_that.androidNotificationPriority,_that.channelId,_that.apnsPriority,_that.interruptionLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationLogItem implements NotificationLogItem {
  const _NotificationLogItem({@JsonKey(name: 'stream_id') required this.streamId, @JsonKey(name: 'device_id') required this.deviceId, required this.framework, required this.result, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(includeIfNull: false, name: 'error_code') this.errorCode, @JsonKey(includeIfNull: false, name: 'error_message') this.errorMessage, @JsonKey(includeIfNull: false, name: 'event_id') this.eventId, @JsonKey(includeIfNull: false) this.title, @JsonKey(includeIfNull: false) this.body, @JsonKey(includeIfNull: false, name: 'android_priority') this.androidPriority, @JsonKey(includeIfNull: false, name: 'android_notification_priority') this.androidNotificationPriority, @JsonKey(includeIfNull: false, name: 'channel_id') this.channelId, @JsonKey(includeIfNull: false, name: 'apns_priority') this.apnsPriority, @JsonKey(includeIfNull: false, name: 'interruption_level') this.interruptionLevel});
  factory _NotificationLogItem.fromJson(Map<String, dynamic> json) => _$NotificationLogItemFromJson(json);

@override@JsonKey(name: 'stream_id') final  String streamId;
@override@JsonKey(name: 'device_id') final  String deviceId;
@override final  NotificationLogItemFramework framework;
@override final  NotificationLogItemResult result;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(includeIfNull: false, name: 'error_code') final  String? errorCode;
@override@JsonKey(includeIfNull: false, name: 'error_message') final  String? errorMessage;
@override@JsonKey(includeIfNull: false, name: 'event_id') final  String? eventId;
@override@JsonKey(includeIfNull: false) final  String? title;
@override@JsonKey(includeIfNull: false) final  String? body;
@override@JsonKey(includeIfNull: false, name: 'android_priority') final  String? androidPriority;
@override@JsonKey(includeIfNull: false, name: 'android_notification_priority') final  String? androidNotificationPriority;
@override@JsonKey(includeIfNull: false, name: 'channel_id') final  String? channelId;
@override@JsonKey(includeIfNull: false, name: 'apns_priority') final  String? apnsPriority;
@override@JsonKey(includeIfNull: false, name: 'interruption_level') final  String? interruptionLevel;

/// Create a copy of NotificationLogItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationLogItemCopyWith<_NotificationLogItem> get copyWith => __$NotificationLogItemCopyWithImpl<_NotificationLogItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationLogItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationLogItem&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.framework, framework) || other.framework == framework)&&(identical(other.result, result) || other.result == result)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.androidPriority, androidPriority) || other.androidPriority == androidPriority)&&(identical(other.androidNotificationPriority, androidNotificationPriority) || other.androidNotificationPriority == androidNotificationPriority)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.apnsPriority, apnsPriority) || other.apnsPriority == apnsPriority)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streamId,deviceId,framework,result,createdAt,errorCode,errorMessage,eventId,title,body,androidPriority,androidNotificationPriority,channelId,apnsPriority,interruptionLevel);

@override
String toString() {
  return 'NotificationLogItem(streamId: $streamId, deviceId: $deviceId, framework: $framework, result: $result, createdAt: $createdAt, errorCode: $errorCode, errorMessage: $errorMessage, eventId: $eventId, title: $title, body: $body, androidPriority: $androidPriority, androidNotificationPriority: $androidNotificationPriority, channelId: $channelId, apnsPriority: $apnsPriority, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class _$NotificationLogItemCopyWith<$Res> implements $NotificationLogItemCopyWith<$Res> {
  factory _$NotificationLogItemCopyWith(_NotificationLogItem value, $Res Function(_NotificationLogItem) _then) = __$NotificationLogItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'stream_id') String streamId,@JsonKey(name: 'device_id') String deviceId, NotificationLogItemFramework framework, NotificationLogItemResult result,@JsonKey(name: 'created_at') String createdAt,@JsonKey(includeIfNull: false, name: 'error_code') String? errorCode,@JsonKey(includeIfNull: false, name: 'error_message') String? errorMessage,@JsonKey(includeIfNull: false, name: 'event_id') String? eventId,@JsonKey(includeIfNull: false) String? title,@JsonKey(includeIfNull: false) String? body,@JsonKey(includeIfNull: false, name: 'android_priority') String? androidPriority,@JsonKey(includeIfNull: false, name: 'android_notification_priority') String? androidNotificationPriority,@JsonKey(includeIfNull: false, name: 'channel_id') String? channelId,@JsonKey(includeIfNull: false, name: 'apns_priority') String? apnsPriority,@JsonKey(includeIfNull: false, name: 'interruption_level') String? interruptionLevel
});




}
/// @nodoc
class __$NotificationLogItemCopyWithImpl<$Res>
    implements _$NotificationLogItemCopyWith<$Res> {
  __$NotificationLogItemCopyWithImpl(this._self, this._then);

  final _NotificationLogItem _self;
  final $Res Function(_NotificationLogItem) _then;

/// Create a copy of NotificationLogItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? streamId = null,Object? deviceId = null,Object? framework = null,Object? result = null,Object? createdAt = null,Object? errorCode = freezed,Object? errorMessage = freezed,Object? eventId = freezed,Object? title = freezed,Object? body = freezed,Object? androidPriority = freezed,Object? androidNotificationPriority = freezed,Object? channelId = freezed,Object? apnsPriority = freezed,Object? interruptionLevel = freezed,}) {
  return _then(_NotificationLogItem(
streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,framework: null == framework ? _self.framework : framework // ignore: cast_nullable_to_non_nullable
as NotificationLogItemFramework,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as NotificationLogItemResult,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,androidPriority: freezed == androidPriority ? _self.androidPriority : androidPriority // ignore: cast_nullable_to_non_nullable
as String?,androidNotificationPriority: freezed == androidNotificationPriority ? _self.androidNotificationPriority : androidNotificationPriority // ignore: cast_nullable_to_non_nullable
as String?,channelId: freezed == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String?,apnsPriority: freezed == apnsPriority ? _self.apnsPriority : apnsPriority // ignore: cast_nullable_to_non_nullable
as String?,interruptionLevel: freezed == interruptionLevel ? _self.interruptionLevel : interruptionLevel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

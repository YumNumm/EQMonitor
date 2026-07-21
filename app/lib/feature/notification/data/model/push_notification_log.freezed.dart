// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_notification_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PushNotificationHistory {

 List<PushNotificationLogEntry> get items; String? get nextCursor;
/// Create a copy of PushNotificationHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushNotificationHistoryCopyWith<PushNotificationHistory> get copyWith => _$PushNotificationHistoryCopyWithImpl<PushNotificationHistory>(this as PushNotificationHistory, _$identity);

  /// Serializes this PushNotificationHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushNotificationHistory&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextCursor);

@override
String toString() {
  return 'PushNotificationHistory(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class $PushNotificationHistoryCopyWith<$Res>  {
  factory $PushNotificationHistoryCopyWith(PushNotificationHistory value, $Res Function(PushNotificationHistory) _then) = _$PushNotificationHistoryCopyWithImpl;
@useResult
$Res call({
 List<PushNotificationLogEntry> items, String? nextCursor
});




}
/// @nodoc
class _$PushNotificationHistoryCopyWithImpl<$Res>
    implements $PushNotificationHistoryCopyWith<$Res> {
  _$PushNotificationHistoryCopyWithImpl(this._self, this._then);

  final PushNotificationHistory _self;
  final $Res Function(PushNotificationHistory) _then;

/// Create a copy of PushNotificationHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PushNotificationLogEntry>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PushNotificationHistory].
extension PushNotificationHistoryPatterns on PushNotificationHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushNotificationHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushNotificationHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushNotificationHistory value)  $default,){
final _that = this;
switch (_that) {
case _PushNotificationHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushNotificationHistory value)?  $default,){
final _that = this;
switch (_that) {
case _PushNotificationHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PushNotificationLogEntry> items,  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushNotificationHistory() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PushNotificationLogEntry> items,  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _PushNotificationHistory():
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PushNotificationLogEntry> items,  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _PushNotificationHistory() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PushNotificationHistory implements PushNotificationHistory {
  const _PushNotificationHistory({required final  List<PushNotificationLogEntry> items, this.nextCursor}): _items = items;
  factory _PushNotificationHistory.fromJson(Map<String, dynamic> json) => _$PushNotificationHistoryFromJson(json);

 final  List<PushNotificationLogEntry> _items;
@override List<PushNotificationLogEntry> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;

/// Create a copy of PushNotificationHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushNotificationHistoryCopyWith<_PushNotificationHistory> get copyWith => __$PushNotificationHistoryCopyWithImpl<_PushNotificationHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PushNotificationHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushNotificationHistory&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor);

@override
String toString() {
  return 'PushNotificationHistory(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$PushNotificationHistoryCopyWith<$Res> implements $PushNotificationHistoryCopyWith<$Res> {
  factory _$PushNotificationHistoryCopyWith(_PushNotificationHistory value, $Res Function(_PushNotificationHistory) _then) = __$PushNotificationHistoryCopyWithImpl;
@override @useResult
$Res call({
 List<PushNotificationLogEntry> items, String? nextCursor
});




}
/// @nodoc
class __$PushNotificationHistoryCopyWithImpl<$Res>
    implements _$PushNotificationHistoryCopyWith<$Res> {
  __$PushNotificationHistoryCopyWithImpl(this._self, this._then);

  final _PushNotificationHistory _self;
  final $Res Function(_PushNotificationHistory) _then;

/// Create a copy of PushNotificationHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_PushNotificationHistory(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PushNotificationLogEntry>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PushNotificationLogEntry {

 String get streamId; String get deviceId; PushNotificationDeliveryFramework get framework; PushNotificationDeliveryResult get result; String get createdAtIso; String? get errorCode; String? get errorMessage; String? get eventId; String? get title; String? get body; String? get androidPriority; String? get androidNotificationPriority; String? get channelId; String? get apnsPriority; String? get interruptionLevel;
/// Create a copy of PushNotificationLogEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushNotificationLogEntryCopyWith<PushNotificationLogEntry> get copyWith => _$PushNotificationLogEntryCopyWithImpl<PushNotificationLogEntry>(this as PushNotificationLogEntry, _$identity);

  /// Serializes this PushNotificationLogEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushNotificationLogEntry&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.framework, framework) || other.framework == framework)&&(identical(other.result, result) || other.result == result)&&(identical(other.createdAtIso, createdAtIso) || other.createdAtIso == createdAtIso)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.androidPriority, androidPriority) || other.androidPriority == androidPriority)&&(identical(other.androidNotificationPriority, androidNotificationPriority) || other.androidNotificationPriority == androidNotificationPriority)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.apnsPriority, apnsPriority) || other.apnsPriority == apnsPriority)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streamId,deviceId,framework,result,createdAtIso,errorCode,errorMessage,eventId,title,body,androidPriority,androidNotificationPriority,channelId,apnsPriority,interruptionLevel);

@override
String toString() {
  return 'PushNotificationLogEntry(streamId: $streamId, deviceId: $deviceId, framework: $framework, result: $result, createdAtIso: $createdAtIso, errorCode: $errorCode, errorMessage: $errorMessage, eventId: $eventId, title: $title, body: $body, androidPriority: $androidPriority, androidNotificationPriority: $androidNotificationPriority, channelId: $channelId, apnsPriority: $apnsPriority, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class $PushNotificationLogEntryCopyWith<$Res>  {
  factory $PushNotificationLogEntryCopyWith(PushNotificationLogEntry value, $Res Function(PushNotificationLogEntry) _then) = _$PushNotificationLogEntryCopyWithImpl;
@useResult
$Res call({
 String streamId, String deviceId, PushNotificationDeliveryFramework framework, PushNotificationDeliveryResult result, String createdAtIso, String? errorCode, String? errorMessage, String? eventId, String? title, String? body, String? androidPriority, String? androidNotificationPriority, String? channelId, String? apnsPriority, String? interruptionLevel
});




}
/// @nodoc
class _$PushNotificationLogEntryCopyWithImpl<$Res>
    implements $PushNotificationLogEntryCopyWith<$Res> {
  _$PushNotificationLogEntryCopyWithImpl(this._self, this._then);

  final PushNotificationLogEntry _self;
  final $Res Function(PushNotificationLogEntry) _then;

/// Create a copy of PushNotificationLogEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streamId = null,Object? deviceId = null,Object? framework = null,Object? result = null,Object? createdAtIso = null,Object? errorCode = freezed,Object? errorMessage = freezed,Object? eventId = freezed,Object? title = freezed,Object? body = freezed,Object? androidPriority = freezed,Object? androidNotificationPriority = freezed,Object? channelId = freezed,Object? apnsPriority = freezed,Object? interruptionLevel = freezed,}) {
  return _then(_self.copyWith(
streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,framework: null == framework ? _self.framework : framework // ignore: cast_nullable_to_non_nullable
as PushNotificationDeliveryFramework,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as PushNotificationDeliveryResult,createdAtIso: null == createdAtIso ? _self.createdAtIso : createdAtIso // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [PushNotificationLogEntry].
extension PushNotificationLogEntryPatterns on PushNotificationLogEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushNotificationLogEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushNotificationLogEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushNotificationLogEntry value)  $default,){
final _that = this;
switch (_that) {
case _PushNotificationLogEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushNotificationLogEntry value)?  $default,){
final _that = this;
switch (_that) {
case _PushNotificationLogEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String streamId,  String deviceId,  PushNotificationDeliveryFramework framework,  PushNotificationDeliveryResult result,  String createdAtIso,  String? errorCode,  String? errorMessage,  String? eventId,  String? title,  String? body,  String? androidPriority,  String? androidNotificationPriority,  String? channelId,  String? apnsPriority,  String? interruptionLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushNotificationLogEntry() when $default != null:
return $default(_that.streamId,_that.deviceId,_that.framework,_that.result,_that.createdAtIso,_that.errorCode,_that.errorMessage,_that.eventId,_that.title,_that.body,_that.androidPriority,_that.androidNotificationPriority,_that.channelId,_that.apnsPriority,_that.interruptionLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String streamId,  String deviceId,  PushNotificationDeliveryFramework framework,  PushNotificationDeliveryResult result,  String createdAtIso,  String? errorCode,  String? errorMessage,  String? eventId,  String? title,  String? body,  String? androidPriority,  String? androidNotificationPriority,  String? channelId,  String? apnsPriority,  String? interruptionLevel)  $default,) {final _that = this;
switch (_that) {
case _PushNotificationLogEntry():
return $default(_that.streamId,_that.deviceId,_that.framework,_that.result,_that.createdAtIso,_that.errorCode,_that.errorMessage,_that.eventId,_that.title,_that.body,_that.androidPriority,_that.androidNotificationPriority,_that.channelId,_that.apnsPriority,_that.interruptionLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String streamId,  String deviceId,  PushNotificationDeliveryFramework framework,  PushNotificationDeliveryResult result,  String createdAtIso,  String? errorCode,  String? errorMessage,  String? eventId,  String? title,  String? body,  String? androidPriority,  String? androidNotificationPriority,  String? channelId,  String? apnsPriority,  String? interruptionLevel)?  $default,) {final _that = this;
switch (_that) {
case _PushNotificationLogEntry() when $default != null:
return $default(_that.streamId,_that.deviceId,_that.framework,_that.result,_that.createdAtIso,_that.errorCode,_that.errorMessage,_that.eventId,_that.title,_that.body,_that.androidPriority,_that.androidNotificationPriority,_that.channelId,_that.apnsPriority,_that.interruptionLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PushNotificationLogEntry implements PushNotificationLogEntry {
  const _PushNotificationLogEntry({required this.streamId, required this.deviceId, required this.framework, required this.result, required this.createdAtIso, this.errorCode, this.errorMessage, this.eventId, this.title, this.body, this.androidPriority, this.androidNotificationPriority, this.channelId, this.apnsPriority, this.interruptionLevel});
  factory _PushNotificationLogEntry.fromJson(Map<String, dynamic> json) => _$PushNotificationLogEntryFromJson(json);

@override final  String streamId;
@override final  String deviceId;
@override final  PushNotificationDeliveryFramework framework;
@override final  PushNotificationDeliveryResult result;
@override final  String createdAtIso;
@override final  String? errorCode;
@override final  String? errorMessage;
@override final  String? eventId;
@override final  String? title;
@override final  String? body;
@override final  String? androidPriority;
@override final  String? androidNotificationPriority;
@override final  String? channelId;
@override final  String? apnsPriority;
@override final  String? interruptionLevel;

/// Create a copy of PushNotificationLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushNotificationLogEntryCopyWith<_PushNotificationLogEntry> get copyWith => __$PushNotificationLogEntryCopyWithImpl<_PushNotificationLogEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PushNotificationLogEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushNotificationLogEntry&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.framework, framework) || other.framework == framework)&&(identical(other.result, result) || other.result == result)&&(identical(other.createdAtIso, createdAtIso) || other.createdAtIso == createdAtIso)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.androidPriority, androidPriority) || other.androidPriority == androidPriority)&&(identical(other.androidNotificationPriority, androidNotificationPriority) || other.androidNotificationPriority == androidNotificationPriority)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.apnsPriority, apnsPriority) || other.apnsPriority == apnsPriority)&&(identical(other.interruptionLevel, interruptionLevel) || other.interruptionLevel == interruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streamId,deviceId,framework,result,createdAtIso,errorCode,errorMessage,eventId,title,body,androidPriority,androidNotificationPriority,channelId,apnsPriority,interruptionLevel);

@override
String toString() {
  return 'PushNotificationLogEntry(streamId: $streamId, deviceId: $deviceId, framework: $framework, result: $result, createdAtIso: $createdAtIso, errorCode: $errorCode, errorMessage: $errorMessage, eventId: $eventId, title: $title, body: $body, androidPriority: $androidPriority, androidNotificationPriority: $androidNotificationPriority, channelId: $channelId, apnsPriority: $apnsPriority, interruptionLevel: $interruptionLevel)';
}


}

/// @nodoc
abstract mixin class _$PushNotificationLogEntryCopyWith<$Res> implements $PushNotificationLogEntryCopyWith<$Res> {
  factory _$PushNotificationLogEntryCopyWith(_PushNotificationLogEntry value, $Res Function(_PushNotificationLogEntry) _then) = __$PushNotificationLogEntryCopyWithImpl;
@override @useResult
$Res call({
 String streamId, String deviceId, PushNotificationDeliveryFramework framework, PushNotificationDeliveryResult result, String createdAtIso, String? errorCode, String? errorMessage, String? eventId, String? title, String? body, String? androidPriority, String? androidNotificationPriority, String? channelId, String? apnsPriority, String? interruptionLevel
});




}
/// @nodoc
class __$PushNotificationLogEntryCopyWithImpl<$Res>
    implements _$PushNotificationLogEntryCopyWith<$Res> {
  __$PushNotificationLogEntryCopyWithImpl(this._self, this._then);

  final _PushNotificationLogEntry _self;
  final $Res Function(_PushNotificationLogEntry) _then;

/// Create a copy of PushNotificationLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? streamId = null,Object? deviceId = null,Object? framework = null,Object? result = null,Object? createdAtIso = null,Object? errorCode = freezed,Object? errorMessage = freezed,Object? eventId = freezed,Object? title = freezed,Object? body = freezed,Object? androidPriority = freezed,Object? androidNotificationPriority = freezed,Object? channelId = freezed,Object? apnsPriority = freezed,Object? interruptionLevel = freezed,}) {
  return _then(_PushNotificationLogEntry(
streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,framework: null == framework ? _self.framework : framework // ignore: cast_nullable_to_non_nullable
as PushNotificationDeliveryFramework,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as PushNotificationDeliveryResult,createdAtIso: null == createdAtIso ? _self.createdAtIso : createdAtIso // ignore: cast_nullable_to_non_nullable
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

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_activity_token_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveActivityTokenResponse {

@JsonKey(name: 'live_activity_id') String get liveActivityId;@JsonKey(name: 'event_id') String get eventId;@JsonKey(name: 'start_trigger') LiveActivityStartTrigger get startTrigger;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of LiveActivityTokenResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveActivityTokenResponseCopyWith<LiveActivityTokenResponse> get copyWith => _$LiveActivityTokenResponseCopyWithImpl<LiveActivityTokenResponse>(this as LiveActivityTokenResponse, _$identity);

  /// Serializes this LiveActivityTokenResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveActivityTokenResponse&&(identical(other.liveActivityId, liveActivityId) || other.liveActivityId == liveActivityId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.startTrigger, startTrigger) || other.startTrigger == startTrigger)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,liveActivityId,eventId,startTrigger,createdAt);

@override
String toString() {
  return 'LiveActivityTokenResponse(liveActivityId: $liveActivityId, eventId: $eventId, startTrigger: $startTrigger, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LiveActivityTokenResponseCopyWith<$Res>  {
  factory $LiveActivityTokenResponseCopyWith(LiveActivityTokenResponse value, $Res Function(LiveActivityTokenResponse) _then) = _$LiveActivityTokenResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'live_activity_id') String liveActivityId,@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'start_trigger') LiveActivityStartTrigger startTrigger,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$LiveActivityTokenResponseCopyWithImpl<$Res>
    implements $LiveActivityTokenResponseCopyWith<$Res> {
  _$LiveActivityTokenResponseCopyWithImpl(this._self, this._then);

  final LiveActivityTokenResponse _self;
  final $Res Function(LiveActivityTokenResponse) _then;

/// Create a copy of LiveActivityTokenResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? liveActivityId = null,Object? eventId = null,Object? startTrigger = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
liveActivityId: null == liveActivityId ? _self.liveActivityId : liveActivityId // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,startTrigger: null == startTrigger ? _self.startTrigger : startTrigger // ignore: cast_nullable_to_non_nullable
as LiveActivityStartTrigger,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveActivityTokenResponse].
extension LiveActivityTokenResponsePatterns on LiveActivityTokenResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveActivityTokenResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveActivityTokenResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveActivityTokenResponse value)  $default,){
final _that = this;
switch (_that) {
case _LiveActivityTokenResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveActivityTokenResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LiveActivityTokenResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'live_activity_id')  String liveActivityId, @JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'start_trigger')  LiveActivityStartTrigger startTrigger, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveActivityTokenResponse() when $default != null:
return $default(_that.liveActivityId,_that.eventId,_that.startTrigger,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'live_activity_id')  String liveActivityId, @JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'start_trigger')  LiveActivityStartTrigger startTrigger, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _LiveActivityTokenResponse():
return $default(_that.liveActivityId,_that.eventId,_that.startTrigger,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'live_activity_id')  String liveActivityId, @JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'start_trigger')  LiveActivityStartTrigger startTrigger, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LiveActivityTokenResponse() when $default != null:
return $default(_that.liveActivityId,_that.eventId,_that.startTrigger,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveActivityTokenResponse implements LiveActivityTokenResponse {
  const _LiveActivityTokenResponse({@JsonKey(name: 'live_activity_id') required this.liveActivityId, @JsonKey(name: 'event_id') required this.eventId, @JsonKey(name: 'start_trigger') required this.startTrigger, @JsonKey(name: 'created_at') required this.createdAt});
  factory _LiveActivityTokenResponse.fromJson(Map<String, dynamic> json) => _$LiveActivityTokenResponseFromJson(json);

@override@JsonKey(name: 'live_activity_id') final  String liveActivityId;
@override@JsonKey(name: 'event_id') final  String eventId;
@override@JsonKey(name: 'start_trigger') final  LiveActivityStartTrigger startTrigger;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of LiveActivityTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveActivityTokenResponseCopyWith<_LiveActivityTokenResponse> get copyWith => __$LiveActivityTokenResponseCopyWithImpl<_LiveActivityTokenResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveActivityTokenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveActivityTokenResponse&&(identical(other.liveActivityId, liveActivityId) || other.liveActivityId == liveActivityId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.startTrigger, startTrigger) || other.startTrigger == startTrigger)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,liveActivityId,eventId,startTrigger,createdAt);

@override
String toString() {
  return 'LiveActivityTokenResponse(liveActivityId: $liveActivityId, eventId: $eventId, startTrigger: $startTrigger, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LiveActivityTokenResponseCopyWith<$Res> implements $LiveActivityTokenResponseCopyWith<$Res> {
  factory _$LiveActivityTokenResponseCopyWith(_LiveActivityTokenResponse value, $Res Function(_LiveActivityTokenResponse) _then) = __$LiveActivityTokenResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'live_activity_id') String liveActivityId,@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'start_trigger') LiveActivityStartTrigger startTrigger,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$LiveActivityTokenResponseCopyWithImpl<$Res>
    implements _$LiveActivityTokenResponseCopyWith<$Res> {
  __$LiveActivityTokenResponseCopyWithImpl(this._self, this._then);

  final _LiveActivityTokenResponse _self;
  final $Res Function(_LiveActivityTokenResponse) _then;

/// Create a copy of LiveActivityTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? liveActivityId = null,Object? eventId = null,Object? startTrigger = null,Object? createdAt = null,}) {
  return _then(_LiveActivityTokenResponse(
liveActivityId: null == liveActivityId ? _self.liveActivityId : liveActivityId // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,startTrigger: null == startTrigger ? _self.startTrigger : startTrigger // ignore: cast_nullable_to_non_nullable
as LiveActivityStartTrigger,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

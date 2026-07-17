// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_live_activity_start_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestLiveActivityStartResponse {

@JsonKey(name: 'live_activity_id') String get liveActivityId;@JsonKey(name: 'event_id') String get eventId;@JsonKey(name: 'start_trigger') LiveActivityStartTrigger get startTrigger;
/// Create a copy of TestLiveActivityStartResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestLiveActivityStartResponseCopyWith<TestLiveActivityStartResponse> get copyWith => _$TestLiveActivityStartResponseCopyWithImpl<TestLiveActivityStartResponse>(this as TestLiveActivityStartResponse, _$identity);

  /// Serializes this TestLiveActivityStartResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestLiveActivityStartResponse&&(identical(other.liveActivityId, liveActivityId) || other.liveActivityId == liveActivityId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.startTrigger, startTrigger) || other.startTrigger == startTrigger));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,liveActivityId,eventId,startTrigger);

@override
String toString() {
  return 'TestLiveActivityStartResponse(liveActivityId: $liveActivityId, eventId: $eventId, startTrigger: $startTrigger)';
}


}

/// @nodoc
abstract mixin class $TestLiveActivityStartResponseCopyWith<$Res>  {
  factory $TestLiveActivityStartResponseCopyWith(TestLiveActivityStartResponse value, $Res Function(TestLiveActivityStartResponse) _then) = _$TestLiveActivityStartResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'live_activity_id') String liveActivityId,@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'start_trigger') LiveActivityStartTrigger startTrigger
});




}
/// @nodoc
class _$TestLiveActivityStartResponseCopyWithImpl<$Res>
    implements $TestLiveActivityStartResponseCopyWith<$Res> {
  _$TestLiveActivityStartResponseCopyWithImpl(this._self, this._then);

  final TestLiveActivityStartResponse _self;
  final $Res Function(TestLiveActivityStartResponse) _then;

/// Create a copy of TestLiveActivityStartResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? liveActivityId = null,Object? eventId = null,Object? startTrigger = null,}) {
  return _then(_self.copyWith(
liveActivityId: null == liveActivityId ? _self.liveActivityId : liveActivityId // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,startTrigger: null == startTrigger ? _self.startTrigger : startTrigger // ignore: cast_nullable_to_non_nullable
as LiveActivityStartTrigger,
  ));
}

}


/// Adds pattern-matching-related methods to [TestLiveActivityStartResponse].
extension TestLiveActivityStartResponsePatterns on TestLiveActivityStartResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestLiveActivityStartResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestLiveActivityStartResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestLiveActivityStartResponse value)  $default,){
final _that = this;
switch (_that) {
case _TestLiveActivityStartResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestLiveActivityStartResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TestLiveActivityStartResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'live_activity_id')  String liveActivityId, @JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'start_trigger')  LiveActivityStartTrigger startTrigger)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestLiveActivityStartResponse() when $default != null:
return $default(_that.liveActivityId,_that.eventId,_that.startTrigger);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'live_activity_id')  String liveActivityId, @JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'start_trigger')  LiveActivityStartTrigger startTrigger)  $default,) {final _that = this;
switch (_that) {
case _TestLiveActivityStartResponse():
return $default(_that.liveActivityId,_that.eventId,_that.startTrigger);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'live_activity_id')  String liveActivityId, @JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'start_trigger')  LiveActivityStartTrigger startTrigger)?  $default,) {final _that = this;
switch (_that) {
case _TestLiveActivityStartResponse() when $default != null:
return $default(_that.liveActivityId,_that.eventId,_that.startTrigger);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestLiveActivityStartResponse implements TestLiveActivityStartResponse {
  const _TestLiveActivityStartResponse({@JsonKey(name: 'live_activity_id') required this.liveActivityId, @JsonKey(name: 'event_id') required this.eventId, @JsonKey(name: 'start_trigger') required this.startTrigger});
  factory _TestLiveActivityStartResponse.fromJson(Map<String, dynamic> json) => _$TestLiveActivityStartResponseFromJson(json);

@override@JsonKey(name: 'live_activity_id') final  String liveActivityId;
@override@JsonKey(name: 'event_id') final  String eventId;
@override@JsonKey(name: 'start_trigger') final  LiveActivityStartTrigger startTrigger;

/// Create a copy of TestLiveActivityStartResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestLiveActivityStartResponseCopyWith<_TestLiveActivityStartResponse> get copyWith => __$TestLiveActivityStartResponseCopyWithImpl<_TestLiveActivityStartResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestLiveActivityStartResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestLiveActivityStartResponse&&(identical(other.liveActivityId, liveActivityId) || other.liveActivityId == liveActivityId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.startTrigger, startTrigger) || other.startTrigger == startTrigger));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,liveActivityId,eventId,startTrigger);

@override
String toString() {
  return 'TestLiveActivityStartResponse(liveActivityId: $liveActivityId, eventId: $eventId, startTrigger: $startTrigger)';
}


}

/// @nodoc
abstract mixin class _$TestLiveActivityStartResponseCopyWith<$Res> implements $TestLiveActivityStartResponseCopyWith<$Res> {
  factory _$TestLiveActivityStartResponseCopyWith(_TestLiveActivityStartResponse value, $Res Function(_TestLiveActivityStartResponse) _then) = __$TestLiveActivityStartResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'live_activity_id') String liveActivityId,@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'start_trigger') LiveActivityStartTrigger startTrigger
});




}
/// @nodoc
class __$TestLiveActivityStartResponseCopyWithImpl<$Res>
    implements _$TestLiveActivityStartResponseCopyWith<$Res> {
  __$TestLiveActivityStartResponseCopyWithImpl(this._self, this._then);

  final _TestLiveActivityStartResponse _self;
  final $Res Function(_TestLiveActivityStartResponse) _then;

/// Create a copy of TestLiveActivityStartResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? liveActivityId = null,Object? eventId = null,Object? startTrigger = null,}) {
  return _then(_TestLiveActivityStartResponse(
liveActivityId: null == liveActivityId ? _self.liveActivityId : liveActivityId // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,startTrigger: null == startTrigger ? _self.startTrigger : startTrigger // ignore: cast_nullable_to_non_nullable
as LiveActivityStartTrigger,
  ));
}


}

// dart format on

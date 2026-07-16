// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_live_activity_send_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestLiveActivitySendResponse {

@JsonKey(name: 'live_activity_id') String get liveActivityId; Event get event; String get message;
/// Create a copy of TestLiveActivitySendResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestLiveActivitySendResponseCopyWith<TestLiveActivitySendResponse> get copyWith => _$TestLiveActivitySendResponseCopyWithImpl<TestLiveActivitySendResponse>(this as TestLiveActivitySendResponse, _$identity);

  /// Serializes this TestLiveActivitySendResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestLiveActivitySendResponse&&(identical(other.liveActivityId, liveActivityId) || other.liveActivityId == liveActivityId)&&(identical(other.event, event) || other.event == event)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,liveActivityId,event,message);

@override
String toString() {
  return 'TestLiveActivitySendResponse(liveActivityId: $liveActivityId, event: $event, message: $message)';
}


}

/// @nodoc
abstract mixin class $TestLiveActivitySendResponseCopyWith<$Res>  {
  factory $TestLiveActivitySendResponseCopyWith(TestLiveActivitySendResponse value, $Res Function(TestLiveActivitySendResponse) _then) = _$TestLiveActivitySendResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'live_activity_id') String liveActivityId, Event event, String message
});




}
/// @nodoc
class _$TestLiveActivitySendResponseCopyWithImpl<$Res>
    implements $TestLiveActivitySendResponseCopyWith<$Res> {
  _$TestLiveActivitySendResponseCopyWithImpl(this._self, this._then);

  final TestLiveActivitySendResponse _self;
  final $Res Function(TestLiveActivitySendResponse) _then;

/// Create a copy of TestLiveActivitySendResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? liveActivityId = null,Object? event = null,Object? message = null,}) {
  return _then(_self.copyWith(
liveActivityId: null == liveActivityId ? _self.liveActivityId : liveActivityId // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as Event,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TestLiveActivitySendResponse].
extension TestLiveActivitySendResponsePatterns on TestLiveActivitySendResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestLiveActivitySendResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestLiveActivitySendResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestLiveActivitySendResponse value)  $default,){
final _that = this;
switch (_that) {
case _TestLiveActivitySendResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestLiveActivitySendResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TestLiveActivitySendResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'live_activity_id')  String liveActivityId,  Event event,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestLiveActivitySendResponse() when $default != null:
return $default(_that.liveActivityId,_that.event,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'live_activity_id')  String liveActivityId,  Event event,  String message)  $default,) {final _that = this;
switch (_that) {
case _TestLiveActivitySendResponse():
return $default(_that.liveActivityId,_that.event,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'live_activity_id')  String liveActivityId,  Event event,  String message)?  $default,) {final _that = this;
switch (_that) {
case _TestLiveActivitySendResponse() when $default != null:
return $default(_that.liveActivityId,_that.event,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestLiveActivitySendResponse implements TestLiveActivitySendResponse {
  const _TestLiveActivitySendResponse({@JsonKey(name: 'live_activity_id') required this.liveActivityId, required this.event, required this.message});
  factory _TestLiveActivitySendResponse.fromJson(Map<String, dynamic> json) => _$TestLiveActivitySendResponseFromJson(json);

@override@JsonKey(name: 'live_activity_id') final  String liveActivityId;
@override final  Event event;
@override final  String message;

/// Create a copy of TestLiveActivitySendResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestLiveActivitySendResponseCopyWith<_TestLiveActivitySendResponse> get copyWith => __$TestLiveActivitySendResponseCopyWithImpl<_TestLiveActivitySendResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestLiveActivitySendResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestLiveActivitySendResponse&&(identical(other.liveActivityId, liveActivityId) || other.liveActivityId == liveActivityId)&&(identical(other.event, event) || other.event == event)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,liveActivityId,event,message);

@override
String toString() {
  return 'TestLiveActivitySendResponse(liveActivityId: $liveActivityId, event: $event, message: $message)';
}


}

/// @nodoc
abstract mixin class _$TestLiveActivitySendResponseCopyWith<$Res> implements $TestLiveActivitySendResponseCopyWith<$Res> {
  factory _$TestLiveActivitySendResponseCopyWith(_TestLiveActivitySendResponse value, $Res Function(_TestLiveActivitySendResponse) _then) = __$TestLiveActivitySendResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'live_activity_id') String liveActivityId, Event event, String message
});




}
/// @nodoc
class __$TestLiveActivitySendResponseCopyWithImpl<$Res>
    implements _$TestLiveActivitySendResponseCopyWith<$Res> {
  __$TestLiveActivitySendResponseCopyWithImpl(this._self, this._then);

  final _TestLiveActivitySendResponse _self;
  final $Res Function(_TestLiveActivitySendResponse) _then;

/// Create a copy of TestLiveActivitySendResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? liveActivityId = null,Object? event = null,Object? message = null,}) {
  return _then(_TestLiveActivitySendResponse(
liveActivityId: null == liveActivityId ? _self.liveActivityId : liveActivityId // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as Event,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

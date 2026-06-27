// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_activity_test_scenario_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveActivityTestScenarioResponse {

/// const: true
 bool get ok;@JsonKey(name: 'event_id') String get eventId;@JsonKey(name: 'live_activity_id') String get liveActivityId;@JsonKey(name: 'reports_planned') num get reportsPlanned;
/// Create a copy of LiveActivityTestScenarioResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveActivityTestScenarioResponseCopyWith<LiveActivityTestScenarioResponse> get copyWith => _$LiveActivityTestScenarioResponseCopyWithImpl<LiveActivityTestScenarioResponse>(this as LiveActivityTestScenarioResponse, _$identity);

  /// Serializes this LiveActivityTestScenarioResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveActivityTestScenarioResponse&&(identical(other.ok, ok) || other.ok == ok)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.liveActivityId, liveActivityId) || other.liveActivityId == liveActivityId)&&(identical(other.reportsPlanned, reportsPlanned) || other.reportsPlanned == reportsPlanned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ok,eventId,liveActivityId,reportsPlanned);

@override
String toString() {
  return 'LiveActivityTestScenarioResponse(ok: $ok, eventId: $eventId, liveActivityId: $liveActivityId, reportsPlanned: $reportsPlanned)';
}


}

/// @nodoc
abstract mixin class $LiveActivityTestScenarioResponseCopyWith<$Res>  {
  factory $LiveActivityTestScenarioResponseCopyWith(LiveActivityTestScenarioResponse value, $Res Function(LiveActivityTestScenarioResponse) _then) = _$LiveActivityTestScenarioResponseCopyWithImpl;
@useResult
$Res call({
 bool ok,@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'live_activity_id') String liveActivityId,@JsonKey(name: 'reports_planned') num reportsPlanned
});




}
/// @nodoc
class _$LiveActivityTestScenarioResponseCopyWithImpl<$Res>
    implements $LiveActivityTestScenarioResponseCopyWith<$Res> {
  _$LiveActivityTestScenarioResponseCopyWithImpl(this._self, this._then);

  final LiveActivityTestScenarioResponse _self;
  final $Res Function(LiveActivityTestScenarioResponse) _then;

/// Create a copy of LiveActivityTestScenarioResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ok = null,Object? eventId = null,Object? liveActivityId = null,Object? reportsPlanned = null,}) {
  return _then(_self.copyWith(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,liveActivityId: null == liveActivityId ? _self.liveActivityId : liveActivityId // ignore: cast_nullable_to_non_nullable
as String,reportsPlanned: null == reportsPlanned ? _self.reportsPlanned : reportsPlanned // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveActivityTestScenarioResponse].
extension LiveActivityTestScenarioResponsePatterns on LiveActivityTestScenarioResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveActivityTestScenarioResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveActivityTestScenarioResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveActivityTestScenarioResponse value)  $default,){
final _that = this;
switch (_that) {
case _LiveActivityTestScenarioResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveActivityTestScenarioResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LiveActivityTestScenarioResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool ok, @JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'live_activity_id')  String liveActivityId, @JsonKey(name: 'reports_planned')  num reportsPlanned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveActivityTestScenarioResponse() when $default != null:
return $default(_that.ok,_that.eventId,_that.liveActivityId,_that.reportsPlanned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool ok, @JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'live_activity_id')  String liveActivityId, @JsonKey(name: 'reports_planned')  num reportsPlanned)  $default,) {final _that = this;
switch (_that) {
case _LiveActivityTestScenarioResponse():
return $default(_that.ok,_that.eventId,_that.liveActivityId,_that.reportsPlanned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool ok, @JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'live_activity_id')  String liveActivityId, @JsonKey(name: 'reports_planned')  num reportsPlanned)?  $default,) {final _that = this;
switch (_that) {
case _LiveActivityTestScenarioResponse() when $default != null:
return $default(_that.ok,_that.eventId,_that.liveActivityId,_that.reportsPlanned);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveActivityTestScenarioResponse implements LiveActivityTestScenarioResponse {
  const _LiveActivityTestScenarioResponse({required this.ok, @JsonKey(name: 'event_id') required this.eventId, @JsonKey(name: 'live_activity_id') required this.liveActivityId, @JsonKey(name: 'reports_planned') required this.reportsPlanned});
  factory _LiveActivityTestScenarioResponse.fromJson(Map<String, dynamic> json) => _$LiveActivityTestScenarioResponseFromJson(json);

/// const: true
@override final  bool ok;
@override@JsonKey(name: 'event_id') final  String eventId;
@override@JsonKey(name: 'live_activity_id') final  String liveActivityId;
@override@JsonKey(name: 'reports_planned') final  num reportsPlanned;

/// Create a copy of LiveActivityTestScenarioResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveActivityTestScenarioResponseCopyWith<_LiveActivityTestScenarioResponse> get copyWith => __$LiveActivityTestScenarioResponseCopyWithImpl<_LiveActivityTestScenarioResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveActivityTestScenarioResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveActivityTestScenarioResponse&&(identical(other.ok, ok) || other.ok == ok)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.liveActivityId, liveActivityId) || other.liveActivityId == liveActivityId)&&(identical(other.reportsPlanned, reportsPlanned) || other.reportsPlanned == reportsPlanned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ok,eventId,liveActivityId,reportsPlanned);

@override
String toString() {
  return 'LiveActivityTestScenarioResponse(ok: $ok, eventId: $eventId, liveActivityId: $liveActivityId, reportsPlanned: $reportsPlanned)';
}


}

/// @nodoc
abstract mixin class _$LiveActivityTestScenarioResponseCopyWith<$Res> implements $LiveActivityTestScenarioResponseCopyWith<$Res> {
  factory _$LiveActivityTestScenarioResponseCopyWith(_LiveActivityTestScenarioResponse value, $Res Function(_LiveActivityTestScenarioResponse) _then) = __$LiveActivityTestScenarioResponseCopyWithImpl;
@override @useResult
$Res call({
 bool ok,@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'live_activity_id') String liveActivityId,@JsonKey(name: 'reports_planned') num reportsPlanned
});




}
/// @nodoc
class __$LiveActivityTestScenarioResponseCopyWithImpl<$Res>
    implements _$LiveActivityTestScenarioResponseCopyWith<$Res> {
  __$LiveActivityTestScenarioResponseCopyWithImpl(this._self, this._then);

  final _LiveActivityTestScenarioResponse _self;
  final $Res Function(_LiveActivityTestScenarioResponse) _then;

/// Create a copy of LiveActivityTestScenarioResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ok = null,Object? eventId = null,Object? liveActivityId = null,Object? reportsPlanned = null,}) {
  return _then(_LiveActivityTestScenarioResponse(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,liveActivityId: null == liveActivityId ? _self.liveActivityId : liveActivityId // ignore: cast_nullable_to_non_nullable
as String,reportsPlanned: null == reportsPlanned ? _self.reportsPlanned : reportsPlanned // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on

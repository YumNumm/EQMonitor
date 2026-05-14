// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_activity_test_scenario_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveActivityTestScenarioRequest {

@JsonKey(name: 'event_type') LiveActivityStartTrigger get eventType;@JsonKey(includeIfNull: false) Scenario? get scenario;
/// Create a copy of LiveActivityTestScenarioRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveActivityTestScenarioRequestCopyWith<LiveActivityTestScenarioRequest> get copyWith => _$LiveActivityTestScenarioRequestCopyWithImpl<LiveActivityTestScenarioRequest>(this as LiveActivityTestScenarioRequest, _$identity);

  /// Serializes this LiveActivityTestScenarioRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveActivityTestScenarioRequest&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.scenario, scenario) || other.scenario == scenario));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventType,scenario);

@override
String toString() {
  return 'LiveActivityTestScenarioRequest(eventType: $eventType, scenario: $scenario)';
}


}

/// @nodoc
abstract mixin class $LiveActivityTestScenarioRequestCopyWith<$Res>  {
  factory $LiveActivityTestScenarioRequestCopyWith(LiveActivityTestScenarioRequest value, $Res Function(LiveActivityTestScenarioRequest) _then) = _$LiveActivityTestScenarioRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_type') LiveActivityStartTrigger eventType,@JsonKey(includeIfNull: false) Scenario? scenario
});




}
/// @nodoc
class _$LiveActivityTestScenarioRequestCopyWithImpl<$Res>
    implements $LiveActivityTestScenarioRequestCopyWith<$Res> {
  _$LiveActivityTestScenarioRequestCopyWithImpl(this._self, this._then);

  final LiveActivityTestScenarioRequest _self;
  final $Res Function(LiveActivityTestScenarioRequest) _then;

/// Create a copy of LiveActivityTestScenarioRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventType = null,Object? scenario = freezed,}) {
  return _then(_self.copyWith(
eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as LiveActivityStartTrigger,scenario: freezed == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as Scenario?,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveActivityTestScenarioRequest].
extension LiveActivityTestScenarioRequestPatterns on LiveActivityTestScenarioRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveActivityTestScenarioRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveActivityTestScenarioRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveActivityTestScenarioRequest value)  $default,){
final _that = this;
switch (_that) {
case _LiveActivityTestScenarioRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveActivityTestScenarioRequest value)?  $default,){
final _that = this;
switch (_that) {
case _LiveActivityTestScenarioRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_type')  LiveActivityStartTrigger eventType, @JsonKey(includeIfNull: false)  Scenario? scenario)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveActivityTestScenarioRequest() when $default != null:
return $default(_that.eventType,_that.scenario);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_type')  LiveActivityStartTrigger eventType, @JsonKey(includeIfNull: false)  Scenario? scenario)  $default,) {final _that = this;
switch (_that) {
case _LiveActivityTestScenarioRequest():
return $default(_that.eventType,_that.scenario);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_type')  LiveActivityStartTrigger eventType, @JsonKey(includeIfNull: false)  Scenario? scenario)?  $default,) {final _that = this;
switch (_that) {
case _LiveActivityTestScenarioRequest() when $default != null:
return $default(_that.eventType,_that.scenario);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveActivityTestScenarioRequest implements LiveActivityTestScenarioRequest {
  const _LiveActivityTestScenarioRequest({@JsonKey(name: 'event_type') required this.eventType, @JsonKey(includeIfNull: false) this.scenario});
  factory _LiveActivityTestScenarioRequest.fromJson(Map<String, dynamic> json) => _$LiveActivityTestScenarioRequestFromJson(json);

@override@JsonKey(name: 'event_type') final  LiveActivityStartTrigger eventType;
@override@JsonKey(includeIfNull: false) final  Scenario? scenario;

/// Create a copy of LiveActivityTestScenarioRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveActivityTestScenarioRequestCopyWith<_LiveActivityTestScenarioRequest> get copyWith => __$LiveActivityTestScenarioRequestCopyWithImpl<_LiveActivityTestScenarioRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveActivityTestScenarioRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveActivityTestScenarioRequest&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.scenario, scenario) || other.scenario == scenario));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventType,scenario);

@override
String toString() {
  return 'LiveActivityTestScenarioRequest(eventType: $eventType, scenario: $scenario)';
}


}

/// @nodoc
abstract mixin class _$LiveActivityTestScenarioRequestCopyWith<$Res> implements $LiveActivityTestScenarioRequestCopyWith<$Res> {
  factory _$LiveActivityTestScenarioRequestCopyWith(_LiveActivityTestScenarioRequest value, $Res Function(_LiveActivityTestScenarioRequest) _then) = __$LiveActivityTestScenarioRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_type') LiveActivityStartTrigger eventType,@JsonKey(includeIfNull: false) Scenario? scenario
});




}
/// @nodoc
class __$LiveActivityTestScenarioRequestCopyWithImpl<$Res>
    implements _$LiveActivityTestScenarioRequestCopyWith<$Res> {
  __$LiveActivityTestScenarioRequestCopyWithImpl(this._self, this._then);

  final _LiveActivityTestScenarioRequest _self;
  final $Res Function(_LiveActivityTestScenarioRequest) _then;

/// Create a copy of LiveActivityTestScenarioRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventType = null,Object? scenario = freezed,}) {
  return _then(_LiveActivityTestScenarioRequest(
eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as LiveActivityStartTrigger,scenario: freezed == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as Scenario?,
  ));
}


}

// dart format on

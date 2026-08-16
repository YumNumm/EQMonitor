// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_scenario_type_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestScenarioTypeResponse {

 String get message; String get scenario;@JsonKey(name: 'event_id') String get eventId;
/// Create a copy of TestScenarioTypeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestScenarioTypeResponseCopyWith<TestScenarioTypeResponse> get copyWith => _$TestScenarioTypeResponseCopyWithImpl<TestScenarioTypeResponse>(this as TestScenarioTypeResponse, _$identity);

  /// Serializes this TestScenarioTypeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestScenarioTypeResponse&&(identical(other.message, message) || other.message == message)&&(identical(other.scenario, scenario) || other.scenario == scenario)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,scenario,eventId);

@override
String toString() {
  return 'TestScenarioTypeResponse(message: $message, scenario: $scenario, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $TestScenarioTypeResponseCopyWith<$Res>  {
  factory $TestScenarioTypeResponseCopyWith(TestScenarioTypeResponse value, $Res Function(TestScenarioTypeResponse) _then) = _$TestScenarioTypeResponseCopyWithImpl;
@useResult
$Res call({
 String message, String scenario,@JsonKey(name: 'event_id') String eventId
});




}
/// @nodoc
class _$TestScenarioTypeResponseCopyWithImpl<$Res>
    implements $TestScenarioTypeResponseCopyWith<$Res> {
  _$TestScenarioTypeResponseCopyWithImpl(this._self, this._then);

  final TestScenarioTypeResponse _self;
  final $Res Function(TestScenarioTypeResponse) _then;

/// Create a copy of TestScenarioTypeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? scenario = null,Object? eventId = null,}) {
  return _then(TestScenarioTypeResponse(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TestScenarioTypeResponse].
extension TestScenarioTypeResponsePatterns on TestScenarioTypeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestScenarioTypeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestScenarioTypeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestScenarioTypeResponse value)  $default,){
final _that = this;
switch (_that) {
case _TestScenarioTypeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestScenarioTypeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TestScenarioTypeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  String scenario, @JsonKey(name: 'event_id')  String eventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestScenarioTypeResponse() when $default != null:
return $default(_that.message,_that.scenario,_that.eventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  String scenario, @JsonKey(name: 'event_id')  String eventId)  $default,) {final _that = this;
switch (_that) {
case _TestScenarioTypeResponse():
return $default(_that.message,_that.scenario,_that.eventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  String scenario, @JsonKey(name: 'event_id')  String eventId)?  $default,) {final _that = this;
switch (_that) {
case _TestScenarioTypeResponse() when $default != null:
return $default(_that.message,_that.scenario,_that.eventId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestScenarioTypeResponse implements TestScenarioTypeResponse {
  const _TestScenarioTypeResponse({required this.message, required this.scenario, @JsonKey(name: 'event_id') required this.eventId});
  factory _TestScenarioTypeResponse.fromJson(Map<String, dynamic> json) => _$TestScenarioTypeResponseFromJson(json);

@override final  String message;
@override final  String scenario;
@override@JsonKey(name: 'event_id') final  String eventId;

/// Create a copy of TestScenarioTypeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestScenarioTypeResponseCopyWith<_TestScenarioTypeResponse> get copyWith => __$TestScenarioTypeResponseCopyWithImpl<_TestScenarioTypeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestScenarioTypeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestScenarioTypeResponse&&(identical(other.message, message) || other.message == message)&&(identical(other.scenario, scenario) || other.scenario == scenario)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,scenario,eventId);

@override
String toString() {
  return 'TestScenarioTypeResponse(message: $message, scenario: $scenario, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class _$TestScenarioTypeResponseCopyWith<$Res> implements $TestScenarioTypeResponseCopyWith<$Res> {
  factory _$TestScenarioTypeResponseCopyWith(_TestScenarioTypeResponse value, $Res Function(_TestScenarioTypeResponse) _then) = __$TestScenarioTypeResponseCopyWithImpl;
@override @useResult
$Res call({
 String message, String scenario,@JsonKey(name: 'event_id') String eventId
});




}
/// @nodoc
class __$TestScenarioTypeResponseCopyWithImpl<$Res>
    implements _$TestScenarioTypeResponseCopyWith<$Res> {
  __$TestScenarioTypeResponseCopyWithImpl(this._self, this._then);

  final _TestScenarioTypeResponse _self;
  final $Res Function(_TestScenarioTypeResponse) _then;

/// Create a copy of TestScenarioTypeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? scenario = null,Object? eventId = null,}) {
  return _then(_TestScenarioTypeResponse(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

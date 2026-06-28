// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_scenario_type_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestScenarioTypeRequest {

 TestNotificationScenario get scenario;
/// Create a copy of TestScenarioTypeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestScenarioTypeRequestCopyWith<TestScenarioTypeRequest> get copyWith => _$TestScenarioTypeRequestCopyWithImpl<TestScenarioTypeRequest>(this as TestScenarioTypeRequest, _$identity);

  /// Serializes this TestScenarioTypeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestScenarioTypeRequest&&(identical(other.scenario, scenario) || other.scenario == scenario));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scenario);

@override
String toString() {
  return 'TestScenarioTypeRequest(scenario: $scenario)';
}


}

/// @nodoc
abstract mixin class $TestScenarioTypeRequestCopyWith<$Res>  {
  factory $TestScenarioTypeRequestCopyWith(TestScenarioTypeRequest value, $Res Function(TestScenarioTypeRequest) _then) = _$TestScenarioTypeRequestCopyWithImpl;
@useResult
$Res call({
 TestNotificationScenario scenario
});




}
/// @nodoc
class _$TestScenarioTypeRequestCopyWithImpl<$Res>
    implements $TestScenarioTypeRequestCopyWith<$Res> {
  _$TestScenarioTypeRequestCopyWithImpl(this._self, this._then);

  final TestScenarioTypeRequest _self;
  final $Res Function(TestScenarioTypeRequest) _then;

/// Create a copy of TestScenarioTypeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scenario = null,}) {
  return _then(_self.copyWith(
scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as TestNotificationScenario,
  ));
}

}


/// Adds pattern-matching-related methods to [TestScenarioTypeRequest].
extension TestScenarioTypeRequestPatterns on TestScenarioTypeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestScenarioTypeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestScenarioTypeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestScenarioTypeRequest value)  $default,){
final _that = this;
switch (_that) {
case _TestScenarioTypeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestScenarioTypeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TestScenarioTypeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TestNotificationScenario scenario)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestScenarioTypeRequest() when $default != null:
return $default(_that.scenario);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TestNotificationScenario scenario)  $default,) {final _that = this;
switch (_that) {
case _TestScenarioTypeRequest():
return $default(_that.scenario);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TestNotificationScenario scenario)?  $default,) {final _that = this;
switch (_that) {
case _TestScenarioTypeRequest() when $default != null:
return $default(_that.scenario);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestScenarioTypeRequest implements TestScenarioTypeRequest {
  const _TestScenarioTypeRequest({required this.scenario});
  factory _TestScenarioTypeRequest.fromJson(Map<String, dynamic> json) => _$TestScenarioTypeRequestFromJson(json);

@override final  TestNotificationScenario scenario;

/// Create a copy of TestScenarioTypeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestScenarioTypeRequestCopyWith<_TestScenarioTypeRequest> get copyWith => __$TestScenarioTypeRequestCopyWithImpl<_TestScenarioTypeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestScenarioTypeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestScenarioTypeRequest&&(identical(other.scenario, scenario) || other.scenario == scenario));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scenario);

@override
String toString() {
  return 'TestScenarioTypeRequest(scenario: $scenario)';
}


}

/// @nodoc
abstract mixin class _$TestScenarioTypeRequestCopyWith<$Res> implements $TestScenarioTypeRequestCopyWith<$Res> {
  factory _$TestScenarioTypeRequestCopyWith(_TestScenarioTypeRequest value, $Res Function(_TestScenarioTypeRequest) _then) = __$TestScenarioTypeRequestCopyWithImpl;
@override @useResult
$Res call({
 TestNotificationScenario scenario
});




}
/// @nodoc
class __$TestScenarioTypeRequestCopyWithImpl<$Res>
    implements _$TestScenarioTypeRequestCopyWith<$Res> {
  __$TestScenarioTypeRequestCopyWithImpl(this._self, this._then);

  final _TestScenarioTypeRequest _self;
  final $Res Function(_TestScenarioTypeRequest) _then;

/// Create a copy of TestScenarioTypeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scenario = null,}) {
  return _then(_TestScenarioTypeRequest(
scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as TestNotificationScenario,
  ));
}


}

// dart format on

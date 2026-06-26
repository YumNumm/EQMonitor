// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_scenario_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestScenarioRequest {

@JsonKey(name: 'event_id') String get eventId;
/// Create a copy of TestScenarioRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestScenarioRequestCopyWith<TestScenarioRequest> get copyWith => _$TestScenarioRequestCopyWithImpl<TestScenarioRequest>(this as TestScenarioRequest, _$identity);

  /// Serializes this TestScenarioRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestScenarioRequest&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId);

@override
String toString() {
  return 'TestScenarioRequest(eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $TestScenarioRequestCopyWith<$Res>  {
  factory $TestScenarioRequestCopyWith(TestScenarioRequest value, $Res Function(TestScenarioRequest) _then) = _$TestScenarioRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id') String eventId
});




}
/// @nodoc
class _$TestScenarioRequestCopyWithImpl<$Res>
    implements $TestScenarioRequestCopyWith<$Res> {
  _$TestScenarioRequestCopyWithImpl(this._self, this._then);

  final TestScenarioRequest _self;
  final $Res Function(TestScenarioRequest) _then;

/// Create a copy of TestScenarioRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TestScenarioRequest].
extension TestScenarioRequestPatterns on TestScenarioRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestScenarioRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestScenarioRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestScenarioRequest value)  $default,){
final _that = this;
switch (_that) {
case _TestScenarioRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestScenarioRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TestScenarioRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestScenarioRequest() when $default != null:
return $default(_that.eventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId)  $default,) {final _that = this;
switch (_that) {
case _TestScenarioRequest():
return $default(_that.eventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId)?  $default,) {final _that = this;
switch (_that) {
case _TestScenarioRequest() when $default != null:
return $default(_that.eventId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestScenarioRequest implements TestScenarioRequest {
  const _TestScenarioRequest({@JsonKey(name: 'event_id') required this.eventId});
  factory _TestScenarioRequest.fromJson(Map<String, dynamic> json) => _$TestScenarioRequestFromJson(json);

@override@JsonKey(name: 'event_id') final  String eventId;

/// Create a copy of TestScenarioRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestScenarioRequestCopyWith<_TestScenarioRequest> get copyWith => __$TestScenarioRequestCopyWithImpl<_TestScenarioRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestScenarioRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestScenarioRequest&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId);

@override
String toString() {
  return 'TestScenarioRequest(eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class _$TestScenarioRequestCopyWith<$Res> implements $TestScenarioRequestCopyWith<$Res> {
  factory _$TestScenarioRequestCopyWith(_TestScenarioRequest value, $Res Function(_TestScenarioRequest) _then) = __$TestScenarioRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id') String eventId
});




}
/// @nodoc
class __$TestScenarioRequestCopyWithImpl<$Res>
    implements _$TestScenarioRequestCopyWith<$Res> {
  __$TestScenarioRequestCopyWithImpl(this._self, this._then);

  final _TestScenarioRequest _self;
  final $Res Function(_TestScenarioRequest) _then;

/// Create a copy of TestScenarioRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,}) {
  return _then(_TestScenarioRequest(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

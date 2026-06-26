// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_scenario_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestScenarioResponse {

@JsonKey(name: 'event_id') String get eventId;@JsonKey(name: 'steps_planned') num get stepsPlanned;@JsonKey(name: 'telegram_types') List<String> get telegramTypes;
/// Create a copy of TestScenarioResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestScenarioResponseCopyWith<TestScenarioResponse> get copyWith => _$TestScenarioResponseCopyWithImpl<TestScenarioResponse>(this as TestScenarioResponse, _$identity);

  /// Serializes this TestScenarioResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestScenarioResponse&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.stepsPlanned, stepsPlanned) || other.stepsPlanned == stepsPlanned)&&const DeepCollectionEquality().equals(other.telegramTypes, telegramTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,stepsPlanned,const DeepCollectionEquality().hash(telegramTypes));

@override
String toString() {
  return 'TestScenarioResponse(eventId: $eventId, stepsPlanned: $stepsPlanned, telegramTypes: $telegramTypes)';
}


}

/// @nodoc
abstract mixin class $TestScenarioResponseCopyWith<$Res>  {
  factory $TestScenarioResponseCopyWith(TestScenarioResponse value, $Res Function(TestScenarioResponse) _then) = _$TestScenarioResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'steps_planned') num stepsPlanned,@JsonKey(name: 'telegram_types') List<String> telegramTypes
});




}
/// @nodoc
class _$TestScenarioResponseCopyWithImpl<$Res>
    implements $TestScenarioResponseCopyWith<$Res> {
  _$TestScenarioResponseCopyWithImpl(this._self, this._then);

  final TestScenarioResponse _self;
  final $Res Function(TestScenarioResponse) _then;

/// Create a copy of TestScenarioResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? stepsPlanned = null,Object? telegramTypes = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,stepsPlanned: null == stepsPlanned ? _self.stepsPlanned : stepsPlanned // ignore: cast_nullable_to_non_nullable
as num,telegramTypes: null == telegramTypes ? _self.telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TestScenarioResponse].
extension TestScenarioResponsePatterns on TestScenarioResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestScenarioResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestScenarioResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestScenarioResponse value)  $default,){
final _that = this;
switch (_that) {
case _TestScenarioResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestScenarioResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TestScenarioResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'steps_planned')  num stepsPlanned, @JsonKey(name: 'telegram_types')  List<String> telegramTypes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestScenarioResponse() when $default != null:
return $default(_that.eventId,_that.stepsPlanned,_that.telegramTypes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'steps_planned')  num stepsPlanned, @JsonKey(name: 'telegram_types')  List<String> telegramTypes)  $default,) {final _that = this;
switch (_that) {
case _TestScenarioResponse():
return $default(_that.eventId,_that.stepsPlanned,_that.telegramTypes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'steps_planned')  num stepsPlanned, @JsonKey(name: 'telegram_types')  List<String> telegramTypes)?  $default,) {final _that = this;
switch (_that) {
case _TestScenarioResponse() when $default != null:
return $default(_that.eventId,_that.stepsPlanned,_that.telegramTypes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestScenarioResponse implements TestScenarioResponse {
  const _TestScenarioResponse({@JsonKey(name: 'event_id') required this.eventId, @JsonKey(name: 'steps_planned') required this.stepsPlanned, @JsonKey(name: 'telegram_types') required final  List<String> telegramTypes}): _telegramTypes = telegramTypes;
  factory _TestScenarioResponse.fromJson(Map<String, dynamic> json) => _$TestScenarioResponseFromJson(json);

@override@JsonKey(name: 'event_id') final  String eventId;
@override@JsonKey(name: 'steps_planned') final  num stepsPlanned;
 final  List<String> _telegramTypes;
@override@JsonKey(name: 'telegram_types') List<String> get telegramTypes {
  if (_telegramTypes is EqualUnmodifiableListView) return _telegramTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegramTypes);
}


/// Create a copy of TestScenarioResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestScenarioResponseCopyWith<_TestScenarioResponse> get copyWith => __$TestScenarioResponseCopyWithImpl<_TestScenarioResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestScenarioResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestScenarioResponse&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.stepsPlanned, stepsPlanned) || other.stepsPlanned == stepsPlanned)&&const DeepCollectionEquality().equals(other._telegramTypes, _telegramTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,stepsPlanned,const DeepCollectionEquality().hash(_telegramTypes));

@override
String toString() {
  return 'TestScenarioResponse(eventId: $eventId, stepsPlanned: $stepsPlanned, telegramTypes: $telegramTypes)';
}


}

/// @nodoc
abstract mixin class _$TestScenarioResponseCopyWith<$Res> implements $TestScenarioResponseCopyWith<$Res> {
  factory _$TestScenarioResponseCopyWith(_TestScenarioResponse value, $Res Function(_TestScenarioResponse) _then) = __$TestScenarioResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'steps_planned') num stepsPlanned,@JsonKey(name: 'telegram_types') List<String> telegramTypes
});




}
/// @nodoc
class __$TestScenarioResponseCopyWithImpl<$Res>
    implements _$TestScenarioResponseCopyWith<$Res> {
  __$TestScenarioResponseCopyWithImpl(this._self, this._then);

  final _TestScenarioResponse _self;
  final $Res Function(_TestScenarioResponse) _then;

/// Create a copy of TestScenarioResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? stepsPlanned = null,Object? telegramTypes = null,}) {
  return _then(_TestScenarioResponse(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,stepsPlanned: null == stepsPlanned ? _self.stepsPlanned : stepsPlanned // ignore: cast_nullable_to_non_nullable
as num,telegramTypes: null == telegramTypes ? _self._telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

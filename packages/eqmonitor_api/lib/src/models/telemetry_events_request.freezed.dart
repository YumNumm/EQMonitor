// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telemetry_events_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelemetryEventsRequest {

 List<TelemetryEvent> get events;
/// Create a copy of TelemetryEventsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelemetryEventsRequestCopyWith<TelemetryEventsRequest> get copyWith => _$TelemetryEventsRequestCopyWithImpl<TelemetryEventsRequest>(this as TelemetryEventsRequest, _$identity);

  /// Serializes this TelemetryEventsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelemetryEventsRequest&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'TelemetryEventsRequest(events: $events)';
}


}

/// @nodoc
abstract mixin class $TelemetryEventsRequestCopyWith<$Res>  {
  factory $TelemetryEventsRequestCopyWith(TelemetryEventsRequest value, $Res Function(TelemetryEventsRequest) _then) = _$TelemetryEventsRequestCopyWithImpl;
@useResult
$Res call({
 List<TelemetryEvent> events
});




}
/// @nodoc
class _$TelemetryEventsRequestCopyWithImpl<$Res>
    implements $TelemetryEventsRequestCopyWith<$Res> {
  _$TelemetryEventsRequestCopyWithImpl(this._self, this._then);

  final TelemetryEventsRequest _self;
  final $Res Function(TelemetryEventsRequest) _then;

/// Create a copy of TelemetryEventsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? events = null,}) {
  return _then(TelemetryEventsRequest(
events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<TelemetryEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [TelemetryEventsRequest].
extension TelemetryEventsRequestPatterns on TelemetryEventsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelemetryEventsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelemetryEventsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelemetryEventsRequest value)  $default,){
final _that = this;
switch (_that) {
case _TelemetryEventsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelemetryEventsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TelemetryEventsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TelemetryEvent> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelemetryEventsRequest() when $default != null:
return $default(_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TelemetryEvent> events)  $default,) {final _that = this;
switch (_that) {
case _TelemetryEventsRequest():
return $default(_that.events);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TelemetryEvent> events)?  $default,) {final _that = this;
switch (_that) {
case _TelemetryEventsRequest() when $default != null:
return $default(_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelemetryEventsRequest implements TelemetryEventsRequest {
  const _TelemetryEventsRequest({required  List<TelemetryEvent> events}): _events = events;
  factory _TelemetryEventsRequest.fromJson(Map<String, dynamic> json) => _$TelemetryEventsRequestFromJson(json);

 final  List<TelemetryEvent> _events;
@override List<TelemetryEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of TelemetryEventsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelemetryEventsRequestCopyWith<_TelemetryEventsRequest> get copyWith => __$TelemetryEventsRequestCopyWithImpl<_TelemetryEventsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelemetryEventsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelemetryEventsRequest&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'TelemetryEventsRequest(events: $events)';
}


}

/// @nodoc
abstract mixin class _$TelemetryEventsRequestCopyWith<$Res> implements $TelemetryEventsRequestCopyWith<$Res> {
  factory _$TelemetryEventsRequestCopyWith(_TelemetryEventsRequest value, $Res Function(_TelemetryEventsRequest) _then) = __$TelemetryEventsRequestCopyWithImpl;
@override @useResult
$Res call({
 List<TelemetryEvent> events
});




}
/// @nodoc
class __$TelemetryEventsRequestCopyWithImpl<$Res>
    implements _$TelemetryEventsRequestCopyWith<$Res> {
  __$TelemetryEventsRequestCopyWithImpl(this._self, this._then);

  final _TelemetryEventsRequest _self;
  final $Res Function(_TelemetryEventsRequest) _then;

/// Create a copy of TelemetryEventsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? events = null,}) {
  return _then(_TelemetryEventsRequest(
events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<TelemetryEvent>,
  ));
}


}

// dart format on

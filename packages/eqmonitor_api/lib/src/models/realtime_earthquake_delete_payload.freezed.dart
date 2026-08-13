// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_earthquake_delete_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeEarthquakeDeletePayload {

 RealtimeEarthquakeDeletePayloadType get type; RealtimeEarthquakeDeletePayloadOperation get operation;@JsonKey(name: 'event_id') String get eventId;
/// Create a copy of RealtimeEarthquakeDeletePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeEarthquakeDeletePayloadCopyWith<RealtimeEarthquakeDeletePayload> get copyWith => _$RealtimeEarthquakeDeletePayloadCopyWithImpl<RealtimeEarthquakeDeletePayload>(this as RealtimeEarthquakeDeletePayload, _$identity);

  /// Serializes this RealtimeEarthquakeDeletePayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEarthquakeDeletePayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId);

@override
String toString() {
  return 'RealtimeEarthquakeDeletePayload(type: $type, operation: $operation, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $RealtimeEarthquakeDeletePayloadCopyWith<$Res>  {
  factory $RealtimeEarthquakeDeletePayloadCopyWith(RealtimeEarthquakeDeletePayload value, $Res Function(RealtimeEarthquakeDeletePayload) _then) = _$RealtimeEarthquakeDeletePayloadCopyWithImpl;
@useResult
$Res call({
 RealtimeEarthquakeDeletePayloadType type, RealtimeEarthquakeDeletePayloadOperation operation,@JsonKey(name: 'event_id') String eventId
});




}
/// @nodoc
class _$RealtimeEarthquakeDeletePayloadCopyWithImpl<$Res>
    implements $RealtimeEarthquakeDeletePayloadCopyWith<$Res> {
  _$RealtimeEarthquakeDeletePayloadCopyWithImpl(this._self, this._then);

  final RealtimeEarthquakeDeletePayload _self;
  final $Res Function(RealtimeEarthquakeDeletePayload) _then;

/// Create a copy of RealtimeEarthquakeDeletePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? operation = null,Object? eventId = null,}) {
  return _then(RealtimeEarthquakeDeletePayload(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeEarthquakeDeletePayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeEarthquakeDeletePayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeEarthquakeDeletePayload].
extension RealtimeEarthquakeDeletePayloadPatterns on RealtimeEarthquakeDeletePayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeEarthquakeDeletePayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeEarthquakeDeletePayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeEarthquakeDeletePayload value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeEarthquakeDeletePayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeEarthquakeDeletePayload value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeEarthquakeDeletePayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RealtimeEarthquakeDeletePayloadType type,  RealtimeEarthquakeDeletePayloadOperation operation, @JsonKey(name: 'event_id')  String eventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeEarthquakeDeletePayload() when $default != null:
return $default(_that.type,_that.operation,_that.eventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RealtimeEarthquakeDeletePayloadType type,  RealtimeEarthquakeDeletePayloadOperation operation, @JsonKey(name: 'event_id')  String eventId)  $default,) {final _that = this;
switch (_that) {
case _RealtimeEarthquakeDeletePayload():
return $default(_that.type,_that.operation,_that.eventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RealtimeEarthquakeDeletePayloadType type,  RealtimeEarthquakeDeletePayloadOperation operation, @JsonKey(name: 'event_id')  String eventId)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeEarthquakeDeletePayload() when $default != null:
return $default(_that.type,_that.operation,_that.eventId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeEarthquakeDeletePayload implements RealtimeEarthquakeDeletePayload {
  const _RealtimeEarthquakeDeletePayload({required this.type, required this.operation, @JsonKey(name: 'event_id') required this.eventId});
  factory _RealtimeEarthquakeDeletePayload.fromJson(Map<String, dynamic> json) => _$RealtimeEarthquakeDeletePayloadFromJson(json);

@override final  RealtimeEarthquakeDeletePayloadType type;
@override final  RealtimeEarthquakeDeletePayloadOperation operation;
@override@JsonKey(name: 'event_id') final  String eventId;

/// Create a copy of RealtimeEarthquakeDeletePayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeEarthquakeDeletePayloadCopyWith<_RealtimeEarthquakeDeletePayload> get copyWith => __$RealtimeEarthquakeDeletePayloadCopyWithImpl<_RealtimeEarthquakeDeletePayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeEarthquakeDeletePayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeEarthquakeDeletePayload&&(identical(other.type, type) || other.type == type)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operation,eventId);

@override
String toString() {
  return 'RealtimeEarthquakeDeletePayload(type: $type, operation: $operation, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class _$RealtimeEarthquakeDeletePayloadCopyWith<$Res> implements $RealtimeEarthquakeDeletePayloadCopyWith<$Res> {
  factory _$RealtimeEarthquakeDeletePayloadCopyWith(_RealtimeEarthquakeDeletePayload value, $Res Function(_RealtimeEarthquakeDeletePayload) _then) = __$RealtimeEarthquakeDeletePayloadCopyWithImpl;
@override @useResult
$Res call({
 RealtimeEarthquakeDeletePayloadType type, RealtimeEarthquakeDeletePayloadOperation operation,@JsonKey(name: 'event_id') String eventId
});




}
/// @nodoc
class __$RealtimeEarthquakeDeletePayloadCopyWithImpl<$Res>
    implements _$RealtimeEarthquakeDeletePayloadCopyWith<$Res> {
  __$RealtimeEarthquakeDeletePayloadCopyWithImpl(this._self, this._then);

  final _RealtimeEarthquakeDeletePayload _self;
  final $Res Function(_RealtimeEarthquakeDeletePayload) _then;

/// Create a copy of RealtimeEarthquakeDeletePayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? operation = null,Object? eventId = null,}) {
  return _then(_RealtimeEarthquakeDeletePayload(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RealtimeEarthquakeDeletePayloadType,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RealtimeEarthquakeDeletePayloadOperation,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
